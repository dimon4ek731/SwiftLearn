import Foundation

public struct LessonTestExecutionResult: Identifiable {
    public let id = UUID()
    public let testCase: TaskTestCase
    public let passed: Bool
    public let message: String
    
    public init(testCase: TaskTestCase, passed: Bool, message: String) {
        self.testCase = testCase
        self.passed = passed
        self.message = message
    }
}

public final class LessonPracticeStore {
    public static let shared = LessonPracticeStore()
    
    private var customChallenges: [String: LessonPracticeChallenge] = [:]
    
    public init() {
        populateChallenges()
    }
    
    public func challenge(for lesson: Lesson) -> LessonPracticeChallenge {
        if let direct = lesson.practiceChallenge {
            return direct
        }
        if let found = customChallenges[lesson.id] {
            return found
        }
        // Fallback guaranteed challenge
        return fallbackChallenge(for: lesson)
    }
    
    public func dynamicStressTestCases(for challenge: LessonPracticeChallenge) -> [TaskTestCase] {
        switch challenge.id {
        case "practice_basics_var_let_types":
            let randomYear = Int.random(in: 1980...2022)
            let randomName = ["Elena", "Dmitry", "Sergey", "Marina", "Victor"].randomElement()!
            let expectedAge = 2026 - randomYear
            return [
                TaskTestCase(
                    title: "Динамический стресс-тест (защита от хардкода)",
                    inputDescription: "computeStats(\"\(randomName)\", \(randomYear), 2026)",
                    expectedOutput: "(\"\(randomName)\", \(expectedAge))",
                    validationCode: "computeStats(name: \"\(randomName)\", birthYear: \(randomYear), currentYear: 2026) == (\"\(randomName)\", \(expectedAge))"
                )
            ]
            
        case "practice_basics_operators_ranges":
            let rVal = Int.random(in: -10...30)
            let isInside = (1...10).contains(rVal)
            return [
                TaskTestCase(
                    title: "Динамический стресс-тест (защита от хардкода)",
                    inputDescription: "isInRange(\(rVal), min: 1, max: 10)",
                    expectedOutput: "\(isInside)",
                    validationCode: "isInRange(\(rVal), min: 1, max: 10) == \(isInside)"
                )
            ]
            
        case "practice_basics_tuples_alias":
            let rCode = [100, 200, 201, 204, 301, 400, 404, 500].randomElement()!
            let isSuccess = (200...299).contains(rCode)
            return [
                TaskTestCase(
                    title: "Динамический стресс-тест (защита от хардкода)",
                    inputDescription: "createHTTPResponse(code: \(rCode), message: \"LiveTest\")",
                    expectedOutput: "(\(rCode), \"LiveTest\", \(isSuccess))",
                    validationCode: "createHTTPResponse(code: \(rCode), message: \"LiveTest\") == (\(rCode), \"LiveTest\", \(isSuccess))"
                )
            ]
            
        case "practice_control_loops_flow":
            let rN = [8, 10, 12].randomElement()!
            var expected = 0
            for i in stride(from: 2, through: rN, by: 2) { expected += i * i }
            return [
                TaskTestCase(
                    title: "Динамический стресс-тест (защита от хардкода)",
                    inputDescription: "sumEvenSquares(upTo: \(rN))",
                    expectedOutput: "\(expected)",
                    validationCode: "sumEvenSquares(upTo: \(rN)) == \(expected)"
                )
            ]
            
        default:
            return []
        }
    }
    
    private func populateChallenges() {
        // 1. basics_var_let_types
        customChallenges["basics_var_let_types"] = LessonPracticeChallenge(
            id: "practice_basics_var_let_types",
            titleRU: "Практика: Константы, Переменные и Вывод",
            titleEN: "Practice: Variables & Constants",
            taskPromptRU: "Напишите функцию `computeStats(name: String, birthYear: Int, currentYear: Int) -> (name: String, age: Int)`, возвращающую кортеж с именем и вычисленным возрастом.",
            taskPromptEN: "Implement `computeStats(name: String, birthYear: Int, currentYear: Int) -> (name: String, age: Int)`.",
            starterCode: ##"""
func computeStats(name: String, birthYear: Int, currentYear: Int) -> (name: String, age: Int) {
    // Ваша реализация
    return (name, 0)
}
"""##,
            solutionCode: ##"""
func computeStats(name: String, birthYear: Int, currentYear: Int) -> (name: String, age: Int) {
    let age = currentYear - birthYear
    return (name, age)
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "computeStats(\"Alice\", 2000, 2026)", expectedOutput: "(\"Alice\", 26)", validationCode: "computeStats(name: \"Alice\", birthYear: 2000, currentYear: 2026) == (\"Alice\", 26)"),
                TaskTestCase(title: "Тест 2", inputDescription: "computeStats(\"Bob\", 1995, 2026)", expectedOutput: "(\"Bob\", 31)", validationCode: "computeStats(name: \"Bob\", birthYear: 1995, currentYear: 2026) == (\"Bob\", 31)")
            ],
            hintsRU: ["Используйте let age = currentYear - birthYear", "Верните кортеж (name, age)"],
            hintsEN: ["Use let age = currentYear - birthYear"]
        )
        
