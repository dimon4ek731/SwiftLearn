import Foundation
import SQLite3

public struct RuntimeVariable: Identifiable, Equatable {
    public var id: String { name }
    public let name: String
    public let typeName: String
    public let valueDescription: String
    public let isConstant: Bool
}

public struct RuntimeError: Equatable {
    public let line: Int
    public let message: String
}

public struct PlaygroundExecutionResult: Equatable {
    public let success: Bool
    public let output: String
    public let durationMs: Double
    public let variables: [RuntimeVariable]
    public let error: RuntimeError?
    
    public static var empty: PlaygroundExecutionResult {
        PlaygroundExecutionResult(
            success: true,
            output: "",
            durationMs: 0.0,
            variables: [],
            error: nil
        )
    }
}

public final class PlaygroundEngine {
    public static let shared = PlaygroundEngine()
    
    public init() {}
    
    // MARK: - Core Execution
    public func execute(code: String, language: TargetLanguage = .swift) async -> PlaygroundExecutionResult {
        if language == .sql {
            return await Task.detached(priority: .userInitiated) {
                let start = DispatchTime.now()
                let result = PlaygroundEngine.executeSQLite(script: code)
                let end = DispatchTime.now()
                let durationMs = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000.0
                
                return PlaygroundExecutionResult(
                    success: result.error == nil,
                    output: result.output.joined(separator: "\n"),
                    durationMs: durationMs,
                    variables: [],
                    error: result.error != nil ? RuntimeError(line: 1, message: result.error!) : nil
                )
            }.value
        }
        
        return await Task.detached(priority: .userInitiated) {
            let start = DispatchTime.now()
            let normalizedSource = PlaygroundEngine.normalizeCode(code, language: language)
            let interpreter = SwiftMiniInterpreter()
            let result = interpreter.run(source: normalizedSource)
            let end = DispatchTime.now()
            let durationMs = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000.0
            
            return PlaygroundExecutionResult(
                success: result.error == nil,
                output: result.output.joined(separator: "\n"),
                durationMs: durationMs,
                variables: result.variables,
                error: result.error
            )
        }.value
    }
    
    // MARK: - Native In-Memory SQLite Engine
    public static func executeSQLite(script: String) -> (output: [String], error: String?) {
        var db: OpaquePointer?
        guard sqlite3_open(":memory:", &db) == SQLITE_OK else {
            return ([], "Cannot initialize in-memory SQLite database.")
        }
        defer { sqlite3_close(db) }
        
        var outputLines: [String] = []
        let rawStatements = script.components(separatedBy: ";")
        
        for rawStmt in rawStatements {
            let stmt = rawStmt.trimmingCharacters(in: .whitespacesAndNewlines)
            if stmt.isEmpty { continue }
            
            var stmtPtr: OpaquePointer?
            if sqlite3_prepare_v2(db, stmt, -1, &stmtPtr, nil) == SQLITE_OK {
                let colCount = sqlite3_column_count(stmtPtr)
                var hasHeader = false
                
                while sqlite3_step(stmtPtr) == SQLITE_ROW {
                    if !hasHeader && colCount > 0 {
                        var headers: [String] = []
                        for c in 0..<colCount {
                            if let name = sqlite3_column_name(stmtPtr, c) {
                                headers.append(String(cString: name))
                            }
                        }
                        outputLines.append("| " + headers.joined(separator: " | ") + " |")
                        hasHeader = true
                    }
                    
                    var row: [String] = []
                    for c in 0..<colCount {
                        if let text = sqlite3_column_text(stmtPtr, c) {
                            row.append(String(cString: text))
                        } else {
                            row.append("NULL")
                        }
                    }
                    outputLines.append("| " + row.joined(separator: " | ") + " |")
                }
                sqlite3_finalize(stmtPtr)
            } else {
                let errMsg = String(cString: sqlite3_errmsg(db))
                return (outputLines, "SQL Error: \(errMsg)")
            }
        }
        
        if outputLines.isEmpty {
            outputLines.append("(Запрос выполнен успешно)")
        }
        
        return (outputLines, nil)
    }
    
    // MARK: - Multi-Language Normalization & Preprocessing
    public static func normalizeCode(_ source: String, language: TargetLanguage) -> String {
        switch language {
        case .swift, .sql:
            return source
            
        case .python:
            return transpilePythonToSwift(source)
            
        case .csharp:
            return transpileCSharpToSwift(source)
        }
    }
    
    private static func transpilePythonToSwift(_ source: String) -> String {
        let lines = source.components(separatedBy: .newlines)
        var outputLines: [String] = []
        var indentStack: [Int] = [0]
        
        for rawLine in lines {
            let trimmed = rawLine.trimmingCharacters(in: .whitespaces)
            if trimmed.isEmpty {
                outputLines.append("")
                continue
            }
            if trimmed.hasPrefix("#") {
                outputLines.append("//" + trimmed.dropFirst())
                continue
            }
            
            // Indentation stack management
            let currentIndent = rawLine.prefix(while: { $0 == " " || $0 == "\t" }).count
            while currentIndent < indentStack.last ?? 0 {
                indentStack.removeLast()
                let closingIndent = String(repeating: " ", count: indentStack.last ?? 0)
                outputLines.append("\(closingIndent)}")
            }
            
            // Function definition: def name(params):
            if trimmed.hasPrefix("def ") && trimmed.hasSuffix(":") {
                let sig = String(trimmed.dropFirst(4).dropLast()).trimmingCharacters(in: .whitespaces)
                if let openP = sig.firstIndex(of: "("), let closeP = sig.lastIndex(of: ")") {
                    let funcName = String(sig[..<openP]).trimmingCharacters(in: .whitespaces)
                    let paramsStr = String(sig[sig.index(after: openP)..<closeP]).trimmingCharacters(in: .whitespaces)
                    let pTokens = paramsStr.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty }
                    let swiftParams = pTokens.map { "_ \($0): Any" }.joined(separator: ", ")
                    
                    let indentSpaces = String(repeating: " ", count: currentIndent)
                    outputLines.append("\(indentSpaces)func \(funcName)(\(swiftParams)) {")
                    indentStack.append(currentIndent + 4)
                    continue
                }
            }
            
            var lineContent = trimmed
            lineContent = lineContent.replacingOccurrences(of: "True", with: "true")
            lineContent = lineContent.replacingOccurrences(of: "False", with: "false")
            lineContent = lineContent.replacingOccurrences(of: "None", with: "nil")
            lineContent = lineContent.replacingOccurrences(of: " and ", with: " && ")
            lineContent = lineContent.replacingOccurrences(of: " or ", with: " || ")
            if lineContent.hasPrefix("not ") {
                lineContent = "!" + lineContent.dropFirst(4)
            }
            
            let indentSpaces = String(repeating: " ", count: currentIndent)
            outputLines.append("\(indentSpaces)\(lineContent)")
        }
        
        while indentStack.count > 1 {
            indentStack.removeLast()
            let closingIndent = String(repeating: " ", count: indentStack.last ?? 0)
            outputLines.append("\(closingIndent)}")
        }
        
