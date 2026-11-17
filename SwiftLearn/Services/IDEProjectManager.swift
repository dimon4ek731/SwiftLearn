import Foundation
import Combine
import SwiftUI

@MainActor
public final class IDEProjectManager: ObservableObject {
    public static let shared = IDEProjectManager()
    
    private let projectsKey = "swiftlearn_ide_projects_v1"
    private let themeKey = "swiftlearn_ide_theme_v1"
    private let activeProjectIdKey = "swiftlearn_ide_active_project_id"
    
    @Published public var projects: [IDEProject] = [] {
        didSet {
            scheduleSaveProjects()
        }
    }
    
    @Published public var activeProjectId: UUID {
        didSet {
            UserDefaults.standard.set(activeProjectId.uuidString, forKey: activeProjectIdKey)
        }
    }
    
    @Published public var theme: IDETheme {
        didSet {
            scheduleSaveTheme()
        }
    }
    
    private var saveProjectsWorkItem: DispatchWorkItem?
    private var saveThemeWorkItem: DispatchWorkItem?
    
    public init() {
        // Load Theme
        if let themeData = UserDefaults.standard.data(forKey: themeKey),
           let decodedTheme = try? JSONDecoder().decode(IDETheme.self, from: themeData) {
            self.theme = decodedTheme
        } else {
            self.theme = IDETheme.forPreset(.xcodeDark)
        }
        
        // Load Projects
        var loadedProjects: [IDEProject]
        if let data = UserDefaults.standard.data(forKey: projectsKey),
           let decoded = try? JSONDecoder().decode([IDEProject].self, from: data),
           !decoded.isEmpty {
            loadedProjects = decoded
            for template in IDEProject.defaultTemplates {
                if !loadedProjects.contains(where: { $0.name == template.name }) {
                    loadedProjects.append(template)
                }
            }
        } else {
            loadedProjects = IDEProject.defaultTemplates
        }
        self.projects = loadedProjects
        
        // Load active project id
        if let savedIdString = UserDefaults.standard.string(forKey: activeProjectIdKey),
           let savedUUID = UUID(uuidString: savedIdString),
           loadedProjects.contains(where: { $0.id == savedUUID }) {
            self.activeProjectId = savedUUID
        } else {
            self.activeProjectId = loadedProjects.first?.id ?? UUID()
        }
    }
    
    public var activeProject: IDEProject? {
        get {
            projects.first(where: { $0.id == activeProjectId }) ?? projects.first
        }
        set {
            if let newProj = newValue, let idx = projects.firstIndex(where: { $0.id == newProj.id }) {
                projects[idx] = newProj
            }
        }
    }
    
    public var activeFile: IDEFile? {
        activeProject?.activeFile
    }
    
    public func selectProject(id: UUID) {
        if projects.contains(where: { $0.id == id }) {
            activeProjectId = id
        }
    }
    
    public func selectFile(id: UUID) {
        guard let idx = projects.firstIndex(where: { $0.id == activeProjectId }) else { return }
        if projects[idx].files.contains(where: { $0.id == id }) {
            projects[idx].activeFileId = id
        }
    }
    
    public func updateActiveFile(content: String) {
        guard let pIdx = projects.firstIndex(where: { $0.id == activeProjectId }) else { return }
        let currentFileId = projects[pIdx].activeFileId
        projects[pIdx].updateFileContent(id: currentFileId, newContent: content)
    }
    
    public func addFile(name: String, content: String = "") {
        guard let pIdx = projects.firstIndex(where: { $0.id == activeProjectId }) else { return }
        _ = projects[pIdx].addFile(name: name, initialContent: content)
    }
    
    public func removeFile(id: UUID) {
        guard let pIdx = projects.firstIndex(where: { $0.id == activeProjectId }) else { return }
        projects[pIdx].removeFile(id: id)
    }
    
    public func createProject(name: String, description: String, language: TargetLanguage = .swift, template: IDEProject? = nil) {
        let projLanguage = template?.language ?? language
        let baseFiles: [IDEFile]
        if let templateFiles = template?.files, !templateFiles.isEmpty {
            baseFiles = templateFiles
        } else {
            let defaultFileName: String
            let defaultContent: String
            switch projLanguage {
            case .swift:
                defaultFileName = "main.swift"
                defaultContent = "// Swift Project\nprint(\"Hello, Swift!\")\n"
            case .python:
                defaultFileName = "main.py"
                defaultContent = "# Python Project\nprint(\"Hello, Python!\")\n"
            case .csharp:
                defaultFileName = "Program.cs"
                defaultContent = "// C# .NET Project\nusing System;\n\nConsole.WriteLine(\"Hello, C#!\");\n"
            case .sql:
                defaultFileName = "main.sql"
                defaultContent = "-- SQL Script\nSELECT 'Hello, SQL Database!' AS greeting;\n"
            }
            baseFiles = [IDEFile(name: defaultFileName, content: defaultContent)]
        }
        
        let newProject = IDEProject(
            name: name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "New Project" : name,
            descriptionText: description,
            language: projLanguage,
            files: baseFiles
        )
        projects.insert(newProject, at: 0)
        activeProjectId = newProject.id
    }
    
