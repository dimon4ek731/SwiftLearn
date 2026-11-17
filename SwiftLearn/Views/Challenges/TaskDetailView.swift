import SwiftUI

public struct TaskDetailView: View {
    public let task: CodingTask
    @ObservedObject var lang = LanguageManager.shared
    @ObservedObject var storage = StorageService.shared
    @Environment(\.dismiss) private var dismiss
    
    @State private var code: String
    @State private var isRunningTests: Bool = false
    @State private var testResults: [TestExecutionResult] = []
    @State private var allPassed: Bool = false
    @State private var selectedTab: Int = 0 // 0: Условие, 1: Тесты, 2: Подсказки, 3: Решение
    @State private var showingSolutionAlert: Bool = false
    @State private var isSolutionRevealed: Bool = false
    
    public struct TestExecutionResult: Identifiable {
        public let id = UUID()
        public let testCase: TaskTestCase
        public let passed: Bool
        public let message: String
    }
    
    public init(task: CodingTask) {
        self.task = task
        _code = State(initialValue: task.starterCode)
    }
    
    private var isSolved: Bool {
        storage.profile.solvedChallengeIDs.contains(task.id)
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Top Section Switcher
            Picker("Раздел", selection: $selectedTab) {
                Text(lang.localized("Условие", "Problem")).tag(0)
                Text(lang.localized("Тесты", "Tests")).tag(1)
                Text(lang.localized("Подсказки", "Hints")).tag(2)
                Text(lang.localized("Решение", "Solution")).tag(3)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(UIColor.secondarySystemBackground))
            
            Divider()
            
            // Content according to selected tab
            switch selectedTab {
            case 0:
                problemDescriptionContent
            case 1:
                testCasesContent
            case 2:
                hintsContent
            case 3:
                solutionContent
            default:
                EmptyView()
            }
            
            Divider()
            
            // Interactive Code Editor Area
            VStack(spacing: 0) {
                // Editor header bar
                HStack {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left.forwardslash.chevron.right")
                            .font(.caption2.bold())
                            .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                        Text(lang.localized("Решение (Swift 6)", "Solution (Swift 6)"))
                            .font(.caption.bold())
                    }
                    
                    Spacer()
                    
                    Button(action: resetToStarter) {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.counterclockwise")
                            Text(lang.localized("Сброс", "Reset"))
                        }
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 6)
                .background(Color(UIColor.secondarySystemBackground))
                
                SyntaxCodeEditor(
                    text: $code,
                    theme: IDEProjectManager.shared.theme,
                    onTextChange: nil,
                    onSuggestionChange: nil
                )
                .frame(maxHeight: .infinity)
                .clipped()
            }
            
            Divider()
            
