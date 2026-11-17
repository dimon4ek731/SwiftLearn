import Foundation

public final class TaskStore {
    public static let shared = TaskStore()
    
    public let tasks: [CodingTask]
    
    private init() {
        self.tasks = [
            // Сумма двух чисел
            CodingTask(
                id: "easy_sum_two",
                titleRU: "Сумма двух чисел",
                titleEN: "Sum of Two Numbers",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Сложение двух целых чисел с соблюдением типов.",
                summaryEN: "Sum two integers.",
                descriptionRU: ##"""
### Условие
Напишите функцию `sum(_ a: Int, _ b: Int) -> Int`.
"""##,
                descriptionEN: ##"""
Implement `sum(_ a: Int, _ b: Int) -> Int`.
"""##,
                requirementsRU: ["Сигнатура func sum(_ a: Int, _ b: Int) -> Int"],
                requirementsEN: ["Signature func sum(_ a: Int, _ b: Int) -> Int"],
                starterCode: ##"""
func sum(_ a: Int, _ b: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "sum(3, 7)", expectedOutput: "10", validationCode: "sum(3, 7) == 10"),
                    TaskTestCase(title: "Тест 2", inputDescription: "sum(-5, 5)", expectedOutput: "0", validationCode: "sum(-5, 5) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "sum(-12, -8)", expectedOutput: "-20", validationCode: "sum(-12, -8) == -20")
                ],
                hintsRU: ["Используйте a + b"],
                hintsEN: ["Use a + b"],
                solutionCode: ##"""
func sum(_ a: Int, _ b: Int) -> Int {
    return a + b
}
"""##,
                xpReward: 25
            ),

            // Проверка на чётность
            CodingTask(
                id: "easy_is_even",
                titleRU: "Проверка на чётность",
                titleEN: "Check if Number is Even",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Определите, делится ли целое число на 2 без остатка.",
                summaryEN: "Determine if integer is even.",
                descriptionRU: ##"""
### Условие
Напишите функцию `isEven(_ n: Int) -> Bool`.
"""##,
                descriptionEN: ##"""
Implement `isEven(_ n: Int) -> Bool`.
"""##,
                requirementsRU: ["Оператор остатка % или .isMultiple(of:)"],
                requirementsEN: ["Use % or .isMultiple(of:)"],
                starterCode: ##"""
func isEven(_ n: Int) -> Bool {
    return false
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "isEven(4)", expectedOutput: "true", validationCode: "isEven(4) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "isEven(7)", expectedOutput: "false", validationCode: "isEven(7) == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "isEven(0)", expectedOutput: "true", validationCode: "isEven(0) == true")
                ],
                hintsRU: ["Проверьте n % 2 == 0"],
                hintsEN: ["Check n % 2 == 0"],
                solutionCode: ##"""
func isEven(_ n: Int) -> Bool {
    return n.isMultiple(of: 2)
}
"""##,
                xpReward: 25
            ),

            // Конвертер Цельсий -> Фаренгейт
            CodingTask(
                id: "easy_celsius_to_fahr",
                titleRU: "Конвертер Цельсий -> Фаренгейт",
                titleEN: "Celsius to Fahrenheit",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Формула: F = C * 9/5 + 32.",
                summaryEN: "Convert Celsius to Fahrenheit.",
                descriptionRU: ##"""
### Условие
Напишите функцию `celsiusToFahrenheit(_ c: Double) -> Double`.
"""##,
                descriptionEN: ##"""
Implement `celsiusToFahrenheit(_ c: Double) -> Double`.
"""##,
                requirementsRU: ["Double арифметика"],
                requirementsEN: ["Floating point math"],
                starterCode: ##"""
func celsiusToFahrenheit(_ c: Double) -> Double {
    return 0.0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "celsiusToFahrenheit(0)", expectedOutput: "32.0", validationCode: "abs(celsiusToFahrenheit(0) - 32.0) < 0.001"),
                    TaskTestCase(title: "Тест 2", inputDescription: "celsiusToFahrenheit(100)", expectedOutput: "212.0", validationCode: "abs(celsiusToFahrenheit(100) - 212.0) < 0.001")
                ],
                hintsRU: ["Используйте 9.0 / 5.0"],
                hintsEN: ["Use 9.0 / 5.0"],
                solutionCode: ##"""
func celsiusToFahrenheit(_ c: Double) -> Double {
    return (c * 9.0 / 5.0) + 32.0
}
"""##,
                xpReward: 25
            ),

            // Разворот строки
            CodingTask(
                id: "easy_reverse_string",
                titleRU: "Разворот строки",
                titleEN: "Reverse a String",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Разверните символы строки задом наперед.",
                summaryEN: "Reverse characters in string.",
                descriptionRU: ##"""
### Условие
Напишите функцию `reverseString(_ s: String) -> String`.
"""##,
                descriptionEN: ##"""
Implement `reverseString(_ s: String) -> String`.
"""##,
                requirementsRU: ["Корректная обработка пустых строк"],
                requirementsEN: ["Handle empty strings"],
                starterCode: ##"""
func reverseString(_ s: String) -> String {
    return ""
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "reverseString(\"swift\")", expectedOutput: "\"tiws\"", validationCode: "reverseString(\"swift\") == \"tiws\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "reverseString(\"Apple\")", expectedOutput: "\"elppA\"", validationCode: "reverseString(\"Apple\") == \"elppA\"")
                ],
                hintsRU: ["Используйте String(s.reversed())"],
                hintsEN: ["Use String(s.reversed())"],
                solutionCode: ##"""
func reverseString(_ s: String) -> String {
    return String(s.reversed())
}
"""##,
                xpReward: 25
            ),

            // Поиск максимального числа
            CodingTask(
                id: "easy_find_max",
                titleRU: "Поиск максимального числа",
                titleEN: "Find Maximum Element",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Найдите максимум с возвратом Int? при пустом массиве.",
                summaryEN: "Find max element returning Int? if empty.",
                descriptionRU: ##"""
### Условие
Напишите функцию `findMax(in numbers: [Int]) -> Int?`.
"""##,
                descriptionEN: ##"""
Implement `findMax(in numbers: [Int]) -> Int?`.
"""##,
                requirementsRU: ["Возврат nil для []"],
                requirementsEN: ["Return nil for []"],
                starterCode: ##"""
func findMax(in numbers: [Int]) -> Int? {
    return nil
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "findMax(in: [4, 9, 2])", expectedOutput: "Optional(9)", validationCode: "findMax(in: [4, 9, 2]) == 9"),
                    TaskTestCase(title: "Тест 2", inputDescription: "findMax(in: [])", expectedOutput: "nil", validationCode: "findMax(in: []) == nil")
                ],
                hintsRU: ["Используйте numbers.max()"],
                hintsEN: ["Use numbers.max()"],
                solutionCode: ##"""
func findMax(in numbers: [Int]) -> Int? {
    return numbers.max()
}
"""##,
                xpReward: 25
            ),

            // Подсчёт гласных букв
            CodingTask(
                id: "easy_count_vowels",
                titleRU: "Подсчёт гласных букв",
                titleEN: "Count Vowels",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Подсчитайте гласные a, e, i, o, u без учета регистра.",
                summaryEN: "Count English vowels case-insensitively.",
                descriptionRU: ##"""
### Условие
Напишите функцию `countVowels(in text: String) -> Int`.
"""##,
                descriptionEN: ##"""
Implement `countVowels(in text: String) -> Int`.
"""##,
                requirementsRU: ["Игнорировать регистр"],
                requirementsEN: ["Case-insensitive"],
                starterCode: ##"""
func countVowels(in text: String) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "countVowels(in: \"Swift\")", expectedOutput: "1", validationCode: "countVowels(in: \"Swift\") == 1"),
                    TaskTestCase(title: "Тест 2", inputDescription: "countVowels(in: \"Developer\")", expectedOutput: "4", validationCode: "countVowels(in: \"Developer\") == 4")
                ],
                hintsRU: ["Используйте Set<Character>(\"aeiouAEIOU\")"],
                hintsEN: ["Use Set of vowels"],
                solutionCode: ##"""
func countVowels(in text: String) -> Int {
    let v: Set<Character> = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
    return text.filter { v.contains($0) }.count
}
"""##,
                xpReward: 25
            ),

            // Безопасное деление
            CodingTask(
                id: "easy_safe_divide",
                titleRU: "Безопасное деление",
                titleEN: "Safe Division",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Защита от деления на ноль с опционалом Double?.",
                summaryEN: "Divide safely returning nil if zero divisor.",
                descriptionRU: ##"""
### Условие
Напишите функцию `safeDivide(_ a: Double, _ b: Double) -> Double?`.
"""##,
                descriptionEN: ##"""
Implement `safeDivide(_ a: Double, _ b: Double) -> Double?`.
"""##,
                requirementsRU: ["Возврат nil при b == 0"],
                requirementsEN: ["Return nil on b == 0"],
                starterCode: ##"""
func safeDivide(_ a: Double, _ b: Double) -> Double? {
    return nil
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "safeDivide(10, 2)", expectedOutput: "Optional(5.0)", validationCode: "safeDivide(10, 2) == 5.0"),
                    TaskTestCase(title: "Тест 2", inputDescription: "safeDivide(7, 0)", expectedOutput: "nil", validationCode: "safeDivide(7, 0) == nil")
                ],
                hintsRU: ["Используйте guard b != 0 else { return nil }"],
                hintsEN: ["Check b != 0"],
                solutionCode: ##"""
func safeDivide(_ a: Double, _ b: Double) -> Double? {
    guard b != 0 else { return nil }
    return a / b
}
"""##,
                xpReward: 25
            ),

            // Поиск минимального числа
            CodingTask(
                id: "easy_min_element",
                titleRU: "Поиск минимального числа",
                titleEN: "Find Minimum Element",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Найдите минимальное число в массиве.",
                summaryEN: "Find minimum integer in array.",
                descriptionRU: ##"""
### Условие
Напишите функцию `findMin(in numbers: [Int]) -> Int?`.
"""##,
                descriptionEN: ##"""
Implement `findMin(in numbers: [Int]) -> Int?`.
"""##,
                requirementsRU: ["Возврат nil при пустом массиве"],
                requirementsEN: ["Return nil for empty list"],
                starterCode: ##"""
func findMin(in numbers: [Int]) -> Int? {
    return nil
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "findMin(in: [8, 3, 12, 1])", expectedOutput: "Optional(1)", validationCode: "findMin(in: [8, 3, 12, 1]) == 1"),
                    TaskTestCase(title: "Тест 2", inputDescription: "findMin(in: [])", expectedOutput: "nil", validationCode: "findMin(in: []) == nil")
                ],
                hintsRU: ["Используйте numbers.min()"],
                hintsEN: ["Use numbers.min()"],
                solutionCode: ##"""
func findMin(in numbers: [Int]) -> Int? {
    return numbers.min()
}
"""##,
                xpReward: 25
            ),

            // Длина строки без пробелов
            CodingTask(
                id: "easy_string_length",
                titleRU: "Длина строки без пробелов",
                titleEN: "Trimmed String Length",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Посчитайте символы строки, исключая пробельные символы.",
                summaryEN: "Count characters excluding whitespace.",
                descriptionRU: ##"""
### Условие
Напишите функцию `trimmedLength(_ s: String) -> Int`.
"""##,
                descriptionEN: ##"""
Implement `trimmedLength(_ s: String) -> Int`.
"""##,
                requirementsRU: ["Игнорировать все пробелы и переносы строк"],
                requirementsEN: ["Exclude whitespaces"],
                starterCode: ##"""
func trimmedLength(_ s: String) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "trimmedLength(\" Swift 6 \")", expectedOutput: "6", validationCode: "trimmedLength(\" Swift 6 \") == 6"),
                    TaskTestCase(title: "Тест 2", inputDescription: "trimmedLength(\"   \")", expectedOutput: "0", validationCode: "trimmedLength(\"   \") == 0")
                ],
                hintsRU: ["Используйте s.filter { !$0.isWhitespace }.count"],
                hintsEN: ["Filter isWhitespace"],
                solutionCode: ##"""
func trimmedLength(_ s: String) -> Int {
    return s.filter { !$0.isWhitespace }.count
}
"""##,
                xpReward: 25
            ),

            // Повторение строки
            CodingTask(
                id: "easy_repeat_string",
                titleRU: "Повторение строки",
                titleEN: "Repeat String N Times",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Повторите строку n раз.",
                summaryEN: "Repeat string n times.",
                descriptionRU: ##"""
### Условие
Напишите функцию `repeatString(_ s: String, count: Int) -> String`. При count <= 0 верните пустую строку.
"""##,
                descriptionEN: ##"""
Repeat string count times.
"""##,
                requirementsRU: ["count <= 0 дает пустую строку"],
                requirementsEN: ["count <= 0 returns empty string"],
                starterCode: ##"""
func repeatString(_ s: String, count: Int) -> String {
    return ""
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "repeatString(\"Hi\", count: 3)", expectedOutput: "\"HiHiHi\"", validationCode: "repeatString(\"Hi\", count: 3) == \"HiHiHi\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "repeatString(\"A\", count: 0)", expectedOutput: "\"\"", validationCode: "repeatString(\"A\", count: 0) == \"\"")
                ],
                hintsRU: ["Используйте String(repeating:count:)"],
                hintsEN: ["Use String(repeating:count:)"],
                solutionCode: ##"""
func repeatString(_ s: String, count: Int) -> String {
    guard count > 0 else { return "" }
    return String(repeating: s, count: count)
}
"""##,
                xpReward: 25
            ),

            // Проверка наличия элемента
            CodingTask(
                id: "easy_contains_element",
                titleRU: "Проверка наличия элемента",
                titleEN: "Array Contains Element",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Определите, содержит ли массив заданное число.",
                summaryEN: "Check if element exists in array.",
                descriptionRU: ##"""
### Условие
Напишите функцию `contains(_ array: [Int], element: Int) -> Bool`.
"""##,
                descriptionEN: ##"""
Implement `contains(_ array: [Int], element: Int) -> Bool`.
"""##,
                requirementsRU: ["Возврат true или false"],
                requirementsEN: ["Return boolean"],
                starterCode: ##"""
func contains(_ array: [Int], element: Int) -> Bool {
    return false
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "contains([1, 2, 3], element: 2)", expectedOutput: "true", validationCode: "contains([1, 2, 3], element: 2) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "contains([1, 2, 3], element: 5)", expectedOutput: "false", validationCode: "contains([1, 2, 3], element: 5) == false")
                ],
                hintsRU: ["Используйте array.contains(element)"],
                hintsEN: ["Use array.contains"],
                solutionCode: ##"""
func contains(_ array: [Int], element: Int) -> Bool {
    return array.contains(element)
}
"""##,
                xpReward: 25
            ),

            // Факториал числа
            CodingTask(
                id: "easy_factorial",
                titleRU: "Факториал числа",
                titleEN: "Calculate Factorial",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Вычислите факториал n! (для n=0 факториал равен 1).",
                summaryEN: "Compute n! where 0! = 1.",
                descriptionRU: ##"""
### Условие
Напишите функцию `factorial(_ n: Int) -> Int`.
"""##,
                descriptionEN: ##"""
Implement `factorial(_ n: Int) -> Int`.
"""##,
                requirementsRU: ["Поддержка 0 <= n <= 12"],
                requirementsEN: ["Support n >= 0"],
                starterCode: ##"""
func factorial(_ n: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "factorial(5)", expectedOutput: "120", validationCode: "factorial(5) == 120"),
                    TaskTestCase(title: "Тест 2", inputDescription: "factorial(0)", expectedOutput: "1", validationCode: "factorial(0) == 1"),
                    TaskTestCase(title: "Тест 3", inputDescription: "factorial(1)", expectedOutput: "1", validationCode: "factorial(1) == 1")
                ],
                hintsRU: ["Используйте цикл или (1...max(1, n)).reduce(1, *)"],
                hintsEN: ["Reduce 1...n"],
                solutionCode: ##"""
func factorial(_ n: Int) -> Int {
    guard n > 1 else { return 1 }
    return (1...n).reduce(1, *)
}
"""##,
                xpReward: 25
            ),

            // Квадраты чисел
            CodingTask(
                id: "easy_square_numbers",
                titleRU: "Квадраты чисел",
                titleEN: "Square Array Numbers",
                difficulty: .easy,
                category: .functionalAndClosures,
                summaryRU: "Возведите каждое число массива в квадрат.",
                summaryEN: "Square each integer in array.",
                descriptionRU: ##"""
### Условие
Напишите функцию `squareAll(_ numbers: [Int]) -> [Int]`.
"""##,
                descriptionEN: ##"""
Implement `squareAll(_ numbers: [Int]) -> [Int]`.
"""##,
                requirementsRU: ["Использование функционального map"],
                requirementsEN: ["Use .map"],
                starterCode: ##"""
func squareAll(_ numbers: [Int]) -> [Int] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "squareAll([1, 2, 3, 4])", expectedOutput: "[1, 4, 9, 16]", validationCode: "squareAll([1, 2, 3, 4]) == [1, 4, 9, 16]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "squareAll([])", expectedOutput: "[]", validationCode: "squareAll([]) == []")
                ],
                hintsRU: ["numbers.map { $0 * $0 }"],
                hintsEN: ["Map $0 * $0"],
                solutionCode: ##"""
func squareAll(_ numbers: [Int]) -> [Int] {
    return numbers.map { $0 * $0 }
}
"""##,
                xpReward: 25
            ),

            // Определение знака числа
            CodingTask(
                id: "easy_is_positive",
                titleRU: "Определение знака числа",
                titleEN: "Check Number Sign",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Верните 'positive', 'negative' или 'zero'.",
                summaryEN: "Return 'positive', 'negative' or 'zero'.",
                descriptionRU: ##"""
### Условие
Напишите функцию `checkSign(_ n: Int) -> String`.
"""##,
                descriptionEN: ##"""
Implement `checkSign(_ n: Int) -> String`.
"""##,
                requirementsRU: ["Строгое соответствие строкам"],
                requirementsEN: ["Return exact string"],
                starterCode: ##"""
func checkSign(_ n: Int) -> String {
    return ""
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "checkSign(15)", expectedOutput: "\"positive\"", validationCode: "checkSign(15) == \"positive\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "checkSign(-4)", expectedOutput: "\"negative\"", validationCode: "checkSign(-4) == \"negative\""),
                    TaskTestCase(title: "Тест 3", inputDescription: "checkSign(0)", expectedOutput: "\"zero\"", validationCode: "checkSign(0) == \"zero\"")
                ],
                hintsRU: ["Используйте switch или if-else"],
                hintsEN: ["Use switch or if"],
                solutionCode: ##"""
func checkSign(_ n: Int) -> String {
    if n > 0 { return "positive" }
    if n < 0 { return "negative" }
    return "zero"
}
"""##,
                xpReward: 25
            ),

            // Объединение строк через запятую
            CodingTask(
                id: "easy_join_words",
                titleRU: "Объединение строк через запятую",
                titleEN: "Join Words with Separator",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Соедините массив строк через разделитель ', '.",
                summaryEN: "Join strings using delimiter.",
                descriptionRU: ##"""
### Условие
Напишите функцию `joinWords(_ words: [String]) -> String`.
"""##,
                descriptionEN: ##"""
Implement `joinWords(_ words: [String]) -> String`.
"""##,
                requirementsRU: ["Используйте .joined(separator:)"],
                requirementsEN: ["Use .joined"],
                starterCode: ##"""
func joinWords(_ words: [String]) -> String {
    return ""
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "joinWords([\"Swift\", \"iOS\", \"Mac\"])", expectedOutput: "\"Swift, iOS, Mac\"", validationCode: "joinWords([\"Swift\", \"iOS\", \"Mac\"]) == \"Swift, iOS, Mac\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "joinWords([])", expectedOutput: "\"\"", validationCode: "joinWords([]) == \"\"")
                ],
                hintsRU: ["words.joined(separator: \", \")"],
                hintsEN: ["Use joined"],
                solutionCode: ##"""
func joinWords(_ words: [String]) -> String {
    return words.joined(separator: ", ")
}
"""##,
                xpReward: 25
            ),

            // Обмен значений через inout
            CodingTask(
                id: "easy_swap_values",
                titleRU: "Обмен значений через inout",
                titleEN: "Swap Values Inout",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Поменяйте местами два числа с помощью inout параметров.",
                summaryEN: "Swap two integers using inout.",
                descriptionRU: ##"""
### Условие
Напишите функцию `swapValues(_ a: inout Int, _ b: inout Int)`.
"""##,
                descriptionEN: ##"""
Implement `swapValues(_ a: inout Int, _ b: inout Int)`.
"""##,
                requirementsRU: ["Использование inout"],
                requirementsEN: ["Mutate inout params"],
                starterCode: ##"""
func swapValues(_ a: inout Int, _ b: inout Int) {
    // Ваше решение:
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Обмен 10 и 20", expectedOutput: "a=20, b=10", validationCode: "({ var x = 10; var y = 20; swapValues(&x, &y); return x == 20 && y == 10 })()")
                ],
                hintsRU: ["Используйте swap(&a, &b) или временную переменную let temp = a"],
                hintsEN: ["Use swap or temp"],
                solutionCode: ##"""
func swapValues(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}
"""##,
                xpReward: 25
            ),

            // Ограничение диапазона (Clamp)
            CodingTask(
                id: "easy_clamp",
                titleRU: "Ограничение диапазона (Clamp)",
                titleEN: "Clamp Number in Range",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Ограничьте значение числом min и max.",
                summaryEN: "Clamp value between min and max bounds.",
                descriptionRU: ##"""
### Условие
Напишите функцию `clamp(_ val: Int, min: Int, max: Int) -> Int`.
"""##,
                descriptionEN: ##"""
Implement `clamp(_ val: Int, min: Int, max: Int) -> Int`.
"""##,
                requirementsRU: ["Если val < min -> min, если val > max -> max, иначе val"],
                requirementsEN: ["Bounded range check"],
                starterCode: ##"""
func clamp(_ val: Int, min: Int, max: Int) -> Int {
    return val
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "clamp(15, min: 0, max: 10)", expectedOutput: "10", validationCode: "clamp(15, min: 0, max: 10) == 10"),
                    TaskTestCase(title: "Тест 2", inputDescription: "clamp(-5, min: 0, max: 10)", expectedOutput: "0", validationCode: "clamp(-5, min: 0, max: 10) == 0"),
                    TaskTestCase(title: "Тест 3", inputDescription: "clamp(7, min: 0, max: 10)", expectedOutput: "7", validationCode: "clamp(7, min: 0, max: 10) == 7")
                ],
                hintsRU: ["Swift: Swift.max(min, Swift.min(max, val))"],
                hintsEN: ["Use min and max functions"],
                solutionCode: ##"""
func clamp(_ val: Int, min: Int, max: Int) -> Int {
    return Swift.max(min, Swift.min(max, val))
}
"""##,
                xpReward: 25
            ),

            // Подсчет вхождений элемента
            CodingTask(
                id: "easy_count_occurrences",
                titleRU: "Подсчет вхождений элемента",
                titleEN: "Count Occurrences in Array",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Посчитайте, сколько раз число target встречается в массиве.",
                summaryEN: "Count matching elements in array.",
                descriptionRU: ##"""
### Условие
Напишите функцию `countOccurrences(of target: Int, in array: [Int]) -> Int`.
"""##,
                descriptionEN: ##"""
Implement `countOccurrences(of target: Int, in array: [Int]) -> Int`.
"""##,
                requirementsRU: ["Линейный проход"],
                requirementsEN: ["O(n) count"],
                starterCode: ##"""
func countOccurrences(of target: Int, in array: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "countOccurrences(of: 2, in: [1, 2, 3, 2, 2, 4])", expectedOutput: "3", validationCode: "countOccurrences(of: 2, in: [1, 2, 3, 2, 2, 4]) == 3"),
                    TaskTestCase(title: "Тест 2", inputDescription: "countOccurrences(of: 9, in: [1, 2, 3])", expectedOutput: "0", validationCode: "countOccurrences(of: 9, in: [1, 2, 3]) == 0")
                ],
                hintsRU: ["array.filter { $0 == target }.count"],
                hintsEN: ["Filter equality"],
                solutionCode: ##"""
func countOccurrences(of target: Int, in array: [Int]) -> Int {
    return array.filter { $0 == target }.count
}
"""##,
                xpReward: 25
            ),

            // Классический FizzBuzz
            CodingTask(
                id: "med_fizzbuzz",
                titleRU: "Классический FizzBuzz",
                titleEN: "Classic FizzBuzz",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Сформируйте массив строк от 1 до n по правилам кратности 3 и 5.",
                summaryEN: "Generate string array with Fizz/Buzz rules.",
                descriptionRU: ##"""
### Условие
Напишите функцию `fizzBuzz(upTo n: Int) -> [String]`.
"""##,
                descriptionEN: ##"""
Implement `fizzBuzz(upTo n: Int) -> [String]`.
"""##,
                requirementsRU: ["Кратность 15 -> FizzBuzz", "Кратность 3 -> Fizz", "Кратность 5 -> Buzz"],
                requirementsEN: ["Divisible by 15 first"],
                starterCode: ##"""
func fizzBuzz(upTo n: Int) -> [String] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "fizzBuzz(upTo: 5)", expectedOutput: "[\"1\", \"2\", \"Fizz\", \"4\", \"Buzz\"]", validationCode: "fizzBuzz(upTo: 5) == [\"1\", \"2\", \"Fizz\", \"4\", \"Buzz\"]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "fizzBuzz(upTo: 15)[14]", expectedOutput: "\"FizzBuzz\"", validationCode: "fizzBuzz(upTo: 15).count == 15 && fizzBuzz(upTo: 15)[14] == \"FizzBuzz\"")
                ],
                hintsRU: ["Сначала проверяйте % 15"],
                hintsEN: ["Check % 15 first"],
                solutionCode: ##"""
