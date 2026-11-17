import Foundation
import Combine
import SQLite3

public struct REPLEntry: Identifiable, Equatable {
    public let id: UUID
    public let command: String
    public let output: String
    public let isError: Bool
    public let timestamp: Date
    public let evaluatedValue: String?
    
    public init(
        id: UUID = UUID(),
        command: String,
        output: String,
        isError: Bool = false,
        timestamp: Date = Date(),
        evaluatedValue: String? = nil
    ) {
        self.id = id
        self.command = command
        self.output = output
        self.isError = isError
        self.timestamp = timestamp
        self.evaluatedValue = evaluatedValue
    }
}

@MainActor
public final class IDEREPLSession: ObservableObject {
    @Published public private(set) var language: TargetLanguage
    @Published public var history: [REPLEntry] = []
    @Published public var isExecuting: Bool = false
    @Published public var commandHistory: [String] = []
    @Published public var historyIndex: Int = -1
    
    // In-memory state for SQL
    private var sqliteDb: OpaquePointer?
    
    // Accumulated code for Swift/Python/C#
    private var accumulatedCode: String = ""
    
    public init(language: TargetLanguage) {
        self.language = language
        if language == .sql {
            initSQLite()
        }
        appendGreeting()
    }
    
    deinit {
        if let db = sqliteDb {
            sqlite3_close(db)
        }
    }
    
    private func initSQLite() {
        if let db = sqliteDb {
            sqlite3_close(db)
            sqliteDb = nil
        }
        var db: OpaquePointer?
        if sqlite3_open(":memory:", &db) == SQLITE_OK {
            self.sqliteDb = db
        }
    }
    
    private func appendGreeting() {
        let greetingText: String
        switch language {
        case .swift:
            greetingText = "Swift 5.10 Interactive REPL. Type expressions or statements."
        case .python:
            greetingText = "Python 3.12 Interactive Shell. Type expressions or statements."
        case .csharp:
            greetingText = "C# 12 / .NET 8 Interactive REPL. Type C# statements or expressions."
        case .sql:
            greetingText = "SQLite 3 Interactive Database Shell (In-Memory). Run DDL/DML queries."
        }
        history.append(REPLEntry(command: "# Initialized", output: greetingText, isError: false))
    }
    
    public func reset() {
        history.removeAll()
        accumulatedCode = ""
        commandHistory.removeAll()
        historyIndex = -1
        if language == .sql {
            initSQLite()
        }
        appendGreeting()
    }
    
    public func setLanguage(_ newLang: TargetLanguage) {
        guard language != newLang else { return }
        self.language = newLang
        reset()
    }
    
    public func execute(command: String) async {
        let trimmed = command.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        commandHistory.append(trimmed)
        historyIndex = commandHistory.count
        isExecuting = true
        defer { isExecuting = false }
        
        if language == .sql {
            await executeSQLCommand(trimmed)
        } else {
            await executeCodeCommand(trimmed)
        }
    }
    
    // MARK: - SQL Execution
    private func executeSQLCommand(_ stmtStr: String) async {
        guard let db = sqliteDb else {
            history.append(REPLEntry(command: stmtStr, output: "Error: Database is not initialized.", isError: true))
            return
        }
        
        let lower = stmtStr.lowercased()
        let isSelect = lower.hasPrefix("select") || lower.hasPrefix("pragma") || lower.hasPrefix("explain") || lower.hasPrefix("with")
        
        if isSelect {
            var stmtPtr: OpaquePointer?
            if sqlite3_prepare_v2(db, stmtStr, -1, &stmtPtr, nil) == SQLITE_OK {
                let colCount = sqlite3_column_count(stmtPtr)
                var headers: [String] = []
                for c in 0..<colCount {
                    let colName = String(cString: sqlite3_column_name(stmtPtr, c))
                    headers.append(colName)
                }
                
                var rows: [[String]] = []
                while sqlite3_step(stmtPtr) == SQLITE_ROW {
                    var row: [String] = []
                    for c in 0..<colCount {
                        if let text = sqlite3_column_text(stmtPtr, c) {
                            row.append(String(cString: text))
                        } else {
                            row.append("NULL")
                        }
                    }
                    rows.append(row)
                }
                sqlite3_finalize(stmtPtr)
                
                let formatted = formatSQLTable(headers: headers, rows: rows)
                history.append(REPLEntry(command: stmtStr, output: formatted, isError: false))
            } else {
                let err = String(cString: sqlite3_errmsg(db))
                history.append(REPLEntry(command: stmtStr, output: "SQL Error: \(err)", isError: true))
            }
        } else {
            var errMessage: UnsafeMutablePointer<CChar>?
            let rc = sqlite3_exec(db, stmtStr, nil, nil, &errMessage)
            if rc == SQLITE_OK {
                let changes = sqlite3_changes(db)
                let msg = changes > 0 ? "Query OK, \(changes) row(s) affected." : "Query OK (Schema/DDL updated)."
                history.append(REPLEntry(command: stmtStr, output: msg, isError: false))
            } else {
                let err = errMessage != nil ? String(cString: errMessage!) : "SQL execution error"
                sqlite3_free(errMessage)
                history.append(REPLEntry(command: stmtStr, output: "SQL Error: \(err)", isError: true))
            }
        }
    }
    