        // 2. basics_operators_ranges
        customChallenges["basics_operators_ranges"] = LessonPracticeChallenge(
            id: "practice_basics_operators_ranges",
            titleRU: "Практика: Операторы диапазонов",
            titleEN: "Practice: Range Operators",
            taskPromptRU: "Напишите функцию `isInRange(_ value: Int, min: Int, max: Int) -> Bool`, проверяющую попадание в закрытый диапазон min...max.",
            taskPromptEN: "Implement `isInRange(_ value: Int, min: Int, max: Int) -> Bool` using closed range.",
            starterCode: ##"""
func isInRange(_ value: Int, min: Int, max: Int) -> Bool {
    return false
}
"""##,
            solutionCode: ##"""
func isInRange(_ value: Int, min: Int, max: Int) -> Bool {
    return (min...max).contains(value)
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "isInRange(5, min: 1, max: 10)", expectedOutput: "true", validationCode: "isInRange(5, min: 1, max: 10) == true"),
                TaskTestCase(title: "Тест 2", inputDescription: "isInRange(15, min: 1, max: 10)", expectedOutput: "false", validationCode: "isInRange(15, min: 1, max: 10) == false"),
                TaskTestCase(title: "Тест 3", inputDescription: "isInRange(10, min: 1, max: 10)", expectedOutput: "true", validationCode: "isInRange(10, min: 1, max: 10) == true")
            ],
            hintsRU: ["Используйте (min...max).contains(value)"],
            hintsEN: ["Use (min...max).contains(value)"]
        )
        
        // 3. basics_tuples_alias
        customChallenges["basics_tuples_alias"] = LessonPracticeChallenge(
            id: "practice_basics_tuples_alias",
            titleRU: "Практика: Кортежи и Typealias",
            titleEN: "Practice: Tuples and Typealias",
            taskPromptRU: "Создайте функцию `createHTTPResponse(code: Int, message: String) -> (statusCode: Int, statusMessage: String, isSuccess: Bool)`, где isSuccess равен true для кодов от 200 до 299.",
            taskPromptEN: "Create function `createHTTPResponse` returning named tuple with isSuccess.",
            starterCode: ##"""
func createHTTPResponse(code: Int, message: String) -> (statusCode: Int, statusMessage: String, isSuccess: Bool) {
    return (code, message, false)
}
"""##,
            solutionCode: ##"""
func createHTTPResponse(code: Int, message: String) -> (statusCode: Int, statusMessage: String, isSuccess: Bool) {
    let success = (200...299).contains(code)
    return (statusCode: code, statusMessage: message, isSuccess: success)
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "createHTTPResponse(code: 200, message: \"OK\")", expectedOutput: "isSuccess: true", validationCode: "createHTTPResponse(code: 200, message: \"OK\").isSuccess == true"),
                TaskTestCase(title: "Тест 2", inputDescription: "createHTTPResponse(code: 404, message: \"Not Found\")", expectedOutput: "isSuccess: false", validationCode: "createHTTPResponse(code: 404, message: \"Not Found\").isSuccess == false")
            ],
            hintsRU: ["Проверьте (200...299).contains(code)"],
            hintsEN: ["Check range 200...299"]
        )
        
        // 4. control_optionals
        customChallenges["control_optionals"] = LessonPracticeChallenge(
            id: "practice_control_optionals",
            titleRU: "Практика: Безопасное развертывание Optionals",
            titleEN: "Practice: Safe Optional Unwrapping",
            taskPromptRU: "Напишите функцию `safeParseScore(rawInput: String?, fallback: Int) -> Int`. Если ввод nil или не может быть преобразован в Int — верните fallback.",
            taskPromptEN: "Implement `safeParseScore(rawInput: String?, fallback: Int) -> Int` using guard let.",
            starterCode: ##"""
func safeParseScore(rawInput: String?, fallback: Int) -> Int {
    return fallback
}
"""##,
            solutionCode: ##"""
func safeParseScore(rawInput: String?, fallback: Int) -> Int {
    guard let rawInput, let parsed = Int(rawInput) else {
        return fallback
    }
    return parsed
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "safeParseScore(\"42\", 0)", expectedOutput: "42", validationCode: "safeParseScore(rawInput: \"42\", fallback: 0) == 42"),
                TaskTestCase(title: "Тест 2", inputDescription: "safeParseScore(nil, 10)", expectedOutput: "10", validationCode: "safeParseScore(rawInput: nil, fallback: 10) == 10"),
                TaskTestCase(title: "Тест 3", inputDescription: "safeParseScore(\"invalid\", -1)", expectedOutput: "-1", validationCode: "safeParseScore(rawInput: \"invalid\", fallback: -1) == -1")
            ],
            hintsRU: ["Используйте guard let rawInput, let parsed = Int(rawInput) else { return fallback }"],
            hintsEN: ["Use guard let with chained optional bindings"]
        )
        
        // 5. control_loops_flow
        customChallenges["control_loops_flow"] = LessonPracticeChallenge(
            id: "practice_control_loops_flow",
            titleRU: "Практика: Циклы и фильтрация",
            titleEN: "Practice: Loops and Control Flow",
            taskPromptRU: "Напишите функцию `sumEvenSquares(upTo n: Int) -> Int`, которая суммирует квадраты всех четных чисел от 2 до n включительно.",
            taskPromptEN: "Calculate sum of squares of all even integers up to n.",
            starterCode: ##"""
func sumEvenSquares(upTo n: Int) -> Int {
    return 0
}
"""##,
            solutionCode: ##"""
func sumEvenSquares(upTo n: Int) -> Int {
    var sum = 0
    for i in stride(from: 2, through: n, by: 2) {
        sum += i * i
    }
    return sum
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "sumEvenSquares(upTo: 4)", expectedOutput: "20", validationCode: "sumEvenSquares(upTo: 4) == 20"),
                TaskTestCase(title: "Тест 2", inputDescription: "sumEvenSquares(upTo: 6)", expectedOutput: "56", validationCode: "sumEvenSquares(upTo: 6) == 56")
            ],
            hintsRU: ["Используйте stride(from: 2, through: n, by: 2) или if i % 2 == 0"],
            hintsEN: ["Iterate through evens and accumulate i * i"]
        )
        
        // 6. control_switch_pattern
        customChallenges["control_switch_pattern"] = LessonPracticeChallenge(
            id: "practice_control_switch_pattern",
            titleRU: "Практика: Pattern Matching и Switch",
            titleEN: "Practice: Pattern Matching & Switch",
            taskPromptRU: "Напишите функцию `classifyHTTP(_ code: Int) -> String`: для 200...299 верните 'Success', для 400...499 — 'Client Error', для 500...599 — 'Server Error', иначе — 'Other'.",
            taskPromptEN: "Classify HTTP status codes using switch statement.",
            starterCode: ##"""
func classifyHTTP(_ code: Int) -> String {
    return ""
}
"""##,
            solutionCode: ##"""
func classifyHTTP(_ code: Int) -> String {
    switch code {
    case 200...299: return "Success"
    case 400...499: return "Client Error"
    case 500...599: return "Server Error"
    default: return "Other"
    }
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "classifyHTTP(200)", expectedOutput: "\"Success\"", validationCode: "classifyHTTP(200) == \"Success\""),
                TaskTestCase(title: "Тест 2", inputDescription: "classifyHTTP(404)", expectedOutput: "\"Client Error\"", validationCode: "classifyHTTP(404) == \"Client Error\""),
                TaskTestCase(title: "Тест 3", inputDescription: "classifyHTTP(503)", expectedOutput: "\"Server Error\"", validationCode: "classifyHTTP(503) == \"Server Error\"")
            ],
            hintsRU: ["Используйте диапазоны case 200...299 в switch"],
            hintsEN: ["Use ranges in switch cases"]
        )
        
        // 7. collections_arrays_slices
        customChallenges["collections_arrays_slices"] = LessonPracticeChallenge(
            id: "practice_collections_arrays_slices",
            titleRU: "Практика: Срезы массивов ArraySlice",
            titleEN: "Practice: Array Slices",
            taskPromptRU: "Напишите функцию `middleElements(_ nums: [Int]) -> [Int]`, которая возвращает новый массив без первого и последнего элементов. Если элементов <= 2, верните пустой массив.",
            taskPromptEN: "Return all elements excluding the first and last.",
            starterCode: ##"""
func middleElements(_ nums: [Int]) -> [Int] {
    return []
}
"""##,
            solutionCode: ##"""
func middleElements(_ nums: [Int]) -> [Int] {
    guard nums.count > 2 else { return [] }
    return Array(nums.dropFirst().dropLast())
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "middleElements([10, 20, 30, 40])", expectedOutput: "[20, 30]", validationCode: "middleElements([10, 20, 30, 40]) == [20, 30]"),
                TaskTestCase(title: "Тест 2", inputDescription: "middleElements([1, 2])", expectedOutput: "[]", validationCode: "middleElements([1, 2]) == []")
            ],
            hintsRU: ["Используйте nums.dropFirst().dropLast() и преобразуйте к Array"],
            hintsEN: ["Use dropFirst and dropLast"]
        )
        
        // 8. collections_dict_sets
        customChallenges["collections_dict_sets"] = LessonPracticeChallenge(
            id: "practice_collections_dict_sets",
            titleRU: "Практика: Словари и Множества",
            titleEN: "Practice: Dictionaries & Sets",
            taskPromptRU: "Напишите функцию `uniqueWordCount(_ words: [String]) -> Int`, возвращающую количество уникальных слов без учета регистра.",
            taskPromptEN: "Count case-insensitive unique words using Set.",
            starterCode: ##"""
func uniqueWordCount(_ words: [String]) -> Int {
    return 0
}
"""##,
            solutionCode: ##"""
func uniqueWordCount(_ words: [String]) -> Int {
    let lower = words.map { $0.lowercased() }
    return Set(lower).count
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "uniqueWordCount([\"Swift\", \"swift\", \"iOS\"])", expectedOutput: "2", validationCode: "uniqueWordCount([\"Swift\", \"swift\", \"iOS\"]) == 2"),
                TaskTestCase(title: "Тест 2", inputDescription: "uniqueWordCount([\"a\", \"b\", \"c\"])", expectedOutput: "3", validationCode: "uniqueWordCount([\"a\", \"b\", \"c\"]) == 3")
            ],
            hintsRU: ["Приведите все слова к lowercased() и оберните в Set"],
            hintsEN: ["Map to lowercased and count Set elements"]
        )
        
        // 9. collections_higher_order
        customChallenges["collections_higher_order"] = LessonPracticeChallenge(
            id: "practice_collections_higher_order",
            titleRU: "Практика: Функции высшего порядка (map/filter/reduce)",
            titleEN: "Practice: Higher Order Functions",
            taskPromptRU: "Напишите функцию `sumOfPositiveDoubles(_ nums: [Int]) -> Int`: отфильтруйте числа > 0, удвойте каждое и сложите результат через reduce.",
            taskPromptEN: "Filter numbers > 0, double each, and calculate sum using reduce.",
            starterCode: ##"""
func sumOfPositiveDoubles(_ nums: [Int]) -> Int {
    return 0
}
"""##,
            solutionCode: ##"""
func sumOfPositiveDoubles(_ nums: [Int]) -> Int {
    return nums
        .filter { $0 > 0 }
        .map { $0 * 2 }
        .reduce(0, +)
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "sumOfPositiveDoubles([-2, 3, 5])", expectedOutput: "16", validationCode: "sumOfPositiveDoubles([-2, 3, 5]) == 16"),
                TaskTestCase(title: "Тест 2", inputDescription: "sumOfPositiveDoubles([-1, -4])", expectedOutput: "0", validationCode: "sumOfPositiveDoubles([-1, -4]) == 0")
            ],
            hintsRU: ["Соедините цепочку: .filter { $0 > 0 }.map { $0 * 2 }.reduce(0, +)"],
            hintsEN: ["Chain filter, map, and reduce"]
        )
        
        // 10. closures_syntax_capture
        customChallenges["closures_syntax_capture"] = LessonPracticeChallenge(
            id: "practice_closures_syntax_capture",
            titleRU: "Практика: Захват значений в замыканиях",
            titleEN: "Practice: Closure Value Capture",
            taskPromptRU: "Напишите фабрику счетчика `makeCounter(start: Int, step: Int) -> () -> Int`, которая возвращает функцию, увеличивающую счетчик на step при каждом вызове.",
            taskPromptEN: "Create counter factory `makeCounter` with step.",
            starterCode: ##"""
func makeCounter(start: Int, step: Int) -> () -> Int {
    return { 0 }
}
"""##,
            solutionCode: ##"""
func makeCounter(start: Int, step: Int) -> () -> Int {
    var current = start
    return {
        current += step
        return current
    }
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "счетчик с шагом 3", expectedOutput: "3 затем 6", validationCode: "({ let c = makeCounter(start: 0, step: 3); return c() == 3 && c() == 6 })()")
            ],
            hintsRU: ["Объявите var current = start внутри функции до возврата замыкания"],
            hintsEN: ["Declare captured var current before returning closure"]
        )
        
        // 11. types_structs_value
        customChallenges["types_structs_value"] = LessonPracticeChallenge(
            id: "practice_types_structs_value",
            titleRU: "Практика: Структуры и Value Semantics",
            titleEN: "Practice: Structs & Value Semantics",
            taskPromptRU: "Создайте структуру `Rectangle` со свойствами `width: Double`, `height: Double` и методом `area() -> Double`. Добавьте mutating метод `scale(by factor: Double)`.",
            taskPromptEN: "Create Rectangle struct with area() and mutating scale(by:).",
            starterCode: ##"""
struct Rectangle {
    var width: Double
    var height: Double
    
    func area() -> Double { return 0 }
    mutating func scale(by factor: Double) {}
}
"""##,
            solutionCode: ##"""
struct Rectangle {
    var width: Double
    var height: Double
    
    func area() -> Double {
        return width * height
    }
    
    mutating func scale(by factor: Double) {
        width *= factor
        height *= factor
    }
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "Rectangle(4, 5).area()", expectedOutput: "20.0", validationCode: "Rectangle(width: 4, height: 5).area() == 20.0"),
                TaskTestCase(title: "Тест 2", inputDescription: "scale(by: 2).area()", expectedOutput: "80.0", validationCode: "({ var r = Rectangle(width: 4, height: 5); r.scale(by: 2); return r.area() == 80.0 })()")
            ],
            hintsRU: ["Не забудьте ключевое слово mutating перед методом scale"],
            hintsEN: ["Use mutating keyword for scale method"]
        )
        
        // 12. pop_protocols_composition
        customChallenges["pop_protocols_composition"] = LessonPracticeChallenge(
            id: "practice_pop_protocols_composition",
            titleRU: "Практика: Протоколы и композиция",
            titleEN: "Practice: Protocols & Composition",
            taskPromptRU: "Объявите протокол `Describable` с требованием `var summary: String { get }`. Создайте структуру `UserProfile: Describable` с полями name и role, возвращающую summary в формате 'Name (Role)'.",
            taskPromptEN: "Create Describable protocol and UserProfile conforming to it.",
            starterCode: ##"""
protocol Describable {
    var summary: String { get }
}

struct UserProfile: Describable {
    let name: String
    let role: String
    var summary: String { return "" }
}
"""##,
            solutionCode: ##"""
protocol Describable {
    var summary: String { get }
}

struct UserProfile: Describable {
    let name: String
    let role: String
    var summary: String {
        return "\(name) (\(role))"
    }
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "UserProfile(\"Alex\", \"Lead\").summary", expectedOutput: "\"Alex (Lead)\"", validationCode: "UserProfile(name: \"Alex\", role: \"Lead\").summary == \"Alex (Lead)\"")
            ],
            hintsRU: ["Верните строку \"\\(name) (\\(role))\""],
            hintsEN: ["Format string with name and role"]
        )
        
        // 13. generics_types_constraints
        customChallenges["generics_types_constraints"] = LessonPracticeChallenge(
            id: "practice_generics_types_constraints",
            titleRU: "Практика: Универсальные типы (Generics)",
            titleEN: "Practice: Generics",
            taskPromptRU: "Напишите дженерик-структуру `Box<T>` со свойством `item: T` и методом `transform<U>(_ closure: (T) -> U) -> Box<U>`.",
            taskPromptEN: "Create generic Box<T> struct with transform method.",
            starterCode: ##"""
struct Box<T> {
    let item: T
    func transform<U>(_ closure: (T) -> U) -> Box<U> {
        return Box<U>(item: closure(item))
    }
}
"""##,
            solutionCode: ##"""
struct Box<T> {
    let item: T
    func transform<U>(_ closure: (T) -> U) -> Box<U> {
        return Box<U>(item: closure(item))
    }
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "Box(21).transform { $0 * 2 }.item", expectedOutput: "42", validationCode: "Box(item: 21).transform { $0 * 2 }.item == 42")
            ],
            hintsRU: ["Инициализируйте Box<U>(item: closure(item))"],
            hintsEN: ["Return Box<U> with transformed item"]
        )
        
        // 14. error_handling_result
        customChallenges["error_handling_result"] = LessonPracticeChallenge(
            id: "practice_error_handling_result",
            titleRU: "Практика: Error Handling и Result",
            titleEN: "Practice: Error Handling",
            taskPromptRU: "Напишите функцию `divide(_ a: Double, by b: Double) -> Result<Double, String>`. Если b == 0, верните `.failure(\"Division by zero\")`, иначе `.success(a / b)`.",
            taskPromptEN: "Return Result type for division handling division by zero.",
            starterCode: ##"""
func divide(_ a: Double, by b: Double) -> Result<Double, String> {
    return .success(0)
}
"""##,
            solutionCode: ##"""
func divide(_ a: Double, by b: Double) -> Result<Double, String> {
    guard b != 0 else {
        return .failure("Division by zero")
    }
    return .success(a / b)
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "divide(10, by: 2)", expectedOutput: ".success(5.0)", validationCode: "divide(10, by: 2) == .success(5.0)"),
                TaskTestCase(title: "Тест 2", inputDescription: "divide(10, by: 0)", expectedOutput: ".failure(\"Division by zero\")", validationCode: "divide(10, by: 0) == .failure(\"Division by zero\")")
            ],
            hintsRU: ["Используйте guard b != 0 else { return .failure(...) }"],
            hintsEN: ["Guard b != 0"]
        )
        
        // 15. swiftui_state_observation_dataflow
        customChallenges["swiftui_state_observation_dataflow"] = LessonPracticeChallenge(
            id: "practice_swiftui_state_observation",
            titleRU: "Практика: Реактивное состояние модели",
            titleEN: "Practice: Reactive State Model",
            taskPromptRU: "Создайте класс `ScoreKeeper` с полем `score: Int` (изначально 0), методами `addPoints(_ pts: Int)` и `reset()`. Баллы не могут быть отрицательными.",
            taskPromptEN: "Implement ScoreKeeper class with positive score invariants.",
            starterCode: ##"""
class ScoreKeeper {
    var score: Int = 0
    func addPoints(_ pts: Int) {}
    func reset() {}
}
"""##,
            solutionCode: ##"""
class ScoreKeeper {
    var score: Int = 0
    func addPoints(_ pts: Int) {
        score = max(0, score + pts)
    }
    func reset() {
        score = 0
    }
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "ScoreKeeper addPoints(50)", expectedOutput: "50", validationCode: "({ let sk = ScoreKeeper(); sk.addPoints(50); return sk.score == 50 })()"),
                TaskTestCase(title: "Тест 2", inputDescription: "ScoreKeeper reset()", expectedOutput: "0", validationCode: "({ let sk = ScoreKeeper(); sk.addPoints(50); sk.reset(); return sk.score == 0 })()")
            ],
            hintsRU: ["Защитите счетчик через max(0, score + pts)"],
            hintsEN: ["Clamp score using max(0, ...)"]
        )

        // MARK: - Python Challenges
        
        customChallenges["py_syntax_pep8"] = LessonPracticeChallenge(
            id: "practice_py_syntax_pep8",
            language: .python,
            titleRU: "Практика: Приветствие пользователя",
            titleEN: "Practice: User Greeting",
            taskPromptRU: "Напишите функцию `format_greeting(name, year)`, возвращающую строку: `Привет, {name}! Твой год: {year}`.",
            taskPromptEN: "Implement `format_greeting(name, year)` returning `Привет, {name}! Твой год: {year}`.",
            starterCode: ##"""
def format_greeting(name, year):
    # Ваша реализация
    return ""
"""##,
            solutionCode: ##"""
def format_greeting(name, year):
    return f"Привет, {name}! Твой год: {year}"
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "format_greeting('Анна', 2026)", expectedOutput: "Привет, Анна! Твой год: 2026", validationCode: "format_greeting('Анна', 2026) == 'Привет, Анна! Твой год: 2026'"),
                TaskTestCase(title: "Тест 2", inputDescription: "format_greeting('Иван', 2000)", expectedOutput: "Привет, Иван! Твой год: 2000", validationCode: "format_greeting('Иван', 2000) == 'Привет, Иван! Твой год: 2000'")
            ],
            hintsRU: ["Используйте f-строку: `f'Привет, {name}! Твой год: {year}'`."],
            hintsEN: ["Use f-string formatting."]
        )

        customChallenges["py_numbers_math"] = LessonPracticeChallenge(
            id: "practice_py_numbers_math",
            language: .python,
            titleRU: "Практика: Расчет Гипотенузы",
            titleEN: "Practice: Hypotenuse Calculation",
            taskPromptRU: "Напишите функцию `calculate_hypotenuse(a, b)`, которая вычисляет длину гипотенузы прямоугольного треугольника с катетами a и b: `(a**2 + b**2)**0.5`.",
            taskPromptEN: "Implement `calculate_hypotenuse(a, b)` returning `(a**2 + b**2)**0.5`.",
            starterCode: ##"""
def calculate_hypotenuse(a, b):
    # Ваша реализация
    return 0.0
"""##,
            solutionCode: ##"""
def calculate_hypotenuse(a, b):
    return (a**2 + b**2) ** 0.5
"""##,
            testCases: [
                TaskTestCase(title: "Египетский треугольник", inputDescription: "calculate_hypotenuse(3, 4)", expectedOutput: "5.0", validationCode: "calculate_hypotenuse(3, 4) == 5.0"),
                TaskTestCase(title: "Катеты 6 и 8", inputDescription: "calculate_hypotenuse(6, 8)", expectedOutput: "10.0", validationCode: "calculate_hypotenuse(6, 8) == 10.0")
            ],
            hintsRU: ["Возведение в степень в Python: `** 2` и `** 0.5`."],
            hintsEN: ["Power operator in Python is `**`."]
        )

        customChallenges["py_strings_fstrings"] = LessonPracticeChallenge(
            id: "practice_py_strings_fstrings",
            language: .python,
            titleRU: "Практика: Разворот строки через срез",
            titleEN: "Practice: String Reversal",
            taskPromptRU: "Напишите функцию `reverse_string(text)`, которая возвращает развернутую задом наперед строку с помощью среза `[::-1]`.",
            taskPromptEN: "Implement `reverse_string(text)` returning the reversed string using `[::-1]`.",
            starterCode: ##"""
def reverse_string(text):
    # Ваша реализация
    return ""
"""##,
            solutionCode: ##"""
def reverse_string(text):
    return text[::-1]
"""##,
            testCases: [
                TaskTestCase(title: "Слово python", inputDescription: "reverse_string('python')", expectedOutput: "nohtyp", validationCode: "reverse_string('python') == 'nohtyp'"),
                TaskTestCase(title: "Палиндром", inputDescription: "reverse_string('radar')", expectedOutput: "radar", validationCode: "reverse_string('radar') == 'radar'")
            ],
            hintsRU: ["Используйте синтаксис среза: `text[::-1]`."],
            hintsEN: ["Use slice step: `text[::-1]`."]
        )

        customChallenges["py_comprehensions_power"] = LessonPracticeChallenge(
            id: "practice_py_comprehensions_power",
            language: .python,
            titleRU: "Практика: Квадраты четных чисел",
            titleEN: "Practice: Even Squares Comprehension",
            taskPromptRU: "Напишите функцию `get_even_squares(numbers)`, которая с помощью list comprehension возвращает список квадратов только четных чисел: `[x**2 for x in numbers if x % 2 == 0]`.",
            taskPromptEN: "Implement `get_even_squares(numbers)` returning squares of even integers.",
            starterCode: ##"""
def get_even_squares(numbers):
    # Ваша реализация
    return []
"""##,
            solutionCode: ##"""
def get_even_squares(numbers):
    return [x**2 for x in numbers if x % 2 == 0]
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1..6", inputDescription: "get_even_squares([1, 2, 3, 4, 5, 6])", expectedOutput: "[4, 16, 36]", validationCode: "get_even_squares([1, 2, 3, 4, 5, 6]) == [4, 16, 36]"),
                TaskTestCase(title: "Только нечетные", inputDescription: "get_even_squares([1, 3, 5])", expectedOutput: "[]", validationCode: "get_even_squares([1, 3, 5]) == []")
            ],
            hintsRU: ["Используйте `[x**2 for x in numbers if x % 2 == 0]`."],
            hintsEN: ["Use list comprehension with an if filter."]
        )

        customChallenges["py_basics_types"] = LessonPracticeChallenge(
            id: "practice_py_basics_types",
            language: .python,
            titleRU: "Практика: Арифметика и Типы в Python",
            titleEN: "Practice: Arithmetic & Types in Python",
            taskPromptRU: "Напишите функцию `compute_circle_area_approx(radius)`, которая вычисляет площадь круга по формуле `3.14159 * radius * radius` и возвращает результат.",
            taskPromptEN: "Implement `compute_circle_area_approx(radius)` returning `3.14159 * radius * radius`.",
            starterCode: ##"""
def compute_circle_area_approx(radius):
    # Ваша реализация
    return 0.0
"""##,
            solutionCode: ##"""
def compute_circle_area_approx(radius):
    return 3.14159 * radius * radius
"""##,
            testCases: [
                TaskTestCase(title: "Радиус 1", inputDescription: "compute_circle_area_approx(1)", expectedOutput: "3.14159", validationCode: "abs(compute_circle_area_approx(1) - 3.14159) < 0.001"),
                TaskTestCase(title: "Радиус 10", inputDescription: "compute_circle_area_approx(10)", expectedOutput: "314.159", validationCode: "abs(compute_circle_area_approx(10) - 314.159) < 0.01")
            ],
            hintsRU: ["Используйте оператор умножения `*`."],
            hintsEN: ["Use the multiplication operator `*`."]
        )

        customChallenges["py_collections_lists_dicts"] = LessonPracticeChallenge(
            id: "practice_py_collections_lists_dicts",
            language: .python,
            titleRU: "Практика: Списки и Подсчет",
            titleEN: "Practice: Lists & Counting",
            taskPromptRU: "Напишите функцию `sum_positive(numbers)`, которая возвращает сумму всех положительных чисел из переданного списка `numbers`.",
            taskPromptEN: "Implement `sum_positive(numbers)` returning the sum of positive integers.",
            starterCode: ##"""
def sum_positive(numbers):
    # Ваша реализация
    return 0
"""##,
            solutionCode: ##"""
def sum_positive(numbers):
    total = 0
    for x in numbers:
        if x > 0:
            total += x
    return total
"""##,
            testCases: [
                TaskTestCase(title: "Смешанный список", inputDescription: "sum_positive([-2, 5, 10, -1])", expectedOutput: "15", validationCode: "sum_positive([-2, 5, 10, -1]) == 15"),
                TaskTestCase(title: "Только отрицательные", inputDescription: "sum_positive([-1, -2, -3])", expectedOutput: "0", validationCode: "sum_positive([-1, -2, -3]) == 0")
            ],
            hintsRU: ["Используйте цикл `for x in numbers:` и проверяйте `if x > 0`."],
            hintsEN: ["Iterate through numbers and check `if x > 0`."]
        )

        // MARK: - C# Challenges
        customChallenges["cs_basics_types"] = LessonPracticeChallenge(
            id: "practice_cs_basics_types",
            language: .csharp,
            titleRU: "Практика: Вычисления в C#",
            titleEN: "Practice: C# Computations",
            taskPromptRU: "Реализуйте метод `ConvertCelsiusToFahrenheit(double c)`, возвращающий температуру в градусах Фаренгейта по формуле `(c * 9.0 / 5.0) + 32.0`.",
            taskPromptEN: "Implement `ConvertCelsiusToFahrenheit(double c)` returning `(c * 9.0 / 5.0) + 32.0`.",
            starterCode: ##"""
public static double ConvertCelsiusToFahrenheit(double c) {
    // Ваша реализация
    return 0.0;
}
"""##,
            solutionCode: ##"""
public static double ConvertCelsiusToFahrenheit(double c) {
    return (c * 9.0 / 5.0) + 32.0;
}
"""##,
            testCases: [
                TaskTestCase(title: "0 градусов Цельсия", inputDescription: "ConvertCelsiusToFahrenheit(0.0)", expectedOutput: "32.0", validationCode: "ConvertCelsiusToFahrenheit(0.0) == 32.0"),
                TaskTestCase(title: "100 градусов Цельсия", inputDescription: "ConvertCelsiusToFahrenheit(100.0)", expectedOutput: "212.0", validationCode: "ConvertCelsiusToFahrenheit(100.0) == 212.0")
            ],
            hintsRU: ["Используйте `(c * 9.0 / 5.0) + 32.0`."],
            hintsEN: ["Use `(c * 9.0 / 5.0) + 32.0`."]
        )

        customChallenges["cs_linq_queries"] = LessonPracticeChallenge(
            id: "practice_cs_linq_queries",
            language: .csharp,
            titleRU: "Практика: Фильтрация в C#",
            titleEN: "Practice: C# Filtering",
            taskPromptRU: "Реализуйте метод `SumEvens(int a, int b, int c)`, который суммирует только четные числа из трех переданных аргументов.",
            taskPromptEN: "Implement `SumEvens(int a, int b, int c)` summing only even numbers.",
            starterCode: ##"""
public static int SumEvens(int a, int b, int c) {
    // Ваша реализация
    return 0;
}
"""##,
            solutionCode: ##"""
public static int SumEvens(int a, int b, int c) {
    int sum = 0;
    if (a % 2 == 0) sum += a;
    if (b % 2 == 0) sum += b;
    if (c % 2 == 0) sum += c;
    return sum;
}
"""##,
            testCases: [
                TaskTestCase(title: "Тест 1", inputDescription: "SumEvens(2, 3, 4)", expectedOutput: "6", validationCode: "SumEvens(2, 3, 4) == 6"),
                TaskTestCase(title: "Тест 2", inputDescription: "SumEvens(1, 3, 5)", expectedOutput: "0", validationCode: "SumEvens(1, 3, 5) == 0")
            ],
            hintsRU: ["Проверяйте делимость на 2: `x % 2 == 0`."],
            hintsEN: ["Check remainder: `x % 2 == 0`."]
        )

        // MARK: - SQL Challenges
        customChallenges["sql_basics_select"] = LessonPracticeChallenge(
            id: "practice_sql_basics_select",
            language: .sql,
            titleRU: "Практика: Запрос SELECT",
            titleEN: "Practice: SELECT Statement",
            taskPromptRU: "Напишите SQL-запрос, который выбирает столбцы `title` и `price` из таблицы `books`.",
            taskPromptEN: "Write a SQL query selecting `title` and `price` from table `books`.",
            starterCode: ##"""
-- Напишите ваш SQL-запрос
SELECT 
"""##,
            solutionCode: ##"""
SELECT title, price FROM books;
"""##,
            testCases: [
                TaskTestCase(
                    title: "Выборка книг",
                    inputDescription: "SELECT title, price FROM books",
                    expectedOutput: "| Swift Guide | 45 |",
                    validationCode: "CREATE TABLE books (id INT, title TEXT, price INT); INSERT INTO books VALUES (1, 'Swift Guide', 45), (2, 'SQL Handbook', 30);"
                )
            ],
            hintsRU: ["Используйте синтаксис: `SELECT title, price FROM books;`."],
            hintsEN: ["Use syntax: `SELECT title, price FROM books;`."]
        )

        customChallenges["sql_filtering_where"] = LessonPracticeChallenge(
            id: "practice_sql_filtering_where",
            language: .sql,
            titleRU: "Практика: Фильтрация WHERE",
            titleEN: "Practice: WHERE Filtering",
            taskPromptRU: "Выберите имя (`name`) и город (`city`) пользователей из таблицы `users`, которые проживают в городе `'Moscow'`.",
            taskPromptEN: "Select `name` and `city` from `users` WHERE `city = 'Moscow'`.",
            starterCode: ##"""
-- Напишите запрос с фильтром WHERE
SELECT 
"""##,
            solutionCode: ##"""
SELECT name, city FROM users WHERE city = 'Moscow';
"""##,
            testCases: [
                TaskTestCase(
                    title: "Пользователи из Москвы",
                    inputDescription: "SELECT name, city FROM users WHERE city = 'Moscow'",
                    expectedOutput: "| Ivan | Moscow |",
                    validationCode: "CREATE TABLE users (id INT, name TEXT, city TEXT); INSERT INTO users VALUES (1, 'Ivan', 'Moscow'), (2, 'John', 'London');"
                )
            ],
            hintsRU: ["Добавьте условие: `WHERE city = 'Moscow'`."],
            hintsEN: ["Add clause: `WHERE city = 'Moscow'`."]
        )

        customChallenges["sql_aggregations_group"] = LessonPracticeChallenge(
            id: "practice_sql_aggregations_group",
            language: .sql,
            titleRU: "Практика: GROUP BY и Агрегация",
            titleEN: "Practice: GROUP BY & Aggregation",
            taskPromptRU: "Напишите запрос, возвращающий `department`, количество сотрудников `COUNT(*)` и среднюю зарплату `AVG(salary)` из таблицы `staff`, сгруппировав по отделу (`GROUP BY department`).",
            taskPromptEN: "Return `department`, `COUNT(*)`, and `AVG(salary)` grouped by `department` from `staff`.",
            starterCode: ##"""
-- Напишите агрегатный запрос с GROUP BY
SELECT 
"""##,
            solutionCode: ##"""
SELECT department, COUNT(*), AVG(salary) FROM staff GROUP BY department;
"""##,
            testCases: [
                TaskTestCase(
                    title: "Агрегация отделов",
                    inputDescription: "SELECT department, COUNT(*), AVG(salary) FROM staff GROUP BY department",
                    expectedOutput: "| IT | 2 | 150.0 |",
                    validationCode: "CREATE TABLE staff (id INT, department TEXT, salary INT); INSERT INTO staff VALUES (1, 'IT', 100), (2, 'IT', 200), (3, 'HR', 80);"
                )
            ],
            hintsRU: ["Используйте `SELECT department, COUNT(*), AVG(salary) FROM staff GROUP BY department;`."],
            hintsEN: ["Use `SELECT department, COUNT(*), AVG(salary) FROM staff GROUP BY department;`."]
        )

        customChallenges["sql_joins_types"] = LessonPracticeChallenge(
            id: "practice_sql_joins_types",
            language: .sql,
            titleRU: "Практика: INNER JOIN",
            titleEN: "Practice: INNER JOIN",
            taskPromptRU: "Объедините таблицу `students` с таблицей `courses` через `INNER JOIN` по условию `students.course_id = courses.id` и выберите имя студента (`students.name`) и название курса (`courses.title`).",
            taskPromptEN: "Join `students` with `courses` ON `students.course_id = courses.id`, selecting `students.name, courses.title`.",
            starterCode: ##"""
-- Напишите запрос с INNER JOIN
SELECT 
"""##,
            solutionCode: ##"""
SELECT students.name, courses.title FROM students INNER JOIN courses ON students.course_id = courses.id;
"""##,
            testCases: [
                TaskTestCase(
                    title: "Связка студенты и курсы",
                    inputDescription: "SELECT students.name, courses.title FROM students INNER JOIN courses ON students.course_id = courses.id",
                    expectedOutput: "| Anna | CS101 |",
                    validationCode: "CREATE TABLE courses (id INT, title TEXT); INSERT INTO courses VALUES (1, 'CS101'); CREATE TABLE students (id INT, name TEXT, course_id INT); INSERT INTO students VALUES (1, 'Anna', 1);"
                )
            ],
            hintsRU: ["Используйте `FROM students INNER JOIN courses ON students.course_id = courses.id`."],
            hintsEN: ["Use `FROM students INNER JOIN courses ON students.course_id = courses.id`."]
        )

    }
    
    private func fallbackChallenge(for lesson: Lesson) -> LessonPracticeChallenge {
        // Generates an interactive tailored challenge based on lesson properties
        let titleRU = "Практическое задание: \(lesson.titleRU)"
        let titleEN = "Hands-on Practice: \(lesson.titleEN)"
        
        if lesson.category.language == .sql {
            return LessonPracticeChallenge(
                id: "practice_\(lesson.id)",
                language: .sql,
                titleRU: titleRU,
                titleEN: titleEN,
                taskPromptRU: "Напишите SQL-запрос, выбирающий `name` и `salary` из таблицы `employees` для сотрудников с зарплатой строго больше 50000.",
                taskPromptEN: "Write a SQL query selecting `name, salary` from `employees` WHERE `salary > 50000`.",
                starterCode: ##"""
-- Напишите ваш SQL-запрос
SELECT name, salary FROM employees WHERE salary > 50000;
"""##,
                solutionCode: ##"""
SELECT name, salary FROM employees WHERE salary > 50000;
"""##,
                testCases: [
                    TaskTestCase(
                        title: "Тест выборки",
                        inputDescription: "SELECT name, salary FROM employees WHERE salary > 50000",
                        expectedOutput: "| Dmitry | 80000 |",
                        validationCode: "CREATE TABLE employees (id INT, name TEXT, salary INT); INSERT INTO employees VALUES (1, 'Alice', 45000), (2, 'Dmitry', 80000);"
                    )
                ],
                hintsRU: ["Используйте фильтрацию WHERE salary > 50000."],
                hintsEN: ["Use WHERE salary > 50000."]
            )
        } else if lesson.category.language == .python {
            return LessonPracticeChallenge(
                id: "practice_\(lesson.id)",
                language: .python,
                titleRU: titleRU,
                titleEN: titleEN,
                taskPromptRU: "Закрепите тему на практике: напишите функцию `compute_metrics(x, y)`, которая возвращает сумму произведений и разностей: `(x * y) + (x - y)`.",
                taskPromptEN: "Implement `compute_metrics(x, y)` returning `(x * y) + (x - y)`.",
                starterCode: ##"""
def compute_metrics(x, y):
    # Ваша реализация
    return 0
"""##,
                solutionCode: ##"""
def compute_metrics(x, y):
    return (x * y) + (x - y)
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "compute_metrics(4, 2)", expectedOutput: "10", validationCode: "compute_metrics(4, 2) == 10"),
                    TaskTestCase(title: "Тест 2", inputDescription: "compute_metrics(5, 3)", expectedOutput: "17", validationCode: "compute_metrics(5, 3) == 17")
                ],
                hintsRU: ["Используйте операторы `*`, `+` и `-`."],
                hintsEN: ["Use operators `*`, `+`, and `-`."]
            )
        } else if lesson.category.language == .csharp {
            return LessonPracticeChallenge(
                id: "practice_\(lesson.id)",
                language: .csharp,
                titleRU: titleRU,
                titleEN: titleEN,
                taskPromptRU: "Закрепите тему на практике: напишите статический метод `ComputeMetrics(int x, int y)`, возвращающий `(x * y) + (x - y)`.",
                taskPromptEN: "Implement `ComputeMetrics(int x, int y)` returning `(x * y) + (x - y)`.",
                starterCode: ##"""
public static int ComputeMetrics(int x, int y) {
    // Ваша реализация
    return 0;
}
"""##,
                solutionCode: ##"""
public static int ComputeMetrics(int x, int y) {
    return (x * y) + (x - y);
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "ComputeMetrics(4, 2)", expectedOutput: "10", validationCode: "ComputeMetrics(4, 2) == 10"),
                    TaskTestCase(title: "Тест 2", inputDescription: "ComputeMetrics(5, 3)", expectedOutput: "17", validationCode: "ComputeMetrics(5, 3) == 17")
                ],
                hintsRU: ["Используйте операторы `*`, `+` и `-`."],
                hintsEN: ["Use operators `*`, `+`, and `-`."]
            )
        }
        
        if lesson.category.track == .swiftUI {
            return LessonPracticeChallenge(
                id: "practice_\(lesson.id)",
                titleRU: titleRU,
                titleEN: titleEN,
                taskPromptRU: "Реализуйте вспомогательную функцию для интерфейса: напишите функцию `calculateLayoutMetrics(containerWidth: Double, spacing: Double, columns: Int) -> Double`, возвращающую ширину одного элемента сетки.",
                taskPromptEN: "Implement `calculateLayoutMetrics(containerWidth: Double, spacing: Double, columns: Int) -> Double`.",
                starterCode: ##"""
func calculateLayoutMetrics(containerWidth: Double, spacing: Double, columns: Int) -> Double {
    // Ваша реализация
    return 0.0
}
"""##,
                solutionCode: ##"""
func calculateLayoutMetrics(containerWidth: Double, spacing: Double, columns: Int) -> Double {
    guard columns > 0 else { return 0.0 }
    let totalSpacing = spacing * Double(columns - 1)
    let available = max(0.0, containerWidth - totalSpacing)
    return available / Double(columns)
}
"""##,
                testCases: [
                    TaskTestCase(
                        title: "Тест 1",
                        inputDescription: "calculateLayoutMetrics(containerWidth: 320, spacing: 10, columns: 3)",
                        expectedOutput: "100.0",
                        validationCode: "calculateLayoutMetrics(containerWidth: 320, spacing: 10, columns: 3) == 100.0"
                    ),
                    TaskTestCase(
                        title: "Тест 2",
                        inputDescription: "calculateLayoutMetrics(containerWidth: 200, spacing: 20, columns: 2)",
                        expectedOutput: "90.0",
                        validationCode: "calculateLayoutMetrics(containerWidth: 200, spacing: 20, columns: 2) == 90.0"
                    )
                ],
                hintsRU: ["Общий отступ равен spacing * Double(columns - 1). Вычтите его из containerWidth и разделите на columns."],
                hintsEN: ["Subtract total spacing from container width and divide by columns count."]
            )
        } else {
            return LessonPracticeChallenge(
                id: "practice_\(lesson.id)",
                titleRU: titleRU,
                titleEN: titleEN,
                taskPromptRU: "Закрепите тему на практике: напишите функцию `processDataStream(_ numbers: [Int]) -> (count: Int, sum: Int, max: Int)`, возвращающую количество элементов, их сумму и максимальный элемент (или 0 для пустого массива).",
                taskPromptEN: "Implement `processDataStream(_ numbers: [Int]) -> (count: Int, sum: Int, max: Int)`.",
                starterCode: ##"""
func processDataStream(_ numbers: [Int]) -> (count: Int, sum: Int, max: Int) {
    // Ваша реализация
    return (0, 0, 0)
}
"""##,
                solutionCode: ##"""
func processDataStream(_ numbers: [Int]) -> (count: Int, sum: Int, max: Int) {
    let count = numbers.count
    let sum = numbers.reduce(0, +)
    let maxVal = numbers.max() ?? 0
    return (count, sum, maxVal)
}
"""##,
                testCases: [
                    TaskTestCase(
                        title: "Тест 1",
                        inputDescription: "processDataStream([1, 4, 9])",
                        expectedOutput: "(3, 14, 9)",
                        validationCode: "processDataStream([1, 4, 9]) == (3, 14, 9)"
                    ),
                    TaskTestCase(
                        title: "Тест 2",
                        inputDescription: "processDataStream([])",
                        expectedOutput: "(0, 0, 0)",
                        validationCode: "processDataStream([]) == (0, 0, 0)"
                    )
                ],
                hintsRU: ["Используйте numbers.count, numbers.reduce(0, +) и numbers.max() ?? 0"],
                hintsEN: ["Use numbers.count, reduce, and max"]
            )
        }
    }
}
