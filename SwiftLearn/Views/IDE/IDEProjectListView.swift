import SwiftUI

public struct IDEProjectListView: View {
    @ObservedObject var ideManager = IDEProjectManager.shared
    @ObservedObject var lang = LanguageManager.shared
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingNewProjectModal: Bool = false
    @State private var newProjectName: String = ""
    @State private var newProjectDesc: String = ""
    @State private var selectedLanguage: TargetLanguage = .swift
    @State private var selectedTemplateIndex: Int = 0
    @State private var projectToExport: URL? = nil
    @State private var showingExportSheet: Bool = false
    @State private var showingFileImporter: Bool = false
    @State private var importErrorMessage: String? = nil
    @State private var showingImportAlert: Bool = false
    
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
                    HStack(spacing: 12) {
                        Button(action: { showingFileImporter = true }) {
                            Image(systemName: "square.and.arrow.down")
                        }
                        
                        Button(action: {
                            selectedLanguage = ideManager.activeProject?.language ?? .swift
                            selectedTemplateIndex = 0
                            showingNewProjectModal = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .fileImporter(
                isPresented: $showingFileImporter,
                allowedContentTypes: [.zip, .plainText, .sourceCode]
            ) { result in
                switch result {
                case .success(let url):
                    let success = ideManager.importProject(from: url)
                    if success {
                        dismiss()
                    } else {
                        importErrorMessage = lang.localized("Не удалось прочитать или импортировать файл.", "Failed to read or import the selected file.")
                        showingImportAlert = true
                    }
                case .failure(let error):
                    importErrorMessage = error.localizedDescription
                    showingImportAlert = true
                }
            }
            .alert(lang.localized("Ошибка импорта", "Import Error"), isPresented: $showingImportAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(importErrorMessage ?? "")
            }
            .sheet(isPresented: $showingNewProjectModal) {
                newProjectSheet
            }
            .sheet(isPresented: $showingExportSheet) {
                if let url = projectToExport {
                    ShareSheet(items: [url])
                }
            }
            .onAppear {
                if ProcessInfo.processInfo.arguments.contains("-newProject") {
                    selectedLanguage = .python
                    showingNewProjectModal = true
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
                    HStack(spacing: 6) {
                        Text(project.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        // Language Badge
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
                    Menu {
                        ForEach(TargetLanguage.allCases) { langItem in
                            Button {
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                ideManager.changeProjectLanguage(id: project.id, newLanguage: langItem)
                            } label: {
                                HStack {
                                    Text(langItem.displayName)
                                    if project.language == langItem {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                    } label: {
                        Label(lang.localized("Изменить язык проекта", "Change Project Language"), systemImage: "arrow.triangle.2.circlepath")
                    }
                    
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
                Section(header: Text(lang.localized("Язык проекта", "Project Language"))) {
                    HStack(spacing: 0) {
                        ForEach(TargetLanguage.allCases) { item in
                            let isSelected = selectedLanguage == item
                            Button {
                                selectLanguage(item)
                            } label: {
                                HStack(spacing: 5) {
                                    Image(systemName: item.icon)
                                        .font(.system(size: 11, weight: .semibold))
                                    Text(item.displayName)
                                        .font(.system(size: 13, weight: isSelected ? .bold : .medium))
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(
                                    ZStack {
                                        if isSelected {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color(UIColor.systemBackground))
                                                .shadow(color: Color.black.opacity(0.12), radius: 3, x: 0, y: 1)
                                        }
                                    }
                                )
                                .foregroundColor(isSelected ? Color(red: 0.14, green: 0.38, blue: 0.82) : .secondary)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                    .padding(3)
                    .background(Color(UIColor.tertiarySystemFill))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .listRowInsets(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
                }
                
                Section(header: Text(lang.localized("Данные проекта", "Project Details"))) {
                    TextField(lang.localized("Название проекта", "Project Name"), text: $newProjectName)
                    TextField(lang.localized("Описание (опционально)", "Description (optional)"), text: $newProjectDesc)
                }
                
                Section(header: Text(lang.localized("Шаблон архитектуры", "Architecture Template"))) {
                    let templates = IDEProject.defaultTemplates.filter { $0.language == selectedLanguage }
                    Picker(lang.localized("Шаблон", "Template"), selection: $selectedTemplateIndex) {
                        Text(lang.localized("Пустой проект", "Blank Project")).tag(0)
                        ForEach(0..<templates.count, id: \.self) { idx in
                            Text(templates[idx].name).tag(idx + 1)
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
                        let templates = IDEProject.defaultTemplates.filter { $0.language == selectedLanguage }
                        let template: IDEProject? = selectedTemplateIndex > 0 ? templates[safe: selectedTemplateIndex - 1] : nil
                        
                        let defaultName = template?.name ?? "My\(selectedLanguage.displayName)App"
                        ideManager.createProject(
                            name: newProjectName.isEmpty ? defaultName : newProjectName,
                            description: newProjectDesc.isEmpty ? (template?.descriptionText ?? "") : newProjectDesc,
                            language: selectedLanguage,
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
    
    private func selectLanguage(_ item: TargetLanguage) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        withAnimation(.spring(response: 0.28, dampingFraction: 0.76)) {
            selectedLanguage = item
            selectedTemplateIndex = 0
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
