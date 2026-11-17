import Foundation

public final class OfficialDocsStore {
    public static let shared = OfficialDocsStore()
    
    public let topics: [OfficialDocTopic]
    
    public init() {
        self.topics = [
            OfficialDocTopic(
                id: "welcome_about",
                section: .welcome,
                chapterNumber: 1,
                titleEN: "About Swift",
                titleRU: "О языке Swift",
                summaryEN: "Swift is a general-purpose, multi-paradigm, compiled programming language developed by Apple Inc. and the open-source community.",
                summaryRU: "Swift — универсальный компилируемый язык программирования от Apple, спроектированный с акцентом на безопасность, производительность и выразительность.",
                webSlug: "guidedtour",
                contentMarkdownEN: ##"""
# About Swift

Swift is a fantastic way to write software, whether it’s for phones, desktops, servers, or anything else that runs code. It’s a safe, fast, and interactive programming language that combines the best in modern language thinking with wisdom from the wider Apple engineering culture and the diverse contributions from its open-source community. The compiler is optimized for performance and the language is optimized for development, without compromising on either.

Swift is friendly to new programmers. It’s an industrial-quality systems programming language that’s as expressive and enjoyable as a scripting language. Writing Swift code in a playground or REPL lets you experiment with code and see the results immediately, without the overhead of building and running an app.

Swift defines away large classes of common programming errors by adopting modern lightweight safety patterns:
- Variables are always initialized before use.
- Array indices are checked for out-of-bounds errors.
- Integers are checked for overflow.
- Optionals ensure that `nil` values are handled explicitly.
- Memory is managed automatically with Automatic Reference Counting (ARC).
- Error handling provides controlled recovery from unexpected failures.
- Swift 6 introduces default Data-Race Safety preventing concurrent mutations across threads.

```swift
let greeting = "Hello, Swift 6!"
print(greeting)
```

Swift code is compiled and optimized to get the most out of modern hardware. The syntax and standard library have been designed based on the guiding principle that the most obvious way to write your code should also perform the best.

"""##,
                contentMarkdownRU: ##"""
# О языке Swift

Swift — современный безопасный, производительный и выразительный компилируемый язык программирования общего назначения, разработанный Apple и открытым сообществом. Он объединяет лучшие достижения теории языков программирования с огромным инженерным опытом платформ Apple.

Язык дружелюбен к новичкам, при этом являясь высокопроизводительным системным инструментом:
- **Безопасность типов**: строгая типизация и автоматический вывод типов (type inference).
- **Инициализация перед использованием**: переменные не могут оставаться неинициализированными.
- **Безопасность диапазонов**: исключены ошибки выхода за границы массивов (out-of-bounds).
- **Контроль переполнения**: целочисленные переполнения вызывают контролируемые падения компилятора, а не повреждение памяти.
- **Опционалы (Optionals)**: явная работа с отсутствующими значениями исключает «ошибки на миллиард долларов» (Null Pointer Exception).
- **Автоматическое управление памятью**: детерминированный подсчет ссылок (ARC).
- **Swift 6 Data-Race Safety**: полная изоляция состояний в многопоточности на уровне компилятора.

```swift
let greeting = "Привет, Swift 6!"
print(greeting)
```

Синтаксис Swift спроектирован так, чтобы самый понятный и читаемый код одновременно являлся максимально оптимизированным по скорости выполнения.

"""##
            ),
            OfficialDocTopic(
                id: "welcome_tour",
                section: .welcome,
                chapterNumber: 2,
                titleEN: "A Swift Tour",
                titleRU: "Экскурс в Swift",
                summaryEN: "A comprehensive tour of the fundamental features and syntax of the Swift programming language.",
                summaryRU: "Полный обзор ключевых синтаксических конструкций: переменные, ветвления, функции, замыкания, ООП, протоколы и конкурентность.",
                webSlug: "guidedtour",
                contentMarkdownEN: ##"""
# A Swift Tour

Tradition suggests that the first program in a new language should print the words “Hello, world!” on the screen. In Swift, this can be done in a single line:

```swift
print("Hello, world!")
```

If you have written code in C or Objective-C, this syntax looks familiar to you — in Swift, this line of code is a complete program. You don’t need to import a separate library for functionality like input/output or string handling. Code written at global scope is used as the entry point for the program, so you don’t need a `main()` function. You also don’t need semicolons at the end of every statement.

## Simple Values
Use `let` to make a constant and `var` to make a variable. The value of a constant doesn't need to be known at compile time, but you must assign it a value exactly once.

```swift
var myVariable = 42
myVariable = 50
let myConstant = 42
```

Values are never implicitly converted to another type. If you need to convert a value to a different type, explicitly make an instance of the desired type:

```swift
let label = "The width is "
let width = 94
let widthLabel = label + String(width)
```

Use `\()` to include values in strings:

```swift
let apples = 3
let oranges = 5
let fruitSummary = "I have \(apples + oranges) pieces of fruit."
```

## Control Flow
Use `if` and `switch` to make conditionals, and use `for-in`, `while`, and `repeat-while` to make loops.

```swift
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)
```

## Functions and Closures
Use `func` to declare a function. Call a function by following its name with a list of arguments in parentheses.

```swift
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")
```

Functions are actually a special case of closures: blocks of code that can be called later.

```swift
let numbers = [20, 19, 7, 12]
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)
```

"""##,
                contentMarkdownRU: ##"""
# Экскурс в Swift

Традиционно знакомство с новым языком начинается с вывода фразы «Hello, world!». В Swift для этого достаточно одной строки:

```swift
print("Hello, world!")
```

Этот код является полноценной программой. Нет необходимости оборачивать код в функцию `main()` или ставить точку с запятой `;` в конце строк.

## Простые значения
Используйте `let` для создания констант и `var` для создания переменных:

```swift
var myVariable = 42
myVariable = 50
let myConstant = 42
```

Swift никогда не выполняет неявное приведение типов:

```swift
let label = "Ширина: "
let width = 94
let widthLabel = label + String(width)
```

Интерполяция строк выполняется через `\()`:

```swift
let apples = 3
let oranges = 5
let fruitSummary = "У меня \(apples + oranges) фруктов."
```

## Управление потоком
Ветвления реализуются через `if` и `switch`, а циклы через `for-in`, `while` и `repeat-while`:

```swift
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)
```

## Функции и замыкания
Функции объявляются ключевым словом `func`:

```swift
func greet(person: String, day: String) -> String {
    return "Привет \(person), сегодня \(day)."
}
print(greet(person: "Алексей", day: "Вторник"))
```

Замыкания позволяют передавать функциональные блоки в качестве аргументов:

```swift
let numbers = [20, 19, 7, 12]
let tripled = numbers.map { $0 * 3 }
print(tripled)
```

"""##
            ),
            OfficialDocTopic(
                id: "guide_basics",
                section: .languageGuide,
                chapterNumber: 1,
                titleEN: "The Basics",
                titleRU: "Основы языка",
                summaryEN: "Constants and variables, type inference, integers, floating-point, booleans, tuples, optionals, and assertions.",
                summaryRU: "Константы и переменные, вывод типов, числа, булевы значения, кортежи, опционалы, утверждения и предусловия.",
                webSlug: "thebasics",
                contentMarkdownEN: ##"""
# The Basics

Swift provides fundamental data types matching standard C and Objective-C types, including `Int` for integers, `Double` and `Float` for floating-point values, `Bool` for Boolean values, and `String` for textual data. Swift also provides powerful versions of the three primary collection types: `Array`, `Set`, and `Dictionary`.

## Constants and Variables
Constants and variables associate a name with a value of a particular type. The value of a constant cannot be changed once it is set, whereas a variable can be set to a different value in the future.

```swift
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
```

> [!NOTE]
> If a stored value in your code won’t change, always declare it as a constant with the `let` keyword. Use variables only for storing values that need to change.

## Type Annotations
You can provide a type annotation when you declare a constant or variable, to be clear about the kind of values the constant or variable can store:

```swift
var welcomeMessage: String
welcomeMessage = "Hello"
```

## Optionals
You use optionals in situations where a value may be absent. An optional represents two possibilities: Either there is a value, and you can unwrap the optional to access that value, or there isn’t a value at all.

```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber) // Int?
```

### Optional Binding
You use optional binding to find out whether an optional contains a value, and if so, to make that value available as a temporary constant or variable:

```swift
if let actualNumber = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
}
```

In Swift 5.7+, shorthand optional binding is supported:

```swift
var optionalName: String? = "John"
if let optionalName {
    print("Hello, \(optionalName)")
}
```

"""##,
                contentMarkdownRU: ##"""
# Основы языка

Swift предоставляет базовые типы данных: `Int` для целых чисел, `Double` и `Float` для вещественных, `Bool` для логических значений, и `String` для строк. Коллекции представлены `Array`, `Set` и `Dictionary`.

## Константы и переменные
Константы объявляются через `let`, переменные — через `var`:

```swift
let maximumAttempts = 10
var currentAttempt = 0
```

> [!NOTE]
> Всегда объявляйте значения через `let`, если они не будут изменяться во время выполнения. Это помогает компилятору оптимизировать память и защищает от случайных мутаций.

## Опциональные типы (Optionals)
Опционал позволяет переменной хранить либо конкретное значение, либо `nil` (отсутствие значения):

```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber) // Тип Int?
```

### Извлечение опционалов (Optional Binding)
Безопасное извлечение значения через `if let` или `guard let`:

```swift
if let actualNumber = Int(possibleNumber) {
    print("Успешно преобразовано: \(actualNumber)")
} else {
    print("Строка не является числом")
}
```

Сокращенный синтаксис Swift:
```swift
var username: String? = "Alice"
if let username {
    print("Привет, \(username)")
}
```

"""##
            ),
            OfficialDocTopic(
                id: "guide_operators",
                section: .languageGuide,
                chapterNumber: 2,
                titleEN: "Basic Operators",
                titleRU: "Базовые операторы",
                summaryEN: "Assignment, arithmetic, compound assignment, comparison, ternary conditional, nil-coalescing, range, and logical operators.",
                summaryRU: "Операторы присваивания, арифметические, составные, операторы сравнения, тернарный оператор, nil-коалесценция и диапазоны.",
                webSlug: "basicoperators",
                contentMarkdownEN: ##"""
# Basic Operators

An operator is a special symbol or phrase that you use to check, change, or combine values.

## Arithmetic Operators
Swift supports the four standard arithmetic operators for all number types:
- Addition (`+`)
- Subtraction (`-`)
- Multiplication (`*`)
- Division (`/`)

```swift
1 + 2       // equals 3
5 - 3       // equals 2
2 * 3       // equals 6
10.0 / 2.5  // equals 4.0
```

Unlike the arithmetic operators in C and Objective-C, the Swift arithmetic operators don’t allow values to overflow by default. Swift values that overflow are trapped as runtime errors unless you use overflow operators like `&+`.

## Nil-Coalescing Operator
The nil-coalescing operator (`a ?? b`) unwraps an optional `a` if it contains a value, or returns a default value `b` if `a` is `nil`:

```swift
let defaultColorName = "red"
var userDefinedColorName: String? // defaults to nil

var colorNameToUse = userDefinedColorName ?? defaultColorName
// colorNameToUse is "red"
```

## Range Operators
- Closed Range Operator (`a...b`): Defines a range running from `a` to `b`, including both `a` and `b`.
- Half-Open Range Operator (`a..<b`): Defines a range running from `a` up to but not including `b`.
- One-Sided Ranges (`a...`, `...b`, `..<b`).

```swift
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
```

"""##,
                contentMarkdownRU: ##"""
# Базовые операторы

Оператор — это специальный символ для проверки, изменения или комбинирования значений.

## Арифметические операторы
Swift поддерживает стандартные операции:
- Сложение (`+`)
- Вычитание (`-`)
- Умножение (`*`)
- Деление (`/`)
- Остаток от деления (`%`)

```swift
let sum = 10 + 20
let diff = 50 - 15
let prod = 4 * 7
let div = 25 / 5
let rem = 9 % 4 // 1
```

> [!IMPORTANT]
> В Swift арифметические операции по умолчанию защищены от переполнения: попытка превысить лимиты типа `Int` вызовет контролируемую ошибку. Для переполняемой арифметики используются специальные операторы (`&+`, `&-`, `&*`).

## Оператор Nil-коалесценции (`??`)
Оператор `a ?? b` извлекает значение из опционала `a`, а если он равен `nil`, возвращает значение по умолчанию `b`:

```swift
let fallbackPort = 8080
var customPort: Int? = nil

let activePort = customPort ?? fallbackPort // 8080
```

## Операторы диапазонов
- Закрытый диапазон (`1...5`): от 1 до 5 включительно.
- Полуоткрытый диапазон (`0..<count`): полезен для индексации массивов.
- Односторонние диапазоны (`2...`, `...10`).

```swift
let names = ["Анна", "Борис", "Виктор"]
for i in 0..<names.count {
    print("Имя: \(names[i])")
}
```

"""##
            ),
            OfficialDocTopic(
                id: "guide_strings",
                section: .languageGuide,
                chapterNumber: 3,
                titleEN: "Strings and Characters",
                titleRU: "Строки и символы",
                summaryEN: "String literals, Unicode grapheme clusters, string interpolation, indexing, substrings, and mutation.",
                summaryRU: "Строковые литералы, Unicode-графемы, интерполяция, индексы String.Index, подстроки Substring и мутации.",
                webSlug: "stringsandcharacters",
                contentMarkdownEN: ##"""
# Strings and Characters

A string is a series of characters, such as `"hello, world"`. Swift strings are represented by the `String` type. The contents of a `String` can be accessed in various ways, including as a collection of `Character` values.

Swift’s `String` and `Character` types provide a fast, Unicode-compliant way to work with text in your code.

## String Mutability
You specify whether a `String` can be modified (or mutated) by assigning it to a variable or to a constant:

```swift
var variableString = "Horse"
variableString += " and carriage"
// variableString is now "Horse and carriage"

let constantString = "Highlander"
// constantString += " and another Highlander"
// this reports a compile-time error
```

## Strings Are Value Types
Swift’s `String` type is a value type. If you create a new `String` value, that `String` value is copied when it is passed to a function or method, or when it is assigned to a constant or variable. In all these cases, a new copy of the existing `String` value is created.

## String Indices
Each `String` value has an associated index type, `String.Index`, which corresponds to the position of each `Character` in the string. Because different characters require different amounts of memory to store, you cannot index into a string with integer values.

```swift
let greeting = "Guten Tag!"
greeting[greeting.startIndex] // G
greeting[greeting.index(before: greeting.endIndex)] // !
greeting[greeting.index(after: greeting.startIndex)] // u
```

## Substrings
When you get a substring from a string — for example, using a subscript or a method like `prefix(_:)` — the result is an instance of `Substring`, not another string. Substrings in Swift have most of the same methods as strings, which means you can work with substrings in the same way you work with strings. However, unlike strings, you use substrings for only a short amount of time while performing actions on a string.

```swift
let greeting = "Hello, world!"
let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]
// beginning is a Substring: "Hello"

// Convert to String for long-term storage
let newString = String(beginning)
```

"""##,
                contentMarkdownRU: ##"""
# Строки и символы

Строка в Swift — это последовательность символов типа `Character`. Тип `String` полностью совместим с Unicode и обеспечивает корректную работу со сложными символами и эмодзи.

## Семантика значений (Value Types)
Строки в Swift являются типами значений (`struct`). При передаче в функцию или присваивании переменной происходит логическое копирование (с оптимизацией Copy-on-Write).

## Индексация строк (`String.Index`)
Поскольку символы Unicode могут занимать разное количество байт (от 1 до 4), прямое обращение по целочисленному индексу `str[3]` запрещено компилятором. Для навигации используется `String.Index`:

```swift
let greeting = "Привет, мир!"
let firstChar = greeting[greeting.startIndex] // "П"
let lastChar = greeting[greeting.index(before: greeting.endIndex)] // "!"
```

## Подстроки (`Substring`)
При получении среза строки возвращается `Substring`. Она ссылается на буфер исходной строки без выделения новой памяти:

```swift
let text = "Swift 6: Concurrency"
if let colonIndex = text.firstIndex(of: ":") {
    let header = text[..<colonIndex] // Substring: "Swift 6"
    let persistentString = String(header) // Преобразование в отдельный String
}
```

"""##
            ),
            OfficialDocTopic(
                id: "guide_collections",
                section: .languageGuide,
                chapterNumber: 4,
                titleEN: "Collection Types",
                titleRU: "Типы коллекций",
                summaryEN: "Arrays, sets, and dictionaries: ordering, uniqueness, key-value mappings, and collection mutations.",
                summaryRU: "Массивы, множества и словари: упорядоченность, уникальность элементов, ассоциативные связи и мутабельность.",
                webSlug: "collectiontypes",
                contentMarkdownEN: ##"""
# Collection Types

Swift provides three primary collection types, known as arrays, sets, and dictionaries, for storing collections of values:
- **Arrays** are ordered collections of values.
- **Sets** are unordered collections of unique values.
- **Dictionaries** are unordered collections of key-value associations.

## Mutability of Collections
If you create an array, set, or dictionary, and assign it to a variable, the collection that is created will be mutable. This means that you can change (or mutate) the collection after it’s created by adding, removing, or changing items. If you assign an array, set, or dictionary to a constant, that collection is immutable, and its size and contents cannot be changed.

## Arrays
An array stores values of the same type in an ordered list. The same value can appear in an array multiple times at different positions.

```swift
var shoppingList: [String] = ["Eggs", "Milk"]
shoppingList.append("Flour")
shoppingList += ["Baking Powder"]
let firstItem = shoppingList[0] // "Eggs"
```

## Sets
A set stores distinct values of the same type in a collection with no defined ordering. You can use a set instead of an array when the order of items isn’t important, or when you need to ensure that an item only appears once. A type must be `Hashable` in order to be stored in a set.

```swift
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
favoriteGenres.insert("Jazz")
if favoriteGenres.contains("Rock") {
    print("Rock is included!")
}
```

## Dictionaries
A dictionary stores associations between keys of the same type and values of the same type in an unordered collection. Each value is associated with a unique key, which acts as an identifier for that value within the dictionary.

```swift
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
airports["LHR"] = "London Heathrow"

if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
}
```

"""##,
                contentMarkdownRU: ##"""
# Типы коллекций

Swift предлагает три основные коллекции для группировки данных:
- **Массивы (`Array`)**: упорядоченные списки элементов.
- **Множества (`Set`)**: неупорядоченные коллекции уникальных элементов (требуют соответствия протоколу `Hashable`).
- **Словари (`Dictionary`)**: пары «ключ-значение» с быстрым поиском по ключу.

## Массивы
```swift
var tasks = ["Изучить Swift", "Написать код"]
tasks.append("Собрать проект")
let count = tasks.count
let first = tasks[0]
```

## Множества
```swift
var uniqueIDs: Set<Int> = [101, 102, 103, 101]
print(uniqueIDs.count) // 3
uniqueIDs.insert(104)
```

## Словари
```swift
var capitals = ["RU": "Москва", "FR": "Париж", "DE": "Берлин"]
capitals["IT"] = "Рим"

if let capital = capitals["RU"] {
    print("Столица: \(capital)")
}
```

"""##
            ),
            OfficialDocTopic(
                id: "guide_control_flow",
                section: .languageGuide,
                chapterNumber: 5,
                titleEN: "Control Flow",
                titleRU: "Управление потоком",
                summaryEN: "For-in, while, repeat-while, if, guard, switch with pattern matching, and control transfer statements.",
                summaryRU: "Циклы for-in, while, repeat-while, ветвления if, оператор guard, сопоставление с шаблоном switch и операторы передачи управления.",
                webSlug: "controlflow",
                contentMarkdownEN: ##"""
# Control Flow

Swift provides a variety of control flow statements. These include `while` loops to perform a task multiple times; `if`, `guard`, and `switch` statements to execute different branches of code; and statements such as `break` and `continue` to transfer the flow of execution.

## For-In Loops
You use the `for-in` loop to iterate over a sequence, such as items in an array, ranges of numbers, or characters in a string:

```swift
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}

for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
```

## Early Exit with Guard
A `guard` statement, like an `if` statement, executes statements depending on the Boolean value of an expression. You use a `guard` statement to require that a condition must be true in order for the code after the `guard` statement to be executed. Unlike an `if` statement, a `guard` statement always has an `else` clause:

```swift
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)!")
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}
```

## Switch and Pattern Matching
A `switch` statement considers a value and compares it against several possible matching patterns. Swift `switch` cases do not fall through by default:

```swift
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
```

"""##,
                contentMarkdownRU: ##"""
# Управление потоком

Swift предоставляет мощные конструкции для управления логикой исполнения программы: циклы, ветвления и сопоставление с образцом.

## Ранний выход (`guard`)
Конструкция `guard let` гарантирует выполнение условия перед переходом к следующей строке, предотвращая глубокую вложенность кода (пирамиду проверок):

```swift
func processUser(id: Int?) {
    guard let id, id > 0 else {
        print("Некорректный идентификатор")
        return
    }
    print("Обработка пользователя #\(id)")
}
```

## Pattern Matching в Switch
Оператор `switch` в Swift исчерпывающий (exhaustive), поддерживает диапазоны, кортежи и привязку значений:

```swift
let httpCode = 404
switch httpCode {
case 200..<300:
    print("Успех")
case 400..<500:
    print("Клиентская ошибка")
case 500..<600:
    print("Серверная ошибка")
default:
    print("Неизвестный статус")
}
```

"""##
            ),
            OfficialDocTopic(
                id: "guide_functions",
                section: .languageGuide,
                chapterNumber: 6,
                titleEN: "Functions",
                titleRU: "Функции",
                summaryEN: "Defining, calling, argument labels, parameter names, default values, variadics, in-out parameters, and function types.",
                summaryRU: "Объявление и вызов, аргументные метки, параметры, значения по умолчанию, вариативные и in-out параметры, функциональные типы.",
                webSlug: "functions",
                contentMarkdownEN: ##"""
# Functions

Functions are self-contained chunks of code that perform a specific task. You give a function a name that identifies what it does, and this name is used to “call” the function to perform its task when needed.

## Argument Labels and Parameter Names
Each function parameter has both an argument label and a parameter name. The argument label is used when calling the function; each argument is written in the function call with its argument label before it. The parameter name is used in the implementation of the function:

```swift
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))
```

If you don’t want an argument label for a parameter, write an underscore (`_`) instead of an explicit argument label:

```swift
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(1, secondParameterName: 2)
```

## In-Out Parameters
Function parameters are constants by default. Trying to change the value of a function parameter from within the body of that function results in a compile-time error. If you want a function to modify a parameter’s value, and you want those changes to persist after the function call has ended, define that parameter as an in-out parameter instead:

```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
```

"""##,
                contentMarkdownRU: ##"""
# Функции

Функции в Swift являются полноправными объектами первого класса (first-class citizens) — их можно передавать в качестве параметров, возвращать из других функций и присваивать переменным.

## Внешние метки и внутренние имена
Swift позволяет задавать читаемые внешние метки аргументов:

```swift
func send(message: String, to recipient: String) {
    print("Отправлено '\(message)' для \(recipient)")
}
send(message: "Привет!", to: "Дмитрий")
```

Символ `_` отключает необходимость указания метки при вызове:
```swift
func square(_ x: Int) -> Int {
    return x * x
}
let res = square(5)
```

## Изменяемые аргументы (`inout`)
Для изменения переданной переменной напрямую используется спецификатор `inout`:

```swift
func increment(_ value: inout Int) {
    value += 1
}
var counter = 10
increment(&counter)
print(counter) // 11
```

"""##
            ),
            OfficialDocTopic(
                id: "guide_closures",
                section: .languageGuide,
                chapterNumber: 7,
                titleEN: "Closures",
                titleRU: "Замыкания",
                summaryEN: "Closure expressions, trailing closures, value capturing, reference semantics, escaping closures, and autoclosures.",
                summaryRU: "Синтаксис замыканий, хвостовые замыкания (trailing closures), захват контекста, @escaping и @autoclosure.",
                webSlug: "closures",
                contentMarkdownEN: ##"""
# Closures

Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.

Closures can capture and store references to any constants and variables from the context in which they’re defined. This is known as closing over those constants and variables. Swift handles all of the memory management of capturing for you.

## Closure Expression Syntax
Closure expression syntax has the following general form:

```swift
{ (parameters) -> return type in
    statements
}
```

```swift
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
var reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
```

### Inferring Type From Context & Shorthand Argument Names
Because the sorting closure is passed as an argument to a method, Swift can infer the types of its parameters and the type of the value it returns. Swift automatically provides shorthand argument names to inline closures: `$0`, `$1`, `$2`:

```swift
reversedNames = names.sorted(by: { $0 > $1 })
```

## Trailing Closures
If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead:

```swift
reversedNames = names.sorted { $0 > $1 }
```

## Escaping Closures
A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. When you declare a function that takes a closure as one of its parameters, you can write `@escaping` before the parameter’s type to indicate that the closure is allowed to escape:

```swift
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
```

"""##,
                contentMarkdownRU: ##"""
# Замыкания (Closures)

Замыкания — это автономные блоки кода, которые можно передавать и использовать в программе. Они способны захватывать и сохранять ссылки на константы и переменные из контекста, в котором были объявлены.

## Синтаксис выражений замыкания
```swift
let numbers = [5, 2, 8, 1, 9]
let sorted = numbers.sorted { $0 < $1 }
```

## Завершающие замыкания (Trailing Closures)
Если замыкание является последним аргументом функции, оно выносится за скобки вызова:

```swift
func fetchData(completion: (Data) -> Void) {
    // загрузка данных
}

fetchData { data in
    print("Получено: \(data.count) байт")
}
```

## Сбегающие замыкания (`@escaping`)
Если замыкание сохраняется для отложенного вызова (например, после завершения асинхронного сетевого запроса), оно помечается `@escaping`:

```swift
class NetworkService {
    var onComplete: (() -> Void)?
    
    func performRequest(completion: @escaping () -> Void) {
        self.onComplete = completion
    }
}
```

"""##
            ),
            OfficialDocTopic(
                id: "guide_structures_classes",
                section: .languageGuide,
                chapterNumber: 8,
                titleEN: "Structures and Classes",
                titleRU: "Структуры и классы",
                summaryEN: "Comparing value types and reference types, identity operators, memberwise initializers, and architectural guidance.",
                summaryRU: "Сравнение типов значений и ссылочных типов, операторы идентичности ===, почленные инициализаторы и выбор структуры данных.",
                webSlug: "classesandstructures",
                contentMarkdownEN: ##"""
# Structures and Classes

Structures and classes are general-purpose, flexible constructs that become the building blocks of your program’s code. You define properties and methods to add functionality to your structures and classes using the same syntax you use to define constants, variables, and functions.

## Comparing Structures and Classes
Structures and classes in Swift have many things in common. Both can:
- Define properties to store values.
- Define methods to provide functionality.
- Define subscripts to provide access to their values using subscript syntax.
- Define initializers to set up their initial state.
- Be extended to expand their functionality beyond a default implementation.
- Conform to protocols to provide standard functionality of a certain kind.

Classes have additional capabilities that structures don’t have:
- **Inheritance** enables one class to inherit the characteristics of another.
- **Type casting** enables you to check and interpret the type of a class instance at runtime.
- **Deinitializers** enable an instance of a class to free up any resources it has assigned.
- **Reference counting** allows more than one reference to a class instance.

> [!IMPORTANT]
> Structures are always copied when they’re passed around in your code, and don’t use reference counting. Prefer structures by default unless class-specific capabilities are strictly required.

```swift
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
```

"""##,
                contentMarkdownRU: ##"""
# Структуры и классы

Структуры (`struct`) и классы (`class`) — главные строительные блоки архитектуры приложений на Swift.

## Главное отличие: Value Types vs Reference Types
- **Структуры (`struct`)** — типы значений. При передаче в функцию или присваивании создается независимая копия объекта.
- **Классы (`class`)** — ссылочные типы. Несколько переменных могут ссылаться на один и тот же экземпляр в памяти (куче).

```swift
struct Point {
    var x: Double
    var y: Double
}

var p1 = Point(x: 10, y: 20)
var p2 = p1
p2.x = 99
print(p1.x) // 10 — p1 осталась неизменной!
```

> [!TIP]
> Официальная рекомендация Apple: по умолчанию всегда выбирайте `struct`. Используйте `class` только тогда, когда вам необходимо наследование, идентичность экземпляра (`===`) или деинициализатор `deinit`.

"""##
            ),
            OfficialDocTopic(
                id: "guide_properties",
                section: .languageGuide,
                chapterNumber: 9,
                titleEN: "Properties",
                titleRU: "Свойства",
                summaryEN: "Stored, computed, lazy properties, property observers (willSet, didSet), and property wrappers.",
                summaryRU: "Хранимые, вычисляемые, ленивые свойства, наблюдатели willSet/didSet и обертки свойств (@propertyWrapper).",
                webSlug: "properties",
                contentMarkdownEN: ##"""
# Properties

Properties associate values with a particular class, structure, or enumeration. Stored properties store constant and variable values as part of an instance, whereas computed properties calculate (rather than store) a value. Computed properties are provided by classes, structures, and enumerations. Stored properties are provided only by classes and structures.

## Computed Properties
In addition to stored properties, classes, structures, and enumerations can define computed properties, which don’t actually store a value. Instead, they provide a getter and an optional setter to retrieve and set other properties and values indirectly:

```swift
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
```

## Property Observers
Property observers observe and respond to changes in a property’s value. Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value.
- `willSet` is called just before the value is stored.
- `didSet` is called immediately after the new value is stored.

```swift
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
```

"""##,
                contentMarkdownRU: ##"""
# Свойства

Свойства связывают значения с экземплярами классов, структур и перечислений.

## Хранимые и вычисляемые свойства
```swift
struct Circle {
    var radius: Double // Хранимое свойство
    
    // Вычисляемое свойство
    var area: Double {
        return Double.pi * radius * radius
    }
}
```

## Наблюдатели свойств (`willSet` и `didSet`)
Позволяют реагировать на изменение значения свойства:

```swift
class Account {
    var balance: Double = 0.0 {
        willSet {
            print("Баланс изменится с \(balance) на \(newValue)")
        }
        didSet {
            print("Баланс обновлен: \(balance) (было \(oldValue))")
        }
    }
}
```

"""##
            ),
            OfficialDocTopic(
                id: "guide_concurrency",
                section: .languageGuide,
                chapterNumber: 10,
                titleEN: "Concurrency",
                titleRU: "Многопоточность (Concurrency)",
                summaryEN: "Async/await, Task and TaskGroup, actors, actor isolation, Sendable, and Swift 6 data-race safety.",
                summaryRU: "Асинхронные функции async/await, задачи Task/TaskGroup, акторы actor, изоляция данных и безопасность потоков в Swift 6.",
                webSlug: "concurrency",
                contentMarkdownEN: ##"""
# Concurrency

Swift has built-in support for writing asynchronous and parallel code in a structured way. Asynchronous code can be suspended and resumed later, though only one piece of the program executes at a time. Suspending and resuming code allows your program to make progress on short-term operations like updating its UI while continuing to run long-term operations like fetching data over the network or parsing files. Parallel code means multiple pieces of code execute simultaneously.

## Defining and Calling Asynchronous Functions
An asynchronous function or method is a special kind of function or method that can be suspended while it’s partway through execution. This is in contrast to ordinary, synchronous functions and methods, which either run to completion, throw an error, or never return.

```swift
func listPhotos(inGallery name: String) async -> [String] {
    // Asynchronous network or file system operations
    return ["photo1.jpg", "photo2.jpg"]
}

let photos = await listPhotos(inGallery: "Summer Vacation")
```

## Actors
You can use actors to safely access shared state. Like classes, actors are reference types. Unlike classes, actors allow only one task to access their mutable state at a time, which makes it safe for code in multiple tasks to interact with the same instance of an actor:

```swift
actor TemperatureLogger {
    let label: String
    var measurements: [Double]
    private(set) var max: Double

    init(label: String, measurement: Double) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }

    func update(with measurement: Double) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}
```

You access properties and methods of an actor with `await`:

```swift
let logger = TemperatureLogger(label: "Outdoors", measurement: 25.0)
print(await logger.max)
```

"""##,
                contentMarkdownRU: ##"""
# Многопоточность (Concurrency)

В Swift встроен современный структурированный механизм работы с асинхронным и параллельным кодом на основе модели `async/await` и акторов (`actor`).

## Асинхронные функции (`async/await`)
Ключевое слово `async` указывает, что выполнение функции может быть приостановлено (suspended) без блокировки вызывающего потока:

```swift
func loadUserProfile(id: String) async throws -> UserProfile {
    let url = URL(string: "https://api.example.com/users/\(id)")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(UserProfile.self, from: data)
}
```

## Акторы (`actor`) и защита от гонок данных
Акторы изолируют своё мутабельное состояние: в любой момент времени только одна задача имеет доступ к их свойствам, что полностью исключает Data Race в Swift 6:

```swift
actor BankAccount {
    var balance: Double = 0.0
    
    func deposit(amount: Double) {
        balance += amount
    }
}

let account = BankAccount()
await account.deposit(amount: 100.0)
```

"""##
            ),
            OfficialDocTopic(
                id: "guide_protocols_generics",
                section: .languageGuide,
                chapterNumber: 11,
                titleEN: "Protocols and Generics",
                titleRU: "Протоколы и Обобщения (Generics)",
                summaryEN: "Defining protocol contracts, protocol extensions, generic types, type constraints, and associated types.",
                summaryRU: "Определение контрактов протоколов, расширения протоколов, обобщенные типы и функции, ограничения типов.",
                webSlug: "protocols",
                contentMarkdownEN: ##"""
# Protocols and Generics

A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements.

## Protocol Syntax
```swift
protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}
```

## Protocol Extensions
Protocols can be extended to provide method, initializer, subscript, and computed property implementations to conforming types. This allows you to define behavior on protocols themselves, rather than in each type’s individual conformance.

## Generics
Generic code enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define. You can write code that avoids duplication and expresses its intent in a clear, abstracted manner.

```swift
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
```

"""##,
                contentMarkdownRU: ##"""
# Протоколы и Обобщения (Generics)

Протоколы задают контракт интерфейса, а обобщения (generics) позволяют писать гибкий и переиспользуемый код для любых типов.

## Протоколы
```swift
protocol Vehicle {
    var speed: Double { get }
    func accelerate()
}

struct Car: Vehicle {
    var speed: Double = 0.0
    mutating func accelerate() {
        speed += 10.0
    }
}
```

## Обобщенные функции и структуры
Дженерики параметризуют код типами данных `<T>`:

```swift
struct Stack<Element> {
    var items: [Element] = []
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element? {
        return items.popLast()
    }
}

var intStack = Stack<Int>()
intStack.push(42)
```

"""##
            ),
            OfficialDocTopic(
                id: "ref_grammar",
                section: .languageReference,
                chapterNumber: 12,
                titleEN: "Summary of the Grammar",
                titleRU: "Сводка грамматики и синтаксиса",
                summaryEN: "Formal grammar rules for lexical structure, expressions, declarations, statements, and types in Swift 6.",
                summaryRU: "Формальные правила грамматики: лексическая структура, выражения, объявления, инструкции и типы в Swift 6.",
                webSlug: "aboutthelanguagereference",
                contentMarkdownEN: ##"""
# Summary of the Grammar

This chapter describes the formal grammar of the Swift programming language. The grammar is written in extended Backus-Naur Form (EBNF).

## Declarations Grammar
```ebnf
declaration → import-declaration
declaration → constant-declaration
declaration → variable-declaration
declaration → typealias-declaration
declaration → function-declaration
declaration → enum-declaration
declaration → struct-declaration
declaration → class-declaration
declaration → actor-declaration
declaration → protocol-declaration
declaration → initializer-declaration
declaration → deinitializer-declaration
declaration → extension-declaration
declaration → subscript-declaration
declaration → macro-declaration
```

## Statements Grammar
```ebnf
statement → expression-statement
statement → declaration
statement → loop-statement
statement → branch-statement
statement → labeled-statement
statement → control-transfer-statement
statement → defer-statement
statement → do-statement
```

"""##,
                contentMarkdownRU: ##"""
# Сводка грамматики и синтаксиса

В данном разделе приведена формальная грамматика синтаксиса Swift 6 в расширенной нотации Бэкуса — Наура (EBNF).

## Грамматика объявлений (Declarations)
```ebnf
declaration → import-declaration
declaration → constant-declaration
declaration → variable-declaration
declaration → function-declaration
declaration → struct-declaration
declaration → class-declaration
declaration → actor-declaration
declaration → protocol-declaration
declaration → extension-declaration
declaration → macro-declaration
```

Полная спецификация грамматики поддерживается компилятором Swift на сайте swift.org.

"""##
            ),
        ]
    }
    
    public func topic(byId id: String) -> OfficialDocTopic? {
        topics.first(where: { $0.id == id })
    }
}