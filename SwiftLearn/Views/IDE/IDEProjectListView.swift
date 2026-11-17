import SwiftUI

public struct IDEProjectListView: View {
    @ObservedObject var ideManager = IDEProjectManager.shared
    @ObservedObject var lang = LanguageManager.shared
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingNewProjectModal: Bool = false
    @State private var newProjectName: String = ""
    @State private var newProjectDesc: String = ""
    @State private var selectedTemplateIndex: Int = 0
    @State private var projectToExport: URL? = nil
    @State private var showingExportSheet: Bool = false
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            List {
                Section(header: Text(lang.localized("Текущие проекты", "Projects"))) {
                    ForEach(ideManager.projects) { project in
                        projectRow(project)
                    }
                    .onDelete(perform: deleteProjects)
                }
            }
            .navigationTitle(lang.localized("Проекты IDE", "IDE Projects"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(lang.localized("Закрыть", "Close")) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showingNewProjectModal = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingNewProjectModal) {
                newProjectSheet
            }
            .sheet(isPresented: $showingExportSheet) {
                if let url = projectToExport {
                    ShareSheet(items: [url])
                }
            }
        }
    }
    
    private func projectRow(_ project: IDEProject) -> some View {
        let isSelected = ideManager.activeProjectId == project.id
        
        return Button(action: {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            ideManager.selectProject(id: project.id)
            dismiss()
        }) {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSelected ? Color(red: 0.14, green: 0.38, blue: 0.82) : Color(UIColor.secondarySystemBackground))
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: isSelected ? "folder.fill.badge.gearshape" : "folder.fill")
                        .foregroundColor(isSelected ? .white : Color(red: 0.14, green: 0.38, blue: 0.82))
                        .font(.title3)
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Text(project.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        if isSelected {
                            Text(lang.localized("АКТИВНЫЙ", "ACTIVE"))
                                .font(.system(size: 9, weight: .bold))
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.green.opacity(0.18))
                                .foregroundColor(.green)
                                .clipShape(Capsule())
                        }
                    }
                    
                    Text("\(project.files.count) \(lang.localized("файл(ов)", "file(s)")) • \(formatDate(project.updatedAt))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    if !project.descriptionText.isEmpty {
                        Text(project.descriptionText)
                            .font(.caption2)
                            .foregroundColor(.secondary.opacity(0.8))
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                Menu {
                    Button(action: {
                        ideManager.duplicateProject(id: project.id)
                    }) {
                        Label(lang.localized("Дублировать", "Duplicate"), systemImage: "doc.on.doc")
                    }
                    
                    Button(action: {
                        exportProject(project)
                    }) {
                        Label(lang.localized("Экспорт в ZIP (на ноутбук)", "Export ZIP (to Laptop)"), systemImage: "square.and.arrow.up")
                    }
                    
                    if ideManager.projects.count > 1 {
                        Button(role: .destructive, action: {
                            ideManager.deleteProject(id: project.id)
                        }) {
                            Label(lang.localized("Удалить", "Delete"), systemImage: "trash")
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(8)
                }
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - New Project Sheet
    private var newProjectSheet: some View {
        NavigationStack {
            Form {
                Section(header: Text(lang.localized("Данные проекта", "Project Details"))) {
                    TextField(lang.localized("Название проекта", "Project Name"), text: $newProjectName)
                    TextField(lang.localized("Описание (опционально)", "Description (optional)"), text: $newProjectDesc)
                }
                
                Section(header: Text(lang.localized("Шаблон архитектуры", "Architecture Template"))) {
                    let templates = IDEProject.defaultTemplates
                    Picker(lang.localized("Шаблон", "Template"), selection: $selectedTemplateIndex) {
                        ForEach(0..<templates.count, id: \.self) { idx in
                            Text(templates[idx].name).tag(idx)
                        }
                    }
                    .pickerStyle(.inline)
                }
            }
            .navigationTitle(lang.localized("Новый проект", "New Project"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(lang.localized("Отмена", "Cancel")) {
                        showingNewProjectModal = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(lang.localized("Создать", "Create")) {
                        let templates = IDEProject.defaultTemplates
                        let template = templates[safe: selectedTemplateIndex]
                        ideManager.createProject(
                            name: newProjectName.isEmpty ? "MyProject" : newProjectName,
                            description: newProjectDesc,
                            template: template
                        )
                        newProjectName = ""
                        newProjectDesc = ""
                        showingNewProjectModal = false
                    }
                }
            }
        }
    }
    
    private func exportProject(_ project: IDEProject) {
        ideManager.selectProject(id: project.id)
        if let url = ideManager.exportActiveProjectAsZip() {
            projectToExport = url
            showingExportSheet = true
        }
    }
    
    private func deleteProjects(at offsets: IndexSet) {
        for index in offsets {
            let project = ideManager.projects[index]
            ideManager.deleteProject(id: project.id)
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: date)
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
