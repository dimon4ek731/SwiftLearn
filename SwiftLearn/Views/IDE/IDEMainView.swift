import SwiftUI

public struct IDEMainView: View {
    @ObservedObject var ideManager = IDEProjectManager.shared
    @ObservedObject var lang = LanguageManager.shared
    @ObservedObject var storage = StorageService.shared
    
    // Editor State
    @State private var currentCode: String = ""
    @State private var activeFileId: UUID? = nil
    @State private var isExecuting: Bool = false
    @State private var executionResult: PlaygroundExecutionResult = .empty
    @State private var activeSuggestion: String? = nil
    
    // Modals & Navigation
    @State private var showingProjectList: Bool = false
    @State private var showingExportSheet: Bool = false
    @State private var exportURL: URL? = nil
    @State private var showingNewFileAlert: Bool = false
    @State private var newFileName: String = ""
    @State private var showingConsole: Bool = true
    @State private var selectedConsoleTab: Int = 0 // 0: Output, 1: Memory, 2: REPL
    @State private var isConsoleExpanded: Bool = false
    @State private var showingFileExplorer: Bool = false
    @State private var showingSnippets: Bool = false
    
    // REPL
    @StateObject private var replSession = IDEREPLSession(language: .swift)
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 0) {
            // 1. Project & File Bar
            projectTopHeader
            fileTabBar
            
            Divider()
            
            // 2. Main Editor Area
            editorArea
            
            // 3. Developer Keyboard Shortcut Toolbar
            quickAccessBar
            
            // 4. Collapsible Output Console
            if showingConsole {
                consoleArea
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
        .onAppear {
            syncEditorWithActiveFile()
            if ProcessInfo.processInfo.arguments.contains("-ideRepl") {
                selectedConsoleTab = 2
                showingConsole = true
            } else if ProcessInfo.processInfo.arguments.contains("-ideFileExplorer") {
                showingFileExplorer = true
            } else if ProcessInfo.processInfo.arguments.contains("-ideSnippets") {
                showingSnippets = true
            } else if ProcessInfo.processInfo.arguments.contains("-newProject") {
                showingProjectList = true
            }
        }
        .onChange(of: ideManager.activeProjectId) { _, _ in
            syncEditorWithActiveFile()
        }
        .onChange(of: ideManager.activeProject?.activeFileId) { _, _ in
            syncEditorWithActiveFile()
        }
        .sheet(isPresented: $showingProjectList) {
            IDEProjectListView()
        }
        .sheet(isPresented: $showingFileExplorer) {
            IDEFileExplorerView()
        }
        .sheet(isPresented: $showingSnippets) {
            IDESnippetsSheet(language: ideManager.activeProject?.language ?? .swift) { snippetCode in
                insertSnippet(snippetCode)
            }
        }
        .sheet(isPresented: $showingExportSheet) {
            if let url = exportURL {
                ShareSheet(items: [url])
            }
        }
        .alert(lang.localized("Новый файл", "New File"), isPresented: $showingNewFileAlert) {
            let ext = ideManager.activeProject?.language.fileExtension ?? "swift"
            TextField("file.\(ext)", text: $newFileName)
            Button(lang.localized("Отмена", "Cancel"), role: .cancel) {
                newFileName = ""
            }
            Button(lang.localized("Создать", "Create")) {
                if !newFileName.isEmpty {
                    let commentPrefix = (ideManager.activeProject?.language == .python) ? "#" : (ideManager.activeProject?.language == .sql ? "--" : "//")
                    ideManager.addFile(name: newFileName, content: "\(commentPrefix) \(newFileName)\n")
                    newFileName = ""
                    syncEditorWithActiveFile()
                }
            }
        }
    }
    
    // MARK: - Project Header
    private var projectTopHeader: some View {
        HStack(spacing: 8) {
            Button(action: { showingProjectList = true }) {
                HStack(spacing: 5) {
                    Image(systemName: "folder.fill")
                        .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                        .font(.caption)
                    Text(ideManager.activeProject?.name ?? "Project")
                        .font(.caption.bold())
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Color(UIColor.tertiarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .layoutPriority(1)
            
            // Interactive Language Switcher Badge
            Menu {
                ForEach(TargetLanguage.allCases) { langItem in
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        if let proj = ideManager.activeProject {
                            ideManager.changeProjectLanguage(id: proj.id, newLanguage: langItem)
                            replSession.setLanguage(langItem)
                        }
                    } label: {
                        HStack {
                            Text(langItem.displayName)
                            if ideManager.activeProject?.language == langItem {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                let langType = ideManager.activeProject?.language ?? .swift
                HStack(spacing: 3) {
                    Image(systemName: langType.icon)
                        .font(.system(size: 8, weight: .bold))
                    Text(langType.displayName)
                        .font(.system(size: 9, weight: .bold))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 7, weight: .bold))
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(Color(red: 0.14, green: 0.38, blue: 0.82).opacity(0.12))
                .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                .clipShape(Capsule())
            }
            
            Spacer(minLength: 4)
            
            // File Explorer Drawer button
            Button(action: { showingFileExplorer = true }) {
                Image(systemName: "folder.badge.gearshape")
                    .font(.caption)
                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                    .padding(6)
                    .background(Color(UIColor.tertiarySystemBackground))
                    .clipShape(Circle())
            }
            
            // Code Snippets Drawer button
            Button(action: { showingSnippets = true }) {
                Image(systemName: "curlybraces")
                    .font(.caption)
                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                    .padding(6)
                    .background(Color(UIColor.tertiarySystemBackground))
                    .clipShape(Circle())
            }
            
            // Export button
            Button(action: exportProject) {
                Image(systemName: "square.and.arrow.up")
                    .font(.caption)
                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                    .padding(6)
                    .background(Color(UIColor.tertiarySystemBackground))
                    .clipShape(Circle())
            }
            
            // Run Project Button
            Button(action: runProject) {
                HStack(spacing: 4) {
                    if isExecuting {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(0.6)
                    } else {
                        Image(systemName: "play.fill")
                            .font(.system(size: 9))
                    }
                    Text(lang.localized("Запуск", "Run"))
                        .font(.caption2.bold())
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color(red: 0.14, green: 0.38, blue: 0.82))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .fixedSize(horizontal: true, vertical: false)
            }
            .disabled(isExecuting)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Color(UIColor.secondarySystemBackground))
    }
    
    // MARK: - File Tab Bar
    private var fileTabBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                if let files = ideManager.activeProject?.files {
                    ForEach(files) { file in
                        let isActive = file.id == ideManager.activeProject?.activeFileId
                        let fileIcon: (icon: String, color: Color) = {
                            let ext = file.name.components(separatedBy: ".").last?.lowercased() ?? ""
                            switch ext {
                            case "swift": return ("swift", .orange)
                            case "py": return ("chevron.left.forwardslash.chevron.right", Color(red: 0.20, green: 0.45, blue: 0.85))
                            case "cs": return ("curlybraces", Color(red: 0.55, green: 0.25, blue: 0.85))
                            case "sql": return ("cylinder.split.1x2", Color(red: 0.16, green: 0.58, blue: 0.40))
                            default: return ("doc.text", .secondary)
                            }
                        }()
                        
                        Button(action: {
                            saveCurrentContent()
                            ideManager.selectFile(id: file.id)
                            syncEditorWithActiveFile()
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: fileIcon.icon)
                                    .font(.caption2)
                                    .foregroundColor(isActive ? fileIcon.color : .secondary)
                                
                                Text(file.name)
                                    .font(.system(size: 12, weight: isActive ? .bold : .regular, design: .monospaced))
                                    .foregroundColor(isActive ? .primary : .secondary)
                                
                                if files.count > 1 {
                                    Button(action: {
                                        ideManager.removeFile(id: file.id)
                                        syncEditorWithActiveFile()
                                    }) {
                                        Image(systemName: "xmark")
                                            .font(.system(size: 9, weight: .bold))
                                            .foregroundColor(.secondary.opacity(0.6))
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(isActive ? Color(UIColor.systemBackground) : Color(UIColor.tertiarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(isActive ? Color(red: 0.14, green: 0.38, blue: 0.82) : Color.clear, lineWidth: 1.5)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                // Add File Button
                Button(action: { showingNewFileAlert = true }) {
                    HStack(spacing: 4) {
                        Image(systemName: "plus")
                        Text(lang.localized("Файл", "File"))
                    }
                    .font(.caption2.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .background(Color(UIColor.secondarySystemBackground))
                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                // File Explorer Drawer Button
                Button(action: { showingFileExplorer = true }) {
                    HStack(spacing: 4) {
                        Image(systemName: "list.bullet.rectangle")
                        Text(lang.localized("Дерево", "Tree"))
                    }
                    .font(.caption2.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .background(Color(UIColor.secondarySystemBackground))
                    .foregroundColor(.secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
        .background(Color(UIColor.tertiarySystemBackground))
    }
    
    // MARK: - Editor Area
    private var editorArea: some View {
        SyntaxCodeEditor(
            text: $currentCode,
            theme: ideManager.theme,
            onTextChange: { newText in
                ideManager.updateActiveFile(content: newText)
            },
            onSuggestionChange: { suggestion in
                withAnimation(.easeInOut(duration: 0.15)) {
                    self.activeSuggestion = suggestion
                }
            }
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ideManager.theme.backgroundColor.color)
        .clipped()
    }
    
    // MARK: - Developer Toolbar
    private var quickAccessBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                // Interactive Ghost Suggestion Pill (Accept by Enter or Tap!)
                if let suggestion = activeSuggestion {
                    Button(action: {
                        NotificationCenter.default.post(name: .acceptCodeCompletion, object: nil)
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: "arrow.right.to.line.compact")
                                .font(.caption2.bold())
                            Text(suggestion)
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                            Text("↵")
                                .font(.system(size: 10, weight: .bold))
                                .padding(.horizontal, 4)
                                .padding(.vertical, 1)
                                .background(Color.white.opacity(0.25))
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color(red: 0.14, green: 0.38, blue: 0.82))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .shadow(color: Color.blue.opacity(0.3), radius: 3)
                    }
                }
                
                // Code Snippets Drawer Button
                Button(action: { showingSnippets = true }) {
                    HStack(spacing: 4) {
                        Image(systemName: "curlybraces")
                            .font(.caption2.bold())
                        Text(lang.localized("Сниппеты", "Snippets"))
                            .font(.system(size: 11, weight: .bold))
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(Color(red: 0.14, green: 0.38, blue: 0.82).opacity(0.12))
                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                
                // Language-Aware Shortcut Buttons
                let activeLang = ideManager.activeProject?.language ?? .swift
                switch activeLang {
                case .python:
                    quickInsertButton("def", insert: "def ")
                    quickInsertButton("class", insert: "class ")
                    quickInsertButton("import", insert: "import ")
                    quickInsertButton("print", insert: "print()")
                    quickInsertButton("if", insert: "if ")
                    quickInsertButton("else:", insert: "else:\n    ")
                    quickInsertButton("for", insert: "for  in :")
                    quickInsertButton("in", insert: " in ")
                    quickInsertButton(":", insert: ":")
                    quickInsertButton("( )", insert: "()")
                    quickInsertButton("[ ]", insert: "[]")
                    quickInsertButton("\" \"", insert: "\"\"")
                    quickInsertButton("Tab", insert: "    ")
                    
                case .csharp:
                    quickInsertButton("Console.WriteLine", insert: "Console.WriteLine();")
                    quickInsertButton("class", insert: "class ")
                    quickInsertButton("public", insert: "public ")
                    quickInsertButton("var", insert: "var ")
                    quickInsertButton("void", insert: "void ")
                    quickInsertButton("new", insert: "new ")
                    quickInsertButton("{ }", insert: " {\n    \n}")
                    quickInsertButton("( )", insert: "()")
                    quickInsertButton("[ ]", insert: "[]")
                    quickInsertButton(";", insert: ";")
                    quickInsertButton("Tab", insert: "    ")
                    
                case .sql:
                    quickInsertButton("SELECT", insert: "SELECT ")
                    quickInsertButton("FROM", insert: "FROM ")
                    quickInsertButton("WHERE", insert: "WHERE ")
                    quickInsertButton("JOIN", insert: "JOIN ")
                    quickInsertButton("GROUP BY", insert: "GROUP BY ")
                    quickInsertButton("ORDER BY", insert: "ORDER BY ")
                    quickInsertButton("LIMIT", insert: "LIMIT ")
                    quickInsertButton("COUNT(*)", insert: "COUNT(*)")
                    quickInsertButton(";", insert: ";")
                    quickInsertButton("Tab", insert: "    ")
                    
                case .swift:
                    quickInsertButton("{ }", insert: " {\n    \n}")
                    quickInsertButton("( )", insert: "()")
                    quickInsertButton("[ ]", insert: "[]")
                    quickInsertButton("\" \"", insert: "\"\"")
                    quickInsertButton("->", insert: " -> ")
                    quickInsertButton("func", insert: "func ")
                    quickInsertButton("var", insert: "var ")
                    quickInsertButton("let", insert: "let ")
                    quickInsertButton("print", insert: "print()")
                    quickInsertButton("struct", insert: "struct ")
                    quickInsertButton("Tab", insert: "    ")
                }
                
                Button(action: { showingConsole.toggle() }) {
                    Image(systemName: showingConsole ? "rectangle.bottomthird.inset.filled" : "rectangle.bottomthird.inset.split")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background(Color(UIColor.secondarySystemBackground))
                        .foregroundColor(.secondary)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
        .background(Color(UIColor.secondarySystemBackground))
    }
    
    private func quickInsertButton(_ label: String, insert: String) -> some View {
        Button(action: {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            currentCode += insert
            ideManager.updateActiveFile(content: currentCode)
        }) {
            Text(label)
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Color(UIColor.tertiarySystemBackground))
                .foregroundColor(.primary)
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
    }
    
    // MARK: - Console Area
    private var consoleArea: some View {
        VStack(spacing: 0) {
            Divider()
            
            // Console Header Tabs
            HStack {
                Button(action: { selectedConsoleTab = 0 }) {
                    Text(lang.localized("Консоль вывода", "Console Output"))
                        .font(.caption.bold())
                        .foregroundColor(selectedConsoleTab == 0 ? Color(red: 0.14, green: 0.38, blue: 0.82) : .secondary)
                }
                
                Text("•").foregroundColor(.secondary)
                
                Button(action: { selectedConsoleTab = 1 }) {
                    Text(lang.localized("Переменные (\(executionResult.variables.count))", "Variables (\(executionResult.variables.count))"))
                        .font(.caption.bold())
                        .foregroundColor(selectedConsoleTab == 1 ? Color(red: 0.14, green: 0.38, blue: 0.82) : .secondary)
                }
                
                Text("•").foregroundColor(.secondary)
                
                Button(action: { selectedConsoleTab = 2 }) {
                    HStack(spacing: 4) {
                        Image(systemName: "terminal.fill")
                            .font(.caption2)
                        Text(lang.localized("REPL", "REPL"))
                            .font(.caption.bold())
                    }
                    .foregroundColor(selectedConsoleTab == 2 ? Color(red: 0.14, green: 0.38, blue: 0.82) : .secondary)
                }
                
                Spacer()
                
                Button(action: {
                    if selectedConsoleTab == 2 {
                        replSession.reset()
                    } else {
                        executionResult = .empty
                    }
                }) {
                    Text(lang.localized("Очистить", "Clear"))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isConsoleExpanded.toggle()
                    }
                }) {
                    Image(systemName: isConsoleExpanded ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .padding(.leading, 4)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 6)
            .background(Color(UIColor.secondarySystemBackground))
            
            // Console Content
            Group {
                if selectedConsoleTab == 0 {
                    ScrollView {
                        consoleOutputContent
                    }
                } else if selectedConsoleTab == 1 {
                    ScrollView {
                        memoryInspectorContent
                    }
                } else {
                    IDEREPLView(replSession: replSession)
                }
            }
            .frame(height: isConsoleExpanded ? 320 : (selectedConsoleTab == 2 ? 220 : 130))
            .background(Color(UIColor.secondarySystemBackground))
        }
        .background(Color(UIColor.secondarySystemBackground))
        .clipped()
    }
    
    private var consoleOutputContent: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let error = executionResult.error {
                Text("\(lang.localized("Ошибка компиляции/выполнения", "Execution Error")) (строка \(error.line)): \(error.message)")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundColor(.red)
                    .padding(8)
            }
            
            if executionResult.output.isEmpty && executionResult.error == nil {
                Text(lang.localized("// Нажмите 'Собрать и запустить' для запуска проекта.", "// Press 'Build & Run' to execute the project."))
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundColor(.secondary.opacity(0.7))
                    .padding(8)
            } else {
                Text(executionResult.output)
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundColor(.primary)
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var memoryInspectorContent: some View {
        VStack(alignment: .leading, spacing: 0) {
            if executionResult.variables.isEmpty {
                Text(lang.localized("// Нет переменных в глобальной области видимости.", "// No variables in scope."))
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundColor(.secondary.opacity(0.7))
                    .padding(8)
            } else {
                ForEach(executionResult.variables) { variable in
                    HStack {
                        Text(variable.name)
                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                            .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                        Text(":")
                            .foregroundColor(.secondary)
                        Text(variable.typeName)
                            .font(.system(size: 10, design: .monospaced))
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(variable.valueDescription)
                            .font(.system(size: 11, design: .monospaced))
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    Divider()
                }
            }
        }
    }
    
    // MARK: - Actions
    private func syncEditorWithActiveFile() {
        if let file = ideManager.activeFile {
            currentCode = file.content
            activeFileId = file.id
        }
        if let lang = ideManager.activeProject?.language {
            replSession.setLanguage(lang)
        }
    }
    
    private func insertSnippet(_ snippet: String) {
        if currentCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            currentCode = snippet
        } else {
            currentCode += "\n\n" + snippet
        }
        ideManager.updateActiveFile(content: currentCode)
    }
    
    private func saveCurrentContent() {
        ideManager.updateActiveFile(content: currentCode)
    }
    
    private func runProject() {
        saveCurrentContent()
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        isExecuting = true
        showingConsole = true
        
        let projectLanguage = ideManager.activeProject?.language ?? .swift
        let codeToExecute = ideManager.activeProject?.combinedCodeForExecution() ?? currentCode
        
        Task {
            let result = await PlaygroundEngine.shared.execute(code: codeToExecute, language: projectLanguage)
            await MainActor.run {
                self.executionResult = result
                self.isExecuting = false
                if result.success {
                    storage.addXP(10)
                }
            }
        }
    }
    
    private func exportProject() {
        saveCurrentContent()
        if let url = ideManager.exportActiveProjectAsZip() {
            exportURL = url
            showingExportSheet = true
        }
    }
}