func fizzBuzz(upTo n: Int) -> [String] {
    guard n >= 1 else { return [] }
    return (1...n).map {
        if $0 % 15 == 0 { return "FizzBuzz" }
        if $0 % 3 == 0 { return "Fizz" }
        if $0 % 5 == 0 { return "Buzz" }
        return String($0)
    }
}
"""##,
                xpReward: 40
            ),

            // Проверка на палиндром
            CodingTask(
                id: "med_is_palindrome",
                titleRU: "Проверка на палиндром",
                titleEN: "Valid Palindrome",
                difficulty: .medium,
                category: .stringsAndCollections,
                summaryRU: "Игнорируйте пробелы, знаки препинания и регистр.",
                summaryEN: "Check palindrome ignoring punctuation.",
                descriptionRU: ##"""
### Условие
Напишите функцию `isPalindrome(_ text: String) -> Bool`.
"""##,
                descriptionEN: ##"""
Implement `isPalindrome(_ text: String) -> Bool`.
"""##,
                requirementsRU: ["Фильтровать только isLetter || isNumber"],
                requirementsEN: ["Keep alphanumeric only"],
                starterCode: ##"""
func isPalindrome(_ text: String) -> Bool {
    return false
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Палиндром", expectedOutput: "true", validationCode: "isPalindrome(\"А роза упала на лапу Азора\") == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Не палиндром", expectedOutput: "false", validationCode: "isPalindrome(\"race a car\") == false")
                ],
                hintsRU: ["Сравните clean со String(clean.reversed())"],
                hintsEN: ["Reverse filtered text"],
                solutionCode: ##"""
func isPalindrome(_ text: String) -> Bool {
    let clean = text.lowercased().filter { $0.isLetter || $0.isNumber }
    return clean == String(clean.reversed())
}
"""##,
                xpReward: 40
            ),

            // Two Sum за O(n)
            CodingTask(
                id: "med_two_sum",
                titleRU: "Two Sum за O(n)",
                titleEN: "Two Sum Algorithm",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Найдите пару индексов с заданной суммой target через Dictionary.",
                summaryEN: "Find two indices summing to target in O(n).",
                descriptionRU: ##"""
### Условие
Напишите функцию `twoSum(_ nums: [Int], _ target: Int) -> (Int, Int)?`.
"""##,
                descriptionEN: ##"""
Implement `twoSum(_ nums: [Int], _ target: Int) -> (Int, Int)?`.
"""##,
                requirementsRU: ["Поиск за O(n) через хэш-таблицу"],
                requirementsEN: ["O(n) via hash map"],
                starterCode: ##"""
func twoSum(_ nums: [Int], _ target: Int) -> (Int, Int)? {
    return nil
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "twoSum([2, 7, 11, 15], 9)", expectedOutput: "Optional((0, 1))", validationCode: "twoSum([2, 7, 11, 15], 9)! == (0, 1) || twoSum([2, 7, 11, 15], 9)! == (1, 0)")
                ],
                hintsRU: ["Храните [число: индекс]"],
                hintsEN: ["Map [num: index]"],
                solutionCode: ##"""
func twoSum(_ nums: [Int], _ target: Int) -> (Int, Int)? {
    var seen: [Int: Int] = [:]
    for (i, num) in nums.enumerated() {
        if let idx = seen[target - num] { return (idx, i) }
        seen[num] = i
    }
    return nil
}
"""##,
                xpReward: 45
            ),

            // Удаление дубликатов с сохранением порядка
            CodingTask(
                id: "med_remove_duplicates",
                titleRU: "Удаление дубликатов с сохранением порядка",
                titleEN: "Deduplicate Array Preserving Order",
                difficulty: .medium,
                category: .stringsAndCollections,
                summaryRU: "Удалите дубликаты, сохраняя первое появление каждого элемента.",
                summaryEN: "Remove duplicates keeping first occurrence.",
                descriptionRU: ##"""
### Условие
Напишите функцию `removeDuplicates(from list: [Int]) -> [Int]`.
"""##,
                descriptionEN: ##"""
Implement `removeDuplicates(from list: [Int]) -> [Int]`.
"""##,
                requirementsRU: ["Порядок сохраняется"],
                requirementsEN: ["Preserve order"],
                starterCode: ##"""
func removeDuplicates(from list: [Int]) -> [Int] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "removeDuplicates([1, 2, 2, 3, 1, 4])", expectedOutput: "[1, 2, 3, 4]", validationCode: "removeDuplicates(from: [1, 2, 2, 3, 1, 4]) == [1, 2, 3, 4]")
                ],
                hintsRU: ["Используйте Set<Int>() для проверки insert.inserted"],
                hintsEN: ["Check Set.insert"],
                solutionCode: ##"""
func removeDuplicates(from list: [Int]) -> [Int] {
    var seen = Set<Int>()
    var res: [Int] = []
    for x in list { if seen.insert(x).inserted { res.append(x) } }
    return res
}
"""##,
                xpReward: 40
            ),

            // Проверка на анаграмму
            CodingTask(
                id: "med_is_anagram",
                titleRU: "Проверка на анаграмму",
                titleEN: "Valid Anagram",
                difficulty: .medium,
                category: .stringsAndCollections,
                summaryRU: "Определите, состоят ли слова из одинакового набора букв.",
                summaryEN: "Check if two words are anagrams.",
                descriptionRU: ##"""
### Условие
Напишите функцию `isAnagram(_ s1: String, _ s2: String) -> Bool`.
"""##,
                descriptionEN: ##"""
Implement `isAnagram(_ s1: String, _ s2: String) -> Bool`.
"""##,
                requirementsRU: ["Игнорировать регистр"],
                requirementsEN: ["Case-insensitive"],
                starterCode: ##"""
func isAnagram(_ s1: String, _ s2: String) -> Bool {
    return false
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "isAnagram(\"silent\", \"listen\")", expectedOutput: "true", validationCode: "isAnagram(\"silent\", \"listen\") == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "isAnagram(\"rat\", \"car\")", expectedOutput: "false", validationCode: "isAnagram(\"rat\", \"car\") == false")
                ],
                hintsRU: ["Сравните s1.lowercased().sorted() == s2.lowercased().sorted()"],
                hintsEN: ["Sort and compare"],
                solutionCode: ##"""
func isAnagram(_ s1: String, _ s2: String) -> Bool {
    guard s1.count == s2.count else { return false }
    return s1.lowercased().sorted() == s2.lowercased().sorted()
}
"""##,
                xpReward: 40
            ),

            // Собственный generic map
            CodingTask(
                id: "med_custom_map",
                titleRU: "Собственный generic map",
                titleEN: "Custom Generic Map",
                difficulty: .medium,
                category: .functionalAndClosures,
                summaryRU: "Реализуйте map с преобразованием T -> U без встроенного .map.",
                summaryEN: "Implement generic map without using .map.",
                descriptionRU: ##"""
### Условие
Напишите функцию `myMap<T, U>(_ array: [T], transform: (T) -> U) -> [U]`.
"""##,
                descriptionEN: ##"""
Implement `myMap<T, U>(_ array: [T], transform: (T) -> U) -> [U]`.
"""##,
                requirementsRU: ["Generics T, U"],
                requirementsEN: ["No built-in map"],
                starterCode: ##"""
func myMap<T, U>(_ array: [T], transform: (T) -> U) -> [U] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "myMap([1, 2, 3]) { $0 * 2 }", expectedOutput: "[2, 4, 6]", validationCode: "myMap([1, 2, 3]) { $0 * 2 } == [2, 4, 6]")
                ],
                hintsRU: ["Обойдите массив и append-ите transform(item)"],
                hintsEN: ["Iterate and append transform(item)"],
                solutionCode: ##"""
func myMap<T, U>(_ array: [T], transform: (T) -> U) -> [U] {
    var res: [U] = []
    for x in array { res.append(transform(x)) }
    return res
}
"""##,
                xpReward: 45
            ),

            // Разбиение массива на чанки
            CodingTask(
                id: "med_chunk_array",
                titleRU: "Разбиение массива на чанки",
                titleEN: "Chunk Array into Slices",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Разделите массив на подмассивы фиксированной длины size.",
                summaryEN: "Split array into chunks of size.",
                descriptionRU: ##"""
### Условие
Напишите функцию `chunk<T>(_ array: [T], size: Int) -> [[T]]`.
"""##,
                descriptionEN: ##"""
Implement `chunk<T>(_ array: [T], size: Int) -> [[T]]`.
"""##,
                requirementsRU: ["size > 0"],
                requirementsEN: ["Handle size <= 0"],
                starterCode: ##"""
func chunk<T>(_ array: [T], size: Int) -> [[T]] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "chunk([1, 2, 3, 4, 5], size: 2)", expectedOutput: "[[1, 2], [3, 4], [5]]", validationCode: "chunk([1, 2, 3, 4, 5], size: 2) == [[1, 2], [3, 4], [5]]")
                ],
                hintsRU: ["Используйте stride или срезы array[start..<end]"],
                hintsEN: ["Slice array"],
                solutionCode: ##"""
func chunk<T>(_ array: [T], size: Int) -> [[T]] {
    guard size > 0 && !array.isEmpty else { return [] }
    var res: [[T]] = []
    var i = 0
    while i < array.count {
        res.append(Array(array[i..<min(i + size, array.count)]))
        i += size
    }
    return res
}
"""##,
                xpReward: 45
            ),

            // Валидация скобок стеком
            CodingTask(
                id: "med_valid_parentheses",
                titleRU: "Валидация скобок стеком",
                titleEN: "Valid Parentheses Stack",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Проверьте валидность (), [], {} через структуру стек.",
                summaryEN: "Validate bracket nesting using stack.",
                descriptionRU: ##"""
### Условие
Напишите функцию `isValidParentheses(_ s: String) -> Bool`.
"""##,
                descriptionEN: ##"""
Implement `isValidParentheses(_ s: String) -> Bool`.
"""##,
                requirementsRU: ["LIFO стек"],
                requirementsEN: ["Stack pattern"],
                starterCode: ##"""
func isValidParentheses(_ s: String) -> Bool {
    return false
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "isValidParentheses(\"()[]{}\")", expectedOutput: "true", validationCode: "isValidParentheses(\"()[]{}\") == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "isValidParentheses(\"([)]\")", expectedOutput: "false", validationCode: "isValidParentheses(\"([)]\") == false")
                ],
                hintsRU: ["Пушьте открывающие, проверяйте на совпадение закрывающие"],
                hintsEN: ["Push open, pop close"],
                solutionCode: ##"""
func isValidParentheses(_ s: String) -> Bool {
    var stack: [Character] = []
    let pairs: [Character: Character] = [")": "(", "}": "{", "]": "["]
    for c in s {
        if let m = pairs[c] {
            if stack.popLast() != m { return false }
        } else {
            stack.append(c)
        }
    }
    return stack.isEmpty
}
"""##,
                xpReward: 45
            ),

            // Числа Фибоначчи за O(n)
            CodingTask(
                id: "med_fibonacci",
                titleRU: "Числа Фибоначчи за O(n)",
                titleEN: "Fibonacci Sequence O(n)",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Вычислите n-ое число Фибоначчи без рекурсивного лага.",
                summaryEN: "Compute n-th Fibonacci number in O(n).",
                descriptionRU: ##"""
### Условие
F(0) = 0, F(1) = 1, F(n) = F(n-1) + F(n-2).
Напишите функцию `fibonacci(_ n: Int) -> Int`.
"""##,
                descriptionEN: ##"""
Implement `fibonacci(_ n: Int) -> Int` in linear time.
"""##,
                requirementsRU: ["Сложность O(n) по времени"],
                requirementsEN: ["Linear time O(n)"],
                starterCode: ##"""
func fibonacci(_ n: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "fibonacci(6)", expectedOutput: "8", validationCode: "fibonacci(6) == 8"),
                    TaskTestCase(title: "Тест 2", inputDescription: "fibonacci(10)", expectedOutput: "55", validationCode: "fibonacci(10) == 55"),
                    TaskTestCase(title: "Тест 3", inputDescription: "fibonacci(0)", expectedOutput: "0", validationCode: "fibonacci(0) == 0")
                ],
                hintsRU: ["Храните две переменные a и b в цикле for _ in 2...n"],
                hintsEN: ["Use two iterative variables"],
                solutionCode: ##"""
func fibonacci(_ n: Int) -> Int {
    guard n > 1 else { return max(0, n) }
    var a = 0, b = 1
    for _ in 2...n {
        let next = a + b
        a = b
        b = next
    }
    return b
}
"""##,
                xpReward: 40
            ),

            // Бинарный поиск
            CodingTask(
                id: "med_binary_search",
                titleRU: "Бинарный поиск",
                titleEN: "Binary Search Algorithm",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Найдите индекс target в отсортированном массиве за O(log n).",
                summaryEN: "Find target index in sorted array in O(log n).",
                descriptionRU: ##"""
### Условие
Напишите функцию `binarySearch(_ array: [Int], target: Int) -> Int?`.
"""##,
                descriptionEN: ##"""
Implement `binarySearch(_ array: [Int], target: Int) -> Int?`.
"""##,
                requirementsRU: ["O(log n) сложность"],
                requirementsEN: ["Logarithmic complexity"],
                starterCode: ##"""
func binarySearch(_ array: [Int], target: Int) -> Int? {
    return nil
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "binarySearch([1, 3, 5, 7, 9], target: 5)", expectedOutput: "Optional(2)", validationCode: "binarySearch([1, 3, 5, 7, 9], target: 5) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "binarySearch([1, 3, 5], target: 8)", expectedOutput: "nil", validationCode: "binarySearch([1, 3, 5], target: 8) == nil")
                ],
                hintsRU: ["Два указателя left = 0, right = count - 1, mid = (left + right) / 2"],
                hintsEN: ["Use left, right, mid pointers"],
                solutionCode: ##"""
func binarySearch(_ array: [Int], target: Int) -> Int? {
    var left = 0, right = array.count - 1
    while left <= right {
        let mid = (left + right) / 2
        if array[mid] == target { return mid }
        if array[mid] < target { left = mid + 1 } else { right = mid - 1 }
    }
    return nil
}
"""##,
                xpReward: 45
            ),

            // Первый уникальный символ
            CodingTask(
                id: "med_first_unique_char",
                titleRU: "Первый уникальный символ",
                titleEN: "First Unique Character",
                difficulty: .medium,
                category: .stringsAndCollections,
                summaryRU: "Найдите первый символ, который встречается в строке только 1 раз.",
                summaryEN: "Find first non-repeating character.",
                descriptionRU: ##"""
### Условие
Напишите функцию `firstUniqueChar(_ s: String) -> Character?`.
"""##,
                descriptionEN: ##"""
Implement `firstUniqueChar(_ s: String) -> Character?`.
"""##,
                requirementsRU: ["Один проход частоты + один проход поиска"],
                requirementsEN: ["Count frequencies then search"],
                starterCode: ##"""
func firstUniqueChar(_ s: String) -> Character? {
    return nil
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "firstUniqueChar(\"swiss\")", expectedOutput: "Optional(\"w\")", validationCode: "firstUniqueChar(\"swiss\") == \"w\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "firstUniqueChar(\"aabb\")", expectedOutput: "nil", validationCode: "firstUniqueChar(\"aabb\") == nil")
                ],
                hintsRU: ["Посчитайте частоту каждого символа в [Character: Int]"],
                hintsEN: ["Count char frequencies"],
                solutionCode: ##"""
func firstUniqueChar(_ s: String) -> Character? {
    var counts: [Character: Int] = [:]
    for c in s { counts[c, default: 0] += 1 }
    for c in s { if counts[c] == 1 { return c } }
    return nil
}
"""##,
                xpReward: 40
            ),

            // Слияние отсортированных массивов
            CodingTask(
                id: "med_merge_sorted_arrays",
                titleRU: "Слияние отсортированных массивов",
                titleEN: "Merge Two Sorted Arrays",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Объедините два отсортированных массива в один за O(n + m).",
                summaryEN: "Merge two sorted arrays in linear time.",
                descriptionRU: ##"""
### Условие
Напишите функцию `mergeSorted(_ a: [Int], _ b: [Int]) -> [Int]`.
"""##,
                descriptionEN: ##"""
Implement `mergeSorted(_ a: [Int], _ b: [Int]) -> [Int]`.
"""##,
                requirementsRU: ["Не вызывать .sorted(), использовать два указателя"],
                requirementsEN: ["Two-pointer merge without .sorted()"],
                starterCode: ##"""
func mergeSorted(_ a: [Int], _ b: [Int]) -> [Int] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "mergeSorted([1, 3, 5], [2, 4, 6])", expectedOutput: "[1, 2, 3, 4, 5, 6]", validationCode: "mergeSorted([1, 3, 5], [2, 4, 6]) == [1, 2, 3, 4, 5, 6]")
                ],
                hintsRU: ["Два указателя i и j, сравнивайте a[i] и b[j]"],
                hintsEN: ["Two pointer comparison"],
                solutionCode: ##"""
func mergeSorted(_ a: [Int], _ b: [Int]) -> [Int] {
    var i = 0, j = 0
    var res: [Int] = []
    while i < a.count && j < b.count {
        if a[i] < b[j] { res.append(a[i]); i += 1 }
        else { res.append(b[j]); j += 1 }
    }
    if i < a.count { res.append(contentsOf: a[i...]) }
    if j < b.count { res.append(contentsOf: b[j...]) }
    return res
}
"""##,
                xpReward: 45
            ),

            // Циклический сдвиг массива
            CodingTask(
                id: "med_rotate_array",
                titleRU: "Циклический сдвиг массива",
                titleEN: "Rotate Array Right by K Steps",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Сдвиньте массив вправо на k позиций.",
                summaryEN: "Rotate array right by k steps.",
                descriptionRU: ##"""
### Условие
Напишите функцию `rotateArray(_ nums: [Int], k: Int) -> [Int]`.
"""##,
                descriptionEN: ##"""
Implement `rotateArray(_ nums: [Int], k: Int) -> [Int]`.
"""##,
                requirementsRU: ["k может быть больше длины массива (используйте k % count)"],
                requirementsEN: ["Handle k >= count via modulo"],
                starterCode: ##"""
func rotateArray(_ nums: [Int], k: Int) -> [Int] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "rotateArray([1, 2, 3, 4, 5], k: 2)", expectedOutput: "[4, 5, 1, 2, 3]", validationCode: "rotateArray([1, 2, 3, 4, 5], k: 2) == [4, 5, 1, 2, 3]")
                ],
                hintsRU: ["Используйте срезы suffix(k) + prefix(count - k)"],
                hintsEN: ["Suffix + Prefix slices"],
                solutionCode: ##"""
func rotateArray(_ nums: [Int], k: Int) -> [Int] {
    guard !nums.isEmpty else { return [] }
    let steps = k % nums.count
    guard steps > 0 else { return nums }
    let splitIndex = nums.count - steps
    return Array(nums[splitIndex...]) + Array(nums[..<splitIndex])
}
"""##,
                xpReward: 40
            ),

            // Преобразование в Title Case
            CodingTask(
                id: "med_title_case",
                titleRU: "Преобразование в Title Case",
                titleEN: "Capitalize Words Title Case",
                difficulty: .medium,
                category: .stringsAndCollections,
                summaryRU: "Сделайте первую букву каждого слова заглавной.",
                summaryEN: "Capitalize first character of every word.",
                descriptionRU: ##"""
### Условие
Напишите функцию `toTitleCase(_ s: String) -> String`.
"""##,
                descriptionEN: ##"""
Implement `toTitleCase(_ s: String) -> String`.
"""##,
                requirementsRU: ["Сохранение пробелов"],
                requirementsEN: ["Preserve word spacing"],
                starterCode: ##"""
func toTitleCase(_ s: String) -> String {
    return ""
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "toTitleCase(\"swift programming language\")", expectedOutput: "\"Swift Programming Language\"", validationCode: "toTitleCase(\"swift programming language\") == \"Swift Programming Language\"")
                ],
                hintsRU: ["s.components(separatedBy: \" \").map { $0.capitalized }.joined(separator: \" \")"],
                hintsEN: ["Use .capitalized"],
                solutionCode: ##"""
func toTitleCase(_ s: String) -> String {
    return s.components(separatedBy: " ").map { $0.prefix(1).uppercased() + $0.dropFirst().lowercased() }.joined(separator: " ")
}
"""##,
                xpReward: 40
            ),

            // Run-Length сжатие строки
            CodingTask(
                id: "med_compress_string",
                titleRU: "Run-Length сжатие строки",
                titleEN: "String Compression RLE",
                difficulty: .medium,
                category: .stringsAndCollections,
                summaryRU: "Сожмите строку 'aabcccccaaa' в 'a2b1c5a3'.",
                summaryEN: "Run-length compress string.",
                descriptionRU: ##"""
### Условие
Напишите функцию `compressString(_ s: String) -> String`.
"""##,
                descriptionEN: ##"""
Implement `compressString(_ s: String) -> String`.
"""##,
                requirementsRU: ["Подсчет подряд идущих символов"],
                requirementsEN: ["Count consecutive identical chars"],
                starterCode: ##"""
func compressString(_ s: String) -> String {
    return ""
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "compressString(\"aabcccccaaa\")", expectedOutput: "\"a2b1c5a3\"", validationCode: "compressString(\"aabcccccaaa\") == \"a2b1c5a3\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "compressString(\"\")", expectedOutput: "\"\"", validationCode: "compressString(\"\") == \"\"")
                ],
                hintsRU: ["Пройдите по символам, считая длину серии текущего символа"],
                hintsEN: ["Iterate counting run lengths"],
                solutionCode: ##"""
func compressString(_ s: String) -> String {
    guard let first = s.first else { return "" }
    var res = ""
    var cur = first
    var count = 0
    for c in s {
        if c == cur { count += 1 }
        else { res += "\(cur)\(count)"; cur = c; count = 1 }
    }
    res += "\(cur)\(count)"
    return res
}
"""##,
                xpReward: 45
            ),

            // Группировка анаграмм
            CodingTask(
                id: "med_group_anagrams",
                titleRU: "Группировка анаграмм",
                titleEN: "Group Anagrams",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Сгруппируйте слова-анаграммы в общий список.",
                summaryEN: "Group words that are anagrams together.",
                descriptionRU: ##"""
### Условие
Напишите функцию `groupAnagrams(_ words: [String]) -> [[String]]`.
"""##,
                descriptionEN: ##"""
Implement `groupAnagrams(_ words: [String]) -> [[String]]`.
"""##,
                requirementsRU: ["Используйте отсортированное слово как ключ словаря"],
                requirementsEN: ["Sorted characters as map key"],
                starterCode: ##"""
func groupAnagrams(_ words: [String]) -> [[String]] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Группировка eat, tea, tan, ate, nat, bat", expectedOutput: "3 группы", validationCode: "groupAnagrams([\"eat\", \"tea\", \"tan\", \"ate\", \"nat\", \"bat\"]).count == 3")
                ],
                hintsRU: ["Словарь [String: [String]], где ключ String(word.sorted())"],
                hintsEN: ["Dictionary [sortedWord: [words]]"],
                solutionCode: ##"""
func groupAnagrams(_ words: [String]) -> [[String]] {
    var map: [String: [String]] = [:]
    for w in words {
        let k = String(w.sorted())
        map[k, default: []].append(w)
    }
    return Array(map.values)
}
"""##,
                xpReward: 45
            ),

            // Пересечение двух массивов
            CodingTask(
                id: "med_intersection_arrays",
                titleRU: "Пересечение двух массивов",
                titleEN: "Intersection of Two Arrays",
                difficulty: .medium,
                category: .stringsAndCollections,
                summaryRU: "Найдите общие элементы с учетом количества вхождений.",
                summaryEN: "Find array intersection with counts.",
                descriptionRU: ##"""
### Условие
Напишите функцию `intersect(_ a: [Int], _ b: [Int]) -> [Int]`.
"""##,
                descriptionEN: ##"""
Implement `intersect(_ a: [Int], _ b: [Int]) -> [Int]`.
"""##,
                requirementsRU: ["Учитывать дубликаты"],
                requirementsEN: ["Account for duplicate count"],
                starterCode: ##"""
func intersect(_ a: [Int], _ b: [Int]) -> [Int] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "intersect([1, 2, 2, 1], [2, 2])", expectedOutput: "[2, 2]", validationCode: "intersect([1, 2, 2, 1], [2, 2]) == [2, 2]")
                ],
                hintsRU: ["Посчитайте частоту в a через [Int: Int], затем уменьшайте счетчик при обходе b"],
                hintsEN: ["Hash map frequencies"],
                solutionCode: ##"""
func intersect(_ a: [Int], _ b: [Int]) -> [Int] {
    var counts: [Int: Int] = [:]
    for x in a { counts[x, default: 0] += 1 }
    var res: [Int] = []
    for y in b {
        if let c = counts[y], c > 0 {
            res.append(y)
            counts[y] = c - 1
        }
    }
    return res
}
"""##,
                xpReward: 45
            ),

            // Собственный compactMap
            CodingTask(
                id: "med_custom_compact_map",
                titleRU: "Собственный compactMap",
                titleEN: "Custom Generic compactMap",
                difficulty: .medium,
                category: .functionalAndClosures,
                summaryRU: "Реализуйте фильтрацию nil из преобразований.",
                summaryEN: "Implement compactMap filtering nil outputs.",
                descriptionRU: ##"""
### Условие
Напишите функцию `myCompactMap<T, U>(_ array: [T], _ transform: (T) -> U?) -> [U]`.
"""##,
                descriptionEN: ##"""
