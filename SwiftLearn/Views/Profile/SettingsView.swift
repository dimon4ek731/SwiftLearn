import SwiftUI

public struct SettingsView: View {
    @ObservedObject var lang = LanguageManager.shared
    @ObservedObject var storage = StorageService.shared
    @ObservedObject var ideManager = IDEProjectManager.shared
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingThemeSettings: Bool = false
    @State private var showResetAlert: Bool = false
    @State private var showResetIDEAlert: Bool = false
    @State private var showClearCacheSuccess: Bool = false
    
    public init() {}
    
    private var totalFileCount: Int {
        ideManager.projects.reduce(0) { $0 + $1.files.count }
    }
    
    public var body: some View {
        NavigationStack {
            Form {
                // Section 1: IDE & Editor Appearance
                Section(header: Text(lang.localized("Среда разработки и Редактор", "IDE & Code Editor"))) {
                    Button(action: { showingThemeSettings = true }) {
                        HStack {
                            Label {
                                Text(lang.localized("Темы и палитра цветов", "Theme & Syntax Palette"))
                                    .foregroundColor(.primary)
                            } icon: {
                                Image(systemName: "paintpalette.fill")
                                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                            }
                            Spacer()
                            Text(ideManager.theme.preset.rawValue)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Image(systemName: "chevron.right")
                                .font(.caption2)
                                .foregroundColor(.secondary.opacity(0.5))
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(lang.localized("Размер шрифта кода", "Editor Font Size"))
                            Spacer()
                            Text("\(Int(ideManager.theme.fontSize)) pt")
                                .font(.system(size: 13, weight: .bold, design: .monospaced))
                                .foregroundColor(.secondary)
                        }
                        Slider(
                            value: $ideManager.theme.fontSize,
                            in: 11...22,
                            step: 1
                        )
                    }
                    .padding(.vertical, 4)
                    
                    Toggle(
                        lang.localized("Показывать номера строк", "Show Line Numbers"),
                        isOn: $ideManager.theme.showLineNumbers
                    )
                    
                    Toggle(
                        lang.localized("Перенос длинных строк", "Word Wrap"),
                        isOn: $ideManager.theme.wrapLines
                    )
                    
                    Toggle(
                        lang.localized("Умные подсказки кода (Autocomplete)", "Smart Autocomplete Suggestions"),
                        isOn: $ideManager.theme.enableAutocomplete
                    )
                    
                    HStack {
                        Text(lang.localized("Подсветка синтаксиса в Скрипте", "Playground Syntax Highlighting"))
                        Spacer()
                        Text(lang.localized("Включена (TextKit)", "Active (TextKit)"))
                            .font(.caption.bold())
                            .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                    }
                    
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        ideManager.theme = IDETheme.forPreset(.xcodeDark)
                    }) {
                        Text(lang.localized("Сбросить тему к Xcode Dark", "Reset Theme to Xcode Dark"))
                            .font(.subheadline)
                            .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                    }
                }
                
                // Section 2: Language & Localization
                Section(header: Text(lang.localized("Язык интерфейса и материалов", "Language & Locale"))) {
                    Picker(lang.localized("Язык", "Language"), selection: $lang.currentLanguage) {
                        ForEach(AppLanguage.allCases) { item in
                            Text(item.title).tag(item)
                        }
                    }
                    .pickerStyle(.inline)
                }
                
                // Section 3: Compiler & Execution Runtime
                Section(header: Text(lang.localized("Компилятор и Исполнение", "Compiler & Execution Engine"))) {
                    HStack {
                        Text(lang.localized("Версия Swift", "Swift Version"))
                        Spacer()
                        Text("Swift 6.0")
                            .font(.system(size: 13, design: .monospaced))
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text(lang.localized("Конкурентность", "Concurrency Mode"))
                        Spacer()
                        Text("Strict Concurrency Checks")
                            .font(.caption.monospaced())
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text(lang.localized("Статический анализатор", "Static Diagnostics"))
                        Spacer()
                        Text(lang.localized("CodeDiagnostics (Вкл)", "CodeDiagnostics (Active)"))
                            .font(.caption.bold())
                            .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                    }
                    HStack {
                        Text(lang.localized("Лимит исполнения скрипта", "Execution Timeout"))
                        Spacer()
                        Text("3.0 sec")
                            .font(.caption.monospaced())
                            .foregroundColor(.secondary)
                    }
                }
                
                // Section 4: Projects & Local Storage
                Section(header: Text(lang.localized("Хранилище и Проекты", "Storage & Workspaces"))) {
                    HStack {
                        Text(lang.localized("Проектов в IDE", "IDE Projects"))
                        Spacer()
                        Text("\(ideManager.projects.count)")
                            .font(.subheadline.bold())
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text(lang.localized("Всего файлов", "Total Files"))
                        Spacer()
                        Text("\(totalFileCount)")
                            .font(.subheadline.bold())
                            .foregroundColor(.secondary)
                    }
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        showClearCacheSuccess = true
                    }) {
                        HStack {
                            Text(lang.localized("Очистить кэш компилятора", "Clear Compiler Cache"))
                            Spacer()
                            if showClearCacheSuccess {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                            }
                        }
                    }
                    Button(action: {
                        showResetIDEAlert = true
                    }) {
                        Text(lang.localized("Восстановить стандартные проекты IDE", "Restore Default IDE Projects"))
                            .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                    }
                }
                
                // Section 5: Specification & Architecture
                Section(header: Text(lang.localized("О платформе SwiftLearn", "About Platform"))) {
                    HStack {
                        Text(lang.localized("Версия приложения", "Version"))
                        Spacer()
                        Text("2.0.0 Pro")
                            .font(.caption.monospaced())
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text(lang.localized("Целевая платформа", "Platform"))
                        Spacer()
                        Text("iOS 17.0+ (Universal)")
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text(lang.localized("Архитектура", "Architecture"))
                        Spacer()
                        Text("Cupertino Pro & Observation")
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text(lang.localized("Конфиденциальность", "Privacy & Storage"))
                        Spacer()
                        Text(lang.localized("100% Локальное On-Device", "100% Offline On-Device"))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                // Section 6: Danger Zone
                Section(header: Text(lang.localized("Опасная зона", "Danger Zone"))) {
                    Button(role: .destructive, action: {
                        showResetAlert = true
                    }) {
                        Label(lang.localized("Сбросить весь прогресс на ноль", "Reset All Progress to Zero"), systemImage: "arrow.counterclockwise")
                    }
                }
            }
            .navigationTitle(lang.localized("Настройки", "Settings"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(lang.localized("Готово", "Done")) {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingThemeSettings) {
                IDEThemeSettingsView()
            }
            .alert(
                lang.localized("Сбросить прогресс на ноль?", "Reset Progress to Zero?"),
                isPresented: $showResetAlert
            ) {
                Button(lang.localized("Отмена", "Cancel"), role: .cancel) {}
                Button(lang.localized("Сбросить на 0", "Reset to 0"), role: .destructive) {
                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                    storage.resetAllProgressToZero()
                    dismiss()
                }
            } message: {
                Text(lang.localized("Все пройденные уроки, решенные задачи (0/72) и очки опыта (0 XP) будут сброшены до абсолютного нуля.", "All completed lessons, solved tasks (0/72) and XP points (0 XP) will be reset to absolute zero."))
            }
            .alert(
                lang.localized("Восстановить проекты?", "Restore Projects?"),
                isPresented: $showResetIDEAlert
            ) {
                Button(lang.localized("Отмена", "Cancel"), role: .cancel) {}
                Button(lang.localized("Восстановить", "Restore"), role: .destructive) {
                    ideManager.projects = IDEProject.defaultTemplates
                    ideManager.activeProjectId = IDEProject.defaultTemplates.first?.id ?? UUID()
                }
            } message: {
                Text(lang.localized("Проекты IDE будут возвращены к исходным шаблонам.", "IDE projects will be reset to default templates."))
            }
        }
    }
}