        return outputLines.joined(separator: "\n")
    }
    
    private static func transpileCSharpToSwift(_ source: String) -> String {
        let lines = source.components(separatedBy: .newlines)
        var outputLines: [String] = []
        
        for rawLine in lines {
            var trimmed = rawLine.trimmingCharacters(in: .whitespaces)
            if trimmed.isEmpty || trimmed.hasPrefix("//") {
                outputLines.append(rawLine)
                continue
            }
            
            // Console.WriteLine / Write
            if trimmed.contains("Console.WriteLine(") {
                trimmed = trimmed.replacingOccurrences(of: "Console.WriteLine(", with: "print(")
            }
            if trimmed.contains("Console.Write(") {
                trimmed = trimmed.replacingOccurrences(of: "Console.Write(", with: "print(")
            }
            
            // Replace C# method signature: e.g. public static int Add(int a, int b) {
            if (trimmed.contains("public") || trimmed.contains("static") || trimmed.contains("void") || trimmed.contains("int ") || trimmed.contains("string ") || trimmed.contains("double ")) && trimmed.contains("(") && trimmed.contains(")") {
                if !trimmed.hasPrefix("if") && !trimmed.hasPrefix("for") && !trimmed.hasPrefix("while") && !trimmed.hasPrefix("print") {
                    let cleaned = trimmed
                        .replacingOccurrences(of: "public ", with: "")
                        .replacingOccurrences(of: "private ", with: "")
                        .replacingOccurrences(of: "protected ", with: "")
                        .replacingOccurrences(of: "internal ", with: "")
                        .replacingOccurrences(of: "static ", with: "")
                    
                    if let openP = cleaned.firstIndex(of: "("), let closeP = cleaned.firstIndex(of: ")") {
                        let beforeP = String(cleaned[..<openP]).trimmingCharacters(in: .whitespaces)
                        let parts = beforeP.components(separatedBy: .whitespaces).filter { !$0.isEmpty }
                        if parts.count >= 2 {
                            let methodName = parts.last!
                            let paramsStr = String(cleaned[cleaned.index(after: openP)..<closeP]).trimmingCharacters(in: .whitespaces)
                            let pTokens = paramsStr.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty }
                            let swiftParams = pTokens.map { token -> String in
                                let tParts = token.components(separatedBy: .whitespaces).filter { !$0.isEmpty }
                                let pName = tParts.last ?? token
                                return "_ \(pName): Any"
                            }.joined(separator: ", ")
                            
                            trimmed = "func \(methodName)(\(swiftParams)) {"
                        }
                    }
                }
            }
            
            // Strip trailing semicolons
            if trimmed.hasSuffix(";") {
                trimmed = String(trimmed.dropLast())
            }
            
            trimmed = trimmed.replacingOccurrences(of: "null", with: "nil")
            trimmed = trimmed.replacingOccurrences(of: "new ", with: "")
            
            outputLines.append(trimmed)
        }
        
        return outputLines.joined(separator: "\n")
    }
}

// MARK: - Swift Value Types
enum SwiftVal: Equatable, CustomStringConvertible {
    case integer(Int)
    case double(Double)
    case string(String)
    case boolean(Bool)
    case array([SwiftVal])
    case tuple([SwiftVal])
    case structure(name: String, fields: [String: SwiftVal])
    case void
    
    var description: String {
        switch self {
        case .integer(let v): return "\(v)"
        case .double(let v): return "\(v)"
        case .string(let v): return v
        case .boolean(let v): return v ? "true" : "false"
        case .array(let v):
            let elements = v.map { $0.description }.joined(separator: ", ")
            return "[\(elements)]"
        case .tuple(let v):
            let elements = v.map { $0.description }.joined(separator: ", ")
            return "(\(elements))"
        case .structure(let name, let fields):
            let fieldStrs = fields.keys.sorted().map { "\($0): \(fields[$0]!.description)" }.joined(separator: ", ")
            return "\(name)(\(fieldStrs))"
        case .void: return "()"
        }
    }
    
    var typeName: String {
        switch self {
        case .integer: return "Int"
        case .double: return "Double"
        case .string: return "String"
        case .boolean: return "Bool"
        case .array(let v):
            let elemType = v.first?.typeName ?? "Any"
            return "[\(elemType)]"
        case .tuple(let v):
            let elemTypes = v.map { $0.typeName }.joined(separator: ", ")
            return "(\(elemTypes))"
        case .structure(let name, _): return name
        case .void: return "Void"
        }
    }
    
    var asBool: Bool {
        switch self {
        case .boolean(let b): return b
        case .integer(let i): return i != 0
        case .double(let d): return d != 0.0
        case .string(let s): return !s.isEmpty
        case .array(let a): return !a.isEmpty
        case .tuple: return true
        case .structure: return true
        case .void: return false
        }
    }
    
    var asDouble: Double? {
        switch self {
        case .integer(let i): return Double(i)
        case .double(let d): return d
        default: return nil
        }
    }
}

// MARK: - Mini Interpreter Implementation
final class SwiftMiniInterpreter {
    private struct VariableRecord {
        var value: SwiftVal
        let isConstant: Bool
    }
    
    struct FunctionDef {
        let name: String
        let parameters: [(label: String?, internalName: String)]
        let bodyLines: [String]
        let startLine: Int
    }
    
    struct StructDef {
        let name: String
        let fields: [(name: String, typeName: String, defaultValue: SwiftVal?)]
    }
    
    private var environment: [String: VariableRecord] = [:]
    private var functions: [String: FunctionDef] = [:]
    private var structs: [String: StructDef] = [:]
    
    private var outputLines: [String] = []
    private var error: RuntimeError?
    private var stepCount: Int = 0
    private let maxSteps = 5000
    
    private var callDepth: Int = 0
    private let maxCallDepth = 60
    
    private var hasReturned: Bool = false
    private var currentReturnValue: SwiftVal? = nil
    
    struct InterpreterOutput {
        let output: [String]
        let variables: [RuntimeVariable]
        let error: RuntimeError?
    }
    
    func run(source: String) -> InterpreterOutput {
        let rawLines = source.components(separatedBy: .newlines)
        
        var i = 0
        while i < rawLines.count && error == nil {
            let line = rawLines[i].trimmingCharacters(in: .whitespaces)
            let lineNumber = i + 1
            
            if line.isEmpty || line.hasPrefix("//") {
                i += 1
                continue
            }
            
            // Function Declaration: func name(...) -> ReturnType { ... }
            if line.hasPrefix("func ") {
                let nextIdx = parseFunctionDeclaration(lines: rawLines, startIndex: i)
                i = nextIdx
                continue
            }
            
            // Struct Declaration: struct Name { ... }
            if line.hasPrefix("struct ") {
                let nextIdx = parseStructDeclaration(lines: rawLines, startIndex: i)
                i = nextIdx
                continue
            }
            
            // Multi-line block structures: if, for, while
            if line.hasPrefix("if ") || line.hasPrefix("if(") {
                let (nextIdx, _) = executeIfBlock(lines: rawLines, startIndex: i)
                i = nextIdx
                continue
            } else if line.hasPrefix("for ") {
                let (nextIdx, _) = executeForBlock(lines: rawLines, startIndex: i)
                i = nextIdx
                continue
            } else if line.hasPrefix("while ") {
                let (nextIdx, _) = executeWhileBlock(lines: rawLines, startIndex: i)
                i = nextIdx
                continue
            }
            
            // Single line statement
            executeStatement(line: line, lineNumber: lineNumber)
            i += 1
        }
        
        let sortedVariables = environment.keys.filter { !$0.hasPrefix("$") }.sorted().map { key -> RuntimeVariable in
            let record = environment[key]!
            return RuntimeVariable(
                name: key,
                typeName: record.value.typeName,
                valueDescription: record.value.description,
                isConstant: record.isConstant
            )
        }
        
        return InterpreterOutput(
            output: outputLines,
            variables: sortedVariables,
            error: error
        )
    }
    
    // MARK: - Function Definition Parsing
    private func parseFunctionDeclaration(lines: [String], startIndex: Int) -> Int {
        let firstLine = lines[startIndex].trimmingCharacters(in: .whitespaces)
        guard let openParen = firstLine.firstIndex(of: "("),
              let closeParen = firstLine.firstIndex(of: ")"),
              firstLine.contains("{") else {
            error = RuntimeError(line: startIndex + 1, message: "Expected valid function signature with '{'")
            return startIndex + 1
        }
        
        let funcKeywordEnd = firstLine.index(firstLine.startIndex, offsetBy: 5)
        let funcName = String(firstLine[funcKeywordEnd..<openParen]).trimmingCharacters(in: .whitespaces)
        
        let paramsInside = String(firstLine[firstLine.index(after: openParen)..<closeParen]).trimmingCharacters(in: .whitespaces)
        var parameters: [(label: String?, internalName: String)] = []
        
        if !paramsInside.isEmpty {
            let paramParts = splitTopLevelArguments(paramsInside)
            for part in paramParts {
                var p = part.trimmingCharacters(in: .whitespaces)
                if let colon = p.firstIndex(of: ":") {
                    p = String(p[..<colon]).trimmingCharacters(in: .whitespaces)
                }
                let tokens = p.components(separatedBy: .whitespaces).filter { !$0.isEmpty }
                if tokens.count == 2 {
                    let external = tokens[0] == "_" ? nil : tokens[0]
                    parameters.append((label: external, internalName: tokens[1]))
                } else if tokens.count == 1 {
                    parameters.append((label: tokens[0], internalName: tokens[0]))
                }
            }
        }
        
        let (endIndex, body) = findBlockEnd(lines: lines, startIndex: startIndex)
        functions[funcName] = FunctionDef(
            name: funcName,
            parameters: parameters,
            bodyLines: body,
            startLine: startIndex + 2
        )
        return endIndex + 1
    }
    
