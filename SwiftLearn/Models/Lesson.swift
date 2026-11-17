import Foundation

public enum CurriculumTrack: String, CaseIterable, Identifiable, Codable {
    case swiftCore = "swift_core"
    case swiftUI = "swiftui"
    
    public var id: String { rawValue }
    
    public func title(for language: AppLanguage) -> String {
        switch self {
        case .swiftCore:
            return "Swift Core"
        case .swiftUI:
            return "SwiftUI Pro"
        }
    }
    
    public var icon: String {
        switch self {
        case .swiftCore: return "swift"
        case .swiftUI: return "macwindow.on.rectangle"
        }
    }
}

public enum LessonCategory: String, CaseIterable, Identifiable, Codable {
    // MARK: - Track 1: Swift Core
    case swiftBasics = "swift_basics"
    case controlFlow = "control_flow"
    case collections = "collections"
    case closures = "closures"
    case oopAndPop = "oop_and_pop"
    case protocolsAndGenerics = "protocols_generics"
    case errorHandling = "error_handling"
    case concurrency = "concurrency"
    
    // MARK: - Track 2: SwiftUI Pro
    case swiftuiAnatomy = "swiftui_anatomy"
    case swiftuiStacks = "swiftui_stacks"
    case swiftuiLayout = "swiftui_layout"
    case swiftuiState = "swiftui_state"
    case swiftuiCollections = "swiftui_collections"
    case swiftuiModifiers = "swiftui_modifiers"
    case swiftuiAnimations = "swiftui_animations"
    case swiftuiNavigation = "swiftui_navigation"
    
    public var id: String { rawValue }
    
    public var track: CurriculumTrack {
        switch self {
        case .swiftBasics, .controlFlow, .collections, .closures,
             .oopAndPop, .protocolsAndGenerics, .errorHandling, .concurrency:
            return .swiftCore
        case .swiftuiAnatomy, .swiftuiStacks, .swiftuiLayout, .swiftuiState,
             .swiftuiCollections, .swiftuiModifiers, .swiftuiAnimations, .swiftuiNavigation:
            return .swiftUI
        }
    }
    
    public func title(for language: AppLanguage) -> String {
        switch self {
        // Swift Core
        case .swiftBasics:
            return language == .russian ? "1. Основы Swift и Типы" : "1. Swift Basics & Types"
        case .controlFlow:
            return language == .russian ? "2. Поток и Опционалы" : "2. Control Flow & Safety"
        case .collections:
            return language == .russian ? "3. Коллекции и Функции" : "3. Collections & Functional"
        case .closures:
            return language == .russian ? "4. Функции и Замыкания" : "4. Functions & Closures"
        case .oopAndPop:
            return language == .russian ? "5. Структуры, Классы и ARC" : "5. Structs, Classes & ARC"
        case .protocolsAndGenerics:
            return language == .russian ? "6. Протоколы и Generics" : "6. Protocols & Generics"
        case .errorHandling:
            return language == .russian ? "7. Обработка Ошибок" : "7. Error Handling & Result"
        case .concurrency:
            return language == .russian ? "8. Асинхронность (Swift 6)" : "8. Concurrency & Actors"
            
        // SwiftUI
        case .swiftuiAnatomy:
            return language == .russian ? "1. Анатомия View и Декларативность" : "1. View Anatomy & Declarative Tree"
        case .swiftuiStacks:
            return language == .russian ? "2. Стеки, Выравнивание и Safe Area" : "2. Stacks, Alignment & Safe Area"
        case .swiftuiLayout:
            return language == .russian ? "3. Алгоритм Layout & Геометрия" : "3. Layout Engine & Sizing"
        case .swiftuiState:
            return language == .russian ? "4. Состояние: @State, @Binding, @Observable" : "4. State, Binding & Observation"
        case .swiftuiCollections:
            return language == .russian ? "5. Списки, LazyVGrid и Grid" : "5. Lists, LazyVGrid & Adaptive Grids"
        case .swiftuiModifiers:
            return language == .russian ? "6. Модификаторы и Кастомные Стили" : "6. ViewModifiers & Custom Styling"
        case .swiftuiAnimations:
            return language == .russian ? "7. Анимации, Переходы и Жесты" : "7. Animations, Transitions & Gestures"
        case .swiftuiNavigation:
            return language == .russian ? "8. Навигация и Модальные Экраны" : "8. NavigationStack & Modal Sheets"
        }
    }
    
