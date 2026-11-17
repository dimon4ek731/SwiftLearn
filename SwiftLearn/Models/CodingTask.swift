import Foundation

public enum TaskDifficulty: String, CaseIterable, Identifiable, Codable {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
    case expert = "expert"
    
    public var id: String { rawValue }
    
    public func title(for language: AppLanguage) -> String {
        switch self {
        case .easy:
            return language == .russian ? "Базовый" : "Easy"
        case .medium:
            return language == .russian ? "Средний" : "Medium"
        case .hard:
            return language == .russian ? "Сложный" : "Hard"
        case .expert:
            return language == .russian ? "Эксперт" : "Expert"
        }
    }
    
    public var colorName: String {
        switch self {
        case .easy: return "green"
        case .medium: return "blue"
        case .hard: return "orange"
        case .expert: return "purple"
        }
    }
}

public enum TaskCategory: String, CaseIterable, Identifiable, Codable {
    case basicsAndMath = "basics_math"
    case stringsAndCollections = "strings_collections"
    case algorithms = "algorithms"
    case oopAndPop = "oop_pop"
    case functionalAndClosures = "functional_closures"
    case concurrency = "concurrency"
    case architecture = "architecture"
    
    public var id: String { rawValue }
    
    public func title(for language: AppLanguage) -> String {
        switch self {
        case .basicsAndMath:
            return language == .russian ? "Синтаксис и Вычисления" : "Basics & Arithmetic"
        case .stringsAndCollections:
            return language == .russian ? "Строки и Коллекции" : "Strings & Collections"
        case .algorithms:
            return language == .russian ? "Алгоритмы и Структуры" : "Algorithms & Structures"
        case .oopAndPop:
            return language == .russian ? "ООП и Протоколы" : "OOP & Protocols"
        case .functionalAndClosures:
            return language == .russian ? "Замыкания и Функционал" : "Closures & Functional"
        case .concurrency:
            return language == .russian ? "Асинхронность и Акторы" : "Concurrency & Actors"
        case .architecture:
            return language == .russian ? "Архитектура и Модели" : "Architecture & Patterns"
        }
    }
    
    public var icon: String {
        switch self {
        case .basicsAndMath: return "plus.forwardslash.minus"
        case .stringsAndCollections: return "square.stack.3d.up"
        case .algorithms: return "arrow.triangle.branch"
        case .oopAndPop: return "cube.transparent"
        case .functionalAndClosures: return "function"
        case .concurrency: return "arrow.triangle.2.circlepath"
        case .architecture: return "macwindow"
        }
    }
}

public struct TaskTestCase: Identifiable, Codable, Hashable, Equatable {
    public var id: UUID = UUID()
    public var title: String
    public var inputDescription: String
    public var expectedOutput: String
    public var validationCode: String // Swift expression checking answer, returns Bool
    
    public init(
        id: UUID = UUID(),
        title: String,
        inputDescription: String,
        expectedOutput: String,
        validationCode: String
    ) {
        self.id = id
        self.title = title
        self.inputDescription = inputDescription
        self.expectedOutput = expectedOutput
        self.validationCode = validationCode
    }
}

public struct CodingTask: Identifiable, Codable {
    public var id: String
    public var titleRU: String
    public var titleEN: String
    public var difficulty: TaskDifficulty
    public var category: TaskCategory
    public var summaryRU: String
    public var summaryEN: String
    public var descriptionRU: String
    public var descriptionEN: String
    public var requirementsRU: [String]
    public var requirementsEN: [String]
    public var starterCode: String
    public var testCases: [TaskTestCase]
    public var hintsRU: [String]
    public var hintsEN: [String]
    public var solutionCode: String
    public var xpReward: Int
    
    public init(
        id: String,
        titleRU: String,
        titleEN: String,
        difficulty: TaskDifficulty,
        category: TaskCategory,
        summaryRU: String,
        summaryEN: String,
        descriptionRU: String,
        descriptionEN: String,
        requirementsRU: [String],
        requirementsEN: [String],
        starterCode: String,
        testCases: [TaskTestCase],
        hintsRU: [String] = [],
        hintsEN: [String] = [],
        solutionCode: String = "",
        xpReward: Int = 30
    ) {
        self.id = id
        self.titleRU = titleRU
        self.titleEN = titleEN
        self.difficulty = difficulty
        self.category = category
        self.summaryRU = summaryRU
        self.summaryEN = summaryEN
        self.descriptionRU = descriptionRU
        self.descriptionEN = descriptionEN
        self.requirementsRU = requirementsRU
        self.requirementsEN = requirementsEN
        self.starterCode = starterCode
        self.testCases = testCases
        self.hintsRU = hintsRU
        self.hintsEN = hintsEN
        self.solutionCode = solutionCode
        self.xpReward = xpReward
    }
}