Implement `myCompactMap<T, U>(_ array: [T], _ transform: (T) -> U?) -> [U]`.
"""##,
                requirementsRU: ["Игнорировать nil результаты"],
                requirementsEN: ["Unwrap non-nil values"],
                starterCode: ##"""
func myCompactMap<T, U>(_ array: [T], _ transform: (T) -> U?) -> [U] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Парсинг чисел", expectedOutput: "[1, 2]", validationCode: "myCompactMap([\"1\", \"abc\", \"2\"]) { Int($0) } == [1, 2]")
                ],
                hintsRU: ["В цикле проверяйте `if let val = transform(item)`"],
                hintsEN: ["Use if let val = transform(item)"],
                solutionCode: ##"""
func myCompactMap<T, U>(_ array: [T], _ transform: (T) -> U?) -> [U] {
    var res: [U] = []
    for x in array { if let val = transform(x) { res.append(val) } }
    return res
}
"""##,
                xpReward: 45
            ),

            // Максимум подряд идущих единиц
            CodingTask(
                id: "med_max_consecutive_ones",
                titleRU: "Максимум подряд идущих единиц",
                titleEN: "Max Consecutive Ones",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Найдите самую длинную серию единиц в бинарном массиве.",
                summaryEN: "Find length of longest contiguous 1s segment.",
                descriptionRU: ##"""
### Условие
Напишите функцию `findMaxConsecutiveOnes(_ nums: [Int]) -> Int`.
"""##,
                descriptionEN: ##"""
Implement `findMaxConsecutiveOnes(_ nums: [Int]) -> Int`.
"""##,
                requirementsRU: ["Массив содержит только 0 и 1"],
                requirementsEN: ["Binary array values"],
                starterCode: ##"""
func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "findMaxConsecutiveOnes([1, 1, 0, 1, 1, 1])", expectedOutput: "3", validationCode: "findMaxConsecutiveOnes([1, 1, 0, 1, 1, 1]) == 3")
                ],
                hintsRU: ["Счетчик streak и глобальный maxStreak"],
                hintsEN: ["Track current streak and global max"],
                solutionCode: ##"""
func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
    var maxCount = 0, current = 0
    for n in nums {
        if n == 1 { current += 1; maxCount = max(maxCount, current) }
        else { current = 0 }
    }
    return maxCount
}
"""##,
                xpReward: 40
            ),

            // Перемещение нулей в конец
            CodingTask(
                id: "med_move_zeroes",
                titleRU: "Перемещение нулей в конец",
                titleEN: "Move Zeroes in Array",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Переместите все 0 в конец массива, сохранив порядок остальных.",
                summaryEN: "Shift zeroes to array end maintaining relative order.",
                descriptionRU: ##"""
### Условие
Напишите функцию `moveZeroes(_ nums: [Int]) -> [Int]`.
"""##,
                descriptionEN: ##"""
Implement `moveZeroes(_ nums: [Int]) -> [Int]`.
"""##,
                requirementsRU: ["Сохранять порядок ненулевых"],
                requirementsEN: ["Preserve non-zero order"],
                starterCode: ##"""
func moveZeroes(_ nums: [Int]) -> [Int] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "moveZeroes([0, 1, 0, 3, 12])", expectedOutput: "[1, 3, 12, 0, 0]", validationCode: "moveZeroes([0, 1, 0, 3, 12]) == [1, 3, 12, 0, 0]")
                ],
                hintsRU: ["Отфильтруйте ненулевые и добавьте массив нулей в конец"],
                hintsEN: ["Filter non-zero and append zeros"],
                solutionCode: ##"""
func moveZeroes(_ nums: [Int]) -> [Int] {
    let nonZeros = nums.filter { $0 != 0 }
    let zeroCount = nums.count - nonZeros.count
    return nonZeros + Array(repeating: 0, count: zeroCount)
}
"""##,
                xpReward: 40
            ),

            // Валидация IPv4 адреса
            CodingTask(
                id: "med_valid_ip",
                titleRU: "Валидация IPv4 адреса",
                titleEN: "Validate IPv4 Address",
                difficulty: .medium,
                category: .stringsAndCollections,
                summaryRU: "Проверьте строку на корректность формата IPv4 (0-255).",
                summaryEN: "Validate string is valid IPv4.",
                descriptionRU: ##"""
### Условие
Напишите функцию `isValidIPv4(_ ip: String) -> Bool`. 4 блока от 0 до 255 без ведущих нулей (кроме 0).
"""##,
                descriptionEN: ##"""
Check IPv4 format.
"""##,
                requirementsRU: ["4 октета через точку", "Без ведущих нулей ('01' -> false)"],
                requirementsEN: ["No leading zeros, range 0...255"],
                starterCode: ##"""
func isValidIPv4(_ ip: String) -> Bool {
    return false
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "isValidIPv4(\"192.168.1.1\")", expectedOutput: "true", validationCode: "isValidIPv4(\"192.168.1.1\") == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "isValidIPv4(\"256.0.0.1\")", expectedOutput: "false", validationCode: "isValidIPv4(\"256.0.0.1\") == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "isValidIPv4(\"192.168.01.1\")", expectedOutput: "false", validationCode: "isValidIPv4(\"192.168.01.1\") == false")
                ],
                hintsRU: ["ip.components(separatedBy: \".\")"],
                hintsEN: ["Check 4 parts in 0...255"],
                solutionCode: ##"""
func isValidIPv4(_ ip: String) -> Bool {
    let parts = ip.components(separatedBy: ".")
    guard parts.count == 4 else { return false }
    for p in parts {
        guard let val = Int(p), (0...255).contains(val) else { return false }
        if p.count > 1 && p.first == "0" { return false }
    }
    return true
}
"""##,
                xpReward: 45
            ),

            // Очередь на двух стеках
            CodingTask(
                id: "med_queue_with_two_stacks",
                titleRU: "Очередь на двух стеках",
                titleEN: "Queue Using Two Stacks",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Реализуйте FIFO очередь с помощью двух LIFO массивов.",
                summaryEN: "Implement FIFO Queue using two LIFO arrays.",
                descriptionRU: ##"""
### Условие
Спроектируйте структуру `MyQueue<T>` с методами `enqueue(_ element: T)` и `dequeue() -> T?`.
"""##,
                descriptionEN: ##"""
Implement FIFO queue with two stacks.
"""##,
                requirementsRU: ["Стек 1 для вставки, Стек 2 для извлечения"],
                requirementsEN: ["Amortized O(1)"],
                starterCode: ##"""
struct MyQueue<T> {
    // Реализация:
    mutating func enqueue(_ element: T) {}
    mutating func dequeue() -> T? { return nil }
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "FIFO порядок", expectedOutput: "1, 2", validationCode: "({ var q = MyQueue<Int>(); q.enqueue(1); q.enqueue(2); return q.dequeue() == 1 && q.dequeue() == 2 })()")
                ],
                hintsRU: ["Переливайте из inbox в outbox при необходимости"],
                hintsEN: ["Transfer between inbox and outbox"],
                solutionCode: ##"""
struct MyQueue<T> {
    private var inbox: [T] = []
    private var outbox: [T] = []
    mutating func enqueue(_ element: T) { inbox.append(element) }
    mutating func dequeue() -> T? {
        if outbox.isEmpty { while let x = inbox.popLast() { outbox.append(x) } }
        return outbox.popLast()
    }
}
"""##,
                xpReward: 45
            ),

            // Проектирование LRU Cache
            CodingTask(
                id: "hard_lru_cache",
                titleRU: "Проектирование LRU Cache",
                titleEN: "Design LRU Cache",
                difficulty: .hard,
                category: .algorithms,
                summaryRU: "Кэш фиксированной емкости с вытеснением наименее используемых.",
                summaryEN: "Bounded cache evicting Least Recently Used items.",
                descriptionRU: ##"""
### Условие
Спроектируйте класс `LRUCache<Key: Hashable, Value>` с емкостью capacity.
"""##,
                descriptionEN: ##"""
Implement LRU Cache.
"""##,
                requirementsRU: ["Соблюдение лимита емкости"],
                requirementsEN: ["Enforce capacity bounds"],
                starterCode: ##"""
final class LRUCache<Key: Hashable, Value> {
    let capacity: Int
    init(capacity: Int) { self.capacity = capacity }
    func get(_ key: Key) -> Value? { return nil }
    func put(_ key: Key, _ value: Value) {}
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Вытеснение", expectedOutput: "a=1, c=3, b=nil", validationCode: "({ let c = LRUCache<String, Int>(capacity: 2); c.put(\"a\", 1); c.put(\"b\", 2); _ = c.get(\"a\"); c.put(\"c\", 3); return c.get(\"a\") == 1 && c.get(\"b\") == nil && c.get(\"c\") == 3 })()")
                ],
                hintsRU: ["Храните массив порядка ключей"],
                hintsEN: ["Track key order array"],
                solutionCode: ##"""
final class LRUCache<Key: Hashable, Value> {
    let capacity: Int
    private var store: [Key: Value] = [:]
    private var order: [Key] = []
    init(capacity: Int) { self.capacity = max(1, capacity) }
    func get(_ key: Key) -> Value? {
        guard let v = store[key] else { return nil }
        touch(key)
        return v
    }
    func put(_ key: Key, _ value: Value) {
        if store[key] != nil { store[key] = value; touch(key) }
        else {
            if order.count >= capacity { store.removeValue(forKey: order.removeFirst()) }
            store[key] = value; order.append(key)
        }
    }
    private func touch(_ k: Key) { if let i = order.firstIndex(of: k) { order.remove(at: i); order.append(k) } }
}
"""##,
                xpReward: 75
            ),

            // Реализация myReduce
            CodingTask(
                id: "hard_custom_filter_reduce",
                titleRU: "Реализация myReduce",
                titleEN: "Custom Generic Reduce",
                difficulty: .hard,
                category: .functionalAndClosures,
                summaryRU: "Создайте универсальную функцию свертки коллекции с аккумулятором.",
                summaryEN: "Generic reduce function folding elements.",
                descriptionRU: ##"""
### Условие
Напишите функцию `myReduce<T, R>(_ list: [T], initial: R, combine: (R, T) -> R) -> R`.
"""##,
                descriptionEN: ##"""
Implement generic myReduce.
"""##,
                requirementsRU: ["Без .reduce"],
                requirementsEN: ["No built-in reduce"],
                starterCode: ##"""
func myReduce<T, R>(_ list: [T], initial: R, combine: (R, T) -> R) -> R {
    return initial
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Сумма чисел", expectedOutput: "10", validationCode: "myReduce([1, 2, 3, 4], initial: 0, combine: +) == 10")
                ],
                hintsRU: ["var acc = initial в цикле for item in list { acc = combine(acc, item) }"],
                hintsEN: ["Accumulate in loop"],
                solutionCode: ##"""
func myReduce<T, R>(_ list: [T], initial: R, combine: (R, T) -> R) -> R {
    var acc = initial
    for x in list { acc = combine(acc, x) }
    return acc
}
"""##,
                xpReward: 65
            ),

            // Сплющивание двумерной матрицы
            CodingTask(
                id: "hard_flatten_array",
                titleRU: "Сплющивание двумерной матрицы",
                titleEN: "Flatten 2D Matrix",
                difficulty: .hard,
                category: .algorithms,
                summaryRU: "Преобразуйте массив массивов [[T]] в одномерный [T].",
                summaryEN: "Convert 2D array to 1D without .flatMap.",
                descriptionRU: ##"""
### Условие
Напишите функцию `flatten<T>(_ matrix: [[T]]) -> [T]` без вызова .flatMap / .joined.
"""##,
                descriptionEN: ##"""
Flatten matrix.
"""##,
                requirementsRU: ["Без .flatMap / .joined"],
                requirementsEN: ["No built-in flatMap"],
                starterCode: ##"""
func flatten<T>(_ matrix: [[T]]) -> [T] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "flatten([[1, 2], [3], [4, 5]])", expectedOutput: "[1, 2, 3, 4, 5]", validationCode: "flatten([[1, 2], [3], [4, 5]]) == [1, 2, 3, 4, 5]")
                ],
                hintsRU: ["Вложенный цикл for row in matrix { for x in row { ... } }"],
                hintsEN: ["Nested loops"],
                solutionCode: ##"""
func flatten<T>(_ matrix: [[T]]) -> [T] {
    var res: [T] = []
    for row in matrix { for x in row { res.append(x) } }
    return res
}
"""##,
                xpReward: 65
            ),

            // Декоратор мемоизации
            CodingTask(
                id: "hard_memoize",
                titleRU: "Декоратор мемоизации",
                titleEN: "Function Memoization Decorator",
                difficulty: .hard,
                category: .functionalAndClosures,
                summaryRU: "Создайте функцию высшего порядка, кэширующую результаты вычислений.",
                summaryEN: "Higher-order caching wrapper.",
                descriptionRU: ##"""
### Условие
Напишите `memoize<In: Hashable, Out>(_ f: @escaping (In) -> Out) -> (In) -> Out`.
"""##,
                descriptionEN: ##"""
Implement memoize wrapper.
"""##,
                requirementsRU: ["Кэширование в захваченном словаре"],
                requirementsEN: ["Capture cache dictionary"],
                starterCode: ##"""
func memoize<In: Hashable, Out>(_ f: @escaping (In) -> Out) -> (In) -> Out {
    return f
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Мемоизация", expectedOutput: "Кэш вызовов", validationCode: "({ var calls = 0; let sq = memoize { (x: Int) -> Int in calls += 1; return x * x }; _ = sq(2); _ = sq(3); _ = sq(2); return calls == 2 })()")
                ],
                hintsRU: ["var cache = [In: Out]() перед возвратом замыкания"],
                hintsEN: ["Check and update cache dictionary"],
                solutionCode: ##"""
func memoize<In: Hashable, Out>(_ f: @escaping (In) -> Out) -> (In) -> Out {
    var cache: [In: Out] = [:]
    return { inVal in
        if let hit = cache[inVal] { return hit }
        let out = f(inVal)
        cache[inVal] = out
        return out
    }
}
"""##,
                xpReward: 75
            ),

            // Потокобезопасный актор банка
            CodingTask(
                id: "hard_actor_vault",
                titleRU: "Потокобезопасный актор банка",
                titleEN: "Thread-Safe Bank Vault Actor",
                difficulty: .hard,
                category: .concurrency,
                summaryRU: "Защитите баланс от Data Races в Swift 6.",
                summaryEN: "Actor isolating bank transactions.",
                descriptionRU: ##"""
### Условие
Создайте `actor BankVaultActor` с методами `deposit(amount:)` и `withdraw(amount:) -> Bool`.
"""##,
                descriptionEN: ##"""
Implement BankVaultActor.
"""##,
                requirementsRU: ["Ключевое слово actor"],
                requirementsEN: ["Actor isolation"],
                starterCode: ##"""
actor BankVaultActor {
    init(startingBalance: Double) {}
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Актор компиляция", expectedOutput: "true", validationCode: "({ let a = BankVaultActor(startingBalance: 100); return true })()")
                ],
                hintsRU: ["actor хранит private var balance"],
                hintsEN: ["Actor isolates state"],
                solutionCode: ##"""
actor BankVaultActor {
    private var balance: Double
    init(startingBalance: Double) { self.balance = max(0, startingBalance) }
    var currentBalance: Double { balance }
    func deposit(amount: Double) { guard amount > 0 else { return }; balance += amount }
    func withdraw(amount: Double) -> Bool { guard amount > 0 && balance >= amount else { return false }; balance -= amount; return true }
}
"""##,
                xpReward: 75
            ),

            // Длиннейшая подстрока без повторов
            CodingTask(
                id: "hard_longest_substring_without_repeating",
                titleRU: "Длиннейшая подстрока без повторов",
                titleEN: "Longest Substring Without Repeating",
                difficulty: .hard,
                category: .algorithms,
                summaryRU: "Найдите длину самой длинной подстроки из неповторяющихся символов (Sliding Window).",
                summaryEN: "Sliding window longest substring without repeats.",
                descriptionRU: ##"""
### Условие
Напишите функцию `lengthOfLongestSubstring(_ s: String) -> Int`. Для 'abcabcbb' ответ 3 ('abc').
"""##,
                descriptionEN: ##"""
Sliding window algorithm.
"""##,
                requirementsRU: ["Сложность O(n)"],
                requirementsEN: ["O(n) time"],
                starterCode: ##"""
func lengthOfLongestSubstring(_ s: String) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "abcabcbb", expectedOutput: "3", validationCode: "lengthOfLongestSubstring(\"abcabcbb\") == 3"),
                    TaskTestCase(title: "Тест 2", inputDescription: "bbbbb", expectedOutput: "1", validationCode: "lengthOfLongestSubstring(\"bbbbb\") == 1")
                ],
                hintsRU: ["Словарь последних позиций символов и плавающее окно"],
                hintsEN: ["Track char index in map"],
                solutionCode: ##"""
func lengthOfLongestSubstring(_ s: String) -> Int {
    var maxLen = 0, start = 0
    var map: [Character: Int] = [:]
    let chars = Array(s)
    for (i, c) in chars.enumerated() {
        if let prev = map[c], prev >= start { start = prev + 1 }
        map[c] = i
        maxLen = max(maxLen, i - start + 1)
    }
    return maxLen
}
"""##,
                xpReward: 75
            ),

            // Слияние интервалов
            CodingTask(
                id: "hard_merge_intervals",
                titleRU: "Слияние интервалов",
                titleEN: "Merge Overlapping Intervals",
                difficulty: .hard,
                category: .algorithms,
                summaryRU: "Объедините пересекающиеся диапазоны времени/чисел.",
                summaryEN: "Merge overlapping numeric intervals.",
                descriptionRU: ##"""
### Условие
Напишите функцию `mergeIntervals(_ intervals: [[Int]]) -> [[Int]]`. Для [[1,3],[2,6],[8,10]] верните [[1,6],[8,10]].
"""##,
                descriptionEN: ##"""
Merge intervals.
"""##,
                requirementsRU: ["Сначала отсортировать по началу"],
                requirementsEN: ["Sort by start point"],
                starterCode: ##"""
func mergeIntervals(_ intervals: [[Int]]) -> [[Int]] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "mergeIntervals([[1, 3], [2, 6], [8, 10]])", expectedOutput: "[[1, 6], [8, 10]]", validationCode: "mergeIntervals([[1, 3], [2, 6], [8, 10]]) == [[1, 6], [8, 10]]")
                ],
                hintsRU: ["Отсортируйте по inter[0], затем сливайте если cur[0] <= last[1]"],
                hintsEN: ["Sort by interval start"],
                solutionCode: ##"""
func mergeIntervals(_ intervals: [[Int]]) -> [[Int]] {
    guard intervals.count > 1 else { return intervals }
    let sorted = intervals.sorted { $0[0] < $1[0] }
    var res: [[Int]] = [sorted[0]]
    for cur in sorted.dropFirst() {
        var last = res.removeLast()
        if cur[0] <= last[1] { last[1] = max(last[1], cur[1]); res.append(last) }
        else { res.append(last); res.append(cur) }
    }
    return res
}
"""##,
                xpReward: 75
            ),

            // Топ K самых частых чисел
            CodingTask(
                id: "hard_top_k_frequent",
                titleRU: "Топ K самых частых чисел",
                titleEN: "Top K Frequent Elements",
                difficulty: .hard,
                category: .algorithms,
                summaryRU: "Найдите k чисел, которые чаще всего встречаются в массиве.",
                summaryEN: "Find k most frequent numbers in array.",
                descriptionRU: ##"""
### Условие
Напишите функцию `topKFrequent(_ nums: [Int], k: Int) -> [Int]`.
"""##,
                descriptionEN: ##"""
Implement topKFrequent.
"""##,
                requirementsRU: ["Сложность быстрее O(n log n)"],
                requirementsEN: ["Count frequency and pick top k"],
                starterCode: ##"""
func topKFrequent(_ nums: [Int], k: Int) -> [Int] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "topKFrequent([1, 1, 1, 2, 2, 3], k: 2)", expectedOutput: "[1, 2]", validationCode: "topKFrequent([1, 1, 1, 2, 2, 3], k: 2) == [1, 2]")
                ],
                hintsRU: ["Посчитайте словарь [Int: Int], затем отсортируйте ключи по значению"],
                hintsEN: ["Sort dictionary by count"],
                solutionCode: ##"""
func topKFrequent(_ nums: [Int], k: Int) -> [Int] {
    var counts: [Int: Int] = [:]
    for x in nums { counts[x, default: 0] += 1 }
    let sortedKeys = counts.sorted { $0.value > $1.value }.map { $0.key }
    return Array(sortedKeys.prefix(k))
}
"""##,
                xpReward: 70
            ),

            // Произведение массива кроме себя
            CodingTask(
                id: "hard_product_except_self",
                titleRU: "Произведение массива кроме себя",
                titleEN: "Product of Array Except Self",
                difficulty: .hard,
                category: .algorithms,
                summaryRU: "Вычислите произведение всех элементов кроме i-го за O(n) без деления.",
                summaryEN: "Array product except self in O(n) without division.",
                descriptionRU: ##"""
### Условие
Напишите функцию `productExceptSelf(_ nums: [Int]) -> [Int]`. Запрещено использовать оператор деления /.
"""##,
                descriptionEN: ##"""
No division operator.
"""##,
                requirementsRU: ["O(n) время, без деления /"],
                requirementsEN: ["No division operator allowed"],
                starterCode: ##"""
func productExceptSelf(_ nums: [Int]) -> [Int] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "productExceptSelf([1, 2, 3, 4])", expectedOutput: "[24, 12, 8, 6]", validationCode: "productExceptSelf([1, 2, 3, 4]) == [24, 12, 8, 6]")
                ],
                hintsRU: ["Префиксные произведения слева направо + суффиксные справа налево"],
                hintsEN: ["Prefix and suffix products"],
                solutionCode: ##"""
func productExceptSelf(_ nums: [Int]) -> [Int] {
    let n = nums.count
    guard n > 0 else { return [] }
    var res = Array(repeating: 1, count: n)
    var left = 1
    for i in 0..<n { res[i] = left; left *= nums[i] }
    var right = 1
    for i in stride(from: n - 1, through: 0, by: -1) { res[i] *= right; right *= nums[i] }
    return res
}
"""##,
                xpReward: 75
            ),

            // Удержание дождевой воды
            CodingTask(
                id: "hard_trapping_rain_water",
                titleRU: "Удержание дождевой воды",
                titleEN: "Trapping Rain Water",
                difficulty: .hard,
                category: .algorithms,
                summaryRU: "Вычислите объем воды, удерживаемый профилем рельефа.",
                summaryEN: "Calculate trapped water volume in O(n).",
                descriptionRU: ##"""
### Условие
Напишите функцию `trapRainWater(_ height: [Int]) -> Int`. Два указателя.
"""##,
                descriptionEN: ##"""
Two pointer trapped water algorithm.
"""##,
                requirementsRU: ["O(n) время, O(1) память"],
                requirementsEN: ["O(n) time, O(1) space"],
                starterCode: ##"""
func trapRainWater(_ height: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "trapRainWater([0,1,0,2,1,0,1,3,2,1,2,1])", expectedOutput: "6", validationCode: "trapRainWater([0,1,0,2,1,0,1,3,2,1,2,1]) == 6")
                ],
                hintsRU: ["Два указателя left и right с отслеживанием leftMax и rightMax"],
                hintsEN: ["Left and right max heights"],
                solutionCode: ##"""
func trapRainWater(_ height: [Int]) -> Int {
    guard height.count > 2 else { return 0 }
    var left = 0, right = height.count - 1
    var lMax = 0, rMax = 0, water = 0
    while left < right {
        if height[left] < height[right] {
            if height[left] >= lMax { lMax = height[left] } else { water += lMax - height[left] }
            left += 1
        } else {
            if height[right] >= rMax { rMax = height[right] } else { water += rMax - height[right] }
            right -= 1
        }
    }
    return water
}
"""##,
                xpReward: 80
            ),

            // Каррирование функций (Currying)
            CodingTask(
                id: "hard_custom_curry",
                titleRU: "Каррирование функций (Currying)",
                titleEN: "Function Currying",
                difficulty: .hard,
                category: .functionalAndClosures,
                summaryRU: "Преобразуйте функцию (A, B) -> C в каррированную форму (A) -> (B) -> C.",
                summaryEN: "Curry binary function.",
                descriptionRU: ##"""
### Условие
Напишите функцию `curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C`.
"""##,
                descriptionEN: ##"""
Functional currying.
"""##,
                requirementsRU: ["Замыкание возвращает замыкание"],
                requirementsEN: ["Nested closures"],
                starterCode: ##"""
func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in f(a, b) } }
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Каррирование суммы", expectedOutput: "15", validationCode: "curry(+)(5)(10) == 15")
                ],
                hintsRU: ["Возвращайте { a in { b in f(a, b) } }"],
                hintsEN: ["Return { a in { b in f(a, b) } }"],
                solutionCode: ##"""
func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in f(a, b) } }
}
"""##,
                xpReward: 65
            ),

            // Глубокое сравнение словарей
            CodingTask(
                id: "hard_deep_equal_dicts",
                titleRU: "Глубокое сравнение словарей",
                titleEN: "Deep Equality of Dictionaries",
                difficulty: .hard,
                category: .algorithms,
                summaryRU: "Реализуйте глубокое рекурсивное сравнение структур JSON [String: Any].",
                summaryEN: "Deep equality check for JSON-like dictionaries.",
                descriptionRU: ##"""
### Условие
Напишите функцию `deepEqualInts(_ a: [String: Int], _ b: [String: Int]) -> Bool`.
"""##,
                descriptionEN: ##"""
Compare dictionary contents.
"""##,
                requirementsRU: ["Сравнение ключей и значений"],
                requirementsEN: ["Key-value equivalence"],
                starterCode: ##"""
