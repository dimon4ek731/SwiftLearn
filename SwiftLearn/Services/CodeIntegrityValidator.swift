import Foundation

public struct CodeIntegrityValidationResult {
    public let isValid: Bool
    public let failureReasonRU: String
    public let failureReasonEN: String
    
    public static let valid = CodeIntegrityValidationResult(isValid: true, failureReasonRU: "", failureReasonEN: "")
}

public final class CodeIntegrityValidator {
    public static let shared = CodeIntegrityValidator()
    
    public init() {}
    
    /// Checks whether the user code contains genuine computations rather than hardcoded returns.
    public func validate(code: String, challenge: LessonPracticeChallenge) -> CodeIntegrityValidationResult {
        let trimmed = code.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 1. Extract function parameters from starter code
        let parameters = extractParameterNames(from: challenge.starterCode)
        
        // 2. Locate function body
        guard let body = extractFunctionBody(from: trimmed) else {
            return CodeIntegrityValidationResult(
                isValid: false,
                failureReasonRU: "Тело функции не найдено. Убедитесь, что фигурные скобки { } расставлены корректно.",
                failureReasonEN: "Function body not found. Ensure braces { } are placed correctly."
            )
        }
        
        let cleanedBody = stripCommentsAndStrings(from: body)
        let bodyTokens = cleanedBody.components(separatedBy: CharacterSet.alphanumerics.inverted).filter { !$0.isEmpty }
        
        // 3. Parameter Usage Check:
        // If the function takes input parameters, they MUST be referenced in the body to perform computations!
        if !parameters.isEmpty {
            let usedParameters = parameters.filter { param in
                bodyTokens.contains(param)
            }
            if usedParameters.isEmpty {
                let paramsList = parameters.joined(separator: ", ")
                return CodeIntegrityValidationResult(
                    isValid: false,
                    failureReasonRU: "Анти-хардкод: функция не использует входные параметры (\(paramsList)). Обязательно должно выполняться вычисление на их основе!",
                    failureReasonEN: "Anti-hardcode: function does not use input parameters (\(paramsList)). Actual computation must be performed!"
                )
            }
        }
        
        // 4. Computation Operations Check:
        // Ensure the body is not just returning a static constant value
        let statements = cleanedBody.components(separatedBy: .newlines)
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
        
        if statements.count == 1, let stmt = statements.first, stmt.hasPrefix("return") {
            let expr = String(stmt.dropFirst(6)).trimmingCharacters(in: .whitespaces)
            let hasOperators = expr.contains("+") || expr.contains("-") || expr.contains("*") ||
                               expr.contains("/") || expr.contains("%") || expr.contains("==") ||
                               expr.contains("!=") || expr.contains("<") || expr.contains(">") ||
                               expr.contains("?") || expr.contains("!") || expr.contains(".") ||
                               expr.contains("...") || expr.contains("..<")
            let hasParamRef = parameters.contains(where: { expr.contains($0) })
            
            if !hasOperators && !hasParamRef {
                return CodeIntegrityValidationResult(
                    isValid: false,
                    failureReasonRU: "Анти-хардкод: обнаружен фиксированный константный возврат. Запрещено возвращать захардкоженный ответ без алгоритма.",
                    failureReasonEN: "Anti-hardcode: constant return detected. Returning a static answer without algorithmic logic is forbidden."
                )
            }
        }
        
        // 5. Test Case Direct Literal Hardcoding Check:
        // Ensure user hasn't hardcoded `return <expectedOutput>` for all visible test cases
        var hardcodedMatches = 0
        for tc in challenge.testCases {
            let expected = tc.expectedOutput.trimmingCharacters(in: .whitespaces)
            if expected.count > 1 && expected != "true" && expected != "false" && expected != "0" {
                if cleanedBody.contains("return " + expected) || cleanedBody.contains("return(" + expected + ")") {
                    hardcodedMatches += 1
                }
            }
        }
        
        if hardcodedMatches >= challenge.testCases.count && hardcodedMatches > 0 {
            return CodeIntegrityValidationResult(
                isValid: false,
                failureReasonRU: "Анти-хардкод: обнаружены захардкоженные константы из тестов. Напишите реальный алгоритм решения!",
                failureReasonEN: "Anti-hardcode: detected hardcoded constants from test cases. Write genuine algorithmic code!"
            )
        }
        
        return .valid
    }
    
    private func extractParameterNames(from starterCode: String) -> [String] {
        guard let openParen = starterCode.firstIndex(of: "("),
              let closeParen = starterCode[openParen...].firstIndex(of: ")") else {
            return []
        }
        let paramsText = String(starterCode[starterCode.index(after: openParen)..<closeParen])
        let parts = paramsText.components(separatedBy: ",")
        var result: [String] = []
        for part in parts {
            var p = part.trimmingCharacters(in: .whitespaces)
            if let colon = p.firstIndex(of: ":") {
                p = String(p[..<colon]).trimmingCharacters(in: .whitespaces)
            }
            let tokens = p.components(separatedBy: .whitespaces).filter { !$0.isEmpty }
            if tokens.count == 2 {
                if tokens[1] != "_" {
                    result.append(tokens[1]) // Swift: `_ value` -> `value` or C#: `int value` -> `value`
                }
            } else if tokens.count == 1 && tokens[0] != "_" {
                result.append(tokens[0]) // Python: `value`
            }
        }
        return result
    }
    
    private func extractFunctionBody(from code: String) -> String? {
        if let firstBrace = code.firstIndex(of: "{"),
           let lastBrace = code.lastIndex(of: "}") {
            if firstBrace < lastBrace {
                return String(code[code.index(after: firstBrace)..<lastBrace])
            }
        }
        // Python indentation-based function body
        let lines = code.components(separatedBy: .newlines)
        var bodyLines: [String] = []
        var insideDef = false
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if trimmed.hasPrefix("def ") && trimmed.contains(":") {
                insideDef = true
                continue
            }
            if insideDef {
                if line.hasPrefix("    ") || line.hasPrefix("\t") {
                    bodyLines.append(line)
                } else if !trimmed.isEmpty {
                    break
                }
            }
        }
        if !bodyLines.isEmpty {
            return bodyLines.joined(separator: "\n")
        }
        return nil
    }
    
    private func stripCommentsAndStrings(from text: String) -> String {
        var result = ""
        var inQuotes = false
        var inLineComment = false
        let chars = Array(text)
        var i = 0
        while i < chars.count {
            let ch = chars[i]
            if inLineComment {
                if ch == "\n" {
                    inLineComment = false
                    result.append(ch)
                }
                i += 1
                continue
            }
            if ch == "\"" || ch == "'" {
                inQuotes.toggle()
                result.append(" ")
                i += 1
                continue
            }
            if !inQuotes {
                if (ch == "/" && i + 1 < chars.count && chars[i+1] == "/") || ch == "#" {
                    inLineComment = true
                    i += (ch == "#" ? 1 : 2)
                    continue
                }
            }
            if !inQuotes {
                result.append(ch)
            } else {
                result.append(" ")
            }
            i += 1
        }
        return result
    }
}