    // MARK: - Struct Definition Parsing
    private func parseStructDeclaration(lines: [String], startIndex: Int) -> Int {
        let firstLine = lines[startIndex].trimmingCharacters(in: .whitespaces)
        guard let openBrace = firstLine.firstIndex(of: "{") else {
            error = RuntimeError(line: startIndex + 1, message: "Expected '{' after struct declaration")
            return startIndex + 1
        }
        
        let structKeywordEnd = firstLine.index(firstLine.startIndex, offsetBy: 7)
        let structName = String(firstLine[structKeywordEnd..<openBrace]).trimmingCharacters(in: .whitespaces)
        
        let (endIndex, body) = findBlockEnd(lines: lines, startIndex: startIndex)
        
        var fields: [(name: String, typeName: String, defaultValue: SwiftVal?)] = []
        for bodyLine in body {
            let trimmed = bodyLine.trimmingCharacters(in: .whitespaces)
            if trimmed.hasPrefix("var ") || trimmed.hasPrefix("let ") {
                let decl = String(trimmed.dropFirst(4)).trimmingCharacters(in: .whitespaces)
                var fieldName = decl
                var typeName = "Any"
                var defaultVal: SwiftVal? = nil
                
                if let eqIdx = decl.firstIndex(of: "=") {
                    let lhs = String(decl[..<eqIdx]).trimmingCharacters(in: .whitespaces)
                    let rhs = String(decl[decl.index(after: eqIdx)...]).trimmingCharacters(in: .whitespaces)
                    defaultVal = evaluateExpression(rhs, lineNumber: startIndex + 1)
                    fieldName = lhs
                }
                
                if let colon = fieldName.firstIndex(of: ":") {
                    typeName = String(fieldName[fieldName.index(after: colon)...]).trimmingCharacters(in: .whitespaces)
                    fieldName = String(fieldName[..<colon]).trimmingCharacters(in: .whitespaces)
                }
                fields.append((name: fieldName, typeName: typeName, defaultValue: defaultVal))
            }
        }
        
        structs[structName] = StructDef(name: structName, fields: fields)
        return endIndex + 1
    }
    
    // MARK: - Single Line Statement
    private func executeStatement(line: String, lineNumber: Int) {
        stepCount += 1
        if stepCount > maxSteps {
            error = RuntimeError(line: lineNumber, message: "Execution limit exceeded (possible infinite loop or deep recursion)")
            return
        }
        
        var stmt = line
        if stmt.hasSuffix(";") {
            stmt.removeLast()
            stmt = stmt.trimmingCharacters(in: .whitespaces)
        }
        
        // Return statement
        if stmt.hasPrefix("return") {
            hasReturned = true
            if stmt == "return" {
                currentReturnValue = .void
            } else if stmt.hasPrefix("return ") {
                let expr = String(stmt.dropFirst(7)).trimmingCharacters(in: .whitespaces)
                currentReturnValue = evaluateExpression(expr, lineNumber: lineNumber)
            }
            return
        }
        
        // print(...)
        if stmt.hasPrefix("print(") && stmt.hasSuffix(")") {
            executePrint(statement: stmt, lineNumber: lineNumber)
            return
        }
        
        // Array methods: .append(), .remove(at:)
        if stmt.contains(".append(") && stmt.hasSuffix(")") {
            executeArrayAppend(statement: stmt, lineNumber: lineNumber)
            return
        }
        if stmt.contains(".remove(at:") && stmt.hasSuffix(")") {
            executeArrayRemove(statement: stmt, lineNumber: lineNumber)
            return
        }
        
        // let / var declaration
        if stmt.hasPrefix("let ") || stmt.hasPrefix("var ") {
            let isLet = stmt.hasPrefix("let ")
            let decl = String(stmt.dropFirst(4)).trimmingCharacters(in: .whitespaces)
            
            guard let eqIdx = decl.firstIndex(of: "=") else {
                return
            }
            
            var varName = String(decl[..<eqIdx]).trimmingCharacters(in: .whitespaces)
            if let colonIdx = varName.firstIndex(of: ":") {
                varName = String(varName[..<colonIdx]).trimmingCharacters(in: .whitespaces)
            }
            
            let exprStr = String(decl[decl.index(after: eqIdx)...]).trimmingCharacters(in: .whitespaces)
            let val = evaluateExpression(exprStr, lineNumber: lineNumber)
            
            if environment[varName] != nil {
                error = RuntimeError(line: lineNumber, message: "Invalid redeclaration of '\(varName)'")
                return
            }
            
            environment[varName] = VariableRecord(value: val, isConstant: isLet)
            return
        }
        
        // Compound assignments: +=, -=, *=, /=
        let compoundOps = ["+=", "-=", "*=", "/="]
        for op in compoundOps {
            if let range = stmt.range(of: op) {
                let lhs = String(stmt[..<range.lowerBound]).trimmingCharacters(in: .whitespaces)
                let exprStr = String(stmt[range.upperBound...]).trimmingCharacters(in: .whitespaces)
                
                if lhs.contains(".") {
                    executeStructFieldCompoundAssign(lhs: lhs, op: op, exprStr: exprStr, lineNumber: lineNumber)
                } else {
                    executeCompoundAssign(varName: lhs, op: op, exprStr: exprStr, lineNumber: lineNumber)
                }
                return
            }
        }
        
        // Simple assignment: lhs = rhs
        if let eqIdx = stmt.firstIndex(of: "="), !stmt.contains("=="), !stmt.contains("<="), !stmt.contains(">="), !stmt.contains("!=") {
            let lhs = String(stmt[..<eqIdx]).trimmingCharacters(in: .whitespaces)
            let exprStr = String(stmt[stmt.index(after: eqIdx)...]).trimmingCharacters(in: .whitespaces)
            
            if lhs.contains("[") && lhs.hasSuffix("]") {
                executeArrayElementAssign(lhs: lhs, rhsExpr: exprStr, lineNumber: lineNumber)
                return
            }
            
            if lhs.contains(".") {
                executeStructFieldAssign(lhs: lhs, rhsExpr: exprStr, lineNumber: lineNumber)
                return
            }
            
            guard let record = environment[lhs] else {
                error = RuntimeError(line: lineNumber, message: "Cannot find '\(lhs)' in scope")
                return
            }
            
            if record.isConstant {
                error = RuntimeError(line: lineNumber, message: "Cannot assign to value: '\(lhs)' is a 'let' constant")
                return
            }
            
            let val = evaluateExpression(exprStr, lineNumber: lineNumber)
            environment[lhs] = VariableRecord(value: val, isConstant: false)
            return
        }
        
        // Expression call for side effects
        _ = evaluateExpression(stmt, lineNumber: lineNumber)
    }
    
    // MARK: - Print Statement
    private func executePrint(statement: String, lineNumber: Int) {
        let inside = String(statement.dropFirst(6).dropLast(1)).trimmingCharacters(in: .whitespaces)
        if inside.isEmpty {
            outputLines.append("")
            return
        }
        
        let args = splitTopLevelArguments(inside)
        var outputs: [String] = []
        for arg in args {
            let val = evaluateExpression(arg, lineNumber: lineNumber)
            outputs.append(val.description)
        }
        outputLines.append(outputs.joined(separator: " "))
    }
    