func deepEqualInts(_ a: [String: Int], _ b: [String: Int]) -> Bool {
    return false
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Идентичные словари", expectedOutput: "true", validationCode: "deepEqualInts([\"x\": 1, \"y\": 2], [\"y\": 2, \"x\": 1]) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "Разные словари", expectedOutput: "false", validationCode: "deepEqualInts([\"x\": 1], [\"x\": 2]) == false")
                ],
                hintsRU: ["Сравните a == b напрямую или через совпадение всех пар"],
                hintsEN: ["Dictionary equality"],
                solutionCode: ##"""
func deepEqualInts(_ a: [String: Int], _ b: [String: Int]) -> Bool {
    return a == b
}
"""##,
                xpReward: 65
            ),

            // Copy-On-Write (COW) Обертка
            CodingTask(
                id: "hard_custom_cow_wrapper",
                titleRU: "Copy-On-Write (COW) Обертка",
                titleEN: "Copy-On-Write Box",
                difficulty: .hard,
                category: .oopAndPop,
                summaryRU: "Создайте структуру-обертку с семантикой COW через isKnownUniquelyReferenced.",
                summaryEN: "Implement custom COW value wrapper using isKnownUniquelyReferenced.",
                descriptionRU: ##"""
### Условие
Спроектируйте структуру `COWBox<T: AnyObject>` со свойством `value`.
"""##,
                descriptionEN: ##"""
Implement COW box.
"""##,
                requirementsRU: ["isKnownUniquelyReferenced(&storage)"],
                requirementsEN: ["Check unique reference"],
                starterCode: ##"""
final class BoxStorage<T> { var val: T; init(_ v: T) { self.val = v } }
struct COWBox<T: AnyObject> {
    // Реализация:
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "COW компиляция", expectedOutput: "true", validationCode: "true")
                ],
                hintsRU: ["Проверяйте isKnownUniquelyReferenced перед мутацией"],
                hintsEN: ["Use isKnownUniquelyReferenced"],
                solutionCode: ##"""
final class StorageCell<T> { var value: T; init(_ v: T) { self.value = v } }
struct COWBox<T: AnyObject> {
    private var ref: StorageCell<T>
    init(_ value: T) { self.ref = StorageCell(value) }
    var value: T { ref.value }
}
"""##,
                xpReward: 75
            ),

            // Потокобезопасный Debounce Актор
            CodingTask(
                id: "hard_debounce_actor",
                titleRU: "Потокобезопасный Debounce Актор",
                titleEN: "Debounce Task Actor",
                difficulty: .hard,
                category: .concurrency,
                summaryRU: "Откладывайте вызов действия, отменяя предыдущие при частых запросах.",
                summaryEN: "Debounce events cancelling previous work in Swift 6.",
                descriptionRU: ##"""
### Условие
Создайте `actor Debouncer` с методом `debounce(delay: Double, action: @escaping () -> Void)`.
"""##,
                descriptionEN: ##"""
Implement Debouncer actor.
"""##,
                requirementsRU: ["Отмена предыдущего Task"],
                requirementsEN: ["Cancel previous task"],
                starterCode: ##"""
actor Debouncer {
    init() {}
    func run(delaySeconds: Double) {}
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Актор инициализация", expectedOutput: "true", validationCode: "({ let d = Debouncer(); return true })()")
                ],
                hintsRU: ["Храните текущий private var task: Task<Void, Never>?"],
                hintsEN: ["Store active Task handle"],
                solutionCode: ##"""
actor Debouncer {
    private var task: Task<Void, Never>?
    init() {}
    func run(delaySeconds: Double) {
        task?.cancel()
        task = Task { try? await Task.sleep(nanoseconds: UInt64(delaySeconds * 1_000_000_000)) }
    }
}
"""##,
                xpReward: 75
            ),

            // Инвертирование бинарного дерева
            CodingTask(
                id: "hard_binary_tree_invert",
                titleRU: "Инвертирование бинарного дерева",
                titleEN: "Invert Binary Tree",
                difficulty: .hard,
                category: .algorithms,
                summaryRU: "Поменяйте местами левые и правые ветви каждого узла дерева.",
                summaryEN: "Invert binary tree nodes recursively.",
                descriptionRU: ##"""
### Условие
Создайте класс `TreeNode` и функцию `invertTree(_ root: TreeNode?) -> TreeNode?`.
"""##,
                descriptionEN: ##"""
Invert tree.
"""##,
                requirementsRU: ["Рекурсивный обмен левого и правого потомка"],
                requirementsEN: ["Swap left and right pointers"],
                starterCode: ##"""
final class TreeNode { var val: Int; var left: TreeNode?; var right: TreeNode?; init(_ val: Int) { self.val = val } }
func invertTree(_ root: TreeNode?) -> TreeNode? {
    return nil
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Инвертирование", expectedOutput: "true", validationCode: "({ let r = TreeNode(1); r.left = TreeNode(2); r.right = TreeNode(3); _ = invertTree(r); return r.left?.val == 3 && r.right?.val == 2 })()")
                ],
                hintsRU: ["let temp = root?.left; root?.left = invertTree(root?.right); root?.right = invertTree(temp)"],
                hintsEN: ["Recursive swap"],
                solutionCode: ##"""
final class TreeNode { var val: Int; var left: TreeNode?; var right: TreeNode?; init(_ val: Int) { self.val = val } }
func invertTree(_ root: TreeNode?) -> TreeNode? {
    guard let node = root else { return nil }
    let l = invertTree(node.right)
    let r = invertTree(node.left)
    node.left = l
    node.right = r
    return node
}
"""##,
                xpReward: 75
            ),

            // Валидация доски Судоку
            CodingTask(
                id: "hard_valid_sudoku",
                titleRU: "Валидация доски Судоку",
                titleEN: "Valid Sudoku 9x9 Board",
                difficulty: .hard,
                category: .algorithms,
                summaryRU: "Проверьте, содержит ли поле 9x9 дубликаты в строках, колонках и блоках 3x3.",
                summaryEN: "Validate Sudoku board without duplicates.",
                descriptionRU: ##"""
### Условие
Напишите функцию `isValidSudoku(_ board: [[Character]]) -> Bool`. Пустые клетки помечены точкой '.'.
"""##,
                descriptionEN: ##"""
Check 9x9 Sudoku.
"""##,
                requirementsRU: ["Проверка 9 строк, 9 колонок и 9 блоков 3x3"],
                requirementsEN: ["Rows, cols, and 3x3 subboxes"],
                starterCode: ##"""
func isValidSudoku(_ board: [[Character]]) -> Bool {
    return false
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Проверка доски", expectedOutput: "true", validationCode: "true")
                ],
                hintsRU: ["Используйте Set строк вида 'row_0_5', 'col_2_5', 'box_0_1_5'"],
                hintsEN: ["Set strings for row/col/box"],
                solutionCode: ##"""
func isValidSudoku(_ board: [[Character]]) -> Bool {
    var seen = Set<String>()
    for r in 0..<9 {
        for c in 0..<9 {
            let ch = board[r][c]
            guard ch != "." else { continue }
            let rowKey = "r\(r)_\(ch)"
            let colKey = "c\(c)_\(ch)"
            let boxKey = "b\(r/3)_\(c/3)_\(ch)"
            if !seen.insert(rowKey).inserted || !seen.insert(colKey).inserted || !seen.insert(boxKey).inserted { return false }
        }
    }
    return true
}
"""##,
                xpReward: 80
            ),

            // Асинхронный Retry механизм
            CodingTask(
                id: "hard_retry_with_delay",
                titleRU: "Асинхронный Retry механизм",
                titleEN: "Async Retry with Delay",
                difficulty: .hard,
                category: .concurrency,
                summaryRU: "Повторите асинхронную операцию до N раз при возникновении ошибки.",
                summaryEN: "Retry async throws operation with attempts limit.",
                descriptionRU: ##"""
### Условие
Напишите функцию `retryAsync<T>(maxAttempts: Int, block: () async throws -> T) async throws -> T`.
"""##,
                descriptionEN: ##"""
Async retry pattern.
"""##,
                requirementsRU: ["Повтор до maxAttempts"],
                requirementsEN: ["Propagate error if exhausted"],
                starterCode: ##"""
func retryAsync<T>(maxAttempts: Int, block: () async throws -> T) async throws -> T {
    return try await block()
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Успешный вызов", expectedOutput: "true", validationCode: "true")
                ],
                hintsRU: ["Цикл for attempt in 1...maxAttempts со связкой do-catch"],
                hintsEN: ["Loop with do-catch"],
                solutionCode: ##"""
func retryAsync<T>(maxAttempts: Int, block: () async throws -> T) async throws -> T {
    var lastError: Error?
    for _ in 1...max(1, maxAttempts) {
        do { return try await block() }
        catch { lastError = error }
    }
    throw lastError!
}
"""##,
                xpReward: 75
            ),

            // Обнаружение цикла в списке
            CodingTask(
                id: "hard_linked_list_cycle",
                titleRU: "Обнаружение цикла в списке",
                titleEN: "Linked List Cycle Detection",
                difficulty: .hard,
                category: .algorithms,
                summaryRU: "Определите наличие замкнутого цикла в связном списке (Floyd's Cycle).",
                summaryEN: "Detect cycle using slow and fast pointers.",
                descriptionRU: ##"""
### Условие
Создайте класс `ListNode: AnyObject` и функцию `hasCycle(_ head: ListNode?) -> Bool`.
"""##,
                descriptionEN: ##"""
Floyd's algorithm.
"""##,
                requirementsRU: ["O(1) память, два указателя slow и fast"],
                requirementsEN: ["Two pointers slow/fast"],
                starterCode: ##"""
final class ListNode { var val: Int; var next: ListNode?; init(_ val: Int) { self.val = val } }
func hasCycle(_ head: ListNode?) -> Bool {
    return false
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Без цикла", expectedOutput: "false", validationCode: "({ let n = ListNode(1); return hasCycle(n) == false })()")
                ],
                hintsRU: ["slow двигается на 1 шаг, fast — на 2 шага. Если slow === fast — цикл есть!"],
                hintsEN: ["Fast moves by 2, slow by 1"],
                solutionCode: ##"""
final class ListNode { var val: Int; var next: ListNode?; init(_ val: Int) { self.val = val } }
func hasCycle(_ head: ListNode?) -> Bool {
    var slow = head
    var fast = head?.next
    while fast != nil && fast?.next != nil {
        if slow === fast { return true }
        slow = slow?.next
        fast = fast?.next?.next
    }
    return false
}
"""##,
                xpReward: 75
            ),

            // Token Bucket Rate Limiter на Акторах
            CodingTask(
                id: "expert_token_bucket",
                titleRU: "Token Bucket Rate Limiter на Акторах",
                titleEN: "Token Bucket Rate Limiter",
                difficulty: .expert,
                category: .concurrency,
                summaryRU: "Алгоритм ограничения частоты запросов API с пополнением токенов.",
                summaryEN: "Design rate limiter algorithm replenishing tokens.",
                descriptionRU: ##"""
### Условие
Напишите актор `TokenBucketLimiter` с методом `tryAcquire() -> Bool`.
"""##,
                descriptionEN: ##"""
Implement rate limiter.
"""##,
                requirementsRU: ["Потокобезопасная изоляция актора"],
                requirementsEN: ["Thread safety via actor"],
                starterCode: ##"""
actor TokenBucketLimiter {
    init(capacity: Int) {}
    func tryAcquire() -> Bool { return false }
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Лимит вызовов", expectedOutput: "true", validationCode: "true")
                ],
                hintsRU: ["Храните tokens: Int и уменьшайте при вызове"],
                hintsEN: ["Decrement tokens on acquire"],
                solutionCode: ##"""
actor TokenBucketLimiter {
    let capacity: Int
    private var tokens: Int
    init(capacity: Int) { self.capacity = max(1, capacity); self.tokens = self.capacity }
    func tryAcquire() -> Bool { guard tokens > 0 else { return false }; tokens -= 1; return true }
    func replenish() { tokens = min(capacity, tokens + 1) }
}
"""##,
                xpReward: 100
            ),

            // Типобезопасная Машина Состояний (FSM)
            CodingTask(
                id: "expert_state_machine",
                titleRU: "Типобезопасная Машина Состояний (FSM)",
                titleEN: "Generic Finite State Machine",
                difficulty: .expert,
                category: .architecture,
                summaryRU: "Создайте архитектуру переходов между состояниями с валидацией разрешенных путей.",
                summaryEN: "Design state machine verifying valid transitions.",
                descriptionRU: ##"""
### Условие
Спроектируйте структуру `StateMachine<State: Hashable>` с методом `transition(to:) -> Bool`.
"""##,
                descriptionEN: ##"""
State machine.
"""##,
                requirementsRU: ["Валидация зарегистрированных переходов"],
                requirementsEN: ["Validate allowed routes"],
                starterCode: ##"""
struct StateMachine<State: Hashable> {
    private(set) var currentState: State
    init(initialState: State) { self.currentState = initialState }
    mutating func addTransition(from: State, to: State) {}
    mutating func transition(to newState: State) -> Bool { return false }
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Валидный и невалидный переход", expectedOutput: "true, false", validationCode: "({ enum S { case a, b, c }; var m = StateMachine<S>(initialState: .a); m.addTransition(from: .a, to: .b); return m.transition(to: .b) == true && m.transition(to: .c) == false })()")
                ],
                hintsRU: ["Храните allowed: [State: Set<State>]"],
                hintsEN: ["Map [State: Set<State>]"],
                solutionCode: ##"""
struct StateMachine<State: Hashable> {
    private(set) var currentState: State
    private var allowed: [State: Set<State>] = [:]
    init(initialState: State) { self.currentState = initialState }
    mutating func addTransition(from: State, to: State) { allowed[from, default: []].insert(to) }
    mutating func transition(to newState: State) -> Bool {
        guard let nextSet = allowed[currentState], nextSet.contains(newState) else { return false }
        currentState = newState
        return true
    }
}
"""##,
                xpReward: 100
            ),

            // Собственный Result Builder
            CodingTask(
                id: "expert_result_builder",
                titleRU: "Собственный Result Builder",
                titleEN: "Custom Result Builder DSL",
                difficulty: .expert,
                category: .architecture,
                summaryRU: "Напишите @resultBuilder для декларативной сборки строк с разделителем.",
                summaryEN: "Build custom @resultBuilder DSL.",
                descriptionRU: ##"""
### Условие
Создайте `@resultBuilder struct LineBuilder` с методом `buildBlock(_ components: String...) -> String`.
"""##,
                descriptionEN: ##"""
DSL builder.
"""##,
                requirementsRU: ["@resultBuilder атрибут"],
                requirementsEN: ["Join with newline"],
                starterCode: ##"""
@resultBuilder
struct LineBuilder {
    static func buildBlock(_ components: String...) -> String { return "" }
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "DSL сборка", expectedOutput: "\"A\\nB\"", validationCode: "LineBuilder.buildBlock(\"A\", \"B\") == \"A\\nB\"")
                ],
                hintsRU: ["components.joined(separator: \"\\n\")"],
                hintsEN: ["Use joined with newline"],
                solutionCode: ##"""
@resultBuilder
struct LineBuilder {
    static func buildBlock(_ components: String...) -> String { return components.joined(separator: "\n") }
}
"""##,
                xpReward: 100
            ),

            // Параллельная обработка через TaskGroup
            CodingTask(
                id: "expert_batch_taskgroup",
                titleRU: "Параллельная обработка через TaskGroup",
                titleEN: "Concurrent Batch TaskGroup",
                difficulty: .expert,
                category: .concurrency,
                summaryRU: "Спроектируйте структурированную асинхронную конкурентность в Swift 6.",
                summaryEN: "Structured concurrency via withTaskGroup.",
                descriptionRU: ##"""
### Условие
Напишите функцию `parallelMap<T: Sendable, R: Sendable>(_ items: [T], transform: @Sendable @escaping (T) async -> R) async -> [R]`.
"""##,
                descriptionEN: ##"""
TaskGroup map.
"""##,
                requirementsRU: ["withTaskGroup(of: (Int, R).self)"],
                requirementsEN: ["Sendable constraints"],
                starterCode: ##"""
func parallelMap<T: Sendable, R: Sendable>(_ items: [T], transform: @Sendable @escaping (T) async -> R) async -> [R] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Параллельный мап", expectedOutput: "true", validationCode: "true")
                ],
                hintsRU: ["Сохраняйте индексы для восстановления исходного порядка"],
                hintsEN: ["Order results by index"],
                solutionCode: ##"""
func parallelMap<T: Sendable, R: Sendable>(_ items: [T], transform: @Sendable @escaping (T) async -> R) async -> [R] {
    await withTaskGroup(of: (Int, R).self) { group in
        for (i, x) in items.enumerated() { group.addTask { (i, await transform(x)) } }
        var pairs: [(Int, R)] = []
        for await p in group { pairs.append(p) }
        return pairs.sorted { $0.0 < $1.0 }.map { $0.1 }
    }
}
"""##,
                xpReward: 100
            ),

            // Single-Flight Async Кэш
            CodingTask(
                id: "expert_async_cache",
                titleRU: "Single-Flight Async Кэш",
                titleEN: "Single-Flight Async Request Coalescer",
                difficulty: .expert,
                category: .concurrency,
                summaryRU: "Предотвратите дублирующие сетевые запросы одного ключа через Task Coalescing.",
                summaryEN: "Coalesce duplicate concurrent async requests.",
                descriptionRU: ##"""
### Условие
Создайте `actor SingleFlightCache<Key: Hashable, Value>` с методом `fetch(key: Key, loader: () async throws -> Value) async throws -> Value`.
"""##,
                descriptionEN: ##"""
Single flight cache.
"""##,
                requirementsRU: ["Хранение активных Task<Value, Error>"],
                requirementsEN: ["Map active tasks"],
                starterCode: ##"""
actor SingleFlightCache<Key: Hashable, Value> {
    init() {}
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Инициализация", expectedOutput: "true", validationCode: "true")
                ],
                hintsRU: ["Храните private var inFlight: [Key: Task<Value, Error>] = [:]"],
                hintsEN: ["Store in-flight tasks"],
                solutionCode: ##"""
actor SingleFlightCache<Key: Hashable, Value> {
    private var inFlight: [Key: Task<Value, Error>] = [:]
    init() {}
    func fetch(key: Key, loader: @Sendable @escaping () async throws -> Value) async throws -> Value {
        if let existing = inFlight[key] { return try await existing.value }
        let task = Task { try await loader() }
        inFlight[key] = task
        defer { inFlight.removeValue(forKey: key) }
        return try await task.value
    }
}
"""##,
                xpReward: 100
            ),

            // Бинарная куча (Priority Queue)
            CodingTask(
                id: "expert_priority_queue",
                titleRU: "Бинарная куча (Priority Queue)",
                titleEN: "Binary Heap Priority Queue",
                difficulty: .expert,
                category: .algorithms,
                summaryRU: "Реализуйте эффективную очередь с приоритетами на основе двоичной кучи.",
                summaryEN: "Binary heap priority queue.",
                descriptionRU: ##"""
### Условие
Создайте `struct PriorityQueue<T: Comparable>` с методами `push(_:)` и `pop() -> T?` за O(log n).
"""##,
                descriptionEN: ##"""
Binary min/max heap.
"""##,
                requirementsRU: ["O(log n) вставка и удаление"],
                requirementsEN: ["Sift up / Sift down"],
                starterCode: ##"""
struct PriorityQueue<T: Comparable> {
    var count: Int { 0 }
    mutating func push(_ item: T) {}
    mutating func pop() -> T? { return nil }
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Приоритетное извлечение", expectedOutput: "true", validationCode: "({ var pq = PriorityQueue<Int>(); pq.push(5); pq.push(1); pq.push(10); return pq.pop() == 10 && pq.pop() == 5 && pq.pop() == 1 })()")
                ],
                hintsRU: ["Храните массив элементов, поднимайте siftUp и опускайте siftDown"],
                hintsEN: ["Heap array navigation (parent = (i-1)/2)"],
                solutionCode: ##"""
struct PriorityQueue<T: Comparable> {
    private var heap: [T] = []
    var count: Int { heap.count }
    mutating func push(_ item: T) {
        heap.append(item)
        var i = heap.count - 1
        while i > 0 {
            let parent = (i - 1) / 2
            if heap[i] > heap[parent] { heap.swapAt(i, parent); i = parent }
            else { break }
        }
    }
    mutating func pop() -> T? {
        guard !heap.isEmpty else { return nil }
        if heap.count == 1 { return heap.removeFirst() }
        let maxVal = heap[0]
        heap[0] = heap.removeLast()
        var i = 0
        while true {
            let left = 2 * i + 1, right = 2 * i + 2
            var largest = i
            if left < heap.count && heap[left] > heap[largest] { largest = left }
            if right < heap.count && heap[right] > heap[largest] { largest = right }
            if largest != i { heap.swapAt(i, largest); i = largest } else { break }
        }
        return maxVal
    }
}
"""##,
                xpReward: 100
            ),

            // Менеджер Undo/Redo (Command Pattern)
            CodingTask(
                id: "expert_observable_undo_redo",
                titleRU: "Менеджер Undo/Redo (Command Pattern)",
                titleEN: "Undo/Redo Command Manager",
                difficulty: .expert,
                category: .architecture,
                summaryRU: "Архитектура отмены и повтора действий на стеках команд.",
                summaryEN: "Undo/Redo history stack manager.",
                descriptionRU: ##"""
### Условие
Создайте класс `HistoryManager` с методами `execute(doAction:, undoAction:)`, `undo()` и `redo()`.
"""##,
                descriptionEN: ##"""
Command pattern.
"""##,
                requirementsRU: ["Два стека: undoStack и redoStack"],
                requirementsEN: ["Two action stacks"],
                starterCode: ##"""
final class HistoryManager {
    func execute(action: @escaping () -> Void, undo: @escaping () -> Void) {}
    func undo() {}
    func redo() {}
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Undo и Redo", expectedOutput: "true", validationCode: "({ var val = 0; let m = HistoryManager(); m.execute(action: { val = 10 }, undo: { val = 0 }); m.undo(); let was0 = (val == 0); m.redo(); return was0 && val == 10 })()")
                ],
                hintsRU: ["execute очищает redoStack и кладет в undoStack"],
                hintsEN: ["Clear redo on new execute"],
                solutionCode: ##"""
final class HistoryManager {
    private var undoStack: [() -> Void] = []
    private var redoStack: [() -> Void] = []
    func execute(action: @escaping () -> Void, undo: @escaping () -> Void) {
        action()
        undoStack.append(undo)
        redoStack.removeAll()
    }
    func undo() {
        guard let u = undoStack.popLast() else { return }
        u()
    }
    func redo() {
        guard let r = redoStack.popLast() else { return }
        r()
    }
}
"""##,
                xpReward: 90
            ),

            // IoC / Dependency Injection Контейнер
            CodingTask(
                id: "expert_dependency_container",
                titleRU: "IoC / Dependency Injection Контейнер",
                titleEN: "Lightweight DI Container",
                difficulty: .expert,
                category: .architecture,
                summaryRU: "Реализуйте контейнер регистрации и резолва сервисов по типу.",
                summaryEN: "Type-safe Dependency Injection container.",
                descriptionRU: ##"""
### Условие
Спроектируйте `final class ServiceLocator` с методами `register<T>(_ type: T.Type, factory: @escaping () -> T)` и `resolve<T>(_ type: T.Type) -> T?`.
"""##,
                descriptionEN: ##"""
DI Container.
"""##,
                requirementsRU: ["Ключ на основе ObjectIdentifier(type)"],
                requirementsEN: ["ObjectIdentifier type keys"],
                starterCode: ##"""
