import Foundation

public enum TargetLanguage: String, CaseIterable, Identifiable, Codable {
    case swift = "swift"
    case python = "python"
    case csharp = "csharp"
    case sql = "sql"
    
    public var id: String { rawValue }
    
    public var title: String {
        switch self {
        case .swift: return "Swift"
        case .python: return "Python"
        case .csharp: return "C#"
        case .sql: return "SQL"
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
        case .sql: return "SQL / SQLite & Postgres"
        }
    }
    
    public var icon: String {
        switch self {
        case .swift: return "swift"
        case .python: return "chevron.left.forwardslash.chevron.right"
        case .csharp: return "curlybraces"
        case .sql: return "cylinder.split.1x2"
        }
    }
    
    public var fileExtension: String {
        switch self {
        case .swift: return "swift"
        case .python: return "py"
        case .csharp: return "cs"
        case .sql: return "sql"
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
    case pythonStdlib = "python_stdlib"
    case pythonSystems = "python_systems"
    
    // C# Tracks
    case csharpCore = "csharp_core"
    case csharpOOP = "csharp_oop"
    case csharpCollections = "csharp_collections"
    case csharpAdvanced = "csharp_advanced"
    
    // SQL Tracks
    case sqlCore = "sql_core"
    case sqlAdvanced = "sql_advanced"
    
    public var id: String { rawValue }
    
    public var language: TargetLanguage {
        switch self {
        case .swiftCore, .swiftUI: return .swift
        case .pythonCore, .pythonAdvanced, .pythonStdlib, .pythonSystems: return .python
        case .csharpCore, .csharpOOP, .csharpCollections, .csharpAdvanced: return .csharp
        case .sqlCore, .sqlAdvanced: return .sql
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
            return language == .russian ? "Python ООП" : "Python OOP"
        case .pythonStdlib:
            return language == .russian ? "Python Stdlib" : "Python Stdlib"
        case .pythonSystems:
            return language == .russian ? "Python Concurrency" : "Python Concurrency"
        case .csharpCore:
            return language == .russian ? "C# Core & Типы" : "C# Core & Types"
        case .csharpOOP:
            return language == .russian ? "C# ООП & Records" : "C# OOP & Records"
        case .csharpCollections:
            return language == .russian ? "C# Коллекции & LINQ" : "C# Collections & LINQ"
        case .csharpAdvanced:
            return language == .russian ? "C# Concurrency & .NET" : "C# Concurrency & .NET"
        case .sqlCore:
            return language == .russian ? "SQL Запросы & DDL" : "SQL Queries & DDL"
        case .sqlAdvanced:
            return language == .russian ? "SQL JOIN & Аналитика" : "SQL JOIN & Analytics"
        }
    }
    
    public var icon: String {
        switch self {
        case .swiftCore: return "swift"
        case .swiftUI: return "macwindow.on.rectangle"
        case .pythonCore: return "chevron.left.forwardslash.chevron.right"
        case .pythonAdvanced: return "cube.transparent"
        case .pythonStdlib: return "shippingbox"
        case .pythonSystems: return "bolt.badge.clock"
        case .csharpCore: return "curlybraces"
        case .csharpOOP: return "shippingbox"
        case .csharpCollections: return "square.stack.3d.up"
        case .csharpAdvanced: return "bolt.badge.clock"
        case .sqlCore: return "cylinder.split.1x2"
        case .sqlAdvanced: return "chart.bar.xaxis"
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
    case pythonControlFlow = "python_control_flow"
    case pythonCollections = "python_collections"
    case pythonFunctions = "python_functions"
    
    // MARK: - Track 4: Python Advanced (OOP)
    case pythonOOP = "python_oop"
    case pythonDunder = "python_dunder"
    case pythonMetaprogramming = "python_metaprogramming"
    
    // MARK: - Track 5: Python Stdlib
    case pythonAdvancedCollections = "python_adv_collections"
    case pythonGenerators = "python_generators"
    case pythonDecorators = "python_decorators"
    case pythonIOAndFiles = "python_io_files"
    
    // MARK: - Track 6: Python Systems & Concurrency
    case pythonExceptions = "python_exceptions"
    case pythonAsync = "python_async"
    case pythonConcurrency = "python_concurrency"
    case pythonTestingAndPerf = "python_testing_perf"
    
    // MARK: - Track 5: C# Core
    case csharpBasics = "csharp_basics"
    case csharpTypes = "csharp_types"
    case csharpControlFlow = "csharp_control"
    case csharpStringsAndSpans = "csharp_strings_spans"
    
    // MARK: - Track 6: C# OOP
    case csharpOOP = "csharp_oop"
    case csharpInheritance = "csharp_inheritance"
    case csharpInterfaces = "csharp_interfaces"
    case csharpRecordsAndEnums = "csharp_records_enums"
    
    // MARK: - Track 7: C# Collections & LINQ
    case csharpGenerics = "csharp_generics"
    case csharpCollections = "csharp_collections"
    case csharpDelegatesEvents = "csharp_delegates_events"
    case csharpLINQ = "csharp_linq"
    
    // MARK: - Track 8: C# Systems & Concurrency
    case csharpExceptions = "csharp_exceptions"
    case csharpAsyncAwait = "csharp_async_await"
    case csharpTPLThreading = "csharp_tpl_threading"
    case csharpModern = "csharp_modern"
    
    // MARK: - Track 7: SQL Core
    case sqlBasics = "sql_basics"
    case sqlFiltering = "sql_filtering"
    case sqlAggregations = "sql_aggregations"
    
    // MARK: - Track 8: SQL Advanced
    case sqlJoins = "sql_joins"
    case sqlDdlDml = "sql_ddl_dml"
    case sqlWindow = "sql_window"
    
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
        case .pythonBasics, .pythonControlFlow, .pythonCollections, .pythonFunctions:
            return .pythonCore
            
        // Python Advanced
        case .pythonOOP, .pythonDunder, .pythonMetaprogramming:
            return .pythonAdvanced
            
        // Python Stdlib
        case .pythonAdvancedCollections, .pythonGenerators, .pythonDecorators, .pythonIOAndFiles:
            return .pythonStdlib
            
        // Python Systems
        case .pythonExceptions, .pythonAsync, .pythonConcurrency, .pythonTestingAndPerf:
            return .pythonSystems
            
        // C# Core
        case .csharpBasics, .csharpTypes, .csharpControlFlow, .csharpStringsAndSpans:
            return .csharpCore
            
        // C# OOP
        case .csharpOOP, .csharpInheritance, .csharpInterfaces, .csharpRecordsAndEnums:
            return .csharpOOP
            
        // C# Collections & LINQ
        case .csharpGenerics, .csharpCollections, .csharpDelegatesEvents, .csharpLINQ:
            return .csharpCollections
            
        // C# Systems & Concurrency
        case .csharpExceptions, .csharpAsyncAwait, .csharpTPLThreading, .csharpModern:
            return .csharpAdvanced
            
        // SQL Core
        case .sqlBasics, .sqlFiltering, .sqlAggregations:
            return .sqlCore
            
        // SQL Advanced
        case .sqlJoins, .sqlDdlDml, .sqlWindow:
            return .sqlAdvanced
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
        case .pythonControlFlow:
            return language == .russian ? "2. Условия, Циклы и Match" : "2. Control Flow, Loops & Match"
        case .pythonCollections:
            return language == .russian ? "3. Списки, Словари, Кортежи и Sets" : "3. Collections, Dicts, Sets & Comprehensions"
        case .pythonFunctions:
            return language == .russian ? "4. Функции, *args/**kwargs и Лямбды" : "4. Functions, Args & Lambdas"
            
        // Python Advanced (OOP)
        case .pythonOOP:
            return language == .russian ? "5. Классы, __init__ и Наследование" : "5. OOP, Classes & Inheritance"
        case .pythonDunder:
            return language == .russian ? "6. Магические Методы (Dunder) и Протоколы" : "6. Magic Methods (Dunder) & Protocols"
        case .pythonMetaprogramming:
            return language == .russian ? "7. Дескрипторы, Слоты и Метаклассы" : "7. Descriptors, Slots & Metaclasses"
            
        // Python Stdlib
        case .pythonAdvancedCollections:
            return language == .russian ? "8. collections, itertools и heapq" : "8. collections, itertools & heapq"
        case .pythonGenerators:
            return language == .russian ? "9. Генераторы, Итераторы и Contextlib" : "9. Generators, Iterators & Context"
        case .pythonDecorators:
            return language == .russian ? "10. Декораторы и Кеширование functools" : "10. Decorators & functools"
        case .pythonIOAndFiles:
            return language == .russian ? "11. Файлы pathlib, JSON и Regex" : "11. pathlib, JSON & Regex"
            
        // Python Systems
        case .pythonExceptions:
            return language == .russian ? "12. Иерархия Исключений и Логирование" : "12. Exceptions & Logging"
        case .pythonAsync:
            return language == .russian ? "13. Asyncio, Event Loop и Задачи" : "13. Asyncio, Event Loop & Tasks"
        case .pythonConcurrency:
            return language == .russian ? "14. GIL, Threading и Multiprocessing" : "14. GIL, Threading & Multiprocessing"
        case .pythonTestingAndPerf:
            return language == .russian ? "15. Тестирование unittest, cProfile и dis" : "15. Testing, Profiling & Bytecode"
            
        // C# Core
        case .csharpBasics:
            return language == .russian ? "1. Синтаксис C# 12, CLR и Top-Level" : "1. C# 12 Syntax, CLR & Top-Level"
        case .csharpTypes:
            return language == .russian ? "2. Значимые (struct) и Ссылочные (class) Типы" : "2. Value Types (struct) & Reference (class)"
        case .csharpControlFlow:
            return language == .russian ? "3. Pattern Matching, switch и Управление" : "3. Pattern Matching, Switch & Control"
        case .csharpStringsAndSpans:
            return language == .russian ? "4. Строки, Raw Literals и Span<T>" : "4. Strings, Raw Literals & Span<T>"
            
        // C# OOP
        case .csharpOOP:
            return language == .russian ? "5. Классы, Свойства и Первичные Конструкторы" : "5. Classes, Properties & Primary Ctors"
        case .csharpInheritance:
            return language == .russian ? "6. Наследование, virtual, override и sealed" : "6. Inheritance, Virtual, Override & Sealed"
        case .csharpInterfaces:
            return language == .russian ? "7. Интерфейсы и Default Interface Methods" : "7. Interfaces & Default Methods"
        case .csharpRecordsAndEnums:
            return language == .russian ? "8. Records, init-only Свойства и Enums [Flags]" : "8. Records, Init-only & Enums [Flags]"
            
        // C# Collections & LINQ
        case .csharpGenerics:
            return language == .russian ? "9. Дженерики и Constraints (where T)" : "9. Generics & Constraints (where T)"
        case .csharpCollections:
            return language == .russian ? "10. Коллекции List<T>, Dict, HashSet и Queue" : "10. Collections List<T>, Dict, HashSet & Queue"
        case .csharpDelegatesEvents:
            return language == .russian ? "11. Делегаты, Func, Action, Лямбды и События" : "11. Delegates, Func/Action, Lambdas & Events"
        case .csharpLINQ:
            return language == .russian ? "12. LINQ: Where, Select, GroupBy, Join и Yield" : "12. LINQ: Where, Select, GroupBy, Join & Yield"
            
        // C# Systems & Concurrency
        case .csharpExceptions:
            return language == .russian ? "13. Исключения, Exception Filters when и IDisposable" : "13. Exceptions, Filters (when) & IDisposable"
        case .csharpAsyncAwait:
            return language == .russian ? "14. Асинхронность: Task, ValueTask и async/await" : "14. Async: Task, ValueTask & async/await"
        case .csharpTPLThreading:
            return language == .russian ? "15. Multithreading, lock, SemaphoreSlim и Parallel" : "15. Multithreading, Lock, Semaphore & Parallel"
        case .csharpModern:
            return language == .russian ? "16. Dependency Injection, Reflection и GC" : "16. Dependency Injection, Reflection & GC"
            
        // SQL Core
        case .sqlBasics:
            return language == .russian ? "1. Основы SQL и выборка SELECT" : "1. SQL Basics & SELECT"
        case .sqlFiltering:
            return language == .russian ? "2. Фильтрация WHERE и Сортировка" : "2. Filtering & Sorting"
        case .sqlAggregations:
            return language == .russian ? "3. Агрегатные функции и GROUP BY" : "3. Aggregations & GROUP BY"
            
        // SQL Advanced
        case .sqlJoins:
            return language == .russian ? "4. Объединение таблиц JOIN" : "4. Table Joins (INNER, LEFT, RIGHT)"
        case .sqlDdlDml:
            return language == .russian ? "5. DDL и DML: Создание и Модификация" : "5. DDL & DML Operations"
        case .sqlWindow:
            return language == .russian ? "6. Оконные функции и Аналитика" : "6. Window Functions & Analytics"
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
        case .pythonControlFlow: return "arrow.triangle.branch"
        case .pythonCollections: return "list.bullet.rectangle"
        case .pythonFunctions: return "function"
        case .pythonOOP: return "cube.transparent"
        case .pythonDunder: return "sparkles"
        case .pythonMetaprogramming: return "gearshape.2"
        case .pythonAdvancedCollections: return "shippingbox"
        case .pythonGenerators: return "arrow.triangle.2.circlepath"
        case .pythonDecorators: return "slider.horizontal.3"
        case .pythonIOAndFiles: return "doc.text"
        case .pythonExceptions: return "exclamationmark.triangle"
        case .pythonAsync: return "bolt.badge.clock"
        case .pythonConcurrency: return "cpu"
        case .pythonTestingAndPerf: return "speedometer"
            
        // C#
        case .csharpBasics: return "curlybraces"
        case .csharpTypes: return "square.2.layers.3d"
        case .csharpControlFlow: return "arrow.triangle.branch"
        case .csharpStringsAndSpans: return "text.quote"
        case .csharpOOP: return "shippingbox"
        case .csharpInheritance: return "arrow.triangle.merge"
        case .csharpInterfaces: return "shield.lefthalf.filled"
        case .csharpRecordsAndEnums: return "cube.transparent"
        case .csharpGenerics: return "chevron.left.forwardslash.chevron.right"
        case .csharpCollections: return "square.stack.3d.up"
        case .csharpDelegatesEvents: return "bolt.horizontal"
        case .csharpLINQ: return "line.3.horizontal.decrease.circle"
        case .csharpExceptions: return "exclamationmark.triangle"
        case .csharpAsyncAwait: return "bolt.badge.clock"
        case .csharpTPLThreading: return "cpu"
        case .csharpModern: return "gearshape.2"
            
        // SQL
        case .sqlBasics: return "cylinder.split.1x2"
        case .sqlFiltering: return "line.3.horizontal.decrease.circle"
        case .sqlAggregations: return "function"
        case .sqlJoins: return "link"
        case .sqlDdlDml: return "plus.square.on.square"
        case .sqlWindow: return "chart.bar.xaxis"
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