    // MARK: - Struct Property Assignments
    private func executeStructFieldAssign(lhs: String, rhsExpr: String, lineNumber: Int) {
        guard let dotIdx = lhs.firstIndex(of: ".") else { return }
        let varName = String(lhs[..<dotIdx]).trimmingCharacters(in: .whitespaces)
        let prop = String(lhs[lhs.index(after: dotIdx)...]).trimmingCharacters(in: .whitespaces)
        
        guard let record = environment[varName] else {
            error = RuntimeError(line: lineNumber, message: "Cannot find '\(varName)' in scope")
            return
        }
        if record.isConstant {
            error = RuntimeError(line: lineNumber, message: "Cannot assign to property: '\(varName)' is a 'let' constant")
            return
        }
        guard case .structure(let sName, var fields) = record.value else {
            error = RuntimeError(line: lineNumber, message: "'\(varName)' is not a struct")
            return
        }
        
        let newVal = evaluateExpression(rhsExpr, lineNumber: lineNumber)
        fields[prop] = newVal
        environment[varName] = VariableRecord(value: .structure(name: sName, fields: fields), isConstant: false)
    }
    
    private func executeStructFieldCompoundAssign(lhs: String, op: String, exprStr: String, lineNumber: Int) {
        guard let dotIdx = lhs.firstIndex(of: ".") else { return }
        let varName = String(lhs[..<dotIdx]).trimmingCharacters(in: .whitespaces)
        let prop = String(lhs[lhs.index(after: dotIdx)...]).trimmingCharacters(in: .whitespaces)
        
        guard let record = environment[varName] else {
            error = RuntimeError(line: lineNumber, message: "Cannot find '\(varName)' in scope")
            return
        }
        if record.isConstant {
            error = RuntimeError(line: lineNumber, message: "Cannot assign to property: '\(varName)' is a 'let' constant")
            return
        }
        guard case .structure(let sName, var fields) = record.value else {
            error = RuntimeError(line: lineNumber, message: "'\(varName)' is not a struct")
            return
        }
        
        guard let currentFieldVal = fields[prop] else {
            error = RuntimeError(line: lineNumber, message: "Value of type '\(sName)' has no member '\(prop)'")
            return
        }
        
        let rhsVal = evaluateExpression(exprStr, lineNumber: lineNumber)
        var updatedFieldVal = currentFieldVal
        
        if op == "+=" {
            if case .integer(let a) = currentFieldVal, case .integer(let b) = rhsVal { updatedFieldVal = .integer(a + b) }
            if case .double(let a) = currentFieldVal, let b = rhsVal.asDouble { updatedFieldVal = .double(a + b) }
            if case .string(let a) = currentFieldVal, case .string(let b) = rhsVal { updatedFieldVal = .string(a + b) }
        } else if op == "-=" {
            if case .integer(let a) = currentFieldVal, case .integer(let b) = rhsVal { updatedFieldVal = .integer(a - b) }
            if case .double(let a) = currentFieldVal, let b = rhsVal.asDouble { updatedFieldVal = .double(a - b) }
        } else if op == "*=" {
            if case .integer(let a) = currentFieldVal, case .integer(let b) = rhsVal { updatedFieldVal = .integer(a * b) }
            if case .double(let a) = currentFieldVal, let b = rhsVal.asDouble { updatedFieldVal = .double(a * b) }
        } else if op == "/=" {
            if case .integer(let a) = currentFieldVal, case .integer(let b) = rhsVal { updatedFieldVal = .integer(a / b) }
            if case .double(let a) = currentFieldVal, let b = rhsVal.asDouble { updatedFieldVal = .double(a / b) }
        }
        
        fields[prop] = updatedFieldVal
        environment[varName] = VariableRecord(value: .structure(name: sName, fields: fields), isConstant: false)
    }
    
    // MARK: - Array Mutation
    private func executeArrayAppend(statement: String, lineNumber: Int) {
        guard let dotIdx = statement.range(of: ".append(") else { return }
        let varName = String(statement[..<dotIdx.lowerBound]).trimmingCharacters(in: .whitespaces)
        guard let record = environment[varName] else {
            error = RuntimeError(line: lineNumber, message: "Cannot find array '\(varName)'")
            return
        }
        if record.isConstant {
            error = RuntimeError(line: lineNumber, message: "Cannot use mutating member on immutable value: '\(varName)' is a 'let' constant")
            return
        }
        guard case .array(var arr) = record.value else {
            error = RuntimeError(line: lineNumber, message: "'\(varName)' is not an array")
            return
        }
        
        let start = dotIdx.upperBound
        let end = statement.index(before: statement.endIndex)
        let exprStr = String(statement[start..<end]).trimmingCharacters(in: .whitespaces)
        let val = evaluateExpression(exprStr, lineNumber: lineNumber)
        arr.append(val)
        environment[varName] = VariableRecord(value: .array(arr), isConstant: false)
    }
    
    private func executeArrayRemove(statement: String, lineNumber: Int) {
        guard let dotIdx = statement.range(of: ".remove(at:") else { return }
        let varName = String(statement[..<dotIdx.lowerBound]).trimmingCharacters(in: .whitespaces)
        guard let record = environment[varName] else {
            error = RuntimeError(line: lineNumber, message: "Cannot find array '\(varName)'")
            return
        }
        if record.isConstant {
            error = RuntimeError(line: lineNumber, message: "Cannot mutate constant array '\(varName)'")
            return
        }
        guard case .array(var arr) = record.value else {
            error = RuntimeError(line: lineNumber, message: "'\(varName)' is not an array")
            return
        }
        
        let start = dotIdx.upperBound
        let end = statement.index(before: statement.endIndex)
        let exprStr = String(statement[start..<end]).trimmingCharacters(in: .whitespaces)
        let val = evaluateExpression(exprStr, lineNumber: lineNumber)
        if case .integer(let idx) = val {
            if idx >= 0 && idx < arr.count {
                arr.remove(at: idx)
                environment[varName] = VariableRecord(value: .array(arr), isConstant: false)
            } else {
                error = RuntimeError(line: lineNumber, message: "Fatal error: Index out of range (index: \(idx), size: \(arr.count))")
            }
        }
    }
    
    private func executeArrayElementAssign(lhs: String, rhsExpr: String, lineNumber: Int) {
        guard let openBracket = lhs.firstIndex(of: "["), lhs.hasSuffix("]") else { return }
        let varName = String(lhs[..<openBracket]).trimmingCharacters(in: .whitespaces)
        let indexExpr = String(lhs[lhs.index(after: openBracket)..<lhs.index(before: lhs.endIndex)])
        
        guard let record = environment[varName] else {
            error = RuntimeError(line: lineNumber, message: "Cannot find '\(varName)' in scope")
            return
        }
        if record.isConstant {
            error = RuntimeError(line: lineNumber, message: "Cannot assign to value: '\(varName)' is a 'let' constant")
            return
        }
        guard case .array(var arr) = record.value else {
            error = RuntimeError(line: lineNumber, message: "'\(varName)' is not an array")
            return
        }
        
        let idxVal = evaluateExpression(indexExpr, lineNumber: lineNumber)
        guard case .integer(let idx) = idxVal else {
            error = RuntimeError(line: lineNumber, message: "Subscript index must be an integer")
            return
        }
        
        if idx < 0 || idx >= arr.count {
            error = RuntimeError(line: lineNumber, message: "Fatal error: Index out of range (\(idx))")
            return
        }
        
        let newVal = evaluateExpression(rhsExpr, lineNumber: lineNumber)
        arr[idx] = newVal
        environment[varName] = VariableRecord(value: .array(arr), isConstant: false)
    }
    
