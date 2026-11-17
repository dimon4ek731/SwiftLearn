import Foundation

public enum TargetLanguage: String, CaseIterable, Identifiable, Codable {
    case swift = "swift"
    case python = "python"
    case csharp = "csharp"
    
    public var id: String { rawValue }
    
    public var title: String {
        switch self {
        case .swift: return "Swift"
        case .python: return "Python"
        case .csharp: return "C#"
        }
    }
    
    public var displayName: String {
        title
    }
    
    public var versionTitle: String {
        switch self {
        case .swift: return "Swift 6"
        case .python: return "Python 3.12"
        case .csharp: return "C# 12 / .NET 8"
        }
    }
    
    public var icon: String {
        switch self {
        case .swift: return "swift"
        case .python: return "chevron.left.forwardslash.chevron.right"
        case .csharp: return "number"
        }
    }
    
    public var fileExtension: String {
        switch self {
        case .swift: return "swift"
        case .python: return "py"
        case .csharp: return "cs"
        }
    }
}

public enum CurriculumTrack: String, CaseIterable, Identifiable, Codable {
    // Swift Tracks
    case swiftCore = "swift_core"
    case swiftUI = "swiftui"
    
    // Python Tracks
    case pythonCore = "python_core"
    case pythonAdvanced = "python_advanced"
    
    // C# Tracks
    case csharpCore = "csharp_core"
    case csharpAdvanced = "csharp_advanced"
    
    public var id: String { rawValue }
    
    public var language: TargetLanguage {
        switch self {
        case .swiftCore, .swiftUI: return .swift
        case .pythonCore, .pythonAdvanced: return .python
        case .csharpCore, .csharpAdvanced: return .csharp
        }
    }
    
    public func title(for language: AppLanguage) -> String {
        switch self {
        case .swiftCore:
            return "Swift Core"
        case .swiftUI:
            return "SwiftUI Pro"
        case .pythonCore:
            return language == .russian ? "Python Core" : "Python Core"
        case .pythonAdvanced:
            return language == .russian ? "Python ООП & Продвинутый" : "Python OOP & Advanced"
        case .csharpCore:
            return language == .russian ? "C# Core & ООП" : "C# Core & OOP"
        case .csharpAdvanced:
            return language == .russian ? "C# LINQ & Асинхронность" : "C# LINQ & Async"
        }
    }
    
    public var icon: String {
        switch self {
        case .swiftCore: return "swift"
        case .swiftUI: return "macwindow.on.rectangle"
        case .pythonCore: return "chevron.left.forwardslash.chevron.right"
        case .pythonAdvanced: return "cube.transparent"
        case .csharpCore: return "number"
        case .csharpAdvanced: return "arrow.triangle.branch"
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
    
    // MARK: - Track 3: Python Core
    case pythonBasics = "python_basics"
    case pythonCollections = "python_collections"
    case pythonFunctions = "python_functions"
    
    // MARK: - Track 4: Python Advanced
    case pythonOOP = "python_oop"
    case pythonAdvanced = "python_advanced"
    
    // MARK: - Track 5: C# Core
    case csharpBasics = "csharp_basics"
    case csharpOOP = "csharp_oop"
    case csharpInterfaces = "csharp_interfaces"
    
    // MARK: - Track 6: C# Advanced
    case csharpCollections = "csharp_collections"
    case csharpLINQ = "csharp_linq"
    case csharpModern = "csharp_modern"
    
    public var id: String { rawValue }
    
    public var language: TargetLanguage {
        track.language
    }
    
    public var track: CurriculumTrack {
        switch self {
        // Swift Core
        case .swiftBasics, .controlFlow, .collections, .closures,
             .oopAndPop, .protocolsAndGenerics, .errorHandling, .concurrency:
            return .swiftCore
            
        // SwiftUI Pro
        case .swiftuiAnatomy, .swiftuiStacks, .swiftuiLayout, .swiftuiState,
             .swiftuiCollections, .swiftuiModifiers, .swiftuiAnimations, .swiftuiNavigation:
            return .swiftUI
            
        // Python Core
        case .pythonBasics, .pythonCollections, .pythonFunctions:
            return .pythonCore
            
        // Python Advanced
        case .pythonOOP, .pythonAdvanced:
            return .pythonAdvanced
            
        // C# Core
        case .csharpBasics, .csharpOOP, .csharpInterfaces:
            return .csharpCore
            
        // C# Advanced
        case .csharpCollections, .csharpLINQ, .csharpModern:
            return .csharpAdvanced
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
            
        // Python Core
        case .pythonBasics:
            return language == .russian ? "1. Синтаксис, Переменные и Типы" : "1. Python Syntax & Dynamic Types"
        case .pythonCollections:
            return language == .russian ? "2. Списки, Словари и Comprehensions" : "2. Lists, Dicts & Comprehensions"
        case .pythonFunctions:
            return language == .russian ? "3. Функции, *args/**kwargs и Лямбды" : "3. Functions, Args & Lambdas"
            
        // Python Advanced
        case .pythonOOP:
            return language == .russian ? "4. Классы, __init__ и Наследование" : "4. OOP, Classes & Inheritance"
        case .pythonAdvanced:
            return language == .russian ? "5. Декораторы, Генераторы и Контексты" : "5. Decorators, Generators & Contexts"
            
        // C# Core
        case .csharpBasics:
            return language == .russian ? "1. Основы C#, Типы и Управление" : "1. C# Basics, Types & Control Flow"
        case .csharpOOP:
            return language == .russian ? "2. Классы, Свойства и Структуры" : "2. Classes, Properties & Structs"
        case .csharpInterfaces:
            return language == .russian ? "3. Интерфейсы и Полиморфизм" : "3. Interfaces & Polymorphism"
            
        // C# Advanced
        case .csharpCollections:
            return language == .russian ? "4. Коллекции и Дженерики" : "4. Collections & Generics"
        case .csharpLINQ:
            return language == .russian ? "5. LINQ и Функциональные Запросы" : "5. LINQ & Functional Queries"
        case .csharpModern:
            return language == .russian ? "6. Records, Pattern Matching & Async" : "6. Records, Pattern Matching & Async"
        }
    }
    
    public var icon: String {
        switch self {
        // Swift
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
            
        // Python
        case .pythonBasics: return "chevron.left.forwardslash.chevron.right"
        case .pythonCollections: return "list.bullet.rectangle"
        case .pythonFunctions: return "function"
        case .pythonOOP: return "cube.transparent"
        case .pythonAdvanced: return "sparkles"
            
        // C#
        case .csharpBasics: return "number"
        case .csharpOOP: return "shippingbox"
        case .csharpInterfaces: return "shield.lefthalf.filled"
        case .csharpCollections: return "square.stack.3d.up"
        case .csharpLINQ: return "line.3.horizontal.decrease.circle"
        case .csharpModern: return "bolt.badge.clock"
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
    public var language: TargetLanguage
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
        language: TargetLanguage = .swift,
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
        self.language = language
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
    public var quiz: [QuizQuestion]
    public var xpReward: Int
    public var practiceChallenge: LessonPracticeChallenge?
    
    public var language: TargetLanguage {
        category.language
    }
    
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
        xpReward: Int = 30,
        quiz: [QuizQuestion] = [],
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
        self.practiceChallenge = practiceChallenge
    }
}