    public var icon: String {
        switch self {
        case .swiftBasics: return "apple.terminal"
        case .controlFlow: return "arrow.triangle.branch"
        case .collections: return "square.stack.3d.up"
        case .closures: return "function"
        case .oopAndPop: return "cube.transparent"
        case .protocolsAndGenerics: return "shield.lefthalf.filled"
        case .errorHandling: return "exclamationmark.triangle"
        case .concurrency: return "arrow.triangle.2.circlepath"
            
        case .swiftuiAnatomy: return "macwindow"
        case .swiftuiStacks: return "square.3.layers.3d.down.right"
        case .swiftuiLayout: return "ruler"
        case .swiftuiState: return "arrow.triangle.2.circlepath.circle"
        case .swiftuiCollections: return "rectangle.grid.2x2"
        case .swiftuiModifiers: return "slider.horizontal.3"
        case .swiftuiAnimations: return "sparkles"
        case .swiftuiNavigation: return "arrow.right.arrow.left.square"
        }
    }
}

public struct QuizQuestion: Identifiable, Codable, Hashable {
    public var id: UUID = UUID()
    public var questionRU: String
    public var questionEN: String
    public var optionsRU: [String]
    public var optionsEN: [String]
    public var correctIndex: Int
    public var explanationRU: String
    public var explanationEN: String
    
    public init(
        id: UUID = UUID(),
        questionRU: String,
        questionEN: String,
        optionsRU: [String],
        optionsEN: [String],
        correctIndex: Int,
        explanationRU: String,
        explanationEN: String
    ) {
        self.id = id
        self.questionRU = questionRU
        self.questionEN = questionEN
        self.optionsRU = optionsRU
        self.optionsEN = optionsEN
        self.correctIndex = correctIndex
        self.explanationRU = explanationRU
        self.explanationEN = explanationEN
    }
}

public struct LessonPracticeChallenge: Identifiable, Codable, Hashable {
    public var id: String
    public var titleRU: String
    public var titleEN: String
    public var taskPromptRU: String
    public var taskPromptEN: String
    public var starterCode: String
    public var solutionCode: String
    public var testCases: [TaskTestCase]
    public var hintsRU: [String]
    public var hintsEN: [String]
    
    public init(
        id: String,
        titleRU: String,
        titleEN: String,
        taskPromptRU: String,
        taskPromptEN: String,
        starterCode: String,
        solutionCode: String,
        testCases: [TaskTestCase],
        hintsRU: [String] = [],
        hintsEN: [String] = []
    ) {
        self.id = id
        self.titleRU = titleRU
        self.titleEN = titleEN
        self.taskPromptRU = taskPromptRU
        self.taskPromptEN = taskPromptEN
        self.starterCode = starterCode
        self.solutionCode = solutionCode
        self.testCases = testCases
        self.hintsRU = hintsRU
        self.hintsEN = hintsEN
    }
}

public struct Lesson: Identifiable, Codable, Hashable {
    public var id: String
    public var category: LessonCategory
    public var titleRU: String
    public var titleEN: String
    public var summaryRU: String
    public var summaryEN: String
    public var contentMarkdownRU: String
    public var contentMarkdownEN: String
    public var codeSnippet: String
    public var xpReward: Int
    public var quiz: [QuizQuestion]
    public var isCompleted: Bool = false
    public var practiceChallenge: LessonPracticeChallenge? = nil
    
    public init(
        id: String,
        category: LessonCategory,
        titleRU: String,
        titleEN: String,
        summaryRU: String,
        summaryEN: String,
        contentMarkdownRU: String,
        contentMarkdownEN: String,
        codeSnippet: String,
        xpReward: Int = 50,
        quiz: [QuizQuestion] = [],
        isCompleted: Bool = false,
        practiceChallenge: LessonPracticeChallenge? = nil
    ) {
        self.id = id
        self.category = category
        self.titleRU = titleRU
        self.titleEN = titleEN
        self.summaryRU = summaryRU
        self.summaryEN = summaryEN
        self.contentMarkdownRU = contentMarkdownRU
        self.contentMarkdownEN = contentMarkdownEN
        self.codeSnippet = codeSnippet
        self.xpReward = xpReward
        self.quiz = quiz
        self.isCompleted = isCompleted
        self.practiceChallenge = practiceChallenge
    }
}