    // MARK: - Compound Assign
    private func executeCompoundAssign(varName: String, op: String, exprStr: String, lineNumber: Int) {
        guard let record = environment[varName] else {
            error = RuntimeError(line: lineNumber, message: "Cannot find '\(varName)' in scope")
            return
        }
        if record.isConstant {
            error = RuntimeError(line: lineNumber, message: "Left side of mutating operator isn't mutable: '\(varName)' is a 'let' constant")
            return
        }
        
        let rhsVal = evaluateExpression(exprStr, lineNumber: lineNumber)
        let current = record.value
        
        var newVal: SwiftVal = current
        switch (current, rhsVal, op) {
        case (.integer(let a), .integer(let b), "+="): newVal = .integer(a + b)
        case (.integer(let a), .integer(let b), "-="): newVal = .integer(a - b)
        case (.integer(let a), .integer(let b), "*="): newVal = .integer(a * b)
        case (.integer(let a), .integer(let b), "/="):
            if b == 0 {
                error = RuntimeError(line: lineNumber, message: "Fatal error: Division by zero")
                return
            }
            newVal = .integer(a / b)
            
        case (.double(let a), .double(let b), "+="): newVal = .double(a + b)
        case (.double(let a), .integer(let b), "+="): newVal = .double(a + Double(b))
        case (.double(let a), .double(let b), "-="): newVal = .double(a - b)
        case (.double(let a), .integer(let b), "-="): newVal = .double(a - Double(b))
        case (.double(let a), .double(let b), "*="): newVal = .double(a * b)
        case (.double(let a), .integer(let b), "*="): newVal = .double(a * Double(b))
        case (.double(let a), .double(let b), "/="): newVal = .double(a / b)
            
        case (.string(let a), .string(let b), "+="): newVal = .string(a + b)
        case (.array(var a), .array(let b), "+="):
            a.append(contentsOf: b)
            newVal = .array(a)
        default:
            error = RuntimeError(line: lineNumber, message: "Binary operator '\(op)' cannot be applied to operands of type '\(current.typeName)' and '\(rhsVal.typeName)'")
            return
        }
        
        environment[varName] = VariableRecord(value: newVal, isConstant: false)
    }
    
    // MARK: - Block Finders
    private func findBlockEnd(lines: [String], startIndex: Int) -> (endIndex: Int, blockLines: [String]) {
        var depth = 0
        var block: [String] = []
        var i = startIndex
        
        while i < lines.count {
            let line = lines[i]
            for ch in line {
                if ch == "{" {
                    depth += 1
                } else if ch == "}" {
                    depth -= 1
                    if depth == 0 {
                        return (i, block)
                    }
                }
            }
            if i > startIndex {
                block.append(line)
            }
            i += 1
        }
        return (i, block)
    }
    
    // MARK: - Control Flow: IF
    private func executeIfBlock(lines: [String], startIndex: Int) -> (nextIndex: Int, executed: Bool) {
        let firstLine = lines[startIndex].trimmingCharacters(in: .whitespaces)
        guard let openBrace = firstLine.firstIndex(of: "{") else {
            error = RuntimeError(line: startIndex + 1, message: "Expected '{' after if condition")
            return (startIndex + 1, false)
        }
        
        let condStr = String(firstLine.dropFirst(2)[..<openBrace]).trimmingCharacters(in: .whitespaces)
        let isTrue = evaluateExpression(condStr, lineNumber: startIndex + 1).asBool
        
        let (endIndex, blockLines) = findBlockEnd(lines: lines, startIndex: startIndex)
        
        if isTrue {
            runBlock(lines: blockLines, baseLine: startIndex + 2)
            var next = endIndex + 1
            if next < lines.count {
                let trimmed = lines[next].trimmingCharacters(in: .whitespaces)
                if trimmed.hasPrefix("else") {
                    let (elseEnd, _) = findBlockEnd(lines: lines, startIndex: next)
                    next = elseEnd + 1
                }
            }
            return (next, true)
        } else {
            let next = endIndex + 1
            if next < lines.count {
                let trimmed = lines[next].trimmingCharacters(in: .whitespaces)
                if trimmed.hasPrefix("else if") {
                    var copyLines = lines
                    copyLines[next] = trimmed.replacingOccurrences(of: "else if", with: "if")
                    let (elseIfEnd, _) = executeIfBlock(lines: copyLines, startIndex: next)
                    return (elseIfEnd, false)
                } else if trimmed.hasPrefix("else") {
                    let (elseEnd, elseBlock) = findBlockEnd(lines: lines, startIndex: next)
                    runBlock(lines: elseBlock, baseLine: next + 2)
                    return (elseEnd + 1, false)
                }
            }
            return (endIndex + 1, false)
        }
    }
    
    // MARK: - Control Flow: FOR
    private func executeForBlock(lines: [String], startIndex: Int) -> (nextIndex: Int, executed: Bool) {
        let firstLine = lines[startIndex].trimmingCharacters(in: .whitespaces)
        guard let openBrace = firstLine.firstIndex(of: "{") else {
            error = RuntimeError(line: startIndex + 1, message: "Expected '{' after for clause")
            return (startIndex + 1, false)
        }
        
        let clause = String(firstLine.dropFirst(4)[..<openBrace]).trimmingCharacters(in: .whitespaces)
        guard let inRange = clause.range(of: " in ") else {
            error = RuntimeError(line: startIndex + 1, message: "Expected 'in' in for loop")
            return (startIndex + 1, false)
        }
        
        let varName = String(clause[..<inRange.lowerBound]).trimmingCharacters(in: .whitespaces)
        let iterExpr = String(clause[inRange.upperBound...]).trimmingCharacters(in: .whitespaces)
        
        let (endIndex, blockLines) = findBlockEnd(lines: lines, startIndex: startIndex)
        
        if iterExpr.contains("...") || iterExpr.contains("..<") {
            let isClosed = iterExpr.contains("...")
            let sep = isClosed ? "..." : "..<"
            let parts = iterExpr.components(separatedBy: sep)
            if parts.count == 2 {
                let startVal = evaluateExpression(parts[0].trimmingCharacters(in: .whitespaces), lineNumber: startIndex + 1)
                let endVal = evaluateExpression(parts[1].trimmingCharacters(in: .whitespaces), lineNumber: startIndex + 1)
                
                if case .integer(let startInt) = startVal, case .integer(let endInt) = endVal {
                    let rangeValues: [Int] = isClosed ? Array(startInt...endInt) : Array(startInt..<endInt)
                    var count = 0
                    for num in rangeValues {
                        count += 1
                        if count > 1000 {
                            error = RuntimeError(line: startIndex + 1, message: "Loop iteration limit exceeded")
                            break
                        }
                        environment[varName] = VariableRecord(value: .integer(num), isConstant: true)
                        runBlock(lines: blockLines, baseLine: startIndex + 2)
                        if error != nil || hasReturned { break }
                    }
                }
            }
        } else {
            let val = evaluateExpression(iterExpr, lineNumber: startIndex + 1)
            if case .array(let arr) = val {
                var count = 0
                for item in arr {
                    count += 1
                    if count > 1000 {
                        error = RuntimeError(line: startIndex + 1, message: "Loop iteration limit exceeded")
                        break
                    }
                    environment[varName] = VariableRecord(value: item, isConstant: true)
                    runBlock(lines: blockLines, baseLine: startIndex + 2)
                    if error != nil || hasReturned { break }
                }
            }
        }
        
        return (endIndex + 1, true)
    }
    
    // MARK: - Control Flow: WHILE
    private func executeWhileBlock(lines: [String], startIndex: Int) -> (nextIndex: Int, executed: Bool) {
        let firstLine = lines[startIndex].trimmingCharacters(in: .whitespaces)
        guard let openBrace = firstLine.firstIndex(of: "{") else {
            error = RuntimeError(line: startIndex + 1, message: "Expected '{' after while condition")
            return (startIndex + 1, false)
        }
        
        let condStr = String(firstLine.dropFirst(6)[..<openBrace]).trimmingCharacters(in: .whitespaces)
        let (endIndex, blockLines) = findBlockEnd(lines: lines, startIndex: startIndex)
        
        var iterations = 0
        while evaluateExpression(condStr, lineNumber: startIndex + 1).asBool {
            iterations += 1
            if iterations > 2000 {
                error = RuntimeError(line: startIndex + 1, message: "Fatal error: infinite while loop detected (exceeded 2000 iterations)")
                break
            }
            runBlock(lines: blockLines, baseLine: startIndex + 2)
            if error != nil || hasReturned { break }
        }
        
        return (endIndex + 1, true)
    }
    
    private func runBlock(lines: [String], baseLine: Int) {
        var i = 0
        while i < lines.count && error == nil && !hasReturned {
            let line = lines[i].trimmingCharacters(in: .whitespaces)
            let currLineNum = baseLine + i
            if line.isEmpty || line.hasPrefix("//") {
                i += 1
                continue
            }
            if line.hasPrefix("if ") || line.hasPrefix("if(") {
                let (nextIdx, _) = executeIfBlock(lines: lines, startIndex: i)
                i = nextIdx
                continue
            } else if line.hasPrefix("for ") {
                let (nextIdx, _) = executeForBlock(lines: lines, startIndex: i)
                i = nextIdx
                continue
            } else if line.hasPrefix("while ") {
                let (nextIdx, _) = executeWhileBlock(lines: lines, startIndex: i)
                i = nextIdx
                continue
            }
            executeStatement(line: line, lineNumber: currLineNum)
            i += 1
        }
    }
    