final class ServiceLocator {
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {}
    func resolve<T>(_ type: T.Type) -> T? { return nil }
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Регистрация и резолв", expectedOutput: "true", validationCode: "({ let loc = ServiceLocator(); loc.register(String.self) { \"Service_OK\" }; return loc.resolve(String.self) == \"Service_OK\" })()")
                ],
                hintsRU: ["Храните factories: [ObjectIdentifier: Any]"],
                hintsEN: ["Map [ObjectIdentifier: factory]"],
                solutionCode: ##"""
final class ServiceLocator {
    private var factories: [ObjectIdentifier: Any] = [:]
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        factories[ObjectIdentifier(type)] = factory
    }
    func resolve<T>(_ type: T.Type) -> T? {
        guard let f = factories[ObjectIdentifier(type)] as? () -> T else { return nil }
        return f()
    }
}
"""##,
                xpReward: 95
            ),

            // Собственный реактивный MiniSubject
            CodingTask(
                id: "expert_combine_like_subject",
                titleRU: "Собственный реактивный MiniSubject",
                titleEN: "Custom Reactive MiniSubject",
                difficulty: .expert,
                category: .architecture,
                summaryRU: "Создайте легкий аналог PassthroughSubject без фреймворка Combine.",
                summaryEN: "Custom event subject publisher.",
                descriptionRU: ##"""
### Условие
Создайте класс `MiniSubject<T>` с методом `send(_ value: T)` и `subscribe(handler:) -> UUID`.
"""##,
                descriptionEN: ##"""
Reactive pattern.
"""##,
                requirementsRU: ["Хранение подписчиков в словаре [UUID: (T) -> Void]"],
                requirementsEN: ["Subscriber dictionary"],
                starterCode: ##"""
final class MiniSubject<T> {
    func send(_ value: T) {}
    func subscribe(_ handler: @escaping (T) -> Void) -> UUID { return UUID() }
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Доставка события", expectedOutput: "true", validationCode: "({ var r = 0; let s = MiniSubject<Int>(); _ = s.subscribe { r = $0 }; s.send(42); return r == 42 })()")
                ],
                hintsRU: ["При send обходите всех подписчиков и вызывайте handler"],
                hintsEN: ["Dispatch to all active subscribers"],
                solutionCode: ##"""
final class MiniSubject<T> {
    private var subs: [UUID: (T) -> Void] = [:]
    func send(_ value: T) { for (_, h) in subs { h(value) } }
    func subscribe(_ handler: @escaping (T) -> Void) -> UUID {
        let id = UUID()
        subs[id] = handler
        return id
    }
    func unsubscribe(_ id: UUID) { subs.removeValue(forKey: id) }
}
"""##,
                xpReward: 95
            ),

            // Кастомный AsyncStream Тикер
            CodingTask(
                id: "expert_async_stream_ticker",
                titleRU: "Кастомный AsyncStream Тикер",
                titleEN: "Custom AsyncStream Ticker",
                difficulty: .expert,
                category: .concurrency,
                summaryRU: "Спроектируйте генератор асинхронной последовательности тиков.",
                summaryEN: "AsyncStream tick producer.",
                descriptionRU: ##"""
### Условие
Напишите функцию `makeRangeStream(count: Int) -> AsyncStream<Int>`.
"""##,
                descriptionEN: ##"""
AsyncStream creation.
"""##,
                requirementsRU: ["AsyncStream { continuation in ... }"],
                requirementsEN: ["Yield elements to continuation"],
                starterCode: ##"""
func makeRangeStream(count: Int) -> AsyncStream<Int> {
    return AsyncStream { $0.finish() }
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Компиляция стрима", expectedOutput: "true", validationCode: "true")
                ],
                hintsRU: ["В цикле вызывайте continuation.yield(i), затем continuation.finish()"],
                hintsEN: ["Yield values then finish"],
                solutionCode: ##"""
func makeRangeStream(count: Int) -> AsyncStream<Int> {
    return AsyncStream { continuation in
        for i in 0..<count { continuation.yield(i) }
        continuation.finish()
    }
}
"""##,
                xpReward: 90
            ),

            // Префиксное дерево (Trie)
            CodingTask(
                id: "expert_trie_prefix_tree",
                titleRU: "Префиксное дерево (Trie)",
                titleEN: "Prefix Tree (Trie)",
                difficulty: .expert,
                category: .algorithms,
                summaryRU: "Спроектируйте префиксное дерево поиска и автодополнения слов.",
                summaryEN: "Trie prefix tree with insert and startsWith.",
                descriptionRU: ##"""
### Условие
Создайте `final class Trie` с методами `insert(_ word: String)` и `startsWith(_ prefix: String) -> Bool`.
"""##,
                descriptionEN: ##"""
Implement Trie.
"""##,
                requirementsRU: ["Дерево узлов с потомками [Character: TrieNode]"],
                requirementsEN: ["Node children map"],
                starterCode: ##"""
final class Trie {
    func insert(_ word: String) {}
    func startsWith(_ prefix: String) -> Bool { return false }
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Префиксный поиск", expectedOutput: "true", validationCode: "({ let t = Trie(); t.insert(\"apple\"); return t.startsWith(\"app\") == true && t.startsWith(\"ban\") == false })()")
                ],
                hintsRU: ["Каждый узел содержит children: [Character: Node] и isEndOfWord: Bool"],
                hintsEN: ["Node tree traversal"],
                solutionCode: ##"""
final class TrieNode { var children: [Character: TrieNode] = [:]; var isEnd = false }
final class Trie {
    private let root = TrieNode()
    func insert(_ word: String) {
        var cur = root
        for c in word { cur = cur.children[c, default: TrieNode()] }
        cur.isEnd = true
    }
    func startsWith(_ prefix: String) -> Bool {
        var cur = root
        for c in prefix { guard let n = cur.children[c] else { return false }; cur = n }
        return true
    }
}
"""##,
                xpReward: 100
            ),

            // Модель Read-Write Lock на Акторах
            CodingTask(
                id: "expert_read_write_lock_actor",
                titleRU: "Модель Read-Write Lock на Акторах",
                titleEN: "Read-Write Lock Actor",
                difficulty: .expert,
                category: .concurrency,
                summaryRU: "Множественное чтение без блокировок, эксклюзивная запись.",
                summaryEN: "Reader-Writer lock coordination.",
                descriptionRU: ##"""
### Условие
Создайте `actor ReadWriteVault<T>` со свойствами безопасного чтения и записи.
"""##,
                descriptionEN: ##"""
Reader writer actor.
"""##,
                requirementsRU: ["Изоляция через actor в Swift 6"],
                requirementsEN: ["Actor synchronization"],
                starterCode: ##"""
actor ReadWriteVault<T> {
    private var value: T
    init(_ v: T) { self.value = v }
    func read() -> T { return value }
    func write(_ newV: T) { self.value = newV }
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Vault чтение и запись", expectedOutput: "true", validationCode: "true")
                ],
                hintsRU: ["Актор автоматически сериализует вызовы"],
                hintsEN: ["Actors serialize access natively"],
                solutionCode: ##"""
actor ReadWriteVault<T> {
    private var value: T
    init(_ v: T) { self.value = v }
    func read() -> T { value }
    func write(_ newV: T) { self.value = newV }
}
"""##,
                xpReward: 90
            ),

            // Калькулятор выражений со скобками
            CodingTask(
                id: "expert_expression_evaluator",
                titleRU: "Калькулятор выражений со скобками",
                titleEN: "Math Expression Evaluator",
                difficulty: .expert,
                category: .algorithms,
                summaryRU: "Вычислите значение математической строки '2 + 3 * (4 - 1)'.",
                summaryEN: "Evaluate arithmetic expression with precedence.",
                descriptionRU: ##"""
### Условие
Напишите функцию `simpleEval(_ a: Int, _ op: Character, _ b: Int) -> Int`.
"""##,
                descriptionEN: ##"""
Basic operator evaluation.
"""##,
                requirementsRU: ["Поддержка +, -, *"],
                requirementsEN: ["Arithmetic operators"],
                starterCode: ##"""
func simpleEval(_ a: Int, _ op: Character, _ b: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "2 + 3", expectedOutput: "5", validationCode: "simpleEval(2, \"+\", 3) == 5"),
                    TaskTestCase(title: "Тест 2", inputDescription: "4 * 5", expectedOutput: "20", validationCode: "simpleEval(4, \"*\", 5) == 20")
                ],
                hintsRU: ["Используйте switch op"],
                hintsEN: ["Switch over operator"],
                solutionCode: ##"""
func simpleEval(_ a: Int, _ op: Character, _ b: Int) -> Int {
    switch op {
    case "+": return a + b
    case "-": return a - b
    case "*": return a * b
    case "/": return b != 0 ? a / b : 0
    default: return 0
    }
}
"""##,
                xpReward: 90
            ),

            // Защита от Actor Reentrancy
            CodingTask(
                id: "expert_actor_reentrancy_guard",
                titleRU: "Защита от Actor Reentrancy",
                titleEN: "Actor Reentrancy Guard",
                difficulty: .expert,
                category: .concurrency,
                summaryRU: "Предотвратите повреждение состояния при await-паузах внутри методов актора.",
                summaryEN: "Guard against state corruption during suspension points in actors.",
                descriptionRU: ##"""
### Условие
Создайте `actor SafeCounter` с методом `increment() -> Int`.
"""##,
                descriptionEN: ##"""
Actor reentrancy.
"""##,
                requirementsRU: ["Атомарное изменение состояния"],
                requirementsEN: ["Atomic state update"],
                starterCode: ##"""
actor SafeCounter {
    private var count = 0
    func increment() -> Int { count += 1; return count }
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "Счетчик", expectedOutput: "true", validationCode: "true")
                ],
                hintsRU: ["Обновляйте локальные переменные до вызова suspension points"],
                hintsEN: ["Update state before await"],
                solutionCode: ##"""
actor SafeCounter {
    private var count = 0
    func increment() -> Int { count += 1; return count }
    func reset() { count = 0 }
}
"""##,
                xpReward: 95
            )
,

            // [LeetCode #9] Палиндром числа (Palindrome Number)
            CodingTask(
                id: "lc_palindrome_number",
                titleRU: "[LeetCode #9] Палиндром числа (Palindrome Number)",
                titleEN: "[LeetCode #9] Palindrome Number",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Определите, читается ли число слева направо и справа налево одинаково без преобразования в строку.",
                summaryEN: "Determine whether an integer is a palindrome without string conversion.",
                descriptionRU: ##"""
### Условие
Напишите функцию `isPalindromeNumber(_ x: Int) -> Bool`, проверяющую, является ли целое число палиндромом.
Отрицательные числа палиндромами не являются.

### Примеры
* `121` -> `true`
* `-121` -> `false`
* `10` -> `false`
"""##,
                descriptionEN: ##"""
Implement `isPalindromeNumber(_ x: Int) -> Bool` to check if an integer is a palindrome.
"""##,
                requirementsRU: ["Не используйте приведение числа к строке", "O(log10(x)) по времени, O(1) по памяти"],
                requirementsEN: ["Do not convert to string", "O(log10(x)) time, O(1) memory"],
                starterCode: ##"""
func isPalindromeNumber(_ x: Int) -> Bool {
    // Ваше решение
    return false
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "isPalindromeNumber(121)", expectedOutput: "true", validationCode: "isPalindromeNumber(121) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "isPalindromeNumber(-121)", expectedOutput: "false", validationCode: "isPalindromeNumber(-121) == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "isPalindromeNumber(10)", expectedOutput: "false", validationCode: "isPalindromeNumber(10) == false"),
                    TaskTestCase(title: "Тест 4", inputDescription: "isPalindromeNumber(1221)", expectedOutput: "true", validationCode: "isPalindromeNumber(1221) == true")
                ],
                hintsRU: ["Если x < 0 или (x % 10 == 0 и x != 0), число не может быть палиндромом.", "Переверните вторую половину числа через деление на 10."],
                hintsEN: ["Negative numbers cannot be palindromes.", "Revert half of the number."],
                solutionCode: ##"""
func isPalindromeNumber(_ x: Int) -> Bool {
    if x < 0 || (x % 10 == 0 && x != 0) { return false }
    var n = x
    var rev = 0
    while n > rev {
        rev = rev * 10 + n % 10
        n /= 10
    }
    return n == rev || n == rev / 10
}
"""##,
                xpReward: 35
            ),

            // [LeetCode #13] Римские числа в целые (Roman to Integer)
            CodingTask(
                id: "lc_roman_to_integer",
                titleRU: "[LeetCode #13] Римские числа в целые (Roman to Integer)",
                titleEN: "[LeetCode #13] Roman to Integer",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Преобразуйте строку с римским числом (I, V, X, L, C, D, M) в арабское целое число.",
                summaryEN: "Convert a roman numeral string to an integer.",
                descriptionRU: ##"""
### Условие
Напишите функцию `romanToInt(_ s: String) -> Int`.
Римские цифры: I=1, V=5, X=10, L=50, C=100, D=500, M=1000.
Если меньшая цифра стоит перед большей (IV, IX, XL, XC, CD, CM), она вычитается.
"""##,
                descriptionEN: ##"""
Implement `romanToInt(_ s: String) -> Int` to convert roman numeral to integer.
"""##,
                requirementsRU: ["Корректная обработка вычитаемых префиксов IV, IX и т.д."],
                requirementsEN: ["Handle subtractive cases like IV, IX, etc."],
                starterCode: ##"""
func romanToInt(_ s: String) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "romanToInt(\"III\")", expectedOutput: "3", validationCode: "romanToInt(\"III\") == 3"),
                    TaskTestCase(title: "Тест 2", inputDescription: "romanToInt(\"LVIII\")", expectedOutput: "58", validationCode: "romanToInt(\"LVIII\") == 58"),
                    TaskTestCase(title: "Тест 3", inputDescription: "romanToInt(\"MCMXCIV\")", expectedOutput: "1994", validationCode: "romanToInt(\"MCMXCIV\") == 1994")
                ],
                hintsRU: ["Сопоставьте символы значениям. Если текущее значение меньше следующего, вычитайте его."],
                hintsEN: ["Map chars to values. If current value is less than next, subtract it."],
                solutionCode: ##"""
func romanToInt(_ s: String) -> Int {
    let map: [Character: Int] = ["I": 1, "V": 5, "X": 10, "L": 50, "C": 100, "D": 500, "M": 1000]
    let chars = Array(s)
    var total = 0
    for i in 0..<chars.count {
        let val = map[chars[i]] ?? 0
        if i + 1 < chars.count && val < (map[chars[i + 1]] ?? 0) {
            total -= val
        } else {
            total += val
        }
    }
    return total
}
"""##,
                xpReward: 35
            ),

            // [LeetCode #14] Самый длинный общий префикс (Longest Common Prefix)
            CodingTask(
                id: "lc_longest_common_prefix",
                titleRU: "[LeetCode #14] Самый длинный общий префикс (Longest Common Prefix)",
                titleEN: "[LeetCode #14] Longest Common Prefix",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Найдите наибольшую общую начальную подстроку среди массива строк.",
                summaryEN: "Find the longest common prefix among an array of strings.",
                descriptionRU: ##"""
### Условие
Напишите функцию `longestCommonPrefix(_ strs: [String]) -> String`.
Если общего префикса нет, верните `""`.
"""##,
                descriptionEN: ##"""
Find the longest common prefix among an array of strings.
"""##,
                requirementsRU: ["Корректная обработка пустого массива и одиночной строки"],
                requirementsEN: ["Handle empty array and single string correctly"],
                starterCode: ##"""
func longestCommonPrefix(_ strs: [String]) -> String {
    return ""
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "longestCommonPrefix([\"flower\",\"flow\",\"flight\"])", expectedOutput: "\"fl\"", validationCode: "longestCommonPrefix([\"flower\",\"flow\",\"flight\"]) == \"fl\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "longestCommonPrefix([\"dog\",\"racecar\",\"car\"])", expectedOutput: "\"\"", validationCode: "longestCommonPrefix([\"dog\",\"racecar\",\"car\"]) == \"\""),
                    TaskTestCase(title: "Тест 3", inputDescription: "longestCommonPrefix([\"interspecies\",\"interstellar\",\"interstate\"])", expectedOutput: "\"inters\"", validationCode: "longestCommonPrefix([\"interspecies\",\"interstellar\",\"interstate\"]) == \"inters\"")
                ],
                hintsRU: ["Возьмите первую строку как базовую и укорачивайте ее, пока остальные строки не начинаются с нее."],
                hintsEN: ["Use the first string as candidate prefix and reduce it until all strings match."],
                solutionCode: ##"""
func longestCommonPrefix(_ strs: [String]) -> String {
    guard let first = strs.first, !first.isEmpty else { return "" }
    var prefix = first
    for s in strs.dropFirst() {
        while !s.hasPrefix(prefix) {
            prefix.removeLast()
            if prefix.isEmpty { return "" }
        }
    }
    return prefix
}
"""##,
                xpReward: 35
            ),

            // [LeetCode #27] Удаление элементов по значению (Remove Element)
            CodingTask(
                id: "lc_remove_element",
                titleRU: "[LeetCode #27] Удаление элементов по значению (Remove Element)",
                titleEN: "[LeetCode #27] Remove Element",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Удалите все вхождения заданного значения из массива in-place и верните новую длину.",
                summaryEN: "Remove all instances of val in-place and return new count.",
                descriptionRU: ##"""
### Условие
Напишите функцию `removeElement(_ nums: inout [Int], _ val: Int) -> Int`.
Переставьте оставшиеся элементы в начало массива `nums` и верните их количество.
"""##,
                descriptionEN: ##"""
Implement `removeElement(_ nums: inout [Int], _ val: Int) -> Int` in-place.
"""##,
                requirementsRU: ["In-place модификация массива", "O(N) время, O(1) память"],
                requirementsEN: ["In-place modification", "O(N) time, O(1) space"],
                starterCode: ##"""
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "removeElement(&[3,2,2,3], 3)", expectedOutput: "2", validationCode: "({ var arr = [3,2,2,3]; let k = removeElement(&arr, 3); return k == 2 && arr.prefix(k).elementsEqual([2,2]) })()"),
                    TaskTestCase(title: "Тест 2", inputDescription: "removeElement(&[0,1,2,2,3,0,4,2], 2)", expectedOutput: "5", validationCode: "({ var arr = [0,1,2,2,3,0,4,2]; let k = removeElement(&arr, 2); return k == 5 && !arr.prefix(k).contains(2) })()")
                ],
                hintsRU: ["Используйте указатель позиции для сохранения элементов, не равных val."],
                hintsEN: ["Use a write index pointer for non-val elements."],
                solutionCode: ##"""
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
    var writeIndex = 0
    for num in nums {
        if num != val {
            nums[writeIndex] = num
            writeIndex += 1
        }
    }
    return writeIndex
}
"""##,
                xpReward: 30
            ),

            // [LeetCode #35] Позиция вставки (Search Insert Position)
            CodingTask(
                id: "lc_search_insert_position",
                titleRU: "[LeetCode #35] Позиция вставки (Search Insert Position)",
                titleEN: "[LeetCode #35] Search Insert Position",
                difficulty: .easy,
                category: .algorithms,
                summaryRU: "Найдите индекс элемента в отсортированном массиве или индекс, куда его следует вставить, за O(log N).",
                summaryEN: "Find target index or insert position in sorted array in O(log N).",
                descriptionRU: ##"""
### Условие
Напишите функцию `searchInsert(_ nums: [Int], _ target: Int) -> Int` со сложностью O(log N).
"""##,
                descriptionEN: ##"""
Implement binary search insert position in O(log N).
"""##,
                requirementsRU: ["Бинарный поиск за O(log N)"],
                requirementsEN: ["Binary search O(log N)"],
                starterCode: ##"""
func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "searchInsert([1,3,5,6], 5)", expectedOutput: "2", validationCode: "searchInsert([1,3,5,6], 5) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "searchInsert([1,3,5,6], 2)", expectedOutput: "1", validationCode: "searchInsert([1,3,5,6], 2) == 1"),
                    TaskTestCase(title: "Тест 3", inputDescription: "searchInsert([1,3,5,6], 7)", expectedOutput: "4", validationCode: "searchInsert([1,3,5,6], 7) == 4")
                ],
                hintsRU: ["Стандартный бинарный поиск: когда low > high, low указывает на позицию вставки."],
                hintsEN: ["When low > high in binary search, low points to insert position."],
                solutionCode: ##"""
func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    var low = 0
    var high = nums.count - 1
    while low <= high {
        let mid = low + (high - low) / 2
        if nums[mid] == target {
            return mid
        } else if nums[mid] < target {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }
    return low
}
"""##,
                xpReward: 35
            ),

            // [LeetCode #58] Длина последнего слова (Length of Last Word)
            CodingTask(
                id: "lc_length_of_last_word",
                titleRU: "[LeetCode #58] Длина последнего слова (Length of Last Word)",
                titleEN: "[LeetCode #58] Length of Last Word",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Верните длину последнего слова в строке, игнорируя завершающие пробелы.",
                summaryEN: "Return length of last word, ignoring trailing whitespaces.",
                descriptionRU: ##"""
### Условие
Напишите функцию `lengthOfLastWord(_ s: String) -> Int`.
Слово — это максимальная подстрока из непробельных символов.
"""##,
                descriptionEN: ##"""
Find length of last word in string with trailing whitespaces.
"""##,
                requirementsRU: ["Не расходовать лишнюю память O(N)"],
                requirementsEN: ["Avoid excess memory allocation"],
                starterCode: ##"""
func lengthOfLastWord(_ s: String) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "lengthOfLastWord(\"Hello World\")", expectedOutput: "5", validationCode: "lengthOfLastWord(\"Hello World\") == 5"),
                    TaskTestCase(title: "Тест 2", inputDescription: "lengthOfLastWord(\"   fly me   to   the moon  \")", expectedOutput: "4", validationCode: "lengthOfLastWord(\"   fly me   to   the moon  \") == 4"),
                    TaskTestCase(title: "Тест 3", inputDescription: "lengthOfLastWord(\"luffy is still joyboy\")", expectedOutput: "6", validationCode: "lengthOfLastWord(\"luffy is still joyboy\") == 6")
                ],
                hintsRU: ["Сканируйте с конца: пропустите пробелы, затем считайте буквы до первого пробела."],
                hintsEN: ["Scan backwards: skip whitespace, count chars."],
                solutionCode: ##"""
func lengthOfLastWord(_ s: String) -> Int {
    var length = 0
    for char in s.reversed() {
        if char == " " {
            if length > 0 { break }
        } else {
            length += 1
        }
    }
    return length
}
"""##,
                xpReward: 25
            ),

            // [LeetCode #66] Плюс один (Plus One)
            CodingTask(
                id: "lc_plus_one",
                titleRU: "[LeetCode #66] Плюс один (Plus One)",
                titleEN: "[LeetCode #66] Plus One",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Прибавьте единицу к числу, представленному массивом десятичных цифр.",
                summaryEN: "Add one to a number represented as an array of digits.",
                descriptionRU: ##"""
### Условие
Напишите функцию `plusOne(_ digits: [Int]) -> [Int]`.
Обработайте переносы разрядов (например, `[9, 9]` -> `[1, 0, 0]`).
"""##,
                descriptionEN: ##"""
Implement `plusOne(_ digits: [Int]) -> [Int]` handling carry.
"""##,
                requirementsRU: ["Корректная обработка каскадного переноса через 9"],
                requirementsEN: ["Correctly handle carry across multiple 9s"],
                starterCode: ##"""
func plusOne(_ digits: [Int]) -> [Int] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "plusOne([1,2,3])", expectedOutput: "[1,2,4]", validationCode: "plusOne([1,2,3]) == [1,2,4]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "plusOne([4,3,2,1])", expectedOutput: "[4,3,2,2]", validationCode: "plusOne([4,3,2,1]) == [4,3,2,2]"),
                    TaskTestCase(title: "Тест 3", inputDescription: "plusOne([9,9])", expectedOutput: "[1,0,0]", validationCode: "plusOne([9,9]) == [1,0,0]")
                ],
                hintsRU: ["Идите с конца массива: если цифра < 9, увеличьте ее и верните результат. Если 9, замените на 0."],
                hintsEN: ["Iterate backwards: if < 9 add 1 and return, else set to 0 and carry."],
                solutionCode: ##"""
func plusOne(_ digits: [Int]) -> [Int] {
    var res = digits
    for i in stride(from: res.count - 1, through: 0, by: -1) {
        if res[i] < 9 {
            res[i] += 1
            return res
        }
        res[i] = 0
    }
    return [1] + res
}
"""##,
                xpReward: 30
            ),

            // [LeetCode #70] Подъём по лестнице (Climbing Stairs)
            CodingTask(
                id: "lc_climbing_stairs",
                titleRU: "[LeetCode #70] Подъём по лестнице (Climbing Stairs)",
                titleEN: "[LeetCode #70] Climbing Stairs",
                difficulty: .easy,
                category: .algorithms,
                summaryRU: "Посчитайте количество уникальных способов подняться на вершину лестницы из n ступеней (1 или 2 шага).",
                summaryEN: "Count unique ways to climb n stairs with steps 1 or 2.",
                descriptionRU: ##"""
### Условие
Напишите функцию `climbStairs(_ n: Int) -> Int`.
На каждом шаге вы можете сделать 1 или 2 ступеньки.
"""##,
                descriptionEN: ##"""
Count unique ways to reach top with step size 1 or 2.
"""##,
                requirementsRU: ["Динамическое программирование O(N) времени, O(1) памяти"],
                requirementsEN: ["DP with O(N) time and O(1) space"],
                starterCode: ##"""
func climbStairs(_ n: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "climbStairs(2)", expectedOutput: "2", validationCode: "climbStairs(2) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "climbStairs(3)", expectedOutput: "3", validationCode: "climbStairs(3) == 3"),
                    TaskTestCase(title: "Тест 3", inputDescription: "climbStairs(5)", expectedOutput: "8", validationCode: "climbStairs(5) == 8")
                ],
                hintsRU: ["f(n) = f(n-1) + f(n-2) — числа Фибоначчи."],
                hintsEN: ["f(n) = f(n-1) + f(n-2), standard Fibonacci recurrence."],
                solutionCode: ##"""
func climbStairs(_ n: Int) -> Int {
    if n <= 2 { return n }
    var a = 1
    var b = 2
    for _ in 3...n {
        let temp = a + b
        a = b
        b = temp
    }
    return b
}
"""##,
                xpReward: 35
            ),

            // [LeetCode #136] Одиночное число (Single Number XOR)
            CodingTask(
                id: "lc_single_number",
                titleRU: "[LeetCode #136] Одиночное число (Single Number XOR)",
                titleEN: "[LeetCode #136] Single Number",
                difficulty: .easy,
                category: .algorithms,
                summaryRU: "Найдите элемент, который появляется ровно один раз, если остальные появляются дважды.",
                summaryEN: "Find the element appearing once when all others appear twice.",
                descriptionRU: ##"""
### Условие
Напишите функцию `singleNumber(_ nums: [Int]) -> Int`.
Сложность должна быть строго O(N) по времени и O(1) по памяти.
"""##,
                descriptionEN: ##"""
Find single number in O(N) time and O(1) memory.
"""##,
                requirementsRU: ["Использование побитового XOR `^`", "O(1) дополнительной памяти"],
                requirementsEN: ["Bitwise XOR `^`", "O(1) auxiliary space"],
                starterCode: ##"""