            // Bottom Action Bar
            bottomActionBar
        }
        .navigationTitle(lang.localized(task.titleRU, task.titleEN))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if isSolved {
                    Label(lang.localized("Решено", "Solved"), systemImage: "checkmark.circle.fill")
                        .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                        .font(.caption.bold())
                } else {
                    Text("+\(task.xpReward) XP")
                        .font(.caption.bold())
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color(red: 0.14, green: 0.38, blue: 0.82).opacity(0.12))
                        .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                        .clipShape(Capsule())
                }
            }
        }
        .onAppear {
            if isSolved {
                isSolutionRevealed = true
            }
        }
    }
    
    // MARK: - Problem Description Content
    private var problemDescriptionContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                // Badges row
                HStack(spacing: 8) {
                    difficultyBadge(task.difficulty)
                    
                    HStack(spacing: 4) {
                        Image(systemName: task.category.icon)
                        Text(task.category.title(for: lang.currentLanguage))
                    }
                    .font(.caption2.bold())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.secondary.opacity(0.12))
                    .clipShape(Capsule())
                    
                    Spacer()
                }
                
                Text(lang.localized(task.descriptionRU, task.descriptionEN))
                    .font(.body)
                    .lineSpacing(4)
                
                if !task.requirementsRU.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(lang.localized("Требования к решению:", "Requirements:"))
                            .font(.subheadline.bold())
                        
                        let reqs = lang.currentLanguage == .russian ? task.requirementsRU : task.requirementsEN
                        ForEach(reqs, id: \.self) { req in
                            HStack(alignment: .top, spacing: 6) {
                                Text("•").bold().foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                                Text(req)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(10)
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding()
        }
        .frame(maxHeight: 180)
    }
    
    // MARK: - Test Cases Content
    private var testCasesContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                if testResults.isEmpty {
                    Text(lang.localized("Нажмите 'Проверить решение' для запуска тестов.", "Press 'Run Tests' below to execute validation test cases."))
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ForEach(testResults) { res in
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: res.passed ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(res.passed ? Color(red: 0.16, green: 0.58, blue: 0.40) : Color(red: 0.75, green: 0.22, blue: 0.22))
                                .font(.subheadline)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(res.testCase.title)
                                    .font(.subheadline.bold())
                                    .foregroundColor(.primary)
                                
                                Text(res.message)
                                    .font(.system(size: 11, design: .monospaced))
                                    .foregroundColor(res.passed ? .secondary : Color(red: 0.75, green: 0.22, blue: 0.22))
                            }
                            
                            Spacer()
                        }
                        .padding(10)
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding()
        }
        .frame(maxHeight: 180)
    }
    
    // MARK: - Hints Content
    private var hintsContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                let hints = lang.currentLanguage == .russian ? task.hintsRU : task.hintsEN
                if hints.isEmpty {
                    Text(lang.localized("Для этой задачи подсказки не требуются.", "No hints available for this challenge."))
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ForEach(Array(hints.enumerated()), id: \.offset) { index, hint in
                        HStack(alignment: .top, spacing: 8) {
                            Text("\(index + 1).")
                                .font(.caption.bold())
                                .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                            Text(hint)
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding()
        }
        .frame(maxHeight: 180)
    }
    
    // MARK: - Solution Content
    private var solutionContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if isSolutionRevealed {
                    Text(lang.localized("Эталонная реализация:", "Reference Implementation:"))
                        .font(.caption.bold())
                        .foregroundColor(.secondary)
                    
                    CodeBlockView(code: task.solutionCode)
                } else {
                    VStack(spacing: 12) {
                        Image(systemName: "lock.fill")
                            .font(.largeTitle)
                            .foregroundColor(.secondary)
                        
                        Text(lang.localized("Решение скрыто, чтобы вы могли решить задачу самостоятельно.", "Solution is locked so you can attempt solving first."))
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        Button(action: { showingSolutionAlert = true }) {
                            Text(lang.localized("Показать решение", "Reveal Solution"))
                                .font(.caption.bold())
                                .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                                .padding(.horizontal, 14)
                                .padding(.vertical, 6)
                                .background(Color(red: 0.14, green: 0.38, blue: 0.82).opacity(0.12))
                                .clipShape(Capsule())
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                }
            }
            .padding()
        }
        .frame(maxHeight: 180)
        .alert(lang.localized("Открыть решение?", "Reveal Solution?"), isPresented: $showingSolutionAlert) {
            Button(lang.localized("Отмена", "Cancel"), role: .cancel) {}
            Button(lang.localized("Открыть", "Reveal")) {
                isSolutionRevealed = true
            }
        } message: {
            Text(lang.localized("Рекомендуется попытаться решить задачу самостоятельно для максимального усвоения.", "Attempting to solve the task on your own yields the best learning result."))
        }
    }
    
    // MARK: - Bottom Action Bar
    private var bottomActionBar: some View {
        HStack(spacing: 12) {
            Button(action: runTestCases) {
                HStack(spacing: 8) {
                    if isRunningTests {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(0.8)
                    } else {
                        Image(systemName: allPassed ? "checkmark" : "play.fill")
                    }
                    Text(actionButtonTitle)
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(actionButtonColor)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .disabled(isRunningTests)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(UIColor.secondarySystemBackground))
    }
    
    private var actionButtonTitle: String {
        if isRunningTests {
            return lang.localized("Тестирование...", "Running Tests...")
        }
        if allPassed {
            return lang.localized("Все тесты пройдены!", "All Tests Passed!")
        }
        return lang.localized("Проверить решение", "Run Tests")
    }
    
    private var actionButtonColor: Color {
        if allPassed {
            return Color(red: 0.16, green: 0.58, blue: 0.40)
        }
        return Color(red: 0.14, green: 0.38, blue: 0.82)
    }
    
    // MARK: - Helpers
    private func difficultyBadge(_ diff: TaskDifficulty) -> some View {
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
            .font(.caption2.bold())
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(bg)
            .foregroundColor(fg)
            .clipShape(Capsule())
    }
    
    private func resetToStarter() {
        code = task.starterCode
        testResults.removeAll()
        allPassed = false
    }
    
    // MARK: - Run Tests Engine
    private func runTestCases() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        isRunningTests = true
        selectedTab = 1 // Switch to tests tab automatically
        
        Task {
            var results: [TestExecutionResult] = []
            var everyTestPassed = true
            
            for tc in task.testCases {
                // Construct executable verification script:
                let testHarness: String
                if task.language == .sql {
                    testHarness = """
\(tc.validationCode);
\(code);
"""
                } else if task.language == .python {
                    testHarness = """
\(code)

__test_passed = \(tc.validationCode)
print("__TEST_RESULT:" + str(__test_passed).lower())
"""
                } else if task.language == .csharp {
                    testHarness = """
\(code)

bool __testPassed = \(tc.validationCode);
Console.WriteLine("__TEST_RESULT:" + __testPassed.ToString().ToLower());
"""
                } else {
                    testHarness = """
\(code)

let __testPassed = \(tc.validationCode)
print("__TEST_RESULT:" + String(__testPassed))
"""
                }
                
                let exec = await PlaygroundEngine.shared.execute(code: testHarness, language: task.language)
                
                if let err = exec.error {
                    results.append(TestExecutionResult(
                        testCase: tc,
                        passed: false,
                        message: "\(lang.localized("Ошибка", "Error")): \(err.message)"
                    ))
                    everyTestPassed = false
                } else if task.language == .sql {
                    let cleanedOutput = exec.output.replacingOccurrences(of: " ", with: "").lowercased()
                    let cleanedExpected = tc.expectedOutput.replacingOccurrences(of: " ", with: "").lowercased()
                    let passed = cleanedOutput.contains(cleanedExpected)
                    
                    results.append(TestExecutionResult(
                        testCase: tc,
                        passed: passed,
                        message: passed ? "\(tc.title): \(exec.output.trimmingCharacters(in: .whitespacesAndNewlines))" : "\(lang.localized("Ожидалось", "Expected")): \(tc.expectedOutput), \(lang.localized("Получено", "Got")): \(exec.output.isEmpty ? "<пусто>" : exec.output)"
                    ))
                    if !passed { everyTestPassed = false }
                } else if exec.output.contains("__TEST_RESULT:true") {
                    results.append(TestExecutionResult(
                        testCase: tc,
                        passed: true,
                        message: "\(tc.inputDescription) == \(tc.expectedOutput)"
                    ))
                } else {
                    results.append(TestExecutionResult(
                        testCase: tc,
                        passed: false,
                        message: "\(lang.localized("Ожидалось", "Expected")): \(tc.expectedOutput)"
                    ))
                    everyTestPassed = false
                }
            }
            
            await MainActor.run {
                self.testResults = results
                self.isRunningTests = false
                self.allPassed = everyTestPassed
                
                if everyTestPassed {
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                    storage.markChallengeSolved(id: task.id, reward: task.xpReward)
                    isSolutionRevealed = true
                } else {
                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                }
            }
        }
    }
}