    // MARK: - User Function Execution
    private func executeFunctionCall(name: String, argsText: String, lineNumber: Int) -> SwiftVal {
        guard let funcDef = functions[name] else { return .void }
        
        callDepth += 1
        if callDepth > maxCallDepth {
            error = RuntimeError(line: lineNumber, message: "Stack overflow: maximum call depth (\(maxCallDepth)) exceeded in recursion")
            callDepth -= 1
            return .void
        }
        
        let argStrings = splitTopLevelArguments(argsText)
        var evaluatedArgs: [SwiftVal] = []
        var labeledArgs: [String: SwiftVal] = [:]
        
        for (idx, argStr) in argStrings.enumerated() {
            var label: String? = nil
            var expr = argStr
            if let colon = argStr.firstIndex(of: ":") {
                let candidate = String(argStr[..<colon]).trimmingCharacters(in: .whitespaces)
                if !candidate.contains(" ") && !candidate.contains("\"") {
                    label = candidate
                    expr = String(argStr[argStr.index(after: colon)...]).trimmingCharacters(in: .whitespaces)
                }
            }
            let val = evaluateExpression(expr, lineNumber: lineNumber)
            evaluatedArgs.append(val)
            if let label = label {
                labeledArgs[label] = val
            }
            if idx < funcDef.parameters.count {
                let param = funcDef.parameters[idx]
                if let extLabel = param.label {
                    labeledArgs[extLabel] = val
                }
            }
        }
        
        let savedEnvironment = environment
        let savedReturned = hasReturned
        let savedReturnVal = currentReturnValue
        
        hasReturned = false
        currentReturnValue = nil
        
        for (idx, param) in funcDef.parameters.enumerated() {
            var valToBind: SwiftVal = .void
            if let extLabel = param.label, let val = labeledArgs[extLabel] {
                valToBind = val
            } else if idx < evaluatedArgs.count {
                valToBind = evaluatedArgs[idx]
            }
            environment[param.internalName] = VariableRecord(value: valToBind, isConstant: true)
        }
        
        runBlock(lines: funcDef.bodyLines, baseLine: funcDef.startLine)
        
        let returnValue = currentReturnValue ?? .void
        
        for (key, rec) in savedEnvironment {
            if environment[key] != nil && !funcDef.parameters.contains(where: { $0.internalName == key }) {
                // Keep mutated globals
            } else {
                environment[key] = rec
            }
        }
        for param in funcDef.parameters {
            if savedEnvironment[param.internalName] == nil {
                environment.removeValue(forKey: param.internalName)
            }
        }
        
        hasReturned = savedReturned
        currentReturnValue = savedReturnVal
        callDepth -= 1
        
        return returnValue
    }
    
    // MARK: - Struct Instantiation
    private func instantiateStruct(name: String, argsText: String, lineNumber: Int) -> SwiftVal {
        guard let sDef = structs[name] else { return .void }
        let argStrings = splitTopLevelArguments(argsText)
        var fields: [String: SwiftVal] = [:]
        
        var positionalIdx = 0
        for arg in argStrings {
            if let colon = arg.firstIndex(of: ":") {
                let fieldName = String(arg[..<colon]).trimmingCharacters(in: .whitespaces)
                let expr = String(arg[arg.index(after: colon)...]).trimmingCharacters(in: .whitespaces)
                fields[fieldName] = evaluateExpression(expr, lineNumber: lineNumber)
            } else if positionalIdx < sDef.fields.count {
                let fieldName = sDef.fields[positionalIdx].name
                fields[fieldName] = evaluateExpression(arg, lineNumber: lineNumber)
                positionalIdx += 1
            }
        }
        
        for field in sDef.fields {
            if fields[field.name] == nil, let defVal = field.defaultValue {
                fields[field.name] = defVal
            }
        }
        
        return .structure(name: name, fields: fields)
    }
    
