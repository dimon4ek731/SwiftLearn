import SwiftUI

public struct ChallengesView: View {
    @ObservedObject var lang = LanguageManager.shared
    @ObservedObject var storage = StorageService.shared
    private let tasks = TaskStore.shared.tasks
    
    @State private var selectedDifficulty: TaskDifficulty? = nil // nil = Все
    @State private var selectedPlatform: String? = nil // "LeetCode", "Codeforces", nil
    @State private var searchText: String = ""
    
    public init() {}
    
    private var filteredTasks: [CodingTask] {
        tasks.filter { task in
            let matchesDifficulty = selectedDifficulty == nil || task.difficulty == selectedDifficulty
            let matchesPlatform = selectedPlatform == nil ||
                task.titleRU.contains(selectedPlatform!) ||
                task.titleEN.contains(selectedPlatform!)
            let matchesSearch = searchText.isEmpty ||
                task.titleRU.localizedCaseInsensitiveContains(searchText) ||
                task.titleEN.localizedCaseInsensitiveContains(searchText) ||
                task.summaryRU.localizedCaseInsensitiveContains(searchText) ||
                task.summaryEN.localizedCaseInsensitiveContains(searchText)
            return matchesDifficulty && matchesPlatform && matchesSearch
        }
    }
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    // 1. Practice Overall Progress Card
                    progressCard
                    
                    // 2. Search & Difficulty Filter
                    filterControls
                    
