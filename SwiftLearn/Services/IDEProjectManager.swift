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
        let loadedProjects: [IDEProject]
        if let data = UserDefaults.standard.data(forKey: projectsKey),
           let decoded = try? JSONDecoder().decode([IDEProject].self, from: data),
           !decoded.isEmpty {
            loadedProjects = decoded
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
    
    public func createProject(name: String, description: String, template: IDEProject? = nil) {
        let baseFiles = template?.files ?? [IDEFile(name: "main.swift", content: "// New Swift Project\nprint(\"Hello, World!\")\n")]
        let newProject = IDEProject(
            name: name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "New Project" : name,
            descriptionText: description,
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