    // MARK: - Expression Evaluation
    private func evaluateExpression(_ expr: String, lineNumber: Int) -> SwiftVal {
        let trimmed = expr.trimmingCharacters(in: .whitespaces)
        
        if trimmed == "true" { return .boolean(true) }
        if trimmed == "false" { return .boolean(false) }
        
        // String literal with quotes
        if trimmed.hasPrefix("\"") && trimmed.hasSuffix("\"") && trimmed.count >= 2 {
            var raw = String(trimmed.dropFirst().dropLast())
            while let startRange = raw.range(of: "\\(") {
                if let endRange = raw[startRange.upperBound...].range(of: ")") {
                    let subExpr = String(raw[startRange.upperBound..<endRange.lowerBound])
                    let subVal = evaluateExpression(subExpr, lineNumber: lineNumber)
                    raw.replaceSubrange(startRange.lowerBound..<endRange.upperBound, with: subVal.description)
                } else {
                    break
                }
            }
            return .string(raw)
        }
        
        // Array literal [1, 2, 3]
        if trimmed.hasPrefix("[") && trimmed.hasSuffix("]") && !trimmed.contains(":") {
            let inside = String(trimmed.dropFirst().dropLast()).trimmingCharacters(in: .whitespaces)
            if inside.isEmpty { return .array([]) }
            let items = splitTopLevelArguments(inside)
            let parsed = items.map { evaluateExpression($0, lineNumber: lineNumber) }
            return .array(parsed)
        }
        
        // Parenthesized expression or Tuple: (x) or (a, b)
        if trimmed.hasPrefix("(") && trimmed.hasSuffix(")") && isBalancedEnclosure(trimmed) {
            let inside = String(trimmed.dropFirst().dropLast()).trimmingCharacters(in: .whitespaces)
            let parts = splitTopLevelArguments(inside)
            if parts.count == 1 {
                return evaluateExpression(parts[0], lineNumber: lineNumber)
            } else if parts.count > 1 {
                let elements = parts.map { evaluateExpression($0, lineNumber: lineNumber) }
                return .tuple(elements)
            }
        }
        
        // Function call: funcName(...)
        if let (funcName, argsInside) = isTopLevelFunctionCall(trimmed) {
            if functions[funcName] != nil {
                return executeFunctionCall(name: funcName, argsText: argsInside, lineNumber: lineNumber)
            }
            if structs[funcName] != nil {
                return instantiateStruct(name: funcName, argsText: argsInside, lineNumber: lineNumber)
            }
        }
        
        // Property calls and closures e.g. arr.map { $0 * 2 }, arr.filter { $0 > 10 }
        if trimmed.contains(".") {
            if let result = evaluatePropertyOrClosureCall(trimmed, lineNumber: lineNumber) {
                return result
            }
        }
        
        // Type initializers: Double(x), Int(x), String(x)
        if trimmed.hasPrefix("Double(") && trimmed.hasSuffix(")") {
            let arg = String(trimmed.dropFirst(7).dropLast())
            let val = evaluateExpression(arg, lineNumber: lineNumber)
            if let d = val.asDouble { return .double(d) }
            if case .string(let s) = val, let d = Double(s) { return .double(d) }
        }
        if trimmed.hasPrefix("Int(") && trimmed.hasSuffix(")") {
            let arg = String(trimmed.dropFirst(4).dropLast())
            let val = evaluateExpression(arg, lineNumber: lineNumber)
            if case .integer(let i) = val { return .integer(i) }
            if case .double(let d) = val { return .integer(Int(d)) }
            if case .string(let s) = val, let i = Int(s) { return .integer(i) }
        }
        if trimmed.hasPrefix("String(") && trimmed.hasSuffix(")") {
            let arg = String(trimmed.dropFirst(7).dropLast())
            let val = evaluateExpression(arg, lineNumber: lineNumber)
            return .string(val.description)
        }
        
        // Built-in functions: abs(x), min(a, b), max(a, b), sqrt(x)
        if trimmed.hasPrefix("abs(") && trimmed.hasSuffix(")") {
            let arg = String(trimmed.dropFirst(4).dropLast())
            let val = evaluateExpression(arg, lineNumber: lineNumber)
            if case .integer(let i) = val { return .integer(abs(i)) }
            if case .double(let d) = val { return .double(abs(d)) }
        }
        if trimmed.hasPrefix("min(") && trimmed.hasSuffix(")") {
            let args = splitTopLevelArguments(String(trimmed.dropFirst(4).dropLast()))
            if args.count == 2 {
                let v1 = evaluateExpression(args[0], lineNumber: lineNumber)
                let v2 = evaluateExpression(args[1], lineNumber: lineNumber)
                if case .integer(let i1) = v1, case .integer(let i2) = v2 { return .integer(min(i1, i2)) }
                if let d1 = v1.asDouble, let d2 = v2.asDouble { return .double(min(d1, d2)) }
            }
        }
        if trimmed.hasPrefix("max(") && trimmed.hasSuffix(")") {
            let args = splitTopLevelArguments(String(trimmed.dropFirst(4).dropLast()))
            if args.count == 2 {
                let v1 = evaluateExpression(args[0], lineNumber: lineNumber)
                let v2 = evaluateExpression(args[1], lineNumber: lineNumber)
                if case .integer(let i1) = v1, case .integer(let i2) = v2 { return .integer(max(i1, i2)) }
                if let d1 = v1.asDouble, let d2 = v2.asDouble { return .double(max(d1, d2)) }
            }
        }
        if trimmed.hasPrefix("sqrt(") && trimmed.hasSuffix(")") {
            let arg = String(trimmed.dropFirst(5).dropLast())
            let val = evaluateExpression(arg, lineNumber: lineNumber)
            if let d = val.asDouble { return .double(sqrt(d)) }
        }
        
        // Array subscript arr[idx]
        if let bracketOpen = trimmed.firstIndex(of: "["), trimmed.hasSuffix("]") {
            let name = String(trimmed[..<bracketOpen]).trimmingCharacters(in: .whitespaces)
            let idxExpr = String(trimmed[trimmed.index(after: bracketOpen)..<trimmed.index(before: trimmed.endIndex)])
            if let rec = environment[name], case .array(let arr) = rec.value {
                let idxVal = evaluateExpression(idxExpr, lineNumber: lineNumber)
                if case .integer(let idx) = idxVal {
                    if idx >= 0 && idx < arr.count {
                        return arr[idx]
                    } else {
                        error = RuntimeError(line: lineNumber, message: "Fatal error: Index out of range (\(idx))")
                        return .void
                    }
                }
            }
        }
        
        // Binary Logical & Comparison Operators
        if let range = findOperator(in: trimmed, op: "||") {
            let left = evaluateExpression(String(trimmed[..<range.lowerBound]), lineNumber: lineNumber).asBool
            let right = evaluateExpression(String(trimmed[range.upperBound...]), lineNumber: lineNumber).asBool
            return .boolean(left || right)
        }
        if let range = findOperator(in: trimmed, op: "&&") {
            let left = evaluateExpression(String(trimmed[..<range.lowerBound]), lineNumber: lineNumber).asBool
            let right = evaluateExpression(String(trimmed[range.upperBound...]), lineNumber: lineNumber).asBool
            return .boolean(left && right)
        }
        if let range = findOperator(in: trimmed, op: "==") {
            let left = evaluateExpression(String(trimmed[..<range.lowerBound]), lineNumber: lineNumber)
            let right = evaluateExpression(String(trimmed[range.upperBound...]), lineNumber: lineNumber)
            return .boolean(left == right)
        }
        if let range = findOperator(in: trimmed, op: "!=") {
            let left = evaluateExpression(String(trimmed[..<range.lowerBound]), lineNumber: lineNumber)
            let right = evaluateExpression(String(trimmed[range.upperBound...]), lineNumber: lineNumber)
            return .boolean(left != right)
        }
        if let range = findOperator(in: trimmed, op: "<=") {
            let left = evaluateExpression(String(trimmed[..<range.lowerBound]), lineNumber: lineNumber)
            let right = evaluateExpression(String(trimmed[range.upperBound...]), lineNumber: lineNumber)
            if let d1 = left.asDouble, let d2 = right.asDouble { return .boolean(d1 <= d2) }
        }
        if let range = findOperator(in: trimmed, op: ">=") {
            let left = evaluateExpression(String(trimmed[..<range.lowerBound]), lineNumber: lineNumber)
            let right = evaluateExpression(String(trimmed[range.upperBound...]), lineNumber: lineNumber)
            if let d1 = left.asDouble, let d2 = right.asDouble { return .boolean(d1 >= d2) }
        }
        if let range = findOperator(in: trimmed, op: "<") {
            let left = evaluateExpression(String(trimmed[..<range.lowerBound]), lineNumber: lineNumber)
            let right = evaluateExpression(String(trimmed[range.upperBound...]), lineNumber: lineNumber)
            if let d1 = left.asDouble, let d2 = right.asDouble { return .boolean(d1 < d2) }
        }
        if let range = findOperator(in: trimmed, op: ">") {
            let left = evaluateExpression(String(trimmed[..<range.lowerBound]), lineNumber: lineNumber)
            let right = evaluateExpression(String(trimmed[range.upperBound...]), lineNumber: lineNumber)
            if let d1 = left.asDouble, let d2 = right.asDouble { return .boolean(d1 > d2) }
        }
        
        // Addition & Subtraction (+, -)
        if let range = findOperator(in: trimmed, op: "+") {
            let left = evaluateExpression(String(trimmed[..<range.lowerBound]), lineNumber: lineNumber)
            let right = evaluateExpression(String(trimmed[range.upperBound...]), lineNumber: lineNumber)
            switch (left, right) {
            case (.integer(let a), .integer(let b)): return .integer(a + b)
            case (.double(let a), .double(let b)): return .double(a + b)
            case (.double(let a), .integer(let b)): return .double(a + Double(b))
            case (.integer(let a), .double(let b)): return .double(Double(a) + b)
            case (.string(let a), .string(let b)): return .string(a + b)
            case (.string(let a), let b): return .string(a + b.description)
            case (.array(let a), .array(let b)): return .array(a + b)
            default: break
            }
        }
        if let range = findOperator(in: trimmed, op: "-") {
            let leftStr = String(trimmed[..<range.lowerBound]).trimmingCharacters(in: .whitespaces)
            if !leftStr.isEmpty {
                let left = evaluateExpression(leftStr, lineNumber: lineNumber)
                let right = evaluateExpression(String(trimmed[range.upperBound...]), lineNumber: lineNumber)
                switch (left, right) {
                case (.integer(let a), .integer(let b)): return .integer(a - b)
                case (.double(let a), .double(let b)): return .double(a - b)
                case (.double(let a), .integer(let b)): return .double(a - Double(b))
                case (.integer(let a), .double(let b)): return .double(Double(a) - b)
                default: break
                }
            }
        }
        
        // Multiplication, Division, Modulo (*, /, %)
        if let range = findOperator(in: trimmed, op: "*") {
            let left = evaluateExpression(String(trimmed[..<range.lowerBound]), lineNumber: lineNumber)
            let right = evaluateExpression(String(trimmed[range.upperBound...]), lineNumber: lineNumber)
            switch (left, right) {
            case (.integer(let a), .integer(let b)): return .integer(a * b)
            case (.double(let a), .double(let b)): return .double(a * b)
            case (.double(let a), .integer(let b)): return .double(a * Double(b))
            case (.integer(let a), .double(let b)): return .double(Double(a) * b)
            default: break
            }
        }
        if let range = findOperator(in: trimmed, op: "/") {
            let left = evaluateExpression(String(trimmed[..<range.lowerBound]), lineNumber: lineNumber)
            let right = evaluateExpression(String(trimmed[range.upperBound...]), lineNumber: lineNumber)
            if right == .integer(0) || right == .double(0.0) {
                error = RuntimeError(line: lineNumber, message: "Fatal error: Division by zero")
                return .void
            }
            switch (left, right) {
            case (.integer(let a), .integer(let b)): return .integer(a / b)
            case (.double(let a), .double(let b)): return .double(a / b)
            case (.double(let a), .integer(let b)): return .double(a / Double(b))
            case (.integer(let a), .double(let b)): return .double(Double(a) / b)
            default: break
            }
        }
        if let range = findOperator(in: trimmed, op: "%") {
            let left = evaluateExpression(String(trimmed[..<range.lowerBound]), lineNumber: lineNumber)
            let right = evaluateExpression(String(trimmed[range.upperBound...]), lineNumber: lineNumber)
            if case .integer(let a) = left, case .integer(let b) = right {
                if b == 0 {
                    error = RuntimeError(line: lineNumber, message: "Fatal error: Remainder by zero")
                    return .void
                }
                return .integer(a % b)
            }
        }
        
        // Unary NOT (!)
        if trimmed.hasPrefix("!") {
            let sub = evaluateExpression(String(trimmed.dropFirst()), lineNumber: lineNumber)
            return .boolean(!sub.asBool)
        }
        
        // Direct Numbers
        if let intVal = Int(trimmed) { return .integer(intVal) }
        if let dblVal = Double(trimmed) { return .double(dblVal) }
        
        // Scope variable lookup
        if let rec = environment[trimmed] {
            return rec.value
        }
        
        return .string(trimmed)
    }
    
