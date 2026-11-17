import SwiftUI

public struct CurriculumView: View {
    @ObservedObject var lang = LanguageManager.shared
    @ObservedObject var storage = StorageService.shared
    @ObservedObject var nav = AppNavigationState.shared
    private let lessons = CurriculumStore.shared.lessons
    
    @State private var selectedTrack: CurriculumTrack = .swiftCore
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    // 1. Track Switcher (Swift Core vs SwiftUI Pro)
                    trackSelector
                    
                    // 2. Track Progress Banner
                    overallProgressCard
                    
                    // 3. Categories & Lessons Breakdown
                    let currentCategories = LessonCategory.allCases.filter { $0.track == selectedTrack }
                    ForEach(currentCategories) { category in
                        let catLessons = lessons.filter { $0.category == category }
                        if !catLessons.isEmpty {
                            categorySection(category: category, lessons: catLessons)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle(lang.localized("Курсы разработки", "Curriculum"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    XPBadgeView()
                }
            }
            .navigationDestination(item: $nav.presentedLesson) { lesson in
                LessonDetailView(lesson: lesson)
            }
        }
    }
    
    // MARK: - Track Selector
    private var trackSelector: some View {
        Picker("Трек обучения", selection: $selectedTrack) {
            ForEach(CurriculumTrack.allCases) { track in
                Text(track.title(for: lang.currentLanguage)).tag(track)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    // MARK: - Overall Progress Card
    private var overallProgressCard: some View {
        let trackLessons = lessons.filter { $0.category.track == selectedTrack }
        let total = max(1, trackLessons.count)
        let completed = trackLessons.filter { storage.profile.completedLessonIDs.contains($0.id) }.count
        let progress = min(1.0, max(0.0, Double(completed) / Double(total)))
        let percentage = Int(progress * 100)
        
        let isSwiftUI = selectedTrack == .swiftUI
        let gradientColors = isSwiftUI
            ? [Color(red: 0.35, green: 0.25, blue: 0.85), Color(red: 0.58, green: 0.28, blue: 0.95)]
            : [Color(red: 0.14, green: 0.38, blue: 0.82), Color(red: 0.25, green: 0.55, blue: 0.95)]
        
        let cardTitle = isSwiftUI
            ? lang.localized("Прогресс освоения SwiftUI", "SwiftUI Framework Mastery")
            : lang.localized("Прогресс освоения Swift Core", "Swift Core Language Mastery")
        
        let cardSubtitle = isSwiftUI
            ? lang.localized("Анатомия View, стеки и layout, @Observable, адаптивные сетки, анимации и навигация.", "View anatomy, stacks, layout rules, @Observable, grids, physics animations, and navigation.")
            : lang.localized("Полная спецификация Swift 6: типы, опционалы, замыкания, ООП/ARC, протоколы, дженерики и акторы.", "Full Swift 6 specification: types, optionals, closures, ARC, generics, typed throws, and actors.")
        
        return VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(cardTitle)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(cardSubtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Text("\(percentage)%")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(gradientColors[0])
            }
            
            // Linear Progress Bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color(UIColor.tertiarySystemFill))
                        .frame(height: 10)
                    
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: gradientColors,
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: max(10, geo.size.width * CGFloat(progress)), height: 10)
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: progress)
                }
            }
            .frame(height: 10)
            
            // Progress Stats Row
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                        .font(.caption)
                    Text("\(completed) \(lang.localized("из", "of")) \(total) \(lang.localized("уроков пройдено", "lessons completed"))")
                        .font(.caption.bold())
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(tierTitle(percentage: percentage, isSwiftUI: isSwiftUI))
                    .font(.caption2.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(gradientColors[0].opacity(0.12))
                    .foregroundColor(gradientColors[0])
                    .clipShape(Capsule())
            }
        }
        .padding(16)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.secondary.opacity(0.15), lineWidth: 1)
        )
        .padding(.horizontal)
    }
    
    // MARK: - Category Section
    private func categorySection(category: LessonCategory, lessons: [Lesson]) -> some View {
        let catCompleted = lessons.filter { storage.profile.completedLessonIDs.contains($0.id) }.count
        let catTotal = lessons.count
        let catProgress = catTotal > 0 ? Double(catCompleted) / Double(catTotal) : 0.0
        let isFullyCompleted = catCompleted == catTotal && catTotal > 0
        let isSwiftUI = category.track == .swiftUI
        let themeColor = isSwiftUI ? Color(red: 0.35, green: 0.25, blue: 0.85) : Color(red: 0.14, green: 0.38, blue: 0.82)
        
        return VStack(alignment: .leading, spacing: 8) {
            // Category Header with mini-progress bar
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Image(systemName: category.icon)
                        .foregroundColor(themeColor)
                        .font(.subheadline)
                    
                    Text(category.title(for: lang.currentLanguage))
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    if isFullyCompleted {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                            Text(lang.localized("Освоено", "Mastered"))
                                .font(.caption2.bold())
                                .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                        }
                    } else {
                        Text("\(catCompleted)/\(catTotal)")
                            .font(.caption.bold())
                            .foregroundColor(.secondary)
                    }
                }
                
                // Mini Category Progress Bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.gray.opacity(0.15))
                            .frame(height: 4)
                        
                        Capsule()
                            .fill(isFullyCompleted ? Color(red: 0.16, green: 0.58, blue: 0.40) : themeColor)
                            .frame(width: max(4, geo.size.width * CGFloat(catProgress)), height: 4)
                    }
                }
                .frame(height: 4)
            }
            .padding(.horizontal)
            .padding(.top, 6)
            
            // Lessons in Category
            VStack(spacing: 8) {
                ForEach(lessons) { lesson in
                    lessonRow(lesson, themeColor: themeColor)
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Lesson Row
    private func lessonRow(_ lesson: Lesson, themeColor: Color) -> some View {
        let isDone = storage.profile.completedLessonIDs.contains(lesson.id)
        
        return NavigationLink(destination: LessonDetailView(lesson: lesson)) {
            HStack(spacing: 12) {
                Image(systemName: isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isDone ? Color(red: 0.16, green: 0.58, blue: 0.40) : .secondary.opacity(0.6))
                    .font(.title3)
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(lang.localized(lesson.titleRU, lesson.titleEN))
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Text(lang.localized(lesson.summaryRU, lesson.summaryEN))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                Spacer()
                
                Text("+\(lesson.xpReward) XP")
                    .font(.caption2.bold())
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color(UIColor.secondarySystemFill))
                    .clipShape(Capsule())
                
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding(12)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isDone ? Color(red: 0.16, green: 0.58, blue: 0.40).opacity(0.3) : Color.clear, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
    
    private func tierTitle(percentage: Int, isSwiftUI: Bool) -> String {
        if isSwiftUI {
            switch percentage {
            case 0...25:
                return lang.localized("UI Novice", "UI Novice")
            case 26...60:
                return lang.localized("Layout Developer", "Layout Developer")
            case 61...90:
                return lang.localized("SwiftUI Specialist", "SwiftUI Specialist")
            default:
                return lang.localized("Lead SwiftUI Architect", "Lead SwiftUI Architect")
            }
        } else {
            switch percentage {
            case 0...25:
                return lang.localized("Junior Foundation", "Junior Foundation")
            case 26...60:
                return lang.localized("Middle Architecture", "Middle Architecture")
            case 61...90:
                return lang.localized("Senior Specialist", "Senior Specialist")
            default:
                return lang.localized("Lead Swift Architect", "Lead Swift Architect")
            }
        }
    }
}
