import SwiftUI

public struct LessonDetailView: View {
    public let lesson: Lesson
    @ObservedObject var lang = LanguageManager.shared
    @ObservedObject var storage = StorageService.shared
    @Environment(\.dismiss) private var dismiss
    
    // Practice Challenge State
    @State private var challenge: LessonPracticeChallenge?
    @State private var userCode: String = ""
    @State private var isRunningTests: Bool = false
    @State private var testResults: [LessonTestExecutionResult] = []
    @State private var allTestsPassed: Bool = false
    @State private var showHintSheet: Bool = false
    @State private var showingSolutionAlert: Bool = false
    @State private var isSolutionRevealed: Bool = false
    @State private var resetConfirmAlert: Bool = false
    
    public init(lesson: Lesson) {
        self.lesson = lesson
    }
    
    private var isLessonMastered: Bool {
        storage.profile.completedLessonIDs.contains(lesson.id)
    }
    
    public var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: - Header Card
                    headerSection
                    
                    Divider()
                        .padding(.horizontal)
                    
                    // MARK: - Structured Curriculum Content
                    VStack(alignment: .leading, spacing: 14) {
                        HStack(spacing: 8) {
                            Image(systemName: "text.book.closed.fill")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.88))
                            
                            Text(lang.localized("Теоретический базис", "Theoretical Foundation"))
                                .font(.headline.weight(.semibold))
                                .foregroundColor(.primary)
                        }
                        
                        CurriculumMarkdownView(
                            markdown: lang.localized(lesson.contentMarkdownRU, lesson.contentMarkdownEN)
                        )
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Code Snippet Section
                    if !lesson.codeSnippet.isEmpty {
                        Divider()
                            .padding(.horizontal)
                        
                        codeExampleSection
                    }
                    
                    // MARK: - Interactive Practical Coding Challenge (Only Requirement)
                    if let challenge = challenge {
                        Divider()
                            .padding(.horizontal)
                        
                        practicalChallengeSection(challenge)
                            .id("PRACTICE_SECTION")
                    }
                    
                    // MARK: - Final Mastery / Completion Status Banner
                    completionStatusBanner
                }
                .padding(.vertical)
                .padding(.bottom, 80)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .onAppear {
                setupChallenge()
                if ProcessInfo.processInfo.arguments.contains("-scrollToPractice") {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation {
                            scrollProxy.scrollTo("PRACTICE_SECTION", anchor: .top)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showHintSheet) {
            hintsSheetView
        }
        .alert(lang.localized("Сбросить код к начальному?", "Reset code to starter?"), isPresented: $resetConfirmAlert) {
            Button(lang.localized("Отмена", "Cancel"), role: .cancel) { }
            Button(lang.localized("Сбросить", "Reset"), role: .destructive) {
                if let ch = challenge {
                    userCode = ch.starterCode
                    testResults.removeAll()
                    allTestsPassed = false
                }
            }
        }
        .alert(lang.localized("Показать эталонное решение?", "Reveal Reference Solution?"), isPresented: $showingSolutionAlert) {
            Button(lang.localized("Отмена", "Cancel"), role: .cancel) { }
            Button(lang.localized("Вставить решение", "Insert Solution")) {
                if let ch = challenge {
                    userCode = ch.solutionCode
                    isSolutionRevealed = true
                }
            }
        } message: {
            Text(lang.localized(
                "Эталонный код будет вставлен в редактор. Постарайтесь разобрать логику его работы перед запуском тестов.",
                "The reference solution will be inserted into your editor. Study its logic before running validation tests."
            ))
        }
    }
    
    private func setupChallenge() {
        let ch = LessonPracticeStore.shared.challenge(for: lesson)
        self.challenge = ch
        if userCode.isEmpty {
            self.userCode = ch.starterCode
        }
        if isLessonMastered {
            self.allTestsPassed = true
        }
    }
    
    // MARK: - Header
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label(lesson.category.title(for: lang.currentLanguage), systemImage: lesson.category.icon)
                    .font(.caption.bold())
                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.88))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(red: 0.14, green: 0.38, blue: 0.88).opacity(0.12))
                    .clipShape(Capsule())
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "bolt.fill")
                        .font(.caption2)
                    Text("+\(lesson.xpReward) XP")
                        .font(.caption.bold())
                }
                .foregroundColor(Color(red: 0.95, green: 0.60, blue: 0.15))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color(red: 0.95, green: 0.60, blue: 0.15).opacity(0.12))
                .clipShape(Capsule())
            }
            
            Text(lang.localized(lesson.titleRU, lesson.titleEN))
                .font(.title2.weight(.bold))
                .foregroundColor(.primary)
            
            // Executive Summary Banner
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "lightbulb.fill")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.88))
                    .padding(.top, 2)
                
                Text(lang.localized(lesson.summaryRU, lesson.summaryEN))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineSpacing(3)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal)
    }
    
    // MARK: - Code Example
    private var codeExampleSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "terminal.fill")
                    .font(.subheadline)
                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.88))
                
                Text(lang.localized("Интерактивный пример", "Interactive Example"))
                    .font(.headline.weight(.semibold))
                    .foregroundColor(.primary)
            }
            .padding(.horizontal)
            
            CodeBlockView(code: lesson.codeSnippet, title: "Example.swift")
                .padding(.horizontal)
            
            HStack(spacing: 10) {
                Button(action: {
                    dismiss()
                    AppNavigationState.shared.navigateToPlayground(withCode: lesson.codeSnippet)
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "play.fill")
                            .font(.caption)
                        Text(lang.localized("Запустить в Плейграунде", "Run in Playground"))
                            .font(.subheadline.bold())
                    }
                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.88))
                    .padding(.vertical, 9)
                    .padding(.horizontal, 14)
                    .background(Color(red: 0.14, green: 0.38, blue: 0.88).opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Practical Coding Challenge Section
    private func practicalChallengeSection(_ ch: LessonPracticeChallenge) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section Header
            HStack(spacing: 8) {
                Image(systemName: "curlybraces.square.fill")
                    .font(.title3)
                    .foregroundColor(Color(red: 0.58, green: 0.22, blue: 0.88))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(lang.localized("Практическое задание: Написание кода", "Practical Coding Challenge"))
                        .font(.title3.bold())
                    
                    Text(lang.localized(ch.titleRU, ch.titleEN))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if allTestsPassed {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark.circle.fill")
                        Text(lang.localized("Решено", "Passed"))
                    }
                    .font(.caption.bold())
                    .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(red: 0.16, green: 0.58, blue: 0.40).opacity(0.12))
                    .clipShape(Capsule())
                }
            }
            .padding(.horizontal)
            
            // Task Prompt Card
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Image(systemName: "target")
                        .font(.caption.bold())
                        .foregroundColor(Color(red: 0.58, green: 0.22, blue: 0.88))
                    Text(lang.localized("Условие задачи:", "Task Requirements:"))
                        .font(.subheadline.bold())
                        .foregroundColor(.primary)
                }
                
                Text(lang.localized(ch.taskPromptRU, ch.taskPromptEN))
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            
            // Editor Controls Bar
            HStack(spacing: 10) {
                Text("Swift IDE")
                    .font(.caption.bold())
                    .foregroundColor(.secondary)
                
                Spacer()
                
                // Hints button
                let hintCount = lang.currentLanguage == .russian ? ch.hintsRU.count : ch.hintsEN.count
                if hintCount > 0 {
                    Button(action: { showHintSheet = true }) {
                        HStack(spacing: 4) {
                            Image(systemName: "lightbulb")
                            Text(lang.localized("Подсказка (\(hintCount))", "Hint (\(hintCount))"))
                        }
                        .font(.caption.bold())
                        .foregroundColor(Color(red: 0.95, green: 0.60, blue: 0.15))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color(red: 0.95, green: 0.60, blue: 0.15).opacity(0.12))
                        .clipShape(Capsule())
                    }
                }
                
                // Reset Code button
                Button(action: { resetConfirmAlert = true }) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.caption.bold())
                        .foregroundColor(.secondary)
                        .padding(7)
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(Circle())
                }
                
                // Reveal Solution button
                Button(action: { showingSolutionAlert = true }) {
                    Image(systemName: "eye")
                        .font(.caption.bold())
                        .foregroundColor(.secondary)
                        .padding(7)
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)
            
            // Embedded Code Editor Card
            ZStack(alignment: .topTrailing) {
                SyntaxCodeEditor(
                    text: $userCode,
                    theme: IDEProjectManager.shared.theme
                )
                .frame(height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                )
            }
            .padding(.horizontal)
            
            // Run Tests Action Button
            Button(action: {
                Task {
                    await runPracticeTests(challenge: ch)
                }
            }) {
                HStack(spacing: 8) {
                    if isRunningTests {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(0.9)
                        Text(lang.localized("Проверка тест-кейсов...", "Validating test cases..."))
                    } else {
                        Image(systemName: allTestsPassed ? "arrow.clockwise" : "play.fill")
                        Text(allTestsPassed ? lang.localized("Запустить тесты повторно", "Rerun Test Suite") : lang.localized("Проверить решение", "Run & Validate Code"))
                    }
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(allTestsPassed ? Color(red: 0.16, green: 0.58, blue: 0.40) : Color(red: 0.58, green: 0.22, blue: 0.88))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal)
            .disabled(isRunningTests)
            
            // Test Cases Card List
            VStack(alignment: .leading, spacing: 8) {
                Text(lang.localized("Тест-кейсы:", "Test Cases:"))
                    .font(.caption.bold())
                    .foregroundColor(.secondary)
                
                if testResults.isEmpty {
                    // Show pending test cases before running
                    ForEach(ch.testCases) { tc in
                        HStack(alignment: .top, spacing: 10) {
                            Circle()
                                .strokeBorder(Color.secondary.opacity(0.4), lineWidth: 1.5)
                                .frame(width: 16, height: 16)
                                .padding(.top, 2)
                            
                            VStack(alignment: .leading, spacing: 3) {
                                Text(tc.title)
                                    .font(.subheadline.bold())
                                    .foregroundColor(.primary)
                                
                                Text("\(tc.inputDescription) → \(tc.expectedOutput)")
                                    .font(.system(size: 11, design: .monospaced))
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding(10)
                        .background(Color(UIColor.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                } else {
                    // Show live validation results
                    ForEach(testResults) { res in
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: res.passed ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(res.passed ? Color(red: 0.16, green: 0.58, blue: 0.40) : Color(red: 0.75, green: 0.22, blue: 0.22))
                                .font(.subheadline)
                                .padding(.top, 2)
                            
                            VStack(alignment: .leading, spacing: 3) {
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
            .padding(.horizontal)
        }
    }
    
    // MARK: - Execute Practice Tests via PlaygroundEngine
    private func runPracticeTests(challenge: LessonPracticeChallenge) async {
        await MainActor.run {
            isRunningTests = true
        }
        
        let code = userCode
        
        // 1. Static Anti-Cheat & Parameter Computation Analysis
        let integrityCheck = CodeIntegrityValidator.shared.validate(code: code, challenge: challenge)
        if !integrityCheck.isValid {
            let reason = lang.localized(integrityCheck.failureReasonRU, integrityCheck.failureReasonEN)
            let cheatTestCase = TaskTestCase(
                title: lang.localized("Защита от хардкода (Анти-чит)", "Anti-Hardcode Integrity"),
                inputDescription: lang.localized("Анализ параметров и алгоритмических вычислений", "Input parameters and calculation analysis"),
                expectedOutput: lang.localized("Реальный алгоритм", "Actual computation"),
                validationCode: "false"
            )
            await MainActor.run {
                self.testResults = [LessonTestExecutionResult(testCase: cheatTestCase, passed: false, message: reason)]
                self.isRunningTests = false
                self.allTestsPassed = false
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            }
            return
        }
        
        var results: [LessonTestExecutionResult] = []
        var everyTestPassed = true
        
        // 2. Visible tests + Dynamic randomized stress tests
        var allTestCases = challenge.testCases
        let dynamicTests = LessonPracticeStore.shared.dynamicStressTestCases(for: challenge)
        allTestCases.append(contentsOf: dynamicTests)
        
        for tc in allTestCases {
            let testHarness = """
\(code)

let __testPassed = \(tc.validationCode)
print("__TEST_RESULT:" + String(__testPassed))
"""
            let exec = await PlaygroundEngine.shared.execute(code: testHarness)
            
            if let err = exec.error {
                results.append(LessonTestExecutionResult(
                    testCase: tc,
                    passed: false,
                    message: "\(lang.localized("Ошибка", "Error")): \(err.message)"
                ))
                everyTestPassed = false
            } else if exec.output.contains("__TEST_RESULT:true") {
                results.append(LessonTestExecutionResult(
                    testCase: tc,
                    passed: true,
                    message: "\(tc.inputDescription) == \(tc.expectedOutput)"
                ))
            } else {
                results.append(LessonTestExecutionResult(
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
            self.allTestsPassed = everyTestPassed
            
            if everyTestPassed {
                UINotificationFeedbackGenerator().notificationOccurred(.success)
                if !isLessonMastered {
                    storage.markLessonCompleted(id: lesson.id, reward: lesson.xpReward)
                }
            } else {
                UINotificationFeedbackGenerator().notificationOccurred(.warning)
            }
        }
    }
    
    // MARK: - Completion Status Banner
    private var completionStatusBanner: some View {
        VStack(spacing: 8) {
            if isLessonMastered {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                    Text(lang.localized("Урок полностью освоен (+ \(lesson.xpReward) XP получено)", "Lesson Mastered (+ \(lesson.xpReward) XP earned)"))
                        .font(.subheadline.bold())
                        .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.16, green: 0.58, blue: 0.40).opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                HStack(spacing: 6) {
                    Image(systemName: "info.circle")
                    Text(lang.localized(
                        "Для освоения урока напишите решение и успешно пройдите все тест-кейсы.",
                        "Write a valid solution and pass all test cases to complete this lesson."
                    ))
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding(.horizontal)
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Hints Sheet
    private var hintsSheetView: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    if let ch = challenge {
                        let hints = lang.currentLanguage == .russian ? ch.hintsRU : ch.hintsEN
                        if hints.isEmpty {
                            Text(lang.localized("Для этой задачи подсказки не требуются.", "No hints required for this challenge."))
                                .foregroundColor(.secondary)
                        } else {
                            ForEach(Array(hints.enumerated()), id: \.offset) { index, hint in
                                HStack(alignment: .top, spacing: 10) {
                                    Text("\(index + 1)")
                                        .font(.caption.bold())
                                        .foregroundColor(.white)
                                        .frame(width: 22, height: 22)
                                        .background(Color(red: 0.58, green: 0.22, blue: 0.88))
                                        .clipShape(Circle())
                                    
                                    Text(hint)
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(UIColor.secondarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(lang.localized("Подсказки", "Hints"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(lang.localized("Готово", "Done")) {
                        showHintSheet = false
                    }
                }
            }
        }
    }
}