func singleNumber(_ nums: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "singleNumber([2,2,1])", expectedOutput: "1", validationCode: "singleNumber([2,2,1]) == 1"),
                    TaskTestCase(title: "Тест 2", inputDescription: "singleNumber([4,1,2,1,2])", expectedOutput: "4", validationCode: "singleNumber([4,1,2,1,2]) == 4"),
                    TaskTestCase(title: "Тест 3", inputDescription: "singleNumber([1])", expectedOutput: "1", validationCode: "singleNumber([1]) == 1")
                ],
                hintsRU: ["Свойства XOR: a ^ a = 0, a ^ 0 = a. Проксорте все числа массива."],
                hintsEN: ["XOR properties: a ^ a = 0, a ^ 0 = a. XOR all elements."],
                solutionCode: ##"""
func singleNumber(_ nums: [Int]) -> Int {
    return nums.reduce(0, ^)
}
"""##,
                xpReward: 35
            ),

            // [LeetCode #169] Элемент большинства (Majority Element)
            CodingTask(
                id: "lc_majority_element",
                titleRU: "[LeetCode #169] Элемент большинства (Majority Element)",
                titleEN: "[LeetCode #169] Majority Element",
                difficulty: .easy,
                category: .algorithms,
                summaryRU: "Найдите элемент, встречающийся более ⌊n / 2⌋ раз, используя алгоритм Бойера-Мура за O(1) памяти.",
                summaryEN: "Find majority element using Boyer-Moore algorithm in O(1) memory.",
                descriptionRU: ##"""
### Условие
Напишите функцию `majorityElement(_ nums: [Int]) -> Int`.
Элемент большинства гарантированно существует.
"""##,
                descriptionEN: ##"""
Implement Boyer-Moore Majority Vote algorithm.
"""##,
                requirementsRU: ["O(N) времени, O(1) памяти"],
                requirementsEN: ["O(N) time, O(1) space"],
                starterCode: ##"""
func majorityElement(_ nums: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "majorityElement([3,2,3])", expectedOutput: "3", validationCode: "majorityElement([3,2,3]) == 3"),
                    TaskTestCase(title: "Тест 2", inputDescription: "majorityElement([2,2,1,1,1,2,2])", expectedOutput: "2", validationCode: "majorityElement([2,2,1,1,1,2,2]) == 2")
                ],
                hintsRU: ["Поддерживайте кандидата и счетчик. Если счетчик 0, берем нового кандидата."],
                hintsEN: ["Maintain candidate and count. If count is 0, switch candidate."],
                solutionCode: ##"""
func majorityElement(_ nums: [Int]) -> Int {
    var candidate = nums[0]
    var count = 0
    for num in nums {
        if count == 0 {
            candidate = num
        }
        count += (num == candidate) ? 1 : -1
    }
    return candidate
}
"""##,
                xpReward: 35
            ),

            // [LeetCode #217] Содержит ли дубликаты (Contains Duplicate)
            CodingTask(
                id: "lc_contains_duplicate",
                titleRU: "[LeetCode #217] Содержит ли дубликаты (Contains Duplicate)",
                titleEN: "[LeetCode #217] Contains Duplicate",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Определите, встречается ли хотя бы одно значение в массиве дважды.",
                summaryEN: "Return true if any value appears at least twice in the array.",
                descriptionRU: ##"""
### Условие
Напишите функцию `containsDuplicate(_ nums: [Int]) -> Bool`.
"""##,
                descriptionEN: ##"""
Check for duplicate values in array.
"""##,
                requirementsRU: ["O(N) времени через Set"],
                requirementsEN: ["O(N) time via Set"],
                starterCode: ##"""
func containsDuplicate(_ nums: [Int]) -> Bool {
    return false
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "containsDuplicate([1,2,3,1])", expectedOutput: "true", validationCode: "containsDuplicate([1,2,3,1]) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "containsDuplicate([1,2,3,4])", expectedOutput: "false", validationCode: "containsDuplicate([1,2,3,4]) == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "containsDuplicate([1,1,1,3,3,4,3,2,4,2])", expectedOutput: "true", validationCode: "containsDuplicate([1,1,1,3,3,4,3,2,4,2]) == true")
                ],
                hintsRU: ["Сравните количество элементов массива и множества Set(nums)."],
                hintsEN: ["Compare count of nums and Set(nums)."],
                solutionCode: ##"""
func containsDuplicate(_ nums: [Int]) -> Bool {
    return Set(nums).count != nums.count
}
"""##,
                xpReward: 25
            ),

            // [LeetCode #268] Пропущенное число (Missing Number)
            CodingTask(
                id: "lc_missing_number",
                titleRU: "[LeetCode #268] Пропущенное число (Missing Number)",
                titleEN: "[LeetCode #268] Missing Number",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Найдите единственное пропущенное число в диапазоне [0, n] за O(N) времени и O(1) памяти.",
                summaryEN: "Find the missing number in range [0, n] with O(1) space.",
                descriptionRU: ##"""
### Условие
Напишите функцию `missingNumber(_ nums: [Int]) -> Int`.
Массив длины n содержит уникальные числа из диапазона [0, n].
"""##,
                descriptionEN: ##"""
Find missing number in [0, n] in O(1) memory.
"""##,
                requirementsRU: ["Формула суммы Гаусса n * (n + 1) / 2"],
                requirementsEN: ["Gauss sum formula n * (n + 1) / 2"],
                starterCode: ##"""
func missingNumber(_ nums: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "missingNumber([3,0,1])", expectedOutput: "2", validationCode: "missingNumber([3,0,1]) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "missingNumber([0,1])", expectedOutput: "2", validationCode: "missingNumber([0,1]) == 2"),
                    TaskTestCase(title: "Тест 3", inputDescription: "missingNumber([9,6,4,2,3,5,7,0,1])", expectedOutput: "8", validationCode: "missingNumber([9,6,4,2,3,5,7,0,1]) == 8")
                ],
                hintsRU: ["Ожидаемая сумма чисел от 0 до n равна n * (n + 1) / 2. Вычтите из нее сумму массива."],
                hintsEN: ["Expected sum is n * (n + 1) / 2. Subtract actual sum."],
                solutionCode: ##"""
func missingNumber(_ nums: [Int]) -> Int {
    let n = nums.count
    let expectedSum = n * (n + 1) / 2
    let actualSum = nums.reduce(0, +)
    return expectedSum - actualSum
}
"""##,
                xpReward: 30
            ),

            // [Codeforces 4A] Арбуз (Watermelon)
            CodingTask(
                id: "cf_4a_watermelon",
                titleRU: "[Codeforces 4A] Арбуз (Watermelon)",
                titleEN: "[Codeforces 4A] Watermelon",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Проверьте, можно ли разделить арбуз весом w на две части, каждая из которых весит четное положительное число килограммов.",
                summaryEN: "Check if watermelon of weight w can be divided into two even positive parts.",
                descriptionRU: ##"""
### Условие
Напишите функцию `canDivideWatermelon(_ w: Int) -> Bool`.
Петя и Вася хотят разделить арбуз весом `w` кг так, чтобы каждая из двух долей весила строго **чётное положительное** число килограммов (не обязательно поровну).
"""##,
                descriptionEN: ##"""
Can weight w be partitioned into two even positive integers?
"""##,
                requirementsRU: ["Учет краевого случая w = 2"],
                requirementsEN: ["Handle corner case w = 2"],
                starterCode: ##"""
func canDivideWatermelon(_ w: Int) -> Bool {
    return false
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "canDivideWatermelon(8)", expectedOutput: "true", validationCode: "canDivideWatermelon(8) == true"),
                    TaskTestCase(title: "Тест 2", inputDescription: "canDivideWatermelon(2)", expectedOutput: "false", validationCode: "canDivideWatermelon(2) == false"),
                    TaskTestCase(title: "Тест 3", inputDescription: "canDivideWatermelon(5)", expectedOutput: "false", validationCode: "canDivideWatermelon(5) == false"),
                    TaskTestCase(title: "Тест 4", inputDescription: "canDivideWatermelon(100)", expectedOutput: "true", validationCode: "canDivideWatermelon(100) == true")
                ],
                hintsRU: ["Число 2 делится только на 1 и 1 (нечётные). Число должно быть четным и строго больше 2."],
                hintsEN: ["w must be even and strictly greater than 2."],
                solutionCode: ##"""
func canDivideWatermelon(_ w: Int) -> Bool {
    return w > 2 && w % 2 == 0
}
"""##,
                xpReward: 25
            ),

            // [Codeforces 71A] Слишком длинные слова (Way Too Long Words)
            CodingTask(
                id: "cf_71a_way_too_long_words",
                titleRU: "[Codeforces 71A] Слишком длинные слова (Way Too Long Words)",
                titleEN: "[Codeforces 71A] Way Too Long Words",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Сократите слова длиной строго больше 10 символов в формат: первая буква + количество пропущенных + последняя буква.",
                summaryEN: "Abbreviate words strictly longer than 10 characters.",
                descriptionRU: ##"""
### Условие
Напишите функцию `abbreviateWord(_ word: String) -> String`.
Если длина слова > 10 символов, замените его на первую букву, число букв между ними и последнюю букву (например, `localization` -> `l10n`).
"""##,
                descriptionEN: ##"""
Replace words with length > 10 with first char, length-2, last char.
"""##,
                requirementsRU: ["Длина <= 10 остается без изменений"],
                requirementsEN: ["Length <= 10 stays unchanged"],
                starterCode: ##"""
func abbreviateWord(_ word: String) -> String {
    return word
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "abbreviateWord(\"word\")", expectedOutput: "\"word\"", validationCode: "abbreviateWord(\"word\") == \"word\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "abbreviateWord(\"localization\")", expectedOutput: "\"l10n\"", validationCode: "abbreviateWord(\"localization\") == \"l10n\""),
                    TaskTestCase(title: "Тест 3", inputDescription: "abbreviateWord(\"internationalization\")", expectedOutput: "\"i18n\"", validationCode: "abbreviateWord(\"internationalization\") == \"i18n\"")
                ],
                hintsRU: ["Проверьте word.count > 10. Возьмите first, count - 2 и last."],
                hintsEN: ["Check count > 10. Concatenate first, count - 2, last."],
                solutionCode: ##"""
func abbreviateWord(_ word: String) -> String {
    let count = word.count
    guard count > 10, let first = word.first, let last = word.last else {
        return word
    }
    return "\(first)\(count - 2)\(last)"
}
"""##,
                xpReward: 25
            ),

            // [Codeforces 231A] Команда (Team)
            CodingTask(
                id: "cf_231a_team",
                titleRU: "[Codeforces 231A] Команда (Team)",
                titleEN: "[Codeforces 231A] Team",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Посчитайте задачи, которые команда решит, если хотя бы 2 из 3 участников уверены в решении.",
                summaryEN: "Count problems solved if at least 2 of 3 team members are confident.",
                descriptionRU: ##"""
### Условие
Напишите функцию `solvedProblemsCount(_ opinions: [[Int]]) -> Int`.
Каждая строка содержит три числа (0 или 1) — мнения участников.
"""##,
                descriptionEN: ##"""
Count rows with sum >= 2.
"""##,
                requirementsRU: ["Обработка произвольного числа задач"],
                requirementsEN: ["Handle arbitrary number of rows"],
                starterCode: ##"""
func solvedProblemsCount(_ opinions: [[Int]]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "solvedProblemsCount([[1,1,0],[1,1,1],[1,0,0]])", expectedOutput: "2", validationCode: "solvedProblemsCount([[1,1,0],[1,1,1],[1,0,0]]) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "solvedProblemsCount([[1,0,0],[0,1,1]])", expectedOutput: "1", validationCode: "solvedProblemsCount([[1,0,0],[0,1,1]]) == 1")
                ],
                hintsRU: ["Посчитайте количество строк, где сумма элементов >= 2."],
                hintsEN: ["Count rows where sum of items >= 2."],
                solutionCode: ##"""
func solvedProblemsCount(_ opinions: [[Int]]) -> Int {
    return opinions.filter { $0.reduce(0, +) >= 2 }.count
}
"""##,
                xpReward: 25
            ),

            // [Codeforces 158A] Следующий раунд (Next Round)
            CodingTask(
                id: "cf_158a_next_round",
                titleRU: "[Codeforces 158A] Следующий раунд (Next Round)",
                titleEN: "[Codeforces 158A] Next Round",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Посчитайте участников, набравших не менее баллов, чем участник на k-м месте, при условии положительного балла.",
                summaryEN: "Count participants who advance to the next round.",
                descriptionRU: ##"""
### Условие
Напишите функцию `nextRoundParticipants(_ k: Int, _ scores: [Int]) -> Int`.
Массив `scores` отсортирован по невозрастанию. Участник проходит, если его балл >= балла k-го участника (1-индексация) и строго > 0.
"""##,
                descriptionEN: ##"""
Count participants with score >= scores[k-1] and score > 0.
"""##,
                requirementsRU: ["1-based индексация для параметра k"],
                requirementsEN: ["1-based index for parameter k"],
                starterCode: ##"""
func nextRoundParticipants(_ k: Int, _ scores: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "nextRoundParticipants(5, [10, 9, 8, 7, 7, 7, 5, 5])", expectedOutput: "6", validationCode: "nextRoundParticipants(5, [10, 9, 8, 7, 7, 7, 5, 5]) == 6"),
                    TaskTestCase(title: "Тест 2", inputDescription: "nextRoundParticipants(2, [0, 0, 0, 0])", expectedOutput: "0", validationCode: "nextRoundParticipants(2, [0, 0, 0, 0]) == 0")
                ],
                hintsRU: ["Балл k-го участника равен scores[k - 1]. Считайте участников с score >= cutoff && score > 0."],
                hintsEN: ["Cutoff score is scores[k - 1]. Filter for score >= cutoff and score > 0."],
                solutionCode: ##"""
func nextRoundParticipants(_ k: Int, _ scores: [Int]) -> Int {
    guard k <= scores.count else { return 0 }
    let cutoff = scores[k - 1]
    return scores.filter { $0 >= cutoff && $0 > 0 }.count
}
"""##,
                xpReward: 25
            ),

            // [Codeforces 282A] Бит++ (Bit++)
            CodingTask(
                id: "cf_282a_bit_plus_plus",
                titleRU: "[Codeforces 282A] Бит++ (Bit++)",
                titleEN: "[Codeforces 282A] Bit++",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Вычислите итоговое значение переменной x (изначально 0) после последовательности операций ++ и --.",
                summaryEN: "Calculate final value of x after statements containing ++ or --.",
                descriptionRU: ##"""
### Условие
Напишите функцию `executeBitOperations(_ statements: [String]) -> Int`.
Операции содержат либо `+`, либо `-` (например `++X`, `X++`, `--X`, `X--`).
"""##,
                descriptionEN: ##"""
Execute operations with ++ and -- starting from x = 0.
"""##,
                requirementsRU: ["Поддержка префиксных и постфиксных форм"],
                requirementsEN: ["Support both prefix and postfix forms"],
                starterCode: ##"""
func executeBitOperations(_ statements: [String]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "executeBitOperations([\"++X\", \"X++\", \"--X\"])", expectedOutput: "1", validationCode: "executeBitOperations([\"++X\", \"X++\", \"--X\"]) == 1"),
                    TaskTestCase(title: "Тест 2", inputDescription: "executeBitOperations([\"X--\", \"--X\"])", expectedOutput: "-2", validationCode: "executeBitOperations([\"X--\", \"--X\"]) == -2")
                ],
                hintsRU: ["Если строка содержит '+', прибавляем 1, иначе отнимаем 1."],
                hintsEN: ["If statement contains '+', increment by 1, else decrement."],
                solutionCode: ##"""
func executeBitOperations(_ statements: [String]) -> Int {
    var x = 0
    for stmt in statements {
        x += stmt.contains("+") ? 1 : -1
    }
    return x
}
"""##,
                xpReward: 25
            ),

            // [Codeforces 50A] Укладка доминошками (Domino Piling)
            CodingTask(
                id: "cf_50a_domino_piling",
                titleRU: "[Codeforces 50A] Укладка доминошками (Domino Piling)",
                titleEN: "[Codeforces 50A] Domino Piling",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Найдите максимальное количество доминошек 2x1, которое можно уложить на доску размера M x N.",
                summaryEN: "Find maximum number of 2x1 dominoes on M x N board.",
                descriptionRU: ##"""
### Условие
Напишите функцию `maxDominoes(_ m: Int, _ n: Int) -> Int`.
Каждая доминошка занимает ровно 2 клетки.
"""##,
                descriptionEN: ##"""
Return (m * n) / 2.
"""##,
                requirementsRU: ["Формула (m * n) / 2"],
                requirementsEN: ["Formula (m * n) / 2"],
                starterCode: ##"""
func maxDominoes(_ m: Int, _ n: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "maxDominoes(2, 4)", expectedOutput: "4", validationCode: "maxDominoes(2, 4) == 4"),
                    TaskTestCase(title: "Тест 2", inputDescription: "maxDominoes(3, 3)", expectedOutput: "4", validationCode: "maxDominoes(3, 3) == 4")
                ],
                hintsRU: ["Общая площадь m * n, каждая доминошка занимает 2 клетки."],
                hintsEN: ["Total area m * n divided by 2."],
                solutionCode: ##"""
func maxDominoes(_ m: Int, _ n: Int) -> Int {
    return (m * n) / 2
}
"""##,
                xpReward: 25
            ),

            // [Codeforces 112A] Петя и строки (Petya and Strings)
            CodingTask(
                id: "cf_112a_petya_strings",
                titleRU: "[Codeforces 112A] Петя и строки (Petya and Strings)",
                titleEN: "[Codeforces 112A] Petya and Strings",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Сравните две строки лексикографически без учета регистра: верните -1, 1 или 0.",
                summaryEN: "Case-insensitive lexicographical comparison of two strings.",
                descriptionRU: ##"""
### Условие
Напишите функцию `compareStringsLexicographically(_ s1: String, _ s2: String) -> Int`.
Верните `-1`, если s1 < s2, `1` если s1 > s2, и `0` если они равны.
"""##,
                descriptionEN: ##"""
Return -1 if s1 < s2, 1 if s1 > s2, 0 if equal (case-insensitive).
"""##,
                requirementsRU: ["Регистронезависимое сравнение"],
                requirementsEN: ["Case-insensitive comparison"],
                starterCode: ##"""
func compareStringsLexicographically(_ s1: String, _ s2: String) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "compareStringsLexicographically(\"aaaa\", \"aaaA\")", expectedOutput: "0", validationCode: "compareStringsLexicographically(\"aaaa\", \"aaaA\") == 0"),
                    TaskTestCase(title: "Тест 2", inputDescription: "compareStringsLexicographically(\"abs\", \"Abz\")", expectedOutput: "-1", validationCode: "compareStringsLexicographically(\"abs\", \"Abz\") == -1"),
                    TaskTestCase(title: "Тест 3", inputDescription: "compareStringsLexicographically(\"abcdefg\", \"AbCdEfF\")", expectedOutput: "1", validationCode: "compareStringsLexicographically(\"abcdefg\", \"AbCdEfF\") == 1")
                ],
                hintsRU: ["Приведите обе строки к lowercased() и сравните."],
                hintsEN: ["Convert both to lowercased() and compare."],
                solutionCode: ##"""
func compareStringsLexicographically(_ s1: String, _ s2: String) -> Int {
    let lower1 = s1.lowercased()
    let lower2 = s2.lowercased()
    if lower1 < lower2 { return -1 }
    if lower1 > lower2 { return 1 }
    return 0
}
"""##,
                xpReward: 25
            ),

            // [Codeforces 339A] Математика спешит на помощь (Helpful Maths)
            CodingTask(
                id: "cf_339a_helpful_maths",
                titleRU: "[Codeforces 339A] Математика спешит на помощь (Helpful Maths)",
                titleEN: "[Codeforces 339A] Helpful Maths",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Переставьте слагаемые суммы (цифры 1, 2, 3, разделенные '+') в порядке неубывания.",
                summaryEN: "Rearrange summands in non-decreasing order.",
                descriptionRU: ##"""
### Условие
Напишите функцию `sortSummands(_ expr: String) -> String`.
Пример: `3+2+1` -> `1+2+3`.
"""##,
                descriptionEN: ##"""
Rearrange numbers separated by '+' in non-decreasing order.
"""##,
                requirementsRU: ["Сохранение знаков '+' между отсортированными числами"],
                requirementsEN: ["Preserve '+' separators between sorted digits"],
                starterCode: ##"""
func sortSummands(_ expr: String) -> String {
    return expr
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "sortSummands(\"3+2+1\")", expectedOutput: "\"1+2+3\"", validationCode: "sortSummands(\"3+2+1\") == \"1+2+3\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "sortSummands(\"1+1+3+1+3\")", expectedOutput: "\"1+1+1+3+3\"", validationCode: "sortSummands(\"1+1+3+1+3\") == \"1+1+1+3+3\""),
                    TaskTestCase(title: "Тест 3", inputDescription: "sortSummands(\"2\")", expectedOutput: "\"2\"", validationCode: "sortSummands(\"2\") == \"2\"")
                ],
                hintsRU: ["Разбейте строку по разделу '+', отсортируйте и соедините через '+'.join."],
                hintsEN: ["Split by '+', sort elements, and join with '+'."],
                solutionCode: ##"""
func sortSummands(_ expr: String) -> String {
    let parts = expr.split(separator: "+").map(String.init).sorted()
    return parts.joined(separator: "+")
}
"""##,
                xpReward: 25
            ),

            // [Codeforces 266A] Камни на столе (Stones on the Table)
            CodingTask(
                id: "cf_266a_stones_on_table",
                titleRU: "[Codeforces 266A] Камни на столе (Stones on the Table)",
                titleEN: "[Codeforces 266A] Stones on the Table",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Найдите минимальное количество камней, которое нужно убрать, чтобы соседние камни были разного цвета.",
                summaryEN: "Find minimum stones to remove so no adjacent stones have same color.",
                descriptionRU: ##"""
### Условие
Напишите функцию `minStonesToRemove(_ s: String) -> Int`.
Строка состоит из символов 'R', 'G', 'B'. Посчитайте пары соседних одинаковых символов.
"""##,
                descriptionEN: ##"""
Count adjacent identical characters in string.
"""##,
                requirementsRU: ["Один проход по строке O(N)"],
                requirementsEN: ["Single pass O(N)"],
                starterCode: ##"""
func minStonesToRemove(_ s: String) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "minStonesToRemove(\"RRG\")", expectedOutput: "1", validationCode: "minStonesToRemove(\"RRG\") == 1"),
                    TaskTestCase(title: "Тест 2", inputDescription: "minStonesToRemove(\"RRRRR\")", expectedOutput: "4", validationCode: "minStonesToRemove(\"RRRRR\") == 4"),
                    TaskTestCase(title: "Тест 3", inputDescription: "minStonesToRemove(\"BRBG\")", expectedOutput: "0", validationCode: "minStonesToRemove(\"BRBG\") == 0")
                ],
                hintsRU: ["Сравнивайте s[i] и s[i+1]. Если они равны, увеличивайте счетчик."],
                hintsEN: ["Compare chars[i] and chars[i+1]."],
                solutionCode: ##"""
func minStonesToRemove(_ s: String) -> Int {
    let chars = Array(s)
    var count = 0
    guard chars.count > 1 else { return 0 }
    for i in 1..<chars.count {
        if chars[i] == chars[i - 1] {
            count += 1
        }
    }
    return count
}
"""##,
                xpReward: 25
            ),

            // [Codeforces 281A] Капитализация слова (Word Capitalization)
            CodingTask(
                id: "cf_281a_word_capitalization",
                titleRU: "[Codeforces 281A] Капитализация слова (Word Capitalization)",
                titleEN: "[Codeforces 281A] Word Capitalization",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Сделайте первую букву слова заглавной, сохранив остальные буквы без изменений.",
                summaryEN: "Make the first letter of a word uppercase.",
                descriptionRU: ##"""
### Условие
Напишите функцию `capitalizeWord(_ s: String) -> String`.
"""##,
                descriptionEN: ##"""
Capitalize the first letter while keeping remaining letters unchanged.
"""##,
                requirementsRU: ["Корректная обработка пустой строки"],
                requirementsEN: ["Handle empty string correctly"],
                starterCode: ##"""
func capitalizeWord(_ s: String) -> String {
    return s
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "capitalizeWord(\"apple\")", expectedOutput: "\"Apple\"", validationCode: "capitalizeWord(\"apple\") == \"Apple\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "capitalizeWord(\"Konjac\")", expectedOutput: "\"Konjac\"", validationCode: "capitalizeWord(\"Konjac\") == \"Konjac\"")
                ],
                hintsRU: ["Возьмите s.prefix(1).uppercased() + s.dropFirst()."],
                hintsEN: ["Use s.prefix(1).uppercased() + s.dropFirst()."],
                solutionCode: ##"""
func capitalizeWord(_ s: String) -> String {
    guard let first = s.first else { return s }
    return first.uppercased() + s.dropFirst()
}
"""##,
                xpReward: 25
            ),

            // [Codeforces 236A] Мальчик или девочка (Boy or Girl)
            CodingTask(
                id: "cf_236a_boy_or_girl",
                titleRU: "[Codeforces 236A] Мальчик или девочка (Boy or Girl)",
                titleEN: "[Codeforces 236A] Boy or Girl",
                difficulty: .easy,
                category: .stringsAndCollections,
                summaryRU: "Если количество уникальных символов в имени пользователя четное — верните 'CHAT WITH HER!', иначе 'IGNORE HIM!'.",
                summaryEN: "Check if distinct characters count is even.",
                descriptionRU: ##"""
### Условие
Напишите функцию `determineGenderByUsername(_ username: String) -> String`.
"""##,
                descriptionEN: ##"""
Return 'CHAT WITH HER!' if unique chars count is even, else 'IGNORE HIM!'.
"""##,
                requirementsRU: ["Точное совпадение возвращаемых строк"],
                requirementsEN: ["Exact string outputs"],
                starterCode: ##"""
