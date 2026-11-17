import SwiftUI

public struct IDEFileExplorerView: View {
    @ObservedObject var ideManager = IDEProjectManager.shared
    @ObservedObject var lang = LanguageManager.shared
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingNewFileAlert: Bool = false
    @State private var newFileName: String = ""
    
    @State private var showingRenameAlert: Bool = false
    @State private var fileToRename: IDEFile? = nil
    @State private var renameFileNameText: String = ""
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            List {
                // Project Overview Header
                if let project = ideManager.activeProject {
                    Section {
                        HStack(spacing: 12) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(red: 0.14, green: 0.38, blue: 0.82).opacity(0.12))
                                    .frame(width: 44, height: 44)
                                Image(systemName: "folder.fill")
                                    .font(.title3)
                                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                            }
                            
                            VStack(alignment: .leading, spacing: 3) {
                                HStack(spacing: 6) {
                                    Text(project.name)
                                        .font(.headline)
                                    
                                    HStack(spacing: 3) {
                                        Image(systemName: project.language.icon)
                                            .font(.system(size: 8, weight: .bold))
                                        Text(project.language.displayName)
                                            .font(.system(size: 9, weight: .bold))
                                    }
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color(red: 0.14, green: 0.38, blue: 0.82).opacity(0.12))
                                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                                    .clipShape(Capsule())
                                }
                                
                                Text("\(project.files.count) \(lang.localized("файлов в проекте", "files in project"))")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                
                // Files Section
                Section(header: Text(lang.localized("Файлы проекта", "Project Files"))) {
                    if let project = ideManager.activeProject {
                        ForEach(project.files) { file in
                            fileRow(file: file, isActive: file.id == project.activeFileId)
                        }
                    }
                }
                
                // Quick File Presets
                Section(header: Text(lang.localized("Быстрое создание модулей", "Quick Module Presets"))) {
                    let presets = quickPresetsForLanguage(ideManager.activeProject?.language ?? .swift)
                    ForEach(presets, id: \.self) { presetName in
                        Button {
                            createFileNamed(presetName)
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle")
                                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                                Text(presetName)
                                    .font(.system(size: 13, design: .monospaced))
                                    .foregroundColor(.primary)
                                Spacer()
                                Text(lang.localized("Создать", "Add"))
                                    .font(.caption2.bold())
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle(lang.localized("Файлы проекта", "Project Files"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(lang.localized("Готово", "Done")) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingNewFileAlert = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert(lang.localized("Новый файл", "New File"), isPresented: $showingNewFileAlert) {
                let ext = ideManager.activeProject?.language.fileExtension ?? "swift"
                TextField("module.\(ext)", text: $newFileName)
                Button(lang.localized("Отмена", "Cancel"), role: .cancel) {
                    newFileName = ""
                }
                Button(lang.localized("Создать", "Create")) {
                    if !newFileName.isEmpty {
                        createFileNamed(newFileName)
                        newFileName = ""
                    }
                }
            }
            .alert(lang.localized("Переименовать файл", "Rename File"), isPresented: $showingRenameAlert) {
                TextField("filename.ext", text: $renameFileNameText)
                Button(lang.localized("Отмена", "Cancel"), role: .cancel) {
                    fileToRename = nil
                    renameFileNameText = ""
                }
                Button(lang.localized("Сохранить", "Save")) {
                    if let target = fileToRename, !renameFileNameText.isEmpty {
                        renameFile(target, newName: renameFileNameText)
                        fileToRename = nil
                        renameFileNameText = ""
                    }
                }
            }
        }
    }
    
    private func fileRow(file: IDEFile, isActive: Bool) -> some View {
        let fileIcon = iconForFilename(file.name)
        let linesCount = file.content.components(separatedBy: .newlines).count
        let bytesCount = file.content.utf8.count
        let sizeDescription = bytesCount > 1024 ? String(format: "%.1f KB", Double(bytesCount) / 1024.0) : "\(bytesCount) B"
        
        return Button {
            ideManager.selectFile(id: file.id)
            dismiss()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: fileIcon.icon)
                    .font(.body)
                    .foregroundColor(fileIcon.color)
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 6) {
                        Text(file.name)
                            .font(.system(size: 14, weight: isActive ? .bold : .medium, design: .monospaced))
                            .foregroundColor(.primary)
                        
                        if isActive {
                            Text(lang.localized("АКТИВНЫЙ", "ACTIVE"))
                                .font(.system(size: 8, weight: .bold))
                                .padding(.horizontal, 5)
                                .padding(.vertical, 1)
                                .background(Color(red: 0.14, green: 0.38, blue: 0.82).opacity(0.15))
                                .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                                .clipShape(Capsule())
                        }
                    }
                    
                    Text("\(linesCount) \(lang.localized("строк", "lines")) • \(sizeDescription)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Menu {
                    Button {
                        fileToRename = file
                        renameFileNameText = file.name
                        showingRenameAlert = true
                    } label: {
                        Label(lang.localized("Переименовать", "Rename"), systemImage: "pencil")
                    }
                    
                    Button {
                        duplicateFile(file)
                    } label: {
                        Label(lang.localized("Дублировать", "Duplicate"), systemImage: "doc.on.doc")
                    }
                    
                    if let project = ideManager.activeProject, project.files.count > 1 {
                        Button(role: .destructive) {
                            ideManager.removeFile(id: file.id)
                        } label: {
                            Label(lang.localized("Удалить", "Delete"), systemImage: "trash")
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(8)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    private func iconForFilename(_ name: String) -> (icon: String, color: Color) {
        let ext = name.components(separatedBy: ".").last?.lowercased() ?? ""
        switch ext {
        case "swift": return ("swift", .orange)
        case "py": return ("chevron.left.forwardslash.chevron.right", Color(red: 0.20, green: 0.45, blue: 0.85))
        case "cs": return ("curlybraces", Color(red: 0.55, green: 0.25, blue: 0.85))
        case "sql": return ("cylinder.split.1x2", Color(red: 0.16, green: 0.58, blue: 0.40))
        default: return ("doc.text", .secondary)
        }
    }
    
    private func quickPresetsForLanguage(_ language: TargetLanguage) -> [String] {
        switch language {
        case .swift: return ["Models.swift", "Services.swift", "ViewModel.swift", "Utils.swift"]
        case .python: return ["models.py", "services.py", "utils.py", "helpers.py"]
        case .csharp: return ["Models.cs", "Repository.cs", "Service.cs", "Helper.cs"]
        case .sql: return ["02_tables.sql", "03_seed_data.sql", "04_queries.sql", "05_indexes.sql"]
        }
    }
    
    private func createFileNamed(_ name: String) {
        var clean = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let ext = ideManager.activeProject?.language.fileExtension ?? "swift"
        if !clean.contains(".") {
            clean += ".\(ext)"
        }
        let prefix = (ideManager.activeProject?.language == .python) ? "#" : (ideManager.activeProject?.language == .sql ? "--" : "//")
        ideManager.addFile(name: clean, content: "\(prefix) \(clean)\n")
    }
    
    private func renameFile(_ file: IDEFile, newName: String) {
        guard let pIdx = ideManager.projects.firstIndex(where: { $0.id == ideManager.activeProjectId }) else { return }
        if let fIdx = ideManager.projects[pIdx].files.firstIndex(where: { $0.id == file.id }) {
            ideManager.projects[pIdx].files[fIdx].name = newName
            ideManager.projects[pIdx].updatedAt = Date()
        }
    }
    
    private func duplicateFile(_ file: IDEFile) {
        let ext = (file.name as NSString).pathExtension
        let baseName = (file.name as NSString).deletingPathExtension
        let copyName = "\(baseName)_Copy.\(ext)"
        ideManager.addFile(name: copyName, content: file.content)
    }
}
