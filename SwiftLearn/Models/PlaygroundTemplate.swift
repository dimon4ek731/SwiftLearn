import Foundation

public struct PlaygroundTemplate: Identifiable, Hashable {
    public var id: String { titleEN }
    public let titleRU: String
    public let titleEN: String
    public let descriptionRU: String
    public let descriptionEN: String
    public let icon: String
    public let defaultCode: String
    
    public static let templates: [PlaygroundTemplate] = [
        PlaygroundTemplate(
            titleRU: "Основы и переменные",
            titleEN: "Variables & Print",
            descriptionRU: "Константы, переменные и строковая интерполяция",
            descriptionEN: "Constants, variables and string interpolation",
            icon: "text.alignleft",
            defaultCode: """
// Основы языка Swift: Константы и переменные
let appName = "SwiftLearn"
let version = 2.0
var activeUsers = 1250

print("Добро пожаловать в \\(appName)!")
print("Текущая версия:", version)

activeUsers += 15
print("Активных разработчиков:", activeUsers)

let isProductionReady = activeUsers > 1000
print("Готовность к релизу:", isProductionReady)
"""
        ),
        PlaygroundTemplate(
            titleRU: "Функции и рекурсия",
            titleEN: "Functions & Recursion",
            descriptionRU: "Пользовательские функции func и рекурсивный расчет",
            descriptionEN: "User-defined func statements and recursive computation",
            icon: "curlybraces",
            defaultCode: """
// Пользовательские функции и вычисления
func calculateSalary(base: Int, bonusRate: Double) -> Double {
    let bonus = Double(base) * bonusRate
    return Double(base) + bonus
}

let seniorSalary = calculateSalary(base: 320000, bonusRate: 0.15)
print("Итоговая компенсация Senior:", seniorSalary)

// Рекурсивный факториал
func factorial(n: Int) -> Int {
    if n <= 1 {
        return 1
    }
    return n * factorial(n: n - 1)
}

print("5! =", factorial(n: 5))
print("6! =", factorial(n: 6))
"""
        ),
        PlaygroundTemplate(
            titleRU: "Структуры данных (struct)",
            titleEN: "Custom Structs",
            descriptionRU: "Пользовательские структуры, свойства и изменение",
            descriptionEN: "Custom structs, properties and mutation",
            icon: "shippingbox",
            defaultCode: """
// Пользовательские структуры в Swift
struct Engineer {
    var name: String
    var grade: String
    var pullRequests: Int
}

var developer = Engineer(name: "Алексей", grade: "Middle+", pullRequests: 42)
print("Инженер:", developer.name)
print("Текущий грейд:", developer.grade)
print("Закрытых PR:", developer.pullRequests)

// Мутация полей структуры
developer.pullRequests += 1
developer.grade = "Senior"

print("После обновления:")
print("Новый грейд:", developer.grade)
print("Всего PR:", developer.pullRequests)
"""
        ),
        PlaygroundTemplate(
            titleRU: "Замыкания: map и filter",
            titleEN: "Closures & Higher-Order",
            descriptionRU: "Трансформация коллекций через функции высшего порядка",
            descriptionEN: "Collection transformation via higher-order closures",
            icon: "arrow.triangle.merge",
            defaultCode: """
// Функции высшего порядка: map и filter
let numbers = [3, 8, 12, 19, 24, 35, 40]
print("Исходный массив:", numbers)

// Фильтрация четных чисел
let evens = numbers.filter { $0 % 2 == 0 }
print("Только четные числа:", evens)

// Трансформация элементов ($0 * 10)
let scaled = evens.map { $0 * 10 }
print("Умноженные на 10:", scaled)

let count = scaled.count
print("Итого элементов:", count)
"""
        ),
        PlaygroundTemplate(
            titleRU: "Алгоритмы и массивы",
            titleEN: "Arrays & Sorting",
            descriptionRU: "Операции с коллекциями и встроенные методы",
            descriptionEN: "Collection operations and standard methods",
            icon: "tray.full",
            defaultCode: """
// Работа с массивами и алгоритмами
var numbers = [42, 17, 88, 5, 63, 29]
print("Исходный массив:", numbers)
print("Количество элементов:", numbers.count)

numbers.append(99)
print("После добавления 99:", numbers)

let sortedNumbers = numbers.sorted()
print("Отсортированный массив:", sortedNumbers)

let reversedNumbers = sortedNumbers.reversed()
print("В обратном порядке:", reversedNumbers)

let firstElement = sortedNumbers.first
let lastElement = sortedNumbers.last
print("Минимум:", firstElement, "Максимум:", lastElement)
"""
        ),
        PlaygroundTemplate(
            titleRU: "Циклы и Фибоначчи",
            titleEN: "Loops & Fibonacci",
            descriptionRU: "Генерация числовой последовательности циклом",
            descriptionEN: "Fibonacci sequence generation using loops",
            icon: "repeat",
            defaultCode: """
// Генерация чисел Фибоначчи
var a = 0
var b = 1
let count = 10

print("Первые \\(count) чисел ряда Фибоначчи:")
print(a)
print(b)

for i in 2..<count {
    let next = a + b
    print(next)
    a = b
    b = next
}
"""
        )
    ]
}
