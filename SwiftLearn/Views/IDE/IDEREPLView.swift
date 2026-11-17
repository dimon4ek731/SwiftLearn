import SwiftUI

public struct IDEREPLView: View {
    @ObservedObject var replSession: IDEREPLSession
    @ObservedObject var lang = LanguageManager.shared
    
    @State private var inputText: String = ""
    @FocusState private var isInputFocused: Bool
    
    public init(replSession: IDEREPLSession) {
        self.replSession = replSession
    }
    
    private var promptSymbol: String {
        switch replSession.language {
        case .swift: return "swift>"
        case .python: return "py>>>"
        case .csharp: return "cs>"
        case .sql: return "sqlite>"
        }
    }
    
    private var promptColor: Color {
        switch replSession.language {
        case .swift: return .orange
        case .python: return Color(red: 0.20, green: 0.45, blue: 0.85)
        case .csharp: return Color(red: 0.55, green: 0.25, blue: 0.85)
        case .sql: return Color(red: 0.16, green: 0.58, blue: 0.40)
        }
    }
    
    private var quickChips: [String] {
        switch replSession.language {
        case .swift:
            return ["let x = 42", "x * 2", "[1, 2, 3].map { $0 * 10 }", "print(\"Swift!\")"]
        case .python:
            return ["x = 100", "[i*2 for i in range(5)]", "len('hello world')", "sum([10, 20, 30])"]
        case .csharp:
            return ["var score = 95;", "Math.Sqrt(144)", "string.Join(\", \", new int[] {1,2,3})", "Console.WriteLine(\".NET 8\");"]
        case .sql:
            return [
                "SELECT sqlite_version();",
                "CREATE TABLE test (id INT, val TEXT);",
                "INSERT INTO test VALUES (1, 'Alpha'), (2, 'Beta');",
                "SELECT * FROM test;"
            ]
        }
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // REPL History List
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(replSession.history) { entry in
                            VStack(alignment: .leading, spacing: 3) {
                                HStack(spacing: 6) {
                                    Text(promptSymbol)
                                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                                        .foregroundColor(promptColor)
                                    
                                    Text(entry.command)
                                        .font(.system(size: 11, weight: .semibold, design: .monospaced))
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                    
                                    Button {
                                        UIPasteboard.general.string = entry.command
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                    } label: {
                                        Image(systemName: "doc.on.doc")
                                            .font(.system(size: 9))
                                            .foregroundColor(.secondary.opacity(0.6))
                                    }
                                }
                                
                                if !entry.output.isEmpty {
                                    Text(entry.output)
                                        .font(.system(size: 11, design: .monospaced))
                                        .foregroundColor(entry.isError ? .red : (entry.output.hasPrefix("=>") ? .blue : .primary))
                                        .padding(.leading, 12)
                                        .textSelection(.enabled)
                                }
                            }
                            .padding(.horizontal, 10)
                            .id(entry.id)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .onChange(of: replSession.history.count) { _, _ in
                    if let last = replSession.history.last {
                        withAnimation {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            Divider()
            
            // Quick Sample Chips
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(quickChips, id: \.self) { chip in
                        Button {
                            inputText = chip
                            submitCommand()
                        } label: {
                            Text(chip)
                                .font(.system(size: 10, design: .monospaced))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color(UIColor.tertiarySystemBackground))
                                .foregroundColor(.primary)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
            }
            .background(Color(UIColor.secondarySystemBackground))
            
            Divider()
            
            // Command Input Line
            HStack(spacing: 8) {
                // History Navigation Buttons
                HStack(spacing: 2) {
                    Button {
                        cycleHistory(direction: -1)
                    } label: {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 10, weight: .bold))
                            .padding(6)
                            .background(Color(UIColor.tertiarySystemBackground))
                            .clipShape(Circle())
                    }
                    .disabled(replSession.commandHistory.isEmpty)
                    
                    Button {
                        cycleHistory(direction: 1)
                    } label: {
                        Image(systemName: "arrow.down")
                            .font(.system(size: 10, weight: .bold))
                            .padding(6)
                            .background(Color(UIColor.tertiarySystemBackground))
                            .clipShape(Circle())
                    }
                    .disabled(replSession.commandHistory.isEmpty)
                }
                
                Text(promptSymbol)
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                    .foregroundColor(promptColor)
                
                TextField(lang.localized("Введите команду или выражение...", "Enter command or expression..."), text: $inputText)
                    .font(.system(size: 12, design: .monospaced))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .focused($isInputFocused)
                    .onSubmit {
                        submitCommand()
                    }
                
                if replSession.isExecuting {
                    ProgressView()
                        .scaleEffect(0.7)
                } else {
                    Button(action: submitCommand) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 22))
                            .foregroundColor(inputText.trimmingCharacters(in: .whitespaces).isEmpty ? .secondary : promptColor)
                    }
                    .disabled(inputText.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color(UIColor.secondarySystemBackground))
        }
    }
    
    private func submitCommand() {
        let cmd = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cmd.isEmpty else { return }
        inputText = ""
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        Task {
            await replSession.execute(command: cmd)
        }
    }
    
    private func cycleHistory(direction: Int) {
        guard !replSession.commandHistory.isEmpty else { return }
        var newIdx = replSession.historyIndex + direction
        if newIdx < 0 {
            newIdx = 0
        } else if newIdx >= replSession.commandHistory.count {
            newIdx = replSession.commandHistory.count
            inputText = ""
            replSession.historyIndex = newIdx
            return
        }
        replSession.historyIndex = newIdx
        inputText = replSession.commandHistory[newIdx]
    }
}