    private func formatSQLTable(headers: [String], rows: [[String]]) -> String {
        guard !headers.isEmpty else { return "(Empty result set)" }
        var colWidths = headers.map { $0.count }
        for row in rows {
            for (idx, cell) in row.enumerated() {
                if idx < colWidths.count {
                    colWidths[idx] = max(colWidths[idx], cell.count)
                }
            }
        }
        
        func formatRow(_ cells: [String]) -> String {
            var parts: [String] = []
            for (idx, cell) in cells.enumerated() {
                let width = colWidths[idx]
                parts.append(cell.padding(toLength: width, withPad: " ", startingAt: 0))
            }
            return "| " + parts.joined(separator: " | ") + " |"
        }
        
        let separator = "+-" + colWidths.map { String(repeating: "-", count: $0) }.joined(separator: "-+-") + "-+"
        var lines: [String] = []
        lines.append(separator)
        lines.append(formatRow(headers))
        lines.append(separator)
        for row in rows {
            lines.append(formatRow(row))
        }
        lines.append(separator)
        lines.append("(\(rows.count) row(s) returned)")
        return lines.joined(separator: "\n")
    }
    
    // MARK: - Swift / Python / C# Execution
    private func executeCodeCommand(_ cmd: String) async {
        // Detect if bare expression
        let isStatement = cmd.hasPrefix("let ") || cmd.hasPrefix("var ") || cmd.hasPrefix("func ") ||
                          cmd.hasPrefix("class ") || cmd.hasPrefix("struct ") || cmd.hasPrefix("def ") ||
                          cmd.hasPrefix("import ") || cmd.hasPrefix("from ") || cmd.hasPrefix("using ") ||
                          cmd.hasPrefix("print(") || cmd.hasPrefix("Console.WriteLine")
        
        let codeWithCommand: String
        if !isStatement {
            switch language {
            case .python:
                codeWithCommand = accumulatedCode + "\n" + "print(" + cmd + ")"
            case .csharp:
                codeWithCommand = accumulatedCode + "\n" + "Console.WriteLine(" + cmd + ");"
            case .swift, .sql:
                codeWithCommand = accumulatedCode + "\n" + "print(" + cmd + ")"
            }
        } else {
            codeWithCommand = accumulatedCode + "\n" + cmd
        }
        
        let result = await PlaygroundEngine.shared.execute(code: codeWithCommand, language: language)
        
        if result.success {
            accumulatedCode = accumulatedCode + "\n" + cmd
            let displayOutput: String
            if !result.output.isEmpty {
                // If we ran a bare expression, let's format output nicely
                let rawOut = result.output.components(separatedBy: "\n").last ?? result.output
                displayOutput = isStatement ? result.output : "=> \(rawOut)"
            } else {
                displayOutput = "(Executed successfully)"
            }
            history.append(REPLEntry(command: cmd, output: displayOutput, isError: false))
        } else {
            let errMsg = result.error?.message ?? "Execution failed"
            history.append(REPLEntry(command: cmd, output: "Error: \(errMsg)", isError: true))
        }
    }
}