                    // 3. Task List
                    tasksListSection
                }
                .padding(.vertical)
            }
            .navigationTitle(lang.localized("Практикум Задач", "Code Challenges"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    XPBadgeView()
                }
            }
            .onAppear {
                if let idx = ProcessInfo.processInfo.arguments.firstIndex(of: "-openPlatform"),
                   idx + 1 < ProcessInfo.processInfo.arguments.count {
                    selectedPlatform = ProcessInfo.processInfo.arguments[idx + 1]
                }
            }
        }
    }
    
    // MARK: - Progress Card
    private var progressCard: some View {
        let total = max(1, tasks.count)
        let solved = tasks.filter { storage.profile.solvedChallengeIDs.contains($0.id) }.count
        let progress = min(1.0, max(0.0, Double(solved) / Double(total)))
        let percentage = Int(progress * 100)
        
        return VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(lang.localized("Прогресс решения задач", "Problem Solving Progress"))
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(lang.localized("От базового синтаксиса до архитектуры, многопоточности и алгоритмов.", "From fundamental syntax to algorithms, concurrency, and architecture."))
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Text("\(percentage)%")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
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
                                colors: [Color(red: 0.16, green: 0.58, blue: 0.40), Color(red: 0.25, green: 0.75, blue: 0.50)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: max(10, geo.size.width * CGFloat(progress)), height: 10)
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: progress)
                }
            }
            .frame(height: 10)
            
            // Stats Row
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                        .font(.caption)
                    Text("\(solved) \(lang.localized("из", "of")) \(total) \(lang.localized("задач решено", "tasks solved"))")
                        .font(.caption.bold())
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(tierTitle(solved: solved, total: total))
                    .font(.caption2.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color(red: 0.16, green: 0.58, blue: 0.40).opacity(0.12))
                    .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
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
    
    // MARK: - Filter Controls
    private var filterControls: some View {
        VStack(spacing: 10) {
            // Search Input
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .font(.caption)
                TextField(lang.localized("Поиск по названию или теме...", "Search challenges..."), text: $searchText)
                    .font(.subheadline)
                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            // Difficulty & Platform Pills
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    filterPill(
                        title: lang.localized("Все", "All"),
                        isSelected: selectedDifficulty == nil && selectedPlatform == nil
                    ) {
                        selectedDifficulty = nil
                        selectedPlatform = nil
                    }
                    
                    filterPill(
                        title: "LeetCode",
                        isSelected: selectedPlatform == "LeetCode",
                        customAccent: Color(red: 0.95, green: 0.55, blue: 0.15)
                    ) {
                        selectedPlatform = selectedPlatform == "LeetCode" ? nil : "LeetCode"
                    }
                    
                    filterPill(
                        title: "Codeforces",
                        isSelected: selectedPlatform == "Codeforces",
                        customAccent: Color(red: 0.18, green: 0.52, blue: 0.95)
                    ) {
                        selectedPlatform = selectedPlatform == "Codeforces" ? nil : "Codeforces"
                    }
                    
                    Divider().frame(height: 16)
                    
                    ForEach(TaskDifficulty.allCases) { diff in
                        filterPill(
                            title: diff.title(for: lang.currentLanguage),
                            isSelected: selectedDifficulty == diff
                        ) {
                            selectedDifficulty = selectedDifficulty == diff ? nil : diff
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func filterPill(title: String, isSelected: Bool, customAccent: Color? = nil, action: @escaping () -> Void) -> some View {
        let accent = customAccent ?? Color(red: 0.14, green: 0.38, blue: 0.82)
        return Button(action: {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            action()
        }) {
            Text(title)
                .font(.caption.bold())
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? accent : Color(UIColor.secondarySystemBackground))
                .foregroundColor(isSelected ? .white : .primary)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Tasks List
    private var tasksListSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("\(lang.localized("Задачи", "Challenges")) (\(filteredTasks.count))")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            
            if filteredTasks.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "tray")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text(lang.localized("Ничего не найдено", "No challenges match filter"))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
            } else {
                VStack(spacing: 8) {
                    ForEach(filteredTasks) { task in
                        taskRow(task)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private func taskRow(_ task: CodingTask) -> some View {
        let isSolved = storage.profile.solvedChallengeIDs.contains(task.id)
        
        return NavigationLink(destination: TaskDetailView(task: task)) {
            HStack(spacing: 12) {
                // Solved indicator
                Image(systemName: isSolved ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSolved ? Color(red: 0.16, green: 0.58, blue: 0.40) : .secondary.opacity(0.4))
                    .font(.title3)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Text(lang.localized(task.titleRU, task.titleEN))
                            .font(.subheadline.bold())
                            .foregroundColor(.primary)
                            .lineLimit(1)
                    }
                    
                    Text(lang.localized(task.summaryRU, task.summaryEN))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    // Metadata tags
                    HStack(spacing: 6) {
                        if task.titleRU.contains("[LeetCode") {
                            Text("LeetCode")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundColor(Color(red: 0.95, green: 0.55, blue: 0.15))
                                .padding(.horizontal, 5)
                                .padding(.vertical, 2)
                                .background(Color(red: 0.95, green: 0.55, blue: 0.15).opacity(0.14))
                                .clipShape(Capsule())
                        } else if task.titleRU.contains("[Codeforces") {
                            Text("Codeforces")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundColor(Color(red: 0.18, green: 0.52, blue: 0.95))
                                .padding(.horizontal, 5)
                                .padding(.vertical, 2)
                                .background(Color(red: 0.18, green: 0.52, blue: 0.95).opacity(0.14))
                                .clipShape(Capsule())
                        }
                        
                        difficultyChip(task.difficulty)
                        
                        HStack(spacing: 3) {
                            Image(systemName: task.category.icon)
                            Text(task.category.title(for: lang.currentLanguage))
                        }
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundColor(.secondary)
                    }
                    .padding(.top, 2)
                }
                
                Spacer()
                
                Text("+\(task.xpReward) XP")
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
                    .stroke(isSolved ? Color(red: 0.16, green: 0.58, blue: 0.40).opacity(0.3) : Color.clear, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
    
    private func difficultyChip(_ diff: TaskDifficulty) -> some View {
        let (bg, fg): (Color, Color) = {
            switch diff {
            case .easy:
                return (Color(red: 0.16, green: 0.58, blue: 0.40).opacity(0.15), Color(red: 0.16, green: 0.58, blue: 0.40))
            case .medium:
                return (Color(red: 0.14, green: 0.38, blue: 0.82).opacity(0.15), Color(red: 0.14, green: 0.38, blue: 0.82))
            case .hard:
                return (Color.orange.opacity(0.15), Color.orange)
            case .expert:
                return (Color.purple.opacity(0.15), Color.purple)
            }
        }()
        
        return Text(diff.title(for: lang.currentLanguage))
            .font(.system(size: 9, weight: .bold))
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(bg)
            .foregroundColor(fg)
            .clipShape(Capsule())
    }
    
    private func tierTitle(solved: Int, total: Int) -> String {
        let ratio = Double(solved) / Double(max(1, total))
        switch ratio {
        case 0..<0.25:
            return lang.localized("Junior Trainee", "Junior Trainee")
        case 0.25..<0.5:
            return lang.localized("Problem Solver", "Problem Solver")
        case 0.5..<0.8:
            return lang.localized("Algorithm Master", "Algorithm Master")
        default:
            return lang.localized("Swift Grandmaster", "Swift Grandmaster")
        }
    }
}