    public func deleteProject(id: UUID) {
        guard projects.count > 1 else { return } // Keep at least one
        projects.removeAll(where: { $0.id == id })
        if activeProjectId == id {
            activeProjectId = projects.first?.id ?? UUID()
        }
    }
    
    public func duplicateProject(id: UUID) {
        guard let original = projects.first(where: { $0.id == id }) else { return }
        let copy = IDEProject(
            name: "\(original.name) (Copy)",
            descriptionText: original.descriptionText,
            language: original.language,
            files: original.files.map { IDEFile(name: $0.name, content: $0.content) }
        )
        projects.insert(copy, at: 0)
        activeProjectId = copy.id
    }
    
    // MARK: - Export to Laptop / Files / AirDrop
    
    /// Creates a zip archive of the active project and returns its local file URL.
    public func exportActiveProjectAsZip() -> URL? {
        guard let project = activeProject else { return nil }
        
        let sanitizedName = project.name
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
            .joined(separator: "_")
        let zipFileName = "\(sanitizedName.isEmpty ? "SwiftProject" : sanitizedName).zip"
        
        let entries = project.files.map { file in
            ZipArchiver.FileEntry(name: file.name, text: file.content)
        }
        
        let zipData = ZipArchiver.createZip(files: entries)
        let tempDir = FileManager.default.temporaryDirectory
        let destinationURL = tempDir.appendingPathComponent(zipFileName)
        
        do {
            try zipData.write(to: destinationURL, options: .atomic)
            return destinationURL
        } catch {
            print("Failed to write project zip:", error)
            return nil
        }
    }
    
    /// Exports the single currently active file as a .swift file URL.
    public func exportActiveFile() -> URL? {
        guard let file = activeFile else { return nil }
        let tempDir = FileManager.default.temporaryDirectory
        let destinationURL = tempDir.appendingPathComponent(file.name)
        
        do {
            try file.content.write(to: destinationURL, atomically: true, encoding: .utf8)
            return destinationURL
        } catch {
            print("Failed to write active file:", error)
            return nil
        }
    }
    
    // MARK: - Import Project from External File / ZIP
    public func importProject(from url: URL) -> Bool {
        let isAccessing = url.startAccessingSecurityScopedResource()
        defer {
            if isAccessing {
                url.stopAccessingSecurityScopedResource()
            }
        }
        
        let ext = url.pathExtension.lowercased()
        let rawBase = url.deletingPathExtension().lastPathComponent
        let projectName = rawBase.replacingOccurrences(of: "_", with: " ")
        
        if ext == "zip" {
            guard let data = try? Data(contentsOf: url) else { return false }
            let entries = ZipArchiver.extractFiles(from: data)
            guard !entries.isEmpty else { return false }
            
            // Detect dominant language from files
            var lang: TargetLanguage = .swift
            for entry in entries {
                let fExt = (entry.name as NSString).pathExtension.lowercased()
                if fExt == "py" { lang = .python; break }
                if fExt == "cs" { lang = .csharp; break }
                if fExt == "sql" { lang = .sql; break }
                if fExt == "swift" { lang = .swift; break }
            }
            
            let ideFiles = entries.map { entry in
                let text = String(data: entry.data, encoding: .utf8) ?? ""
                return IDEFile(name: entry.name, content: text)
            }
            
            let newProject = IDEProject(
                name: projectName.isEmpty ? "Imported Project" : projectName,
                descriptionText: "Импортировано из ZIP архива",
                language: lang,
                files: ideFiles
            )
            projects.insert(newProject, at: 0)
            activeProjectId = newProject.id
            return true
        } else {
            // Single code file
            guard let text = try? String(contentsOf: url, encoding: .utf8) else { return false }
            let lang: TargetLanguage
            switch ext {
            case "py": lang = .python
            case "cs": lang = .csharp
            case "sql": lang = .sql
            default: lang = .swift
            }
            
            let file = IDEFile(name: url.lastPathComponent, content: text)
            let newProject = IDEProject(
                name: projectName.isEmpty ? "Imported File" : projectName,
                descriptionText: "Импортировано из файла \(url.lastPathComponent)",
                language: lang,
                files: [file]
            )
            projects.insert(newProject, at: 0)
            activeProjectId = newProject.id
            return true
        }
    }
    
    // MARK: - Persistence
    private func scheduleSaveProjects() {
        saveProjectsWorkItem?.cancel()
        let projectsToSave = self.projects
        let key = self.projectsKey
        
        let item = DispatchWorkItem {
            if let encoded = try? JSONEncoder().encode(projectsToSave) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
        saveProjectsWorkItem = item
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 0.5, execute: item)
    }
    
    private func scheduleSaveTheme() {
        saveThemeWorkItem?.cancel()
        let themeToSave = self.theme
        let key = self.themeKey
        
        let item = DispatchWorkItem {
            if let encoded = try? JSONEncoder().encode(themeToSave) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
        saveThemeWorkItem = item
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 0.3, execute: item)
    }
}