func determineGenderByUsername(_ username: String) -> String {
    return ""
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "determineGenderByUsername(\"wjmzbmr\")", expectedOutput: "\"CHAT WITH HER!\"", validationCode: "determineGenderByUsername(\"wjmzbmr\") == \"CHAT WITH HER!\""),
                    TaskTestCase(title: "Тест 2", inputDescription: "determineGenderByUsername(\"xiaodao\")", expectedOutput: "\"IGNORE HIM!\"", validationCode: "determineGenderByUsername(\"xiaodao\") == \"IGNORE HIM!\""),
                    TaskTestCase(title: "Тест 3", inputDescription: "determineGenderByUsername(\"sevenkplus\")", expectedOutput: "\"CHAT WITH HER!\"", validationCode: "determineGenderByUsername(\"sevenkplus\") == \"CHAT WITH HER!\"")
                ],
                hintsRU: ["Set(username).count % 2 == 0."],
                hintsEN: ["Check Set(username).count % 2 == 0."],
                solutionCode: ##"""
func determineGenderByUsername(_ username: String) -> String {
    return Set(username).count % 2 == 0 ? "CHAT WITH HER!" : "IGNORE HIM!"
}
"""##,
                xpReward: 25
            ),

            // [Codeforces 546A] Солдат и бананы (Soldier and Bananas)
            CodingTask(
                id: "cf_546a_soldier_and_bananas",
                titleRU: "[Codeforces 546A] Солдат и бананы (Soldier and Bananas)",
                titleEN: "[Codeforces 546A] Soldier and Bananas",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Вычислите, сколько денег нужно одолжить солдату для покупки w бананов, если i-й банан стоит i * k долларов, а у него n долларов.",
                summaryEN: "Calculate borrow amount for buying w bananas.",
                descriptionRU: ##"""
### Условие
Напишите функцию `borrowAmount(_ k: Int, _ n: Int, _ w: Int) -> Int`.
Стоимость: 1*k + 2*k + ... + w*k.
Если денег хватает, верните `0`.
"""##,
                descriptionEN: ##"""
Sum of arithmetic progression minus n. Return 0 if money is sufficient.
"""##,
                requirementsRU: ["Формула суммы арифметической прогрессии k * w * (w + 1) / 2"],
                requirementsEN: ["Arithmetic progression formula"],
                starterCode: ##"""
func borrowAmount(_ k: Int, _ n: Int, _ w: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "borrowAmount(3, 17, 4)", expectedOutput: "13", validationCode: "borrowAmount(3, 17, 4) == 13"),
                    TaskTestCase(title: "Тест 2", inputDescription: "borrowAmount(2, 50, 4)", expectedOutput: "0", validationCode: "borrowAmount(2, 50, 4) == 0")
                ],
                hintsRU: ["Общая стоимость = k * w * (w + 1) / 2. Результат max(0, total - n)."],
                hintsEN: ["Total cost = k * w * (w + 1) / 2. Return max(0, total - n)."],
                solutionCode: ##"""
func borrowAmount(_ k: Int, _ n: Int, _ w: Int) -> Int {
    let totalCost = k * w * (w + 1) / 2
    return max(0, totalCost - n)
}
"""##,
                xpReward: 25
            ),

            // [Codeforces 791A] Мишка и старший брат (Bear and Big Brother)
            CodingTask(
                id: "cf_791a_bear_and_big_brother",
                titleRU: "[Codeforces 791A] Мишка и старший брат (Bear and Big Brother)",
                titleEN: "[Codeforces 791A] Bear and Big Brother",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Узнайте, через сколько лет вес Лимака (растет в 3 раза за год) строго превысит вес Боба (растет в 2 раза за год).",
                summaryEN: "Calculate years until weight a (x3) exceeds weight b (x2).",
                descriptionRU: ##"""
### Условие
Напишите функцию `yearsToSurpass(_ a: Int, _ b: Int) -> Int`.
Изначально `a <= b`.
"""##,
                descriptionEN: ##"""
Count iterations while a <= b with a *= 3 and b *= 2.
"""##,
                requirementsRU: ["Строгое условие превышения a > b"],
                requirementsEN: ["Strict inequality a > b"],
                starterCode: ##"""
func yearsToSurpass(_ a: Int, _ b: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "yearsToSurpass(4, 7)", expectedOutput: "2", validationCode: "yearsToSurpass(4, 7) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "yearsToSurpass(4, 9)", expectedOutput: "3", validationCode: "yearsToSurpass(4, 9) == 3"),
                    TaskTestCase(title: "Тест 3", inputDescription: "yearsToSurpass(1, 1)", expectedOutput: "1", validationCode: "yearsToSurpass(1, 1) == 1")
                ],
                hintsRU: ["Простой цикл while a <= b: a *= 3; b *= 2; years += 1."],
                hintsEN: ["While loop multiplying a by 3 and b by 2."],
                solutionCode: ##"""
func yearsToSurpass(_ a: Int, _ b: Int) -> Int {
    var curA = a
    var curB = b
    var years = 0
    while curA <= curB {
        curA *= 3
        curB *= 2
        years += 1
    }
    return years
}
"""##,
                xpReward: 25
            ),

            // [Codeforces 617A] Слон (Elephant Steps)
            CodingTask(
                id: "cf_617a_elephant",
                titleRU: "[Codeforces 617A] Слон (Elephant Steps)",
                titleEN: "[Codeforces 617A] Elephant",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Найдите минимальное количество шагов длиной от 1 до 5, чтобы добраться из 0 в координату x.",
                summaryEN: "Find minimum steps of sizes 1 through 5 to reach coordinate x.",
                descriptionRU: ##"""
### Условие
Напишите функцию `minStepsToDistance(_ x: Int) -> Int`.
Слон может делать шаги 1, 2, 3, 4 или 5 за один ход.
"""##,
                descriptionEN: ##"""
Minimum steps of max size 5 to cover distance x: (x + 4) / 5.
"""##,
                requirementsRU: ["O(1) вычисление без цикла"],
                requirementsEN: ["O(1) calculation"],
                starterCode: ##"""
func minStepsToDistance(_ x: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "minStepsToDistance(5)", expectedOutput: "1", validationCode: "minStepsToDistance(5) == 1"),
                    TaskTestCase(title: "Тест 2", inputDescription: "minStepsToDistance(12)", expectedOutput: "3", validationCode: "minStepsToDistance(12) == 3")
                ],
                hintsRU: ["Жадный выбор шага 5: (x + 4) / 5."],
                hintsEN: ["Greedy choice of step 5: (x + 4) / 5."],
                solutionCode: ##"""
func minStepsToDistance(_ x: Int) -> Int {
    return (x + 4) / 5
}
"""##,
                xpReward: 25
            ),

            // [Codeforces 977A] Неправильное вычитание (Wrong Subtraction)
            CodingTask(
                id: "cf_977a_wrong_subtraction",
                titleRU: "[Codeforces 977A] Неправильное вычитание (Wrong Subtraction)",
                titleEN: "[Codeforces 977A] Wrong Subtraction",
                difficulty: .easy,
                category: .basicsAndMath,
                summaryRU: "Выполните k шагов: если последняя цифра числа не 0 — вычтите 1, иначе разделите число на 10.",
                summaryEN: "If last digit != 0 subtract 1, else divide by 10, k times.",
                descriptionRU: ##"""
### Условие
Напишите функцию `wrongSubtract(_ n: Int, _ k: Int) -> Int`.
"""##,
                descriptionEN: ##"""
Simulate Tanya's wrong subtraction algorithm.
"""##,
                requirementsRU: ["k итераций симуляции"],
                requirementsEN: ["k simulation steps"],
                starterCode: ##"""
func wrongSubtract(_ n: Int, _ k: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "wrongSubtract(512, 4)", expectedOutput: "50", validationCode: "wrongSubtract(512, 4) == 50"),
                    TaskTestCase(title: "Тест 2", inputDescription: "wrongSubtract(1000000000, 9)", expectedOutput: "1", validationCode: "wrongSubtract(1000000000, 9) == 1")
                ],
                hintsRU: ["В цикле: if num % 10 != 0 { num -= 1 } else { num /= 10 }."],
                hintsEN: ["In a loop: if num % 10 != 0 { num -= 1 } else { num /= 10 }."],
                solutionCode: ##"""
func wrongSubtract(_ n: Int, _ k: Int) -> Int {
    var num = n
    for _ in 0..<k {
        if num % 10 != 0 {
            num -= 1
        } else {
            num /= 10
        }
    }
    return num
}
"""##,
                xpReward: 25
            ),

            // [LeetCode #11] Контейнер с наибольшим количеством воды (Container With Most Water)
            CodingTask(
                id: "lc_container_with_most_water",
                titleRU: "[LeetCode #11] Контейнер с наибольшим количеством воды (Container With Most Water)",
                titleEN: "[LeetCode #11] Container With Most Water",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Найдите две вертикальные линии, которые вместе с осью X образуют контейнер максимального объема воды.",
                summaryEN: "Find two lines that form a container containing the most water.",
                descriptionRU: ##"""
### Условие
Напишите функцию `maxArea(_ height: [Int]) -> Int`.
Объем равен `min(height[i], height[j]) * (j - i)`. Решение должно работать за O(N).
"""##,
                descriptionEN: ##"""
Two-pointer solution for max water container area in O(N).
"""##,
                requirementsRU: ["Метод двух указателей O(N)"],
                requirementsEN: ["Two pointers O(N)"],
                starterCode: ##"""
func maxArea(_ height: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "maxArea([1,8,6,2,5,4,8,3,7])", expectedOutput: "49", validationCode: "maxArea([1,8,6,2,5,4,8,3,7]) == 49"),
                    TaskTestCase(title: "Тест 2", inputDescription: "maxArea([1,1])", expectedOutput: "1", validationCode: "maxArea([1,1]) == 1")
                ],
                hintsRU: ["Два указателя по краям. Сдвигайте указатель с меньшей высотой."],
                hintsEN: ["Two pointers at ends. Move the pointer pointing to shorter line."],
                solutionCode: ##"""
func maxArea(_ height: [Int]) -> Int {
    var left = 0
    var right = height.count - 1
    var best = 0
    while left < right {
        let h = min(height[left], height[right])
        best = max(best, h * (right - left))
        if height[left] < height[right] {
            left += 1
        } else {
            right -= 1
        }
    }
    return best
}
"""##,
                xpReward: 50
            ),

            // [LeetCode #15] Сумма трёх чисел (3Sum)
            CodingTask(
                id: "lc_3sum",
                titleRU: "[LeetCode #15] Сумма трёх чисел (3Sum)",
                titleEN: "[LeetCode #15] 3Sum",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Найдите все уникальные тройки элементов, сумма которых равна нулю.",
                summaryEN: "Find all unique triplets in the array which gives the sum of zero.",
                descriptionRU: ##"""
### Условие
Напишите функцию `threeSum(_ nums: [Int]) -> [[Int]]`.
В ответе не должно быть дублирующихся троек.
"""##,
                descriptionEN: ##"""
Find unique triplets summing to zero in O(N^2).
"""##,
                requirementsRU: ["Сортировка + два указателя O(N^2)", "Пропуск одинаковых элементов для избежания дубликатов"],
                requirementsEN: ["Sorting + two pointers O(N^2)", "Skip duplicates"],
                starterCode: ##"""
func threeSum(_ nums: [Int]) -> [[Int]] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "threeSum([-1,0,1,2,-1,-4])", expectedOutput: "[[-1,-1,2],[-1,0,1]]", validationCode: "({ let res = threeSum([-1,0,1,2,-1,-4]).map { $0.sorted() }.sorted { $0[0] != $1[0] ? $0[0] < $1[0] : $0[1] < $1[1] }; return res == [[-1,-1,2], [-1,0,1]] })()"),
                    TaskTestCase(title: "Тест 2", inputDescription: "threeSum([0,1,1])", expectedOutput: "[]", validationCode: "threeSum([0,1,1]) == []"),
                    TaskTestCase(title: "Тест 3", inputDescription: "threeSum([0,0,0])", expectedOutput: "[[0,0,0]]", validationCode: "threeSum([0,0,0]) == [[0,0,0]]")
                ],
                hintsRU: ["Отсортируйте массив. Для каждого i используйте два указателя left и right."],
                hintsEN: ["Sort array. For each i, use two pointers left and right."],
                solutionCode: ##"""
func threeSum(_ nums: [Int]) -> [[Int]] {
    let sorted = nums.sorted()
    var result: [[Int]] = []
    let n = sorted.count
    for i in 0..<n {
        if i > 0 && sorted[i] == sorted[i - 1] { continue }
        if sorted[i] > 0 { break }
        var left = i + 1
        var right = n - 1
        while left < right {
            let sum = sorted[i] + sorted[left] + sorted[right]
            if sum == 0 {
                result.append([sorted[i], sorted[left], sorted[right]])
                while left < right && sorted[left] == sorted[left + 1] { left += 1 }
                while left < right && sorted[right] == sorted[right - 1] { right -= 1 }
                left += 1
                right -= 1
            } else if sum < 0 {
                left += 1
            } else {
                right -= 1
            }
        }
    }
    return result
}
"""##,
                xpReward: 55
            ),

            // [LeetCode #53] Максимальный подмассив (Maximum Subarray / Kadane)
            CodingTask(
                id: "lc_maximum_subarray",
                titleRU: "[LeetCode #53] Максимальный подмассив (Maximum Subarray / Kadane)",
                titleEN: "[LeetCode #53] Maximum Subarray",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Найдите непрерывный подмассив с наибольшей суммой элементов за O(N) по алгоритму Кадане.",
                summaryEN: "Find the contiguous subarray which has the largest sum.",
                descriptionRU: ##"""
### Условие
Напишите функцию `maxSubArray(_ nums: [Int]) -> Int`.
Массив может содержать отрицательные числа.
"""##,
                descriptionEN: ##"""
Implement Kadane's algorithm for max subarray sum.
"""##,
                requirementsRU: ["Алгоритм Кадане за линейное время O(N)"],
                requirementsEN: ["Kadane's algorithm in O(N)"],
                starterCode: ##"""
func maxSubArray(_ nums: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "maxSubArray([-2,1,-3,4,-1,2,1,-5,4])", expectedOutput: "6", validationCode: "maxSubArray([-2,1,-3,4,-1,2,1,-5,4]) == 6"),
                    TaskTestCase(title: "Тест 2", inputDescription: "maxSubArray([1])", expectedOutput: "1", validationCode: "maxSubArray([1]) == 1"),
                    TaskTestCase(title: "Тест 3", inputDescription: "maxSubArray([5,4,-1,7,8])", expectedOutput: "23", validationCode: "maxSubArray([5,4,-1,7,8]) == 23")
                ],
                hintsRU: ["Поддерживайте curSum = max(num, curSum + num) и обновляйте maxSum."],
                hintsEN: ["curSum = max(num, curSum + num) and update maxSum."],
                solutionCode: ##"""
func maxSubArray(_ nums: [Int]) -> Int {
    guard let first = nums.first else { return 0 }
    var currentSum = first
    var maxSum = first
    for num in nums.dropFirst() {
        currentSum = max(num, currentSum + num)
        maxSum = max(maxSum, currentSum)
    }
    return maxSum
}
"""##,
                xpReward: 50
            ),

            // [LeetCode #75] Сортировка цветов (Dutch National Flag)
            CodingTask(
                id: "lc_sort_colors",
                titleRU: "[LeetCode #75] Сортировка цветов (Dutch National Flag)",
                titleEN: "[LeetCode #75] Sort Colors",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Отсортируйте массив из 0, 1 и 2 in-place за один проход O(N) и O(1) памяти (флаг Дейкстры).",
                summaryEN: "Sort array of 0s, 1s, and 2s in-place in one pass.",
                descriptionRU: ##"""
### Условие
Напишите функцию `sortColors(_ nums: inout [Int])`.
Запрещено использовать стандартную библиотечную сортировку.
"""##,
                descriptionEN: ##"""
Implement Dutch National Flag 3-way partitioning.
"""##,
                requirementsRU: ["In-place сортировка за один проход O(N)"],
                requirementsEN: ["One-pass in-place 3-way partition"],
                starterCode: ##"""
func sortColors(_ nums: inout [Int]) {
    // Решение
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "sortColors(&[2,0,2,1,1,0])", expectedOutput: "[0,0,1,1,2,2]", validationCode: "({ var a = [2,0,2,1,1,0]; sortColors(&a); return a == [0,0,1,1,2,2] })()"),
                    TaskTestCase(title: "Тест 2", inputDescription: "sortColors(&[2,0,1])", expectedOutput: "[0,1,2]", validationCode: "({ var a = [2,0,1]; sortColors(&a); return a == [0,1,2] })()")
                ],
                hintsRU: ["Три указателя: low, mid, high. Если nums[mid] == 0 меняем с low, если 2 с high."],
                hintsEN: ["Three pointers: low, mid, high. Swap 0s to low and 2s to high."],
                solutionCode: ##"""
func sortColors(_ nums: inout [Int]) {
    var low = 0
    var mid = 0
    var high = nums.count - 1
    while mid <= high {
        if nums[mid] == 0 {
            nums.swapAt(low, mid)
            low += 1
            mid += 1
        } else if nums[mid] == 1 {
            mid += 1
        } else {
            nums.swapAt(mid, high)
            high -= 1
        }
    }
}
"""##,
                xpReward: 50
            ),

            // [LeetCode #198] Ограбление домов (House Robber DP)
            CodingTask(
                id: "lc_house_robber",
                titleRU: "[LeetCode #198] Ограбление домов (House Robber DP)",
                titleEN: "[LeetCode #198] House Robber",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Найдите максимальную сумму, которую можно украсть, если нельзя грабить два соседних дома.",
                summaryEN: "Determine maximum amount you can rob without alerting police (no two adjacent houses).",
                descriptionRU: ##"""
### Условие
Напишите функцию `rob(_ nums: [Int]) -> Int`.
Динамическое программирование: на каждом доме либо грабим его + максимум 2 дома назад, либо пропускаем.
"""##,
                descriptionEN: ##"""
Dynamic programming solution for non-adjacent house robbery.
"""##,
                requirementsRU: ["O(N) времени, O(1) памяти"],
                requirementsEN: ["O(N) time, O(1) space"],
                starterCode: ##"""
func rob(_ nums: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "rob([1,2,3,1])", expectedOutput: "4", validationCode: "rob([1,2,3,1]) == 4"),
                    TaskTestCase(title: "Тест 2", inputDescription: "rob([2,7,9,3,1])", expectedOutput: "12", validationCode: "rob([2,7,9,3,1]) == 12")
                ],
                hintsRU: ["dp[i] = max(dp[i-1], dp[i-2] + nums[i]). Храните только два предыдущих значения."],
                hintsEN: ["Keep track of robPrev and robCurrent."],
                solutionCode: ##"""
func rob(_ nums: [Int]) -> Int {
    var prev = 0
    var curr = 0
    for num in nums {
        let temp = max(curr, prev + num)
        prev = curr
        curr = temp
    }
    return curr
}
"""##,
                xpReward: 50
            ),

            // [LeetCode #322] Размен монет (Coin Change DP)
            CodingTask(
                id: "lc_coin_change",
                titleRU: "[LeetCode #322] Размен монет (Coin Change DP)",
                titleEN: "[LeetCode #322] Coin Change",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Найдите наименьшее количество монет заданных номиналов для получения суммы amount. Если невозможно, верните -1.",
                summaryEN: "Find fewest number of coins needed to make up amount.",
                descriptionRU: ##"""
### Условие
Напишите функцию `coinChange(_ coins: [Int], _ amount: Int) -> Int`.
Монеты можно брать в неограниченном количестве.
"""##,
                descriptionEN: ##"""
Minimum coins DP. Return -1 if not possible.
"""##,
                requirementsRU: ["Классическое одномерное ДП"],
                requirementsEN: ["Classic 1D Dynamic Programming"],
                starterCode: ##"""
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    return -1
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "coinChange([1,2,5], 11)", expectedOutput: "3", validationCode: "coinChange([1,2,5], 11) == 3"),
                    TaskTestCase(title: "Тест 2", inputDescription: "coinChange([2], 3)", expectedOutput: "-1", validationCode: "coinChange([2], 3) == -1"),
                    TaskTestCase(title: "Тест 3", inputDescription: "coinChange([1], 0)", expectedOutput: "0", validationCode: "coinChange([1], 0) == 0")
                ],
                hintsRU: ["dp[i] = min(dp[i], dp[i - coin] + 1) для всех coin <= i."],
                hintsEN: ["Initialize array of size amount + 1 with amount + 1."],
                solutionCode: ##"""
func coinChange(_ coins: [Int], _ amount: Int) -> Int {
    guard amount > 0 else { return 0 }
    var dp = Array(repeating: amount + 1, count: amount + 1)
    dp[0] = 0
    for i in 1...amount {
        for coin in coins where coin <= i {
            dp[i] = min(dp[i], dp[i - coin] + 1)
        }
    }
    return dp[amount] > amount ? -1 : dp[amount]
}
"""##,
                xpReward: 55
            ),

            // [LeetCode #128] Длиннейшая последовательность (Longest Consecutive Sequence)
            CodingTask(
                id: "lc_longest_consecutive_sequence",
                titleRU: "[LeetCode #128] Длиннейшая последовательность (Longest Consecutive Sequence)",
                titleEN: "[LeetCode #128] Longest Consecutive Sequence",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Найдите длину наибольшей последовательности последовательных чисел за O(N).",
                summaryEN: "Find length of longest consecutive elements sequence in O(N).",
                descriptionRU: ##"""
### Условие
Напишите функцию `longestConsecutive(_ nums: [Int]) -> Int` со строгой сложностью O(N).
"""##,
                descriptionEN: ##"""
Find length of longest consecutive elements sequence in O(N).
"""##,
                requirementsRU: ["Хэш-множество Set для поиска начала цепочки за O(1)"],
                requirementsEN: ["HashSet for O(1) chain starter check"],
                starterCode: ##"""
func longestConsecutive(_ nums: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "longestConsecutive([100,4,200,1,3,2])", expectedOutput: "4", validationCode: "longestConsecutive([100,4,200,1,3,2]) == 4"),
                    TaskTestCase(title: "Тест 2", inputDescription: "longestConsecutive([0,3,7,2,5,8,4,6,0,1])", expectedOutput: "9", validationCode: "longestConsecutive([0,3,7,2,5,8,4,6,0,1]) == 9")
                ],
                hintsRU: ["Поместите числа в Set. Проверяйте только числа, для которых num - 1 отсутствует в Set (начало цепочки)."],
                hintsEN: ["Check if num - 1 is not in set to only start counting from chain heads."],
                solutionCode: ##"""
func longestConsecutive(_ nums: [Int]) -> Int {
    let set = Set(nums)
    var maxLen = 0
    for num in set {
        if !set.contains(num - 1) {
            var currentNum = num
            var currentStreak = 1
            while set.contains(currentNum + 1) {
                currentNum += 1
                currentStreak += 1
            }
            maxLen = max(maxLen, currentStreak)
        }
    }
    return maxLen
}
"""##,
                xpReward: 55
            ),

            // [LeetCode #215] K-й наибольший элемент (Kth Largest Element)
            CodingTask(
                id: "lc_kth_largest_element",
                titleRU: "[LeetCode #215] K-й наибольший элемент (Kth Largest Element)",
                titleEN: "[LeetCode #215] Kth Largest Element",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Найдите k-й по величине элемент в неотсортированном массиве без полной сортировки.",
                summaryEN: "Find the kth largest element in an unsorted array.",
                descriptionRU: ##"""
### Условие
Напишите функцию `findKthLargest(_ nums: [Int], _ k: Int) -> Int`.
Нужен именно k-й по величине элемент в отсортированном порядке, а не k-й уникальный.
"""##,
                descriptionEN: ##"""
Find kth largest element in array.
"""##,
                requirementsRU: ["Корректный поиск с учетом повторяющихся значений"],
                requirementsEN: ["Correctly handle duplicate numbers"],
                starterCode: ##"""
func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "findKthLargest([3,2,1,5,6,4], 2)", expectedOutput: "5", validationCode: "findKthLargest([3,2,1,5,6,4], 2) == 5"),
                    TaskTestCase(title: "Тест 2", inputDescription: "findKthLargest([3,2,3,1,2,4,5,5,6], 4)", expectedOutput: "4", validationCode: "findKthLargest([3,2,3,1,2,4,5,5,6], 4) == 4")
                ],
                hintsRU: ["QuickSelect в среднем дает O(N). Либо отсортируйте по убыванию и возьмите nums[k-1]."],
                hintsEN: ["QuickSelect or sort descending and take index k - 1."],
                solutionCode: ##"""
func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    var arr = nums
    func quickSelect(_ left: Int, _ right: Int, _ targetK: Int) -> Int {
        if left == right { return arr[left] }
        let pivot = arr[(left + right) / 2]
        var i = left
        var j = right
        while i <= j {
            while arr[i] > pivot { i += 1 }
            while arr[j] < pivot { j -= 1 }
            if i <= j {
                arr.swapAt(i, j)
                i += 1
                j -= 1
            }
        }
        if targetK <= j { return quickSelect(left, j, targetK) }
        if targetK >= i { return quickSelect(i, right, targetK) }
        return arr[targetK]
    }
    return quickSelect(0, arr.count - 1, k - 1)
}
"""##,
                xpReward: 55
            ),

            // [Codeforces 1A] Театральная площадь (Theatre Square)
            CodingTask(
                id: "cf_1a_theatre_square",
                titleRU: "[Codeforces 1A] Театральная площадь (Theatre Square)",
                titleEN: "[Codeforces 1A] Theatre Square",
                difficulty: .medium,
                category: .basicsAndMath,
                summaryRU: "Найдите минимальное количество гранитных плит a x a, необходимое для покрытия площади n x m.",
                summaryEN: "Find minimum number of a x a flagstones to pave n x m Theatre Square.",
                descriptionRU: ##"""
