import SwiftUI

public struct PlaygroundView: View {
    @ObservedObject var lang = LanguageManager.shared
    @ObservedObject var storage = StorageService.shared
    @ObservedObject var nav = AppNavigationState.shared
    @ObservedObject var ideManager = IDEProjectManager.shared
    
    @State private var codeText: String = PlaygroundTemplate.templates[0].defaultCode
    @State private var selectedTemplate: PlaygroundTemplate = PlaygroundTemplate.templates[0]
    @State private var isExecuting: Bool = false
    @State private var executionResult: PlaygroundExecutionResult = .empty
    @State private var activeTab: ConsoleTab = .console
    @State private var showResetAlert: Bool = false
    
    enum ConsoleTab: String, CaseIterable, Identifiable {
        case console = "Консоль"
        case inspector = "Инспектор"
        
        var id: String { rawValue }
        
        @MainActor
        func localized(lang: LanguageManager) -> String {
            switch self {
            case .console: return lang.localized("Консоль вывода", "Console Output")
            case .inspector: return lang.localized("Инспектор памяти", "Memory Inspector")
            }
        }
    }
    
    public init(initialCode: String? = nil) {
        if let initialCode = initialCode, !initialCode.isEmpty {
            _codeText = State(initialValue: initialCode)
        }
    }
    
