import SwiftUI

public struct ProfileView: View {
    @ObservedObject var lang = LanguageManager.shared
    @ObservedObject var storage = StorageService.shared
    @ObservedObject var ideManager = IDEProjectManager.shared
    
    @State private var showingSettings: Bool = false
    @State private var showingThemeSettings: Bool = false
    @State private var showingStreakSheet: Bool = false
    @State private var showingResetAlert: Bool = false
    @State private var showingInterviewPrep: Bool = false
    
    public init() {}
    
    private var nextLevelXP: Int {
        storage.profile.level * 100
    }
    
    private var currentLevelXPProgress: Double {
        let currentLevelBase = (storage.profile.level - 1) * 100
        let inLevel = storage.profile.xp - currentLevelBase
        return min(1.0, max(0.0, Double(inLevel) / 100.0))
    }
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Header Card
                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.14, green: 0.17, blue: 0.22))
                                .frame(width: 72, height: 72)
                            Image(systemName: "swift")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(Color(red: 0.85, green: 0.88, blue: 0.95))
                        }
                        
                        VStack(spacing: 4) {
                            Text(lang.localized(storage.profile.levelTitle.ru, storage.profile.levelTitle.en))
                                .font(.title3.bold())
                            Text(lang.localized("Квалификация: Уровень \(storage.profile.level)", "Qualification: Level \(storage.profile.level)"))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        // XP Progress Bar
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("\(storage.profile.xp) XP")
                                    .font(.caption.bold())
                                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                                Spacer()
                                Text("\(nextLevelXP) XP")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            ProgressView(value: currentLevelXPProgress)
                                .tint(Color(red: 0.14, green: 0.38, blue: 0.82))
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 4)
                    }
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.horizontal)
                    
                    // Stats Grid
                    HStack(spacing: 12) {
                        Button(action: {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            showingStreakSheet = true
                        }) {
                            statCard(
                                icon: "flame.fill",
                                title: lang.localized("Дней серии", "Streak Days"),
                                value: "\(storage.profile.streakDays)",
                                iconColor: .orange
                            )
                        }
                        .buttonStyle(.plain)
                        
                        statCard(
                            icon: "checkmark.shield",
                            title: lang.localized("Модулей сдано", "Modules Done"),
                            value: "\(storage.profile.completedLessonIDs.count)"
                        )
                        statCard(
                            icon: "chart.bar",
                            title: lang.localized("Опыт (XP)", "Total XP"),
                            value: "\(storage.profile.xp)"
                        )
                    }
                    .padding(.horizontal)
                    
                    // Career & Interview Prep Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text(lang.localized("Карьера и собеседования", "Career & Interview Preparation"))
                            .font(.headline)
                            .padding(.horizontal)
                        
                        Button(action: { showingInterviewPrep = true }) {
                            HStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(Color(red: 0.14, green: 0.38, blue: 0.82).opacity(0.12))
                                        .frame(width: 38, height: 38)
                                    Image(systemName: "graduationcap.fill")
                                        .font(.caption.bold())
                                        .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                                }
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(lang.localized("Собеседование, Big-O и Языковая матрица", "Interview Prep, Big-O & Rosetta Stone"))
                                        .font(.subheadline.bold())
                                        .foregroundColor(.primary)
                                    Text(lang.localized("Сложность алгоритмов, кросс-языковые шаблоны, топ вопросы", "Complexity cheat sheet, cross-language patterns, top Q&A"))
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundColor(.secondary.opacity(0.6))
                            }
                            .padding(12)
                            .background(Color(UIColor.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal)
                        }
                        .buttonStyle(.plain)
                    }

                    // Settings & IDE Environment Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text(lang.localized("Среда разработки и Настройки", "Development Environment & Settings"))
                            .font(.headline)
                            .padding(.horizontal)
                        
                        VStack(spacing: 8) {
                            Button(action: { showingThemeSettings = true }) {
                                HStack(spacing: 12) {
                                    ZStack {
                                        Circle()
                                            .fill(Color(red: 0.14, green: 0.38, blue: 0.82).opacity(0.12))
                                            .frame(width: 38, height: 38)
                                        Image(systemName: "paintpalette.fill")
                                            .font(.caption.bold())
                                            .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(lang.localized("Темы и цвета IDE", "IDE Themes & Colors"))
                                            .font(.subheadline.bold())
                                            .foregroundColor(.primary)
                                        Text(lang.localized("Палитра: \(ideManager.theme.preset.rawValue), \(Int(ideManager.theme.fontSize)) pt", "Theme: \(ideManager.theme.preset.rawValue), \(Int(ideManager.theme.fontSize)) pt"))
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.secondary.opacity(0.6))
                                }
                                .padding(12)
                                .background(Color(UIColor.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            .buttonStyle(.plain)
                            
                            Button(action: { showingSettings = true }) {
                                HStack(spacing: 12) {
                                    ZStack {
                                        Circle()
                                            .fill(Color(red: 0.16, green: 0.58, blue: 0.40).opacity(0.12))
                                            .frame(width: 38, height: 38)
                                        Image(systemName: "gearshape.fill")
                                            .font(.caption.bold())
                                            .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(lang.localized("Полное меню настроек", "Full Settings Menu"))
                                            .font(.subheadline.bold())
                                            .foregroundColor(.primary)
                                        Text(lang.localized("Редактор, компилятор, язык, сброс данных", "Editor, compiler, language, data reset"))
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.secondary.opacity(0.6))
                                }
                                .padding(12)
                                .background(Color(UIColor.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            .buttonStyle(.plain)
                            
                            // Reset Progress to Zero Button
                            Button(action: {
                                showingResetAlert = true
                            }) {
                                HStack(spacing: 12) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.red.opacity(0.12))
                                            .frame(width: 38, height: 38)
                                        Image(systemName: "arrow.counterclockwise")
                                            .font(.caption.bold())
                                            .foregroundColor(.red)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(lang.localized("Сбросить прогресс на ноль", "Reset Progress to Zero"))
                                            .font(.subheadline.bold())
                                            .foregroundColor(.red)
                                        Text(lang.localized("Обнуление XP, пройденных уроков и задач", "Reset XP, completed lessons, and challenges to 0"))
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.secondary.opacity(0.6))
                                }
                                .padding(12)
                                .background(Color(UIColor.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle(lang.localized("Профиль", "Profile"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showingSettings = true }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.primary)
                    }
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
            .sheet(isPresented: $showingThemeSettings) {
                IDEThemeSettingsView()
            }
            .sheet(isPresented: $showingStreakSheet) {
                StreakDetailSheet()
            }
            .sheet(isPresented: $showingInterviewPrep) {
                NavigationStack {
                    InterviewPrepView()
                        .navigationTitle(lang.localized("Подготовка к собеседованию", "Interview Preparation"))
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button(lang.localized("Готово", "Done")) {
                                    showingInterviewPrep = false
                                }
                            }
                        }
                }
            }
            .alert(
                lang.localized("Сбросить прогресс на ноль?", "Reset Progress to Zero?"),
                isPresented: $showingResetAlert
            ) {
                Button(lang.localized("Отмена", "Cancel"), role: .cancel) {}
                Button(lang.localized("Сбросить на 0", "Reset to 0"), role: .destructive) {
                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                    storage.resetAllProgressToZero()
                }
            } message: {
                Text(lang.localized(
                    "Все набранные очки опыта (XP), решенные задачи (0/\(TaskStore.shared.tasks.count)), пройденные уроки и серия дней будут сброшены до абсолютного нуля.",
                    "All XP points, solved challenges (0/\(TaskStore.shared.tasks.count)), completed lessons, and streak days will be reset to absolute zero."
                ))
            }
        }
    }
    
    private func statCard(icon: String, title: String, value: String, iconColor: Color = Color(red: 0.14, green: 0.38, blue: 0.82)) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.subheadline)
                .foregroundColor(iconColor)
            Text(value)
                .font(.headline.bold())
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
