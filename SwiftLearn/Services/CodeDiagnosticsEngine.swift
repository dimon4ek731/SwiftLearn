import Foundation

public final class CodeDiagnosticsEngine {
    public static let shared = CodeDiagnosticsEngine()
    
    public init() {}
    
    public func analyze(code: String) -> CodeAnalysisResult {
        var issues: [CodeIssue] = []
        var score = 100
        var bestPracticesRU: [String] = []
        var bestPracticesEN: [String] = []
        
        let lines = code.components(separatedBy: .newlines)
        var mutatedLetNames: Set<String> = []
        var missingStateVarNames: Set<String> = []
        
        // 1. Check for mutating let
        for (index, line) in lines.enumerated() {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if trimmed.hasPrefix("//") { continue }
            
            if trimmed.contains("let ") && trimmed.contains("=") && !trimmed.contains("guard") && !trimmed.contains("if") {
                let parts = trimmed.components(separatedBy: "let ")
                if parts.count > 1 {
                    let rawName = parts[1].components(separatedBy: CharacterSet(charactersIn: " :=<(")).first ?? ""
                    let varName = rawName.trimmingCharacters(in: .whitespaces)
                    if !varName.isEmpty && varName != "_" {
                        for laterLine in lines.dropFirst(index + 1) {
                            let cleanLater = laterLine.trimmingCharacters(in: .whitespaces)
                            if cleanLater.hasPrefix("//") { continue }
                            
                            // Check if mutated
                            let assignmentPatterns = [
                                "\(varName) =",
                                "\(varName) +=",
                                "\(varName) -=",
                                "\(varName) *=",
                                "self.\(varName) ="
                            ]
                            
                            if assignmentPatterns.contains(where: { cleanLater.contains($0) }) {
                                issues.append(CodeIssue(
                                    line: index + 1,
                                    titleRU: "Попытка изменить константу (let)",
                                    titleEN: "Attempt to mutate a constant (let)",
                                    messageRU: "Идентификатор '\(varName)' объявлен как 'let' (неизменяемая константа), но далее вы пытаетесь изменить его значение.",
                                    messageEN: "Variable '\(varName)' is declared as 'let' (immutable), but mutated later.",
                                    severity: .error,
                                    suggestionRU: "Замените 'let \(varName)' на 'var \(varName)'.",
                                    suggestionEN: "Change 'let \(varName)' to 'var \(varName)'."
                                ))
                                mutatedLetNames.insert(varName)
                                score -= 25
                                break
                            }
                        }
                    }
                }
            }
        }
        
        // 2. Check for missing @State in SwiftUI View
        let isSwiftUIView = code.contains("struct ") && code.contains(": View")
        if isSwiftUIView {
            for (index, line) in lines.enumerated() {
                let trimmed = line.trimmingCharacters(in: .whitespaces)
                if trimmed.hasPrefix("//") { continue }
                
                if trimmed.hasPrefix("var ") && trimmed.contains("=") && !trimmed.contains("body") && !trimmed.contains("@State") && !trimmed.contains("@Binding") && !trimmed.contains("@Environment") {
                    let rawName = trimmed.components(separatedBy: "var ")[1].components(separatedBy: CharacterSet(charactersIn: " :=<(")).first ?? ""
                    let varName = rawName.trimmingCharacters(in: .whitespaces)
                    
                    if !varName.isEmpty && !trimmed.contains("some View") {
                        // Look for mutations on OTHER lines (not the declaration itself)
                        var mutated = false
                        for (otherIdx, otherLine) in lines.enumerated() where otherIdx != index {
                            let clean = otherLine.trimmingCharacters(in: .whitespaces)
                            if clean.hasPrefix("//") { continue }
                            if clean.contains("\(varName) =") || clean.contains("\(varName) +=") || clean.contains("\(varName).toggle()") {
                                mutated = true
                                break
                            }
                        }
                        
                        if mutated {
                            issues.append(CodeIssue(
                                line: index + 1,
                                titleRU: "Изменение свойства View без @State",
                                titleEN: "Mutating View property without @State",
                                messageRU: "Структуры SwiftUI являются неизменяемыми Value Types. Свойство '\(varName)' изменяется, но не помечено оберткой @State.",
                                messageEN: "SwiftUI views are immutable structs. Property '\(varName)' is mutated without @State wrapper.",
                                severity: .error,
                                suggestionRU: "Добавьте аннотацию '@State private var \(varName)'.",
                                suggestionEN: "Add '@State private var \(varName)' annotation."
                            ))
                            missingStateVarNames.insert(varName)
                            score -= 20
                            break
                        }
                    }
                }
            }
        }
        
        // 3. Force Unwrapping (!) — filter out comments, string literals, and boolean NOT
        for (index, line) in lines.enumerated() {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if trimmed.hasPrefix("//") { continue }
            
            // Remove quoted string literals to prevent Text("Hello!") from triggering
            let withoutStrings = removeStringLiterals(from: trimmed)
            
            // Check true force unwraps
            let hasForceCast = withoutStrings.contains("as! ")
            let hasForceTry = withoutStrings.contains("try! ")
            let hasPostfixBang = containsForceUnwrapBang(withoutStrings)
            
            if hasForceCast || hasForceTry || hasPostfixBang {
                issues.append(CodeIssue(
                    line: index + 1,
                    titleRU: "Опасное принудительное извлечение (Force Unwrap '!')",
                    titleEN: "Dangerous Force Unwrap ('!')",
                    messageRU: "Символ '!' приведет к аварийному завершению (fatalError crash), если значение окажется nil.",
                    messageEN: "Force unwrapping with '!' will crash the application if the value is nil.",
                    severity: .warning,
                    suggestionRU: "Используйте безопасное извлечение: 'if let', 'guard let' или оператор nil-коалесценции '??'.",
                    suggestionEN: "Use safe unwrapping: 'if let', 'guard let', or nil-coalescing '??'."
                ))
                score -= 15
                break
            }
        }
        
        // 4. Strong Reference Cycle in Closures (Only relevant inside a class)
        let isClassContext = code.contains("class ")
        if isClassContext && (code.contains("self.") || code.contains("self?.")) && (!code.contains("[weak self]") && !code.contains("[unowned self]")) {
            let hasEscapingContext = code.contains("Task {") || code.contains(".sink") || code.contains("DispatchQueue") || code.contains("completion")
            if hasEscapingContext {
                issues.append(CodeIssue(
                    line: nil,
                    titleRU: "Потенциальная циклическая ссылка (Retain Cycle)",
                    titleEN: "Potential Memory Leak (Retain Cycle)",
                    messageRU: "Захват 'self' внутри замыкания класса создает сильную циклическую ссылку ARC.",
                    messageEN: "Capturing 'self' strongly in a class closure creates an ARC retain cycle.",
                    severity: .warning,
                    suggestionRU: "Используйте список захвата: '{ [weak self] in guard let self else { return } ... }'.",
                    suggestionEN: "Use a capture list: '{ [weak self] in guard let self else { return } ... }'."
                ))
                score -= 10
            }
        }
        
        // 5. SwiftUI Modifier Order (.background before .padding)
        if code.contains(".background(") && code.contains(".padding(") {
            let bgIndex = code.range(of: ".background(")?.lowerBound
            let padIndex = code.range(of: ".padding(")?.lowerBound
            if let bg = bgIndex, let pad = padIndex, bg < pad {
                issues.append(CodeIssue(
                    line: nil,
                    titleRU: "Порядок модификаторов: .background перед .padding",
                    titleEN: "SwiftUI Modifier Order: background before padding",
                    messageRU: "Модификатор .background применится только к размеру контента, а последующий .padding добавит пустое пространство снаружи фона.",
                    messageEN: "In SwiftUI, .background before .padding only colors the unpadded content; padding is added outside.",
                    severity: .tip,
                    suggestionRU: "Поменяйте порядок: сначала .padding(), затем .background(...).",
                    suggestionEN: "Call .padding() first, then .background(...)."
                ))
                score -= 5
            }
        }
        
        // 6. NavigationStack / NavigationView check
        if code.contains("NavigationView") {
            issues.append(CodeIssue(
                line: nil,
                titleRU: "Устаревший контейнер: NavigationView",
                titleEN: "Deprecated Container: NavigationView",
                messageRU: "NavigationView устарел начиная с iOS 16 и заменен на NavigationStack.",
                messageEN: "NavigationView is deprecated starting with iOS 16.",
                severity: .warning,
                suggestionRU: "Замените 'NavigationView' на 'NavigationStack'.",
                suggestionEN: "Replace 'NavigationView' with 'NavigationStack'."
            ))
            score -= 10
        }
        
        score = max(20, min(100, score))
        
        bestPracticesRU.append("Всегда отдавайте предпочтение 'let' перед 'var', если значение не изменяется.")
        bestPracticesRU.append("В SwiftUI объявляйте свойства @State приватными ('private').")
        bestPracticesRU.append("Используйте безопасное извлечение опционалов через guard let / if let.")
        
        bestPracticesEN.append("Always prefer 'let' over 'var' when values do not change.")
        bestPracticesEN.append("Mark SwiftUI @State properties as 'private'.")
        bestPracticesEN.append("Use safe optional unwrapping with guard let / if let.")
        
        let fixed = generateRefactoredCode(
            original: code,
            mutatedLetNames: mutatedLetNames,
            missingStateVarNames: missingStateVarNames,
            issues: issues
        )
        
        let summaryRU = issues.isEmpty
            ? "Синтаксических и архитектурных дефектов не обнаружено. Код соответствует стандартам Swift и SwiftUI."
            : "Обнаружено замечаний: \(issues.count). Рекомендации и вариант рефакторинга приведены ниже."
            
        let summaryEN = issues.isEmpty
            ? "No syntax or architectural defects found. Code adheres to Swift and SwiftUI standards."
            : "Detected \(issues.count) issues. Review recommendations and refactored solution below."
            
        return CodeAnalysisResult(
            score: score,
            issues: issues,
            summaryRU: summaryRU,
            summaryEN: summaryEN,
            fixedCode: fixed,
            bestPracticesRU: bestPracticesRU,
            bestPracticesEN: bestPracticesEN
        )
    }
    