    // MARK: - Method, Property & Closure Calls
    private func evaluatePropertyOrClosureCall(_ expr: String, lineNumber: Int) -> SwiftVal? {
        if let mapRange = expr.range(of: ".map") {
            let objExpr = String(expr[..<mapRange.lowerBound]).trimmingCharacters(in: .whitespaces)
            let objVal = evaluateExpression(objExpr, lineNumber: lineNumber)
            if case .array(let arr) = objVal {
                if let braceOpen = expr.firstIndex(of: "{"), let braceClose = expr.lastIndex(of: "}") {
                    let closureBody = String(expr[expr.index(after: braceOpen)..<braceClose]).trimmingCharacters(in: .whitespaces)
                    var mapped: [SwiftVal] = []
                    for item in arr {
                        environment["$0"] = VariableRecord(value: item, isConstant: true)
                        let res = evaluateExpression(closureBody, lineNumber: lineNumber)
                        mapped.append(res)
                    }
                    environment.removeValue(forKey: "$0")
                    return .array(mapped)
                }
            }
        }
        
        if let filterRange = expr.range(of: ".filter") {
            let objExpr = String(expr[..<filterRange.lowerBound]).trimmingCharacters(in: .whitespaces)
            let objVal = evaluateExpression(objExpr, lineNumber: lineNumber)
            if case .array(let arr) = objVal {
                if let braceOpen = expr.firstIndex(of: "{"), let braceClose = expr.lastIndex(of: "}") {
                    let closureBody = String(expr[expr.index(after: braceOpen)..<braceClose]).trimmingCharacters(in: .whitespaces)
                    var filtered: [SwiftVal] = []
                    for item in arr {
                        environment["$0"] = VariableRecord(value: item, isConstant: true)
                        let cond = evaluateExpression(closureBody, lineNumber: lineNumber)
                        if cond.asBool {
                            filtered.append(item)
                        }
                    }
                    environment.removeValue(forKey: "$0")
                    return .array(filtered)
                }
            }
        }
        
        // Standard dot properties
        guard let dotIdx = expr.lastIndex(of: ".") else { return nil }
        let objExpr = String(expr[..<dotIdx]).trimmingCharacters(in: .whitespaces)
        let prop = String(expr[expr.index(after: dotIdx)...]).trimmingCharacters(in: .whitespaces)
        
        let objVal = evaluateExpression(objExpr, lineNumber: lineNumber)
        
        switch objVal {
        case .string(let s):
            if prop == "count" { return .integer(s.count) }
            if prop == "isEmpty" { return .boolean(s.isEmpty) }
            if prop == "uppercased()" { return .string(s.uppercased()) }
            if prop == "lowercased()" { return .string(s.lowercased()) }
            if prop == "reversed()" { return .string(String(s.reversed())) }
            
        case .array(let a):
            if prop == "count" { return .integer(a.count) }
            if prop == "isEmpty" { return .boolean(a.isEmpty) }
            if prop == "first" { return a.first ?? .void }
            if prop == "last" { return a.last ?? .void }
            if prop == "reversed()" { return .array(a.reversed()) }
            if prop == "sorted()" {
                if a.allSatisfy({ if case .integer = $0 { return true } else { return false } }) {
                    let sorted = a.compactMap { val -> Int? in
                        if case .integer(let i) = val { return i } else { return nil }
                    }.sorted().map { SwiftVal.integer($0) }
                    return .array(sorted)
                }
            }
            
        case .structure(_, let fields):
            if let val = fields[prop] {
                return val
            }
            
        default: break
        }
        return nil
    }
    
    // MARK: - Operator & String Parsing Helpers
    private func findOperator(in text: String, op: String) -> Range<String.Index>? {
        var depth = 0
        var inQuotes = false
        var i = text.startIndex
        
        while i < text.endIndex {
            let ch = text[i]
            if ch == "\"" {
                inQuotes.toggle()
            } else if !inQuotes {
                if ch == "(" || ch == "[" || ch == "{" {
                    depth += 1
                } else if ch == ")" || ch == "]" || ch == "}" {
                    depth -= 1
                } else if depth == 0 {
                    if text[i...].hasPrefix(op) {
                        let endIdx = text.index(i, offsetBy: op.count)
                        if op == "=" && (text[i...].hasPrefix("==") || text[i...].hasPrefix("!=")) {
                            // skip
                        } else {
                            return i..<endIdx
                        }
                    }
                }
            }
            i = text.index(after: i)
        }
        return nil
    }
    
    private func isBalancedEnclosure(_ text: String) -> Bool {
        guard text.hasPrefix("(") && text.hasSuffix(")") else { return false }
        var depth = 0
        var inQuotes = false
        var i = text.startIndex
        while i < text.endIndex {
            let ch = text[i]
            if ch == "\"" {
                inQuotes.toggle()
            } else if !inQuotes {
                if ch == "(" {
                    depth += 1
                } else if ch == ")" {
                    depth -= 1
                    if depth == 0 && i < text.index(before: text.endIndex) {
                        return false
                    }
                }
            }
            i = text.index(after: i)
        }
        return depth == 0
    }
    
    private func isTopLevelFunctionCall(_ text: String) -> (funcName: String, args: String)? {
        guard let openParen = text.firstIndex(of: "("), text.hasSuffix(")") else { return nil }
        let funcName = String(text[..<openParen]).trimmingCharacters(in: .whitespaces)
        guard !funcName.isEmpty && !funcName.contains(" ") && !funcName.contains("\"") && !funcName.contains(".") else { return nil }
        
        var depth = 0
        var inQuotes = false
        var i = openParen
        while i < text.endIndex {
            let ch = text[i]
            if ch == "\"" {
                inQuotes.toggle()
            } else if !inQuotes {
                if ch == "(" {
                    depth += 1
                } else if ch == ")" {
                    depth -= 1
                    if depth == 0 {
                        if i == text.index(before: text.endIndex) {
                            let argsInside = String(text[text.index(after: openParen)..<i])
                            return (funcName, argsInside)
                        } else {
                            return nil
                        }
                    }
                }
            }
            i = text.index(after: i)
        }
        return nil
    }
    
    private func splitTopLevelArguments(_ text: String) -> [String] {
        var args: [String] = []
        var current = ""
        var depth = 0
        var inQuotes = false
        
        for ch in text {
            if ch == "\"" {
                inQuotes.toggle()
                current.append(ch)
            } else if inQuotes {
                current.append(ch)
            } else if ch == "(" || ch == "[" || ch == "{" {
                depth += 1
                current.append(ch)
            } else if ch == ")" || ch == "]" || ch == "}" {
                depth -= 1
                current.append(ch)
            } else if ch == "," && depth == 0 {
                args.append(current.trimmingCharacters(in: .whitespaces))
                current = ""
            } else {
                current.append(ch)
            }
        }
        if !current.trimmingCharacters(in: .whitespaces).isEmpty {
            args.append(current.trimmingCharacters(in: .whitespaces))
        }
        return args
    }
}