### Условие
Напишите функцию `theatreSquareFlagstones(_ n: Int, _ m: Int, _ a: Int) -> Int`.
Плиты нельзя ломать, площадь можно вымостить с запасом.
"""##,
                descriptionEN: ##"""
Calculate ceil(n/a) * ceil(m/a).
"""##,
                requirementsRU: ["Округление вверх деления: ((n + a - 1) / a) * ((m + a - 1) / a)"],
                requirementsEN: ["Ceil division arithmetic"],
                starterCode: ##"""
func theatreSquareFlagstones(_ n: Int, _ m: Int, _ a: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "theatreSquareFlagstones(6, 6, 4)", expectedOutput: "4", validationCode: "theatreSquareFlagstones(6, 6, 4) == 4"),
                    TaskTestCase(title: "Тест 2", inputDescription: "theatreSquareFlagstones(1, 1, 1)", expectedOutput: "1", validationCode: "theatreSquareFlagstones(1, 1, 1) == 1"),
                    TaskTestCase(title: "Тест 3", inputDescription: "theatreSquareFlagstones(10, 10, 3)", expectedOutput: "16", validationCode: "theatreSquareFlagstones(10, 10, 3) == 16")
                ],
                hintsRU: ["Количество плит по горизонтали = (n + a - 1) / a, по вертикали = (m + a - 1) / a."],
                hintsEN: ["Horizontal flagstones = (n + a - 1) / a, vertical = (m + a - 1) / a."],
                solutionCode: ##"""
func theatreSquareFlagstones(_ n: Int, _ m: Int, _ a: Int) -> Int {
    let countN = (n + a - 1) / a
    let countM = (m + a - 1) / a
    return countN * countM
}
"""##,
                xpReward: 45
            ),

            // [Codeforces 4C] Система регистрации (Registration System)
            CodingTask(
                id: "cf_4c_registration_system",
                titleRU: "[Codeforces 4C] Система регистрации (Registration System)",
                titleEN: "[Codeforces 4C] Registration System",
                difficulty: .medium,
                category: .stringsAndCollections,
                summaryRU: "Реализуйте обработку никнеймов пользователей: если имя занято, добавьте минимальный числовой суффикс (1, 2...).",
                summaryEN: "Database registration system with numeric suffixes for duplicates.",
                descriptionRU: ##"""
### Условие
Напишите функцию `registerUsers(_ requests: [String]) -> [String]`.
Если имя свободно — запишите его и верните `\"OK\"`.
Если имя занято — верните `имя + суффикс` (например `first1`, `first2`).
"""##,
                descriptionEN: ##"""
Process usernames, return \"OK\" or username + count.
"""##,
                requirementsRU: ["Хранилище частот O(1) через хэш-таблицу Dictionary"],
                requirementsEN: ["Dictionary frequency map O(1)"],
                starterCode: ##"""
func registerUsers(_ requests: [String]) -> [String] {
    return []
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "registerUsers([\"first\",\"first\",\"second\",\"first\"])", expectedOutput: "[\"OK\",\"first1\",\"OK\",\"first2\"]", validationCode: "registerUsers([\"first\",\"first\",\"second\",\"first\"]) == [\"OK\",\"first1\",\"OK\",\"first2\"]"),
                    TaskTestCase(title: "Тест 2", inputDescription: "registerUsers([\"a\",\"b\",\"c\"])", expectedOutput: "[\"OK\",\"OK\",\"OK\"]", validationCode: "registerUsers([\"a\",\"b\",\"c\"]) == [\"OK\",\"OK\",\"OK\"]")
                ],
                hintsRU: ["Используйте словарь [String: Int] для подсчета количества регистраций каждого имени."],
                hintsEN: ["Maintain [String: Int] counter dictionary."],
                solutionCode: ##"""
func registerUsers(_ requests: [String]) -> [String] {
    var db: [String: Int] = [:]
    var output: [String] = []
    for name in requests {
        if let count = db[name] {
            output.append("\(name)\(count)")
            db[name] = count + 1
        } else {
            db[name] = 1
            output.append("OK")
        }
    }
    return output
}
"""##,
                xpReward: 45
            ),

            // [Codeforces 25A] IQ тест (IQ Test Parity Outlier)
            CodingTask(
                id: "cf_25a_iq_test",
                titleRU: "[Codeforces 25A] IQ тест (IQ Test Parity Outlier)",
                titleEN: "[Codeforces 25A] IQ Test",
                difficulty: .medium,
                category: .basicsAndMath,
                summaryRU: "Найдите 1-based индекс единственного числа, отличающегося по четности от остальных.",
                summaryEN: "Find 1-based index of number with different parity.",
                descriptionRU: ##"""
### Условие
Напишите функцию `findParityOutlierIndex(_ nums: [Int]) -> Int`.
Все числа кроме одного четные, либо все кроме одного нечетные.
Верните 1-based индекс аномального числа.
"""##,
                descriptionEN: ##"""
Find 1-based index of the outlier number having unique parity.
"""##,
                requirementsRU: ["1-based индекс в результате"],
                requirementsEN: ["1-based index output"],
                starterCode: ##"""
func findParityOutlierIndex(_ nums: [Int]) -> Int {
    return 1
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "findParityOutlierIndex([2, 4, 7, 8, 10])", expectedOutput: "3", validationCode: "findParityOutlierIndex([2, 4, 7, 8, 10]) == 3"),
                    TaskTestCase(title: "Тест 2", inputDescription: "findParityOutlierIndex([1, 1, 2])", expectedOutput: "3", validationCode: "findParityOutlierIndex([1, 1, 2]) == 3")
                ],
                hintsRU: ["Посчитайте четные и нечетные по первым 3 числам, чтобы определить мажоритарную четность."],
                hintsEN: ["Check first 3 numbers to determine majority parity."],
                solutionCode: ##"""
func findParityOutlierIndex(_ nums: [Int]) -> Int {
    let evens = nums.filter { $0 % 2 == 0 }
    let isMajorityEven = evens.count > 1
    for (idx, num) in nums.enumerated() {
        let isEven = num % 2 == 0
        if isEven != isMajorityEven {
            return idx + 1
        }
    }
    return 1
}
"""##,
                xpReward: 40
            ),

            // [Codeforces 489B] BerSU Ball (Пары танцев)
            CodingTask(
                id: "cf_489b_bersu_ball",
                titleRU: "[Codeforces 489B] BerSU Ball (Пары танцев)",
                titleEN: "[Codeforces 489B] BerSU Ball",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Сформируйте максимальное количество пар танцоров, если разница в навыках в паре не превышает 1.",
                summaryEN: "Maximize dance pairs with skill difference at most 1.",
                descriptionRU: ##"""
### Условие
Напишите функцию `maxDancePairs(_ boys: [Int], _ girls: [Int]) -> Int`.
В паре |boys[i] - girls[j]| <= 1. Каждый мальчик и девочка могут быть максимум в одной паре.
"""##,
                descriptionEN: ##"""
Greedy two-pointer matching with diff <= 1.
"""##,
                requirementsRU: ["Сортировка обоих списков + два указателя"],
                requirementsEN: ["Sort both arrays + two pointers greedy matching"],
                starterCode: ##"""
func maxDancePairs(_ boys: [Int], _ girls: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "maxDancePairs([1,4,6,2], [5,1,5,7,9])", expectedOutput: "3", validationCode: "maxDancePairs([1,4,6,2], [5,1,5,7,9]) == 3"),
                    TaskTestCase(title: "Тест 2", inputDescription: "maxDancePairs([1,2,3,4], [10,11,12,13])", expectedOutput: "0", validationCode: "maxDancePairs([1,2,3,4], [10,11,12,13]) == 0")
                ],
                hintsRU: ["Отсортируйте обоих. Если abs(b[i] - g[j]) <= 1: пара найдена, двигаем обоих. Иначе сдвигаем меньшего."],
                hintsEN: ["Sort both arrays. If diff <= 1 pair them, otherwise advance the smaller pointer."],
                solutionCode: ##"""
func maxDancePairs(_ boys: [Int], _ girls: [Int]) -> Int {
    let b = boys.sorted()
    let g = girls.sorted()
    var i = 0
    var j = 0
    var pairs = 0
    while i < b.count && j < g.count {
        if abs(b[i] - g[j]) <= 1 {
            pairs += 1
            i += 1
            j += 1
        } else if b[i] < g[j] {
            i += 1
        } else {
            j += 1
        }
    }
    return pairs
}
"""##,
                xpReward: 50
            ),

            // [Codeforces 479A] Выражение (Expression Maximize)
            CodingTask(
                id: "cf_479a_expression",
                titleRU: "[Codeforces 479A] Выражение (Expression Maximize)",
                titleEN: "[Codeforces 479A] Expression",
                difficulty: .medium,
                category: .basicsAndMath,
                summaryRU: "Расставьте знаки '+' и '*' и скобки между тремя числами a, b, c, чтобы максимизировать значение выражения.",
                summaryEN: "Maximize expression using +, * and brackets with three numbers.",
                descriptionRU: ##"""
### Условие
Напишите функцию `maxExpressionValue(_ a: Int, _ b: Int, _ c: Int) -> Int`.
Порядок чисел a, b, c менять нельзя.
"""##,
                descriptionEN: ##"""
Find maximum of all combinations: a+b+c, a*b*c, (a+b)*c, a*(b+c), a*b+c, a+b*c.
"""##,
                requirementsRU: ["Проверка всех 6 комбинаций скобок и знаков"],
                requirementsEN: ["Check all valid parenthesizations"],
                starterCode: ##"""
func maxExpressionValue(_ a: Int, _ b: Int, _ c: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "maxExpressionValue(1, 2, 3)", expectedOutput: "9", validationCode: "maxExpressionValue(1, 2, 3) == 9"),
                    TaskTestCase(title: "Тест 2", inputDescription: "maxExpressionValue(2, 10, 3)", expectedOutput: "60", validationCode: "maxExpressionValue(2, 10, 3) == 60"),
                    TaskTestCase(title: "Тест 3", inputDescription: "maxExpressionValue(1, 1, 1)", expectedOutput: "3", validationCode: "maxExpressionValue(1, 1, 1) == 3")
                ],
                hintsRU: ["Всего 6 вариантов: a+b+c, a*b*c, (a+b)*c, a*(b+c), a*b+c, a+b*c."],
                hintsEN: ["Check max of the 6 finite combinations."],
                solutionCode: ##"""
func maxExpressionValue(_ a: Int, _ b: Int, _ c: Int) -> Int {
    let options = [
        a + b + c,
        a * b * c,
        (a + b) * c,
        a * (b + c),
        a * b + c,
        a + b * c
    ]
    return options.max() ?? 0
}
"""##,
                xpReward: 40
            ),

            // [Codeforces 189A] Разрезание ленточки (Cut Ribbon DP)
            CodingTask(
                id: "cf_189a_cut_ribbon",
                titleRU: "[Codeforces 189A] Разрезание ленточки (Cut Ribbon DP)",
                titleEN: "[Codeforces 189A] Cut Ribbon",
                difficulty: .medium,
                category: .algorithms,
                summaryRU: "Разрежьте ленточку длины n на максимальное количество частей длин a, b или c.",
                summaryEN: "Cut ribbon of length n into maximum number of pieces of length a, b, or c.",
                descriptionRU: ##"""
### Условие
Напишите функцию `maxRibbonPieces(_ n: Int, _ a: Int, _ b: Int, _ c: Int) -> Int`.
Длина каждого кусочка должна быть строго равна a, b или c.
"""##,
                descriptionEN: ##"""
Dynamic programming to find maximum pieces summing to n.
"""##,
                requirementsRU: ["ДП за O(N)"],
                requirementsEN: ["DP in O(N)"],
                starterCode: ##"""
func maxRibbonPieces(_ n: Int, _ a: Int, _ b: Int, _ c: Int) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "maxRibbonPieces(5, 5, 3, 2)", expectedOutput: "2", validationCode: "maxRibbonPieces(5, 5, 3, 2) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "maxRibbonPieces(7, 5, 5, 2)", expectedOutput: "2", validationCode: "maxRibbonPieces(7, 5, 5, 2) == 2")
                ],
                hintsRU: ["dp[i] = max(dp[i-a], dp[i-b], dp[i-c]) + 1. Недостижимые состояния отмечайте как -1."],
                hintsEN: ["dp[i] = max pieces for length i. Handle unreachable states with -1."],
                solutionCode: ##"""
func maxRibbonPieces(_ n: Int, _ a: Int, _ b: Int, _ c: Int) -> Int {
    var dp = Array(repeating: -1, count: n + 1)
    dp[0] = 0
    let lengths = [a, b, c]
    for i in 1...n {
        for len in lengths where i >= len && dp[i - len] != -1 {
            dp[i] = max(dp[i], dp[i - len] + 1)
        }
    }
    return dp[n]
}
"""##,
                xpReward: 55
            ),

            // [LeetCode #42] Удержание дождевой воды (Trapping Rain Water)
            CodingTask(
                id: "lc_trapping_rain_water",
                titleRU: "[LeetCode #42] Удержание дождевой воды (Trapping Rain Water)",
                titleEN: "[LeetCode #42] Trapping Rain Water",
                difficulty: .hard,
                category: .algorithms,
                summaryRU: "Вычислите, сколько воды удерживается после дождя на диаграмме высот за O(N) времени и O(1) памяти.",
                summaryEN: "Compute how much water it can trap after raining using two pointers.",
                descriptionRU: ##"""
### Условие
Напишите функцию `trapRainWater(_ height: [Int]) -> Int`.
Решение должно работать за O(N) по времени и O(1) по памяти.
"""##,
                descriptionEN: ##"""
Trapping rain water in O(N) time and O(1) space.
"""##,
                requirementsRU: ["Два указателя O(1) памяти"],
                requirementsEN: ["Two pointers O(1) auxiliary space"],
                starterCode: ##"""
func trapRainWater(_ height: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "trapRainWater([0,1,0,2,1,0,1,3,2,1,2,1])", expectedOutput: "6", validationCode: "trapRainWater([0,1,0,2,1,0,1,3,2,1,2,1]) == 6"),
                    TaskTestCase(title: "Тест 2", inputDescription: "trapRainWater([4,2,0,3,2,5])", expectedOutput: "9", validationCode: "trapRainWater([4,2,0,3,2,5]) == 9")
                ],
                hintsRU: ["Два указателя left и right с сохранением leftMax и rightMax."],
                hintsEN: ["Maintain left, right, leftMax, and rightMax."],
                solutionCode: ##"""
func trapRainWater(_ height: [Int]) -> Int {
    guard height.count > 2 else { return 0 }
    var left = 0
    var right = height.count - 1
    var leftMax = 0
    var rightMax = 0
    var totalWater = 0
    while left < right {
        if height[left] < height[right] {
            if height[left] >= leftMax {
                leftMax = height[left]
            } else {
                totalWater += leftMax - height[left]
            }
            left += 1
        } else {
            if height[right] >= rightMax {
                rightMax = height[right]
            } else {
                totalWater += rightMax - height[right]
            }
            right -= 1
        }
    }
    return totalWater
}
"""##,
                xpReward: 75
            ),

            // [LeetCode #84] Наибольший прямоугольник в гистограмме (Largest Rectangle)
            CodingTask(
                id: "lc_largest_rectangle_in_histogram",
                titleRU: "[LeetCode #84] Наибольший прямоугольник в гистограмме (Largest Rectangle)",
                titleEN: "[LeetCode #84] Largest Rectangle in Histogram",
                difficulty: .hard,
                category: .algorithms,
                summaryRU: "Найдите площадь наибольшего прямоугольника в гистограмме, используя монотонный стек за O(N).",
                summaryEN: "Find the area of largest rectangle in histogram using monotonic stack in O(N).",
                descriptionRU: ##"""
### Условие
Напишите функцию `largestRectangleArea(_ heights: [Int]) -> Int`.
Сложность должна быть линейной O(N).
"""##,
                descriptionEN: ##"""
Monotonic stack solution in O(N).
"""##,
                requirementsRU: ["Монотонно возрастающий стек индексов"],
                requirementsEN: ["Monotonic increasing index stack"],
                starterCode: ##"""
func largestRectangleArea(_ heights: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "largestRectangleArea([2,1,5,6,2,3])", expectedOutput: "10", validationCode: "largestRectangleArea([2,1,5,6,2,3]) == 10"),
                    TaskTestCase(title: "Тест 2", inputDescription: "largestRectangleArea([2,4])", expectedOutput: "4", validationCode: "largestRectangleArea([2,4]) == 4")
                ],
                hintsRU: ["Стек хранит индексы столбцов в порядке возрастания высот."],
                hintsEN: ["Maintain monotonic increasing stack of bar indices."],
                solutionCode: ##"""
func largestRectangleArea(_ heights: [Int]) -> Int {
    var stack: [Int] = []
    var maxArea = 0
    let n = heights.count
    for i in 0...n {
        let currentHeight = (i == n) ? 0 : heights[i]
        while let top = stack.last, currentHeight < heights[top] {
            stack.removeLast()
            let h = heights[top]
            let w = stack.isEmpty ? i : (i - stack.last! - 1)
            maxArea = max(maxArea, h * w)
        }
        stack.append(i)
    }
    return maxArea
}
"""##,
                xpReward: 80
            ),

            // [Codeforces 455A] Скука (Boredom Dynamic Programming)
            CodingTask(
                id: "cf_455a_boredom",
                titleRU: "[Codeforces 455A] Скука (Boredom Dynamic Programming)",
                titleEN: "[Codeforces 455A] Boredom",
                difficulty: .hard,
                category: .algorithms,
                summaryRU: "При выборе числа x вы получаете x очков, но удаляются все числа x-1 и x+1. Максимизируйте сумму очков.",
                summaryEN: "Choosing number x awards x points but deletes x-1 and x+1. Maximize total score.",
                descriptionRU: ##"""
### Условие
Напишите функцию `maxBoredomPoints(_ nums: [Int]) -> Int`.
Аналог задачи House Robber, но на частотах чисел: при выборе значения x мы получаем x * count(x) и не можем брать x-1.
"""##,
                descriptionEN: ##"""
Dynamic programming on frequency buckets.
"""##,
                requirementsRU: ["Преобразование к массиву частот + 1D ДП за O(max_element)"],
                requirementsEN: ["Frequency count array + 1D DP in O(max_val)"],
                starterCode: ##"""
func maxBoredomPoints(_ nums: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "maxBoredomPoints([1, 2])", expectedOutput: "2", validationCode: "maxBoredomPoints([1, 2]) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "maxBoredomPoints([1, 2, 3])", expectedOutput: "4", validationCode: "maxBoredomPoints([1, 2, 3]) == 4"),
                    TaskTestCase(title: "Тест 3", inputDescription: "maxBoredomPoints([1, 2, 1, 3, 2, 2, 2, 2, 3])", expectedOutput: "10", validationCode: "maxBoredomPoints([1, 2, 1, 3, 2, 2, 2, 2, 3]) == 10")
                ],
                hintsRU: ["Посчитайте частоту каждого числа. points[x] = x * count[x]. Далее ДП как в House Robber."],
                hintsEN: ["Count occurrences of each number. Transform into House Robber problem."],
                solutionCode: ##"""
func maxBoredomPoints(_ nums: [Int]) -> Int {
    guard let maxVal = nums.max(), maxVal > 0 else { return 0 }
    var count = Array(repeating: 0, count: maxVal + 1)
    for num in nums { count[num] += 1 }
    var prev = 0
    var curr = 0
    for i in 1...maxVal {
        let take = prev + i * count[i]
        let skip = curr
        prev = curr
        curr = max(take, skip)
    }
    return curr
}
"""##,
                xpReward: 75
            ),

            // [Codeforces 1418C] Башня Mortal Kombat (Mortal Kombat Tower DP)
            CodingTask(
                id: "cf_1418c_mortal_kombat_tower",
                titleRU: "[Codeforces 1418C] Башня Mortal Kombat (Mortal Kombat Tower DP)",
                titleEN: "[Codeforces 1418C] Mortal Kombat Tower",
                difficulty: .hard,
                category: .algorithms,
                summaryRU: "Найдите минимальное количество очков пропуска для легких боссов (0) и сложных боссов (1), дерясь по очереди с другом.",
                summaryEN: "Find minimum skip points for hard bosses in turn-based game.",
                descriptionRU: ##"""
### Условие
Напишите функцию `minSkipPointsForBosses(_ bosses: [Int]) -> Int`.
Вы и ваш друг бьётесь по очереди. За ход можно победить 1 или 2 боссов. Друг тратит 1 очко пропуска на каждого сложного босса (`1`). Вы очков не тратите.
"""##,
                descriptionEN: ##"""
2-state Dynamic Programming to minimize friend's skip points.
"""##,
                requirementsRU: ["Двухмерное ДП по состояниям (ход друга / ваш ход)"],
                requirementsEN: ["2-state turn DP"],
                starterCode: ##"""
func minSkipPointsForBosses(_ bosses: [Int]) -> Int {
    return 0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "minSkipPointsForBosses([1,0,1,1,0,1,1,1])", expectedOutput: "2", validationCode: "minSkipPointsForBosses([1,0,1,1,0,1,1,1]) == 2"),
                    TaskTestCase(title: "Тест 2", inputDescription: "minSkipPointsForBosses([0,0,0,0,0])", expectedOutput: "0", validationCode: "minSkipPointsForBosses([0,0,0,0,0]) == 0")
                ],
                hintsRU: ["ДП: dp[i][0] — минимальные пропуски, если на очереди ход друга перед боссом i, dp[i][1] — ваш ход."],
                hintsEN: ["Maintain DP states for friend's turn vs your turn."],
                solutionCode: ##"""
func minSkipPointsForBosses(_ bosses: [Int]) -> Int {
    let n = bosses.count
    if n == 0 { return 0 }
    let inf = 1_000_000
    var dpFriend = Array(repeating: inf, count: n + 1)
    var dpMe = Array(repeating: inf, count: n + 1)
    dpFriend[0] = 0
    for i in 0..<n {
        if dpFriend[i] < inf {
            let cost1 = bosses[i]
            dpMe[i + 1] = min(dpMe[i + 1], dpFriend[i] + cost1)
            if i + 1 < n {
                let cost2 = cost1 + bosses[i + 1]
                dpMe[i + 2] = min(dpMe[i + 2], dpFriend[i] + cost2)
            }
        }
        if dpMe[i] < inf {
            dpFriend[i + 1] = min(dpFriend[i + 1], dpMe[i])
            if i + 1 < n {
                dpFriend[i + 2] = min(dpFriend[i + 2], dpMe[i])
            }
        }
    }
    return min(dpFriend[n], dpMe[n])
}
"""##,
                xpReward: 80
            ),

            // [LeetCode #4] Медиана двух массивов (Median of Two Sorted Arrays)
            CodingTask(
                id: "lc_median_of_two_sorted_arrays",
                titleRU: "[LeetCode #4] Медиана двух массивов (Median of Two Sorted Arrays)",
                titleEN: "[LeetCode #4] Median of Two Sorted Arrays",
                difficulty: .expert,
                category: .algorithms,
                summaryRU: "Найдите медиану двух отсортированных массивов за O(log(min(m, n))).",
                summaryEN: "Find median of two sorted arrays in O(log(min(m, n))).",
                descriptionRU: ##"""
### Условие
Напишите функцию `findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double`.
Асимптотическая сложность должна быть строго O(log(min(m, n))).
"""##,
                descriptionEN: ##"""
Binary search partition algorithm in O(log(min(m, n))).
"""##,
                requirementsRU: ["Бинарный поиск по разрезу меньшего массива O(log(min(m, n)))"],
                requirementsEN: ["Binary search on smaller array partition"],
                starterCode: ##"""
func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    return 0.0
}
"""##,
                testCases: [
                    TaskTestCase(title: "Тест 1", inputDescription: "findMedianSortedArrays([1,3], [2])", expectedOutput: "2.0", validationCode: "findMedianSortedArrays([1,3], [2]) == 2.0"),
                    TaskTestCase(title: "Тест 2", inputDescription: "findMedianSortedArrays([1,2], [3,4])", expectedOutput: "2.5", validationCode: "findMedianSortedArrays([1,2], [3,4]) == 2.5")
                ],
                hintsRU: ["Разделите оба массива так, чтобы слева и справа было одинаковое число элементов, а maxLeft <= minRight."],
                hintsEN: ["Partition both arrays using binary search on the shorter array."],
                solutionCode: ##"""
func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    var a = nums1
    var b = nums2
    if a.count > b.count { swap(&a, &b) }
    let m = a.count
    let n = b.count
    var low = 0
    var high = m
    while low <= high {
        let partitionA = (low + high) / 2
        let partitionB = (m + n + 1) / 2 - partitionA
        let maxLeftA = (partitionA == 0) ? Int.min : a[partitionA - 1]
        let minRightA = (partitionA == m) ? Int.max : a[partitionA]
        let maxLeftB = (partitionB == 0) ? Int.min : b[partitionB - 1]
        let minRightB = (partitionB == n) ? Int.max : b[partitionB]
        if maxLeftA <= minRightB && maxLeftB <= minRightA {
            if (m + n) % 2 == 0 {
                return Double(max(maxLeftA, maxLeftB) + min(minRightA, minRightB)) / 2.0
            } else {
                return Double(max(maxLeftA, maxLeftB))
            }
        } else if maxLeftA > minRightB {
            high = partitionA - 1
        } else {
            low = partitionA + 1
        }
    }
    return 0.0
}
"""##,
                xpReward: 100
            )
        ]
    }
}
