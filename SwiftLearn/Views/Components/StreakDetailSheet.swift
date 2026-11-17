import SwiftUI

public struct StreakDetailSheet: View {
    @ObservedObject var storage = StorageService.shared
    @ObservedObject var lang = LanguageManager.shared
    @ObservedObject var nav = AppNavigationState.shared
    @Environment(\.dismiss) private var dismiss
    
    @State private var animateGlow: Bool = false
    
    public init() {}
    
    // Milestones list
    private let milestones: [(days: Int, titleRU: String, titleEN: String, rewardXP: Int)] = [
        (3, "Первая искра", "First Spark", 50),
        (7, "Неделя в потоке", "Week in Flow", 150),
        (14, "Стальной фокус", "Iron Focus", 300),
        (30, "Мастер дисциплины", "Discipline Master", 1000),
        (100, "Легендарный архитектор", "Legendary Architect", 5000)
    ]
    
    // 7-day calendar data for current week
    private var weekDays: [(date: Date, dayLabel: String, dateString: String, isToday: Bool, isPast: Bool, isFuture: Bool, hasActivity: Bool)] {
        let calendar = Calendar.current
        let today = Date()
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: today) else { return [] }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        var result: [(Date, String, String, Bool, Bool, Bool, Bool)] = []
        let dayNamesRU = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
        let dayNamesEN = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        
        for i in 0..<7 {
            if let dayDate = calendar.date(byAdding: .day, value: i, to: weekInterval.start) {
                let key = formatter.string(from: dayDate)
                let isToday = calendar.isDateInToday(dayDate)
                let isPast = dayDate < today && !isToday
                let isFuture = dayDate > today && !isToday
                let hasAct = storage.profile.activeDates.contains(key)
                let dayLabel = lang.currentLanguage == .russian ? dayNamesRU[i] : dayNamesEN[i]
                result.append((dayDate, dayLabel, key, isToday, isPast, isFuture, hasAct))
            }
        }
        return result
    }
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // 1. Hero Animated Flame
                    heroFlameSection
                    
                    // 2. 7-Day Week Calendar
                    weeklyStreakCalendar
                    
                    // 3. Streak Freeze Protection
                    streakFreezeCard
                    
                    // 4. Milestones
                    milestonesSection
                    
                    // 5. Overall Stats
                    statsOverview
                }
                .padding(.vertical, 16)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle(lang.localized("Ударный режим", "Daily Streak"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(lang.localized("Готово", "Done")) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                    animateGlow = true
                }
            }
        }
    }
    
    // MARK: - Hero Flame Section
    private var heroFlameSection: some View {
        VStack(spacing: 12) {
            ZStack {
                // Outer ambient glow
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.orange.opacity(animateGlow ? 0.35 : 0.20),
                                Color.red.opacity(animateGlow ? 0.15 : 0.05),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 20,
                            endRadius: 90
                        )
                    )
                    .frame(width: 170, height: 170)
                    .scaleEffect(animateGlow ? 1.08 : 0.94)
                
                // Flame Core
                Image(systemName: storage.profile.hasPracticedToday ? "flame.fill" : "flame")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            colors: storage.profile.hasPracticedToday
                                ? [Color(red: 1.0, green: 0.65, blue: 0.1), Color(red: 0.95, green: 0.25, blue: 0.1)]
                                : [Color.orange.opacity(0.8), Color.orange.opacity(0.5)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .shadow(color: Color.orange.opacity(0.5), radius: animateGlow ? 16 : 8)
            }
            .padding(.top, 8)
            
            VStack(spacing: 4) {
                Text("\(storage.profile.streakDays)")
                    .font(.system(size: 46, weight: .heavy, design: .rounded))
                    .foregroundColor(.primary)
                
                Text(lang.localized(streakTitleRU, streakTitleEN))
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            
            // Status Pill
            HStack(spacing: 6) {
                if storage.profile.hasPracticedToday {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                    Text(lang.localized("Огонёк горит! Вы практиковались сегодня", "Streak active! You practiced today"))
                        .font(.caption.bold())
                        .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                } else {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.orange)
                    Text(lang.localized("Решите задачу сегодня, чтобы огонёк не угас!", "Solve a challenge today to keep the flame alive!"))
                        .font(.caption.bold())
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                storage.profile.hasPracticedToday
                    ? Color(red: 0.16, green: 0.58, blue: 0.40).opacity(0.12)
                    : Color.orange.opacity(0.12)
            )
            .clipShape(Capsule())
            
            if !storage.profile.hasPracticedToday {
                Button(action: {
                    dismiss()
                    nav.navigateToChallenges()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "play.fill")
                            .font(.caption2)
                        Text(lang.localized("Решить задачу прямо сейчас", "Solve a Challenge Now"))
                            .font(.subheadline.bold())
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color(red: 0.14, green: 0.38, blue: 0.82))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
                .padding(.top, 4)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
    
    private var streakTitleRU: String {
        let n = storage.profile.streakDays
        let lastTwo = n % 100
        let lastOne = n % 10
        if lastTwo >= 11 && lastTwo <= 19 {
            return "дней ударного режима"
        }
        if lastOne == 1 { return "день ударного режима" }
        if lastOne >= 2 && lastOne <= 4 { return "дня ударного режима" }
        return "дней ударного режима"
    }
    
    private var streakTitleEN: String {
        storage.profile.streakDays == 1 ? "Day Streak" : "Days Streak"
    }
    
    // MARK: - 7-Day Calendar Section
    private var weeklyStreakCalendar: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(lang.localized("Недельная активность", "Weekly Activity"))
                .font(.subheadline.bold())
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            HStack(spacing: 8) {
                ForEach(weekDays, id: \.dateString) { day in
                    VStack(spacing: 6) {
                        Text(day.dayLabel)
                            .font(.system(size: 11, weight: day.isToday ? .bold : .medium))
                            .foregroundColor(day.isToday ? .primary : .secondary)
                        
                        ZStack {
                            Circle()
                                .fill(
                                    day.hasActivity
                                        ? Color.orange
                                        : (day.isToday ? Color.orange.opacity(0.15) : Color(UIColor.tertiarySystemFill))
                                )
                                .frame(width: 38, height: 38)
                                .overlay(
                                    Circle()
                                        .stroke(day.isToday ? Color.orange : Color.clear, lineWidth: 2)
                                )
                            
                            if day.hasActivity {
                                Image(systemName: "flame.fill")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                            } else if day.isToday {
                                Image(systemName: "flame")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.orange)
                            } else {
                                Text("\(Calendar.current.component(.day, from: day.date))")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.secondary.opacity(0.6))
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 8)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.horizontal)
        }
    }
    
    // MARK: - Streak Freeze Card
    private var streakFreezeCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.cyan.opacity(0.15))
                        .frame(width: 44, height: 44)
                    Image(systemName: "snowflake")
                        .font(.title3.bold())
                        .foregroundColor(Color.cyan)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(lang.localized("Заморозка серии", "Streak Freeze"))
                        .font(.subheadline.bold())
                    Text(lang.localized("Доступно: \(storage.profile.streakFreezeCount) из 3", "Available: \(storage.profile.streakFreezeCount) of 3"))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if storage.profile.streakFreezeCount < 3 {
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        _ = storage.buyStreakFreeze()
                    }) {
                        HStack(spacing: 4) {
                            Text("100 XP")
                                .font(.caption.bold())
                            Image(systemName: "plus")
                                .font(.caption2.bold())
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(storage.profile.xp >= 100 ? Color.cyan : Color.secondary.opacity(0.2))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                    }
                    .disabled(storage.profile.xp < 100)
                } else {
                    Text(lang.localized("Максимум", "Max"))
                        .font(.caption2.bold())
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(UIColor.tertiarySystemFill))
                        .clipShape(Capsule())
                }
            }
            
            Text(lang.localized(
                "Заморозка автоматически спасает ваш огонёк от сгорания, если вы пропустите один день занятий.",
                "Streak freeze automatically protects your flame from resetting if you miss a single day of practice."
            ))
            .font(.caption2)
            .foregroundColor(.secondary)
        }
        .padding(14)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal)
    }
    
    // MARK: - Milestones Section
    private var milestonesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(lang.localized("Награды за серии дней", "Streak Milestones"))
                .font(.subheadline.bold())
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            VStack(spacing: 8) {
                ForEach(milestones, id: \.days) { m in
                    let isReached = storage.profile.streakDays >= m.days
                    let isClaimed = storage.profile.claimedStreakMilestoneIDs.contains(m.days)
                    
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(isReached ? Color.orange.opacity(0.15) : Color(UIColor.tertiarySystemFill))
                                .frame(width: 36, height: 36)
                            Image(systemName: isReached ? "flame.fill" : "lock")
                                .font(.caption.bold())
                                .foregroundColor(isReached ? .orange : .secondary)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(lang.localized(m.titleRU, m.titleEN))
                                .font(.subheadline.bold())
                                .foregroundColor(isReached ? .primary : .secondary)
                            Text("\(m.days) " + lang.localized("дней подряд", "days streak"))
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        if isClaimed {
                            HStack(spacing: 4) {
                                Image(systemName: "checkmark")
                                    .font(.caption2.bold())
                                Text("+\(m.rewardXP) XP")
                                    .font(.caption.bold())
                            }
                            .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                        } else if isReached {
                            Button(action: {
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                storage.claimStreakMilestone(days: m.days, rewardXP: m.rewardXP)
                            }) {
                                Text(lang.localized("Забрать +\(m.rewardXP) XP", "Claim +\(m.rewardXP) XP"))
                                    .font(.caption.bold())
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                            }
                        } else {
                            Text("+\(m.rewardXP) XP")
                                .font(.caption.bold())
                                .foregroundColor(.secondary.opacity(0.6))
                        }
                    }
                    .padding(12)
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Overall Stats
    private var statsOverview: some View {
        HStack(spacing: 12) {
            statTile(
                title: lang.localized("Текущая серия", "Current Streak"),
                value: "\(storage.profile.streakDays) " + lang.localized("дн.", "days"),
                icon: "flame.fill",
                iconColor: .orange
            )
            statTile(
                title: lang.localized("Рекорд серии", "Longest Streak"),
                value: "\(storage.profile.longestStreakDays) " + lang.localized("дн.", "days"),
                icon: "trophy.fill",
                iconColor: Color(red: 0.85, green: 0.65, blue: 0.12)
            )
            statTile(
                title: lang.localized("Активных дней", "Total Active"),
                value: "\(storage.profile.activeDates.count) " + lang.localized("дн.", "days"),
                icon: "calendar",
                iconColor: Color(red: 0.14, green: 0.38, blue: 0.82)
            )
        }
        .padding(.horizontal)
    }
    
    private func statTile(title: String, value: String, icon: String, iconColor: Color) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.subheadline)
                .foregroundColor(iconColor)
            Text(value)
                .font(.subheadline.bold())
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
