import SwiftUI

public struct IDEThemeSettingsView: View {
    @ObservedObject var ideManager = IDEProjectManager.shared
    @ObservedObject var lang = LanguageManager.shared
    @Environment(\.dismiss) private var dismiss
    
    private let samplePreviewCode = """
// Демонстрация синтаксиса и темы
import SwiftUI

struct UserProfile: Identifiable {
    let id: UUID = UUID()
    var username: String = "swift_developer"
    var score: Int = 42
    
    func displaySummary() {
        print("Инженер: \\(username), баллы: \\(score)")
    }
}
"""
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            Form {
                // Section 1: Live Interactive Preview
                Section(header: Text(lang.localized("Живой предпросмотр темы", "Live Theme Preview"))) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(SwiftSyntaxHighlighter.highlight(code: samplePreviewCode, theme: ideManager.theme))
                            .font(.system(size: CGFloat(ideManager.theme.fontSize), weight: .regular, design: .monospaced))
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .background(ideManager.theme.backgroundColor.color)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.vertical, 4)
                }
                
                // Section 2: Preset Themes
                Section(header: Text(lang.localized("Готовые палитры (Пресеты)", "Theme Presets"))) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(IDEThemePreset.allCases) { preset in
                                presetCard(preset)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                }
                
                // Section 3: Fine-grained Color Customization ("Цвета у всего")
                Section(
                    header: Text(lang.localized("Индивидуальная настройка цветов", "Fine-Grained Color Customization")),
                    footer: Text(lang.localized("Вы можете изменить оттенок любого элемента кода. Изменения сохраняются автоматически.", "Customize any syntax token color. Changes are saved automatically."))
                ) {
                    colorPickerRow(
                        title: lang.localized("Фон редактора", "Editor Background"),
                        binding: bindingFor(\.backgroundColor)
                    )
                    colorPickerRow(
                        title: lang.localized("Полоса номеров строк", "Line Gutter Background"),
                        binding: bindingFor(\.gutterColor)
                    )
                    colorPickerRow(
                        title: lang.localized("Номера строк", "Line Numbers"),
                        binding: bindingFor(\.lineNumberColor)
                    )
                    colorPickerRow(
                        title: lang.localized("Основной текст", "Base Plain Text"),
                        binding: bindingFor(\.textColor)
                    )
                    colorPickerRow(
                        title: lang.localized("Ключевые слова (func, struct, let)", "Keywords (func, struct, let)"),
                        binding: bindingFor(\.keywordColor)
                    )
                    colorPickerRow(
                        title: lang.localized("Типы и структуры (Int, String, View)", "Types & Structs (Int, String, View)"),
                        binding: bindingFor(\.typeColor)
                    )
                    colorPickerRow(
                        title: lang.localized("Строковые литералы (\"...\")", "String Literals (\"...\")"),
                        binding: bindingFor(\.stringColor)
                    )
                    colorPickerRow(
                        title: lang.localized("Числовые константы (0-9)", "Numeric Literals (0-9)"),
                        binding: bindingFor(\.numberColor)
                    )
                    colorPickerRow(
                        title: lang.localized("Комментарии (// ...)", "Comments (// ...)"),
                        binding: bindingFor(\.commentColor)
                    )
                    colorPickerRow(
                        title: lang.localized("Вызовы функций (call())", "Function Calls (call())"),
                        binding: bindingFor(\.callColor)
                    )
                }
                
                // Section 4: Editor Typography & Layout
                Section(header: Text(lang.localized("Шрифт и верстка редактора", "Typography & Layout"))) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(lang.localized("Размер шрифта", "Font Size"))
                            Spacer()
                            Text("\(Int(ideManager.theme.fontSize)) pt")
                                .foregroundColor(.secondary)
                                .font(.monospaced(.body)())
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
                }
            }
            .navigationTitle(lang.localized("Темы и цвета IDE", "IDE Themes & Colors"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(lang.localized("Готово", "Done")) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Views
    private func presetCard(_ preset: IDEThemePreset) -> some View {
        let isSelected = ideManager.theme.preset == preset
        let tempTheme = IDETheme.forPreset(preset)
        
        return Button(action: {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            ideManager.theme = IDETheme.forPreset(preset)
        }) {
            VStack(alignment: .leading, spacing: 8) {
                // Color dots row
                HStack(spacing: 4) {
                    Circle().fill(tempTheme.backgroundColor.color).frame(width: 14, height: 14)
                    Circle().fill(tempTheme.keywordColor.color).frame(width: 14, height: 14)
                    Circle().fill(tempTheme.typeColor.color).frame(width: 14, height: 14)
                    Circle().fill(tempTheme.stringColor.color).frame(width: 14, height: 14)
                }
                
                Text(preset.rawValue)
                    .font(.caption.bold())
                    .foregroundColor(isSelected ? .white : .primary)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(isSelected ? Color(red: 0.14, green: 0.38, blue: 0.82) : Color(UIColor.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.blue : Color.secondary.opacity(0.2), lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
    }
    
    private func colorPickerRow(title: String, binding: Binding<Color>) -> some View {
        ColorPicker(selection: binding, supportsOpacity: false) {
            Text(title)
                .font(.subheadline)
        }
    }
    
    private func bindingFor(_ keyPath: WritableKeyPath<IDETheme, CodableColor>) -> Binding<Color> {
        Binding<Color>(
            get: {
                ideManager.theme[keyPath: keyPath].color
            },
            set: { newColor in
                ideManager.theme.preset = .custom
                ideManager.theme[keyPath: keyPath].color = newColor
            }
        )
    }
}