    private func removeStringLiterals(from line: String) -> String {
        var result = ""
        var inString = false
        var prevChar: Character? = nil
        
        for ch in line {
            if ch == "\"" && prevChar != "\\" {
                inString.toggle()
                prevChar = ch
                continue
            }
            if !inString {
                result.append(ch)
            }
            prevChar = ch
        }
        return result
    }
    
    private func containsForceUnwrapBang(_ text: String) -> Bool {
        let tokens = text.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        for token in tokens {
            if token.hasPrefix("!") { continue } // Boolean NOT e.g. !isValid
            if token.contains("!=") { continue }
            if token.hasSuffix("!") || token.contains("!)") || token.contains("!,") || token.contains("!.") {
                return true
            }
        }
        return false
    }
    
    private func generateRefactoredCode(
        original: String,
        mutatedLetNames: Set<String>,
        missingStateVarNames: Set<String>,
        issues: [CodeIssue]
    ) -> String {
        var result = original
        
        // 1. Replace NavigationView
        if result.contains("NavigationView") {
            result = result.replacingOccurrences(of: "NavigationView", with: "NavigationStack")
        }
        
        // 2. Fix mutated let -> var
        for varName in mutatedLetNames {
            result = result.replacingOccurrences(of: "let \(varName) ", with: "var \(varName) ")
            result = result.replacingOccurrences(of: "let \(varName):", with: "var \(varName):")
            result = result.replacingOccurrences(of: "let \(varName)=", with: "var \(varName)=")
        }
        
        // 3. Fix missing @State
        for varName in missingStateVarNames {
            result = result.replacingOccurrences(of: "var \(varName) ", with: "@State private var \(varName) ")
            result = result.replacingOccurrences(of: "var \(varName):", with: "@State private var \(varName):")
        }
        
        // 4. Fix force unwrap
        if issues.contains(where: { $0.titleEN.contains("Force Unwrap") }) {
            result = result.replacingOccurrences(of: "Int(input)!", with: "Int(input) ?? 0")
            result = result.replacingOccurrences(of: "Int(text)!", with: "Int(text) ?? 0")
            result = result.replacingOccurrences(of: "as! ", with: "as? ")
        }
        
        // 5. Fix modifier ordering (swap background and padding if adjacent)
        if result.contains(".background(") && result.contains(".padding(") {
            let lines = result.components(separatedBy: .newlines)
            var newLines: [String] = []
            var skipNext = false
            
            for i in 0..<lines.count {
                if skipNext {
                    skipNext = false
                    continue
                }
                
                let line = lines[i]
                if i + 1 < lines.count {
                    let nextLine = lines[i + 1]
                    if line.contains(".background(") && nextLine.contains(".padding(") {
                        let indent = line.prefix(while: { $0 == " " || $0 == "\t" })
                        let padTrimmed = nextLine.trimmingCharacters(in: .whitespaces)
                        let bgTrimmed = line.trimmingCharacters(in: .whitespaces)
                        newLines.append("\(indent)\(padTrimmed)")
                        newLines.append("\(indent)\(bgTrimmed)")
                        skipNext = true
                        continue
                    }
                }
                newLines.append(line)
            }
            result = newLines.joined(separator: "\n")
        }
        
        return result
    }
}