    private var lineCount: Int {
        max(1, codeText.components(separatedBy: .newlines).count)
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Template Selector & Controls
                headerControls
                
                // Code Editor with Line Numbers
                editorSection
                
                // Action Buttons: Run & Discuss
                actionSection
                
                // Output Terminal / Variable Inspector
                consoleSection
            }
            .padding(.top, 12)
            .padding(.bottom, 48)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .onAppear {
            if executionResult.output.isEmpty && !codeText.isEmpty {
                runCode()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .loadPlaygroundCode)) { notif in
            if let customCode = notif.object as? String, !customCode.isEmpty {
                self.codeText = customCode
                self.runCode()
            }
        }
    }
    
    // MARK: - Header & Template Picker
    private var headerControls: some View {
        VStack(spacing: 10) {
            HStack {
                Menu {
                    ForEach(PlaygroundTemplate.templates) { template in
                        Button(action: {
                            selectedTemplate = template
                            codeText = template.defaultCode
                            runCode()
                        }) {
                            Label(
                                lang.localized(template.titleRU, template.titleEN),
                                systemImage: template.icon
                            )
                        }
                    }
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "folder")
                            .font(.subheadline)
                        Text(lang.localized(selectedTemplate.titleRU, selectedTemplate.titleEN))
                            .font(.subheadline.weight(.medium))
                        Image(systemName: "chevron.down")
                            .font(.caption2)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(Color(UIColor.secondarySystemBackground))
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                    )
                }
                
                Spacer()
                
                Button(action: {
                    codeText = selectedTemplate.defaultCode
                    runCode()
                }) {
                    Label(lang.localized("Сброс", "Reset"), systemImage: "arrow.counterclockwise")
                        .font(.caption.weight(.medium))
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 7)
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Code Editor Section
    private var editorSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(lang.localized("Редактор кода (Swift):", "Code Editor (Swift):"))
                    .font(.caption.bold())
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text("\(lineCount) " + lang.localized("строк", "lines"))
                    .font(.caption2.monospaced())
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            
            VStack(spacing: 0) {
                SyntaxCodeEditor(
                    text: $codeText,
                    theme: ideManager.theme
                )
                .frame(height: 240)
                .background(ideManager.theme.backgroundColor.color)
                
                Divider()
                
                // Quick Code Snippet Shortcuts
                quickAccessBar
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
            )
            .padding(.horizontal)
        }
    }
    
    // MARK: - Quick Snippet Accessory Bar
    private var quickAccessBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                snippetPill("print(\"\")", insert: "print(\"\")")
                snippetPill("let", insert: "let ")
                snippetPill("var", insert: "var ")
                snippetPill("for in", insert: "for i in 1...5 {\n    \n}")
                snippetPill("if", insert: "if ")
                snippetPill(".append()", insert: ".append()")
                snippetPill("[ ]", insert: "[]")
                snippetPill("\\()", insert: "\\()")
            }
            .padding(.horizontal)
        }
    }
    
    private func snippetPill(_ label: String, insert: String) -> some View {
        Button(action: {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            codeText += insert
        }) {
            Text(label)
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Color(UIColor.secondarySystemBackground))
                .foregroundColor(.primary)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.secondary.opacity(0.18), lineWidth: 1)
                )
        }
    }
    
    // MARK: - Action Section
    private var actionSection: some View {
        VStack(spacing: 8) {
            Button(action: runCode) {
                HStack(spacing: 8) {
                    if isExecuting {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(0.8)
                    } else {
                        Image(systemName: "play.fill")
                            .font(.subheadline)
                    }
                    Text(lang.localized("Выполнить код", "Execute Code"))
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 13)
                .background(Color(red: 0.14, green: 0.38, blue: 0.82))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(isExecuting)
            .padding(.horizontal)
        }
    }
    
    // MARK: - Console & Inspector Section
    private var consoleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Segmented console/inspector switcher
            HStack {
                Picker("Вид", selection: $activeTab) {
                    ForEach(ConsoleTab.allCases) { tab in
                        Text(tab.localized(lang: lang)).tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                
                Spacer()
                
                if executionResult.durationMs > 0 {
                    HStack(spacing: 4) {
                        Image(systemName: executionResult.success ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(executionResult.success ? Color(red: 0.12, green: 0.58, blue: 0.38) : Color(red: 0.85, green: 0.22, blue: 0.25))
                        Text(String(format: "%.1f ms", executionResult.durationMs))
                            .font(.caption2.monospaced())
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal)
            
            // Console Terminal Box
            VStack(alignment: .leading, spacing: 0) {
                // Header bar
                HStack {
                    HStack(spacing: 6) {
                        Circle()
                            .fill(Color.red.opacity(0.7))
                            .frame(width: 8, height: 8)
                        Circle()
                            .fill(Color.yellow.opacity(0.7))
                            .frame(width: 8, height: 8)
                        Circle()
                            .fill(Color.green.opacity(0.7))
                            .frame(width: 8, height: 8)
                    }
                    
                    Spacer()
                    
                    Text("swift-stdout")
                        .font(.caption2.monospaced())
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button(action: {
                        UIPasteboard.general.string = executionResult.output
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    }) {
                        Image(systemName: "doc.on.doc")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(UIColor.tertiarySystemBackground))
                
                Divider()
                
                // Body
                if activeTab == .console {
                    consoleOutputBody
                } else {
                    inspectorBody
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
            )
            .padding(.horizontal)
        }
    }
    
    // MARK: - Console Output Body
    private var consoleOutputBody: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let error = executionResult.error {
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(Color(red: 0.85, green: 0.22, blue: 0.25))
                        .font(.footnote)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(lang.localized("Ошибка выполнения (строка \(error.line)):", "Runtime Error (line \(error.line)):"))
                            .font(.caption.bold())
                            .foregroundColor(Color(red: 0.85, green: 0.22, blue: 0.25))
                        Text(error.message)
                            .font(.system(size: 12, design: .monospaced))
                            .foregroundColor(.primary)
                    }
                }
                .padding(.bottom, 6)
                Divider()
            }
            
            if executionResult.output.isEmpty {
                Text(lang.localized("// Стандартный вывод пуст. Вызовите print(...) для отображения логов.", "// Standard output is empty. Call print(...) to write logs."))
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundColor(.secondary.opacity(0.7))
                    .padding(.vertical, 8)
            } else {
                Text(executionResult.output)
                    .font(.system(size: 12, weight: .regular, design: .monospaced))
                    .foregroundColor(.primary)
                    .lineSpacing(3)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(12)
        .frame(minHeight: 120, alignment: .topLeading)
        .background(Color(UIColor.secondarySystemBackground))
    }
    
    // MARK: - Memory Inspector Body
    private var inspectorBody: some View {
        VStack(alignment: .leading, spacing: 0) {
            if executionResult.variables.isEmpty {
                Text(lang.localized("// В области видимости нет сохраненных переменных.", "// No variables in scope."))
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundColor(.secondary.opacity(0.7))
                    .padding(12)
            } else {
                ForEach(executionResult.variables) { variable in
                    HStack {
                        Text(variable.isConstant ? "let" : "var")
                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                            .foregroundColor(variable.isConstant ? Color(red: 0.14, green: 0.38, blue: 0.82) : Color(red: 0.75, green: 0.45, blue: 0.12))
                        
                        Text(variable.name)
                            .font(.system(size: 12, weight: .semibold, design: .monospaced))
                        
                        Text(":")
                            .foregroundColor(.secondary)
                        
                        Text(variable.typeName)
                            .font(.system(size: 11, design: .monospaced))
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text(variable.valueDescription)
                            .font(.system(size: 12, weight: .medium, design: .monospaced))
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    Divider()
                }
            }
        }
        .frame(minHeight: 120, alignment: .topLeading)
        .background(Color(UIColor.secondarySystemBackground))
    }
    
    // MARK: - Actions
    private func runCode() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        isExecuting = true
        
        Task {
            let result = await PlaygroundEngine.shared.execute(code: codeText)
            await MainActor.run {
                self.executionResult = result
                self.isExecuting = false
                if result.success {
                    self.storage.addXP(5)
                }
            }
        }
    }
}
