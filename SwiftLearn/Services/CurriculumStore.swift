import Foundation

public final class CurriculumStore {
    public static let shared = CurriculumStore()
    
    public let lessons: [Lesson]
    
    private init() {
        self.lessons = [
            // ==========================================
            // MODULE 1: ОСНОВЫ SWIFT И ТИПЫ ДАННЫХ
            // ==========================================
            Lesson(
                id: "basics_var_let_types",
                category: .swiftBasics,
                titleRU: "Переменные, Константы и Вывод Типов",
                titleEN: "Variables, Constants & Type Inference",
                summaryRU: "Фундамент безопасности Swift: let vs var, строгая типизация и интерполяция строк.",
                summaryEN: "Swift safety foundation: let vs var, static typing, and string interpolation.",
                contentMarkdownRU: """
### Константы (`let`) и Переменные (`var`)

В языке Swift действует фундаментальное правило: **всегда объявляйте значения через `let`, если они не будут изменяться**.

- `let` объявляет **константу** (иммутабельное значение). Значение присваивается один раз и оптимизируется компилятором (компилятор может встраивать его значение напрямую и исключать проверки во время выполнения).
- `var` объявляет **переменную** (мутабельное значение), которое может быть переназначено.

### Вывод типов (Type Inference)
Swift является языком со **статической строгой типизацией**, однако вам не обязательно указывать тип явно — компилятор автоматически вычисляет его:

```swift
let speed = 90             // Int
let temperature = 36.6     // Double
let isActive = true        // Bool
let language = "Swift 6"   // String
```

### Интерполяция строк
Специальный синтаксис `\\(...)` позволяет легко объединять данные любых типов внутри строки.
""",
                contentMarkdownEN: """
### Constants (`let`) and Variables (`var`)

Swift emphasizes safety through immutability. Rule number one: **always prefer `let` over `var` unless value mutation is strictly required**.

- `let` declares an immutable constant. Once initialized, its value cannot change.
- `var` declares a mutable variable whose value can change over time.

### Type Inference
Swift is strongly typed. The compiler automatically deduces types from initial values.
""",
                codeSnippet: """
let platform: String = "iOS"
var version: Double = 17.0
version += 1.0

let message = "Целевая платформа: \\(platform), версия: \\(version)"
print(message)
""",
                xpReward: 30,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что произойдет, если попытаться изменить значение константы `let`?",
                        questionEN: "What happens when reassigning a `let` constant?",
                        optionsRU: ["Ошибка компиляции", "Ошибка времени выполнения", "Значение обновится", "Вызов предупреждения warning"],
                        optionsEN: ["Compile-time error", "Runtime exception", "Value is updated", "Warning only"],
                        correctIndex: 0,
                        explanationRU: "В Swift компилятор на этапе сборки предотвращает мутацию констант let.",
                        explanationEN: "Swift compiler forbids mutating constants at compile time."
                    )
                ]
            ),
            
            Lesson(
                id: "basics_operators_ranges",
                category: .swiftBasics,
                titleRU: "Операторы и Диапазоны (Ranges)",
                titleEN: "Operators & Range Expressions",
                summaryRU: "Арифметические, составные, логические, тернарные и диапазонные операторы a...b.",
                summaryEN: "Arithmetic, compound, logical, ternary, and closed/half-open ranges.",
                contentMarkdownRU: """
### Операторы в Swift
Swift поддерживает полный набор арифметических (`+`, `-`, `*`, `/`, `%`) и логических операторов (`&&`, `||`, `!`).
Swift **защищает от переполнения**: операция `Int.max + 1` вызовет ошибку, предотвращая повреждение памяти.

### Тернарный оператор
Компактная форма условия `вопрос ? ответ1 : ответ2`:
```swift
let status = isAuthorized ? "Добро пожаловать" : "Требуется авторизация"
```

### Диапазоны (Ranges)
Swift предлагает мощные типы диапазонов:
1. **Закрытый диапазон (`a...b`)**: включает `a` и `b` (например, `1...5` -> 1, 2, 3, 4, 5).
2. **Полуоткрытый диапазон (`a..<b`)**: включает `a`, но НЕ включает `b` (например, `0..<array.count`).
3. **Односторонние диапазоны (`a...`, `...b`)**: используются для срезов коллекций.
""",
                contentMarkdownEN: """
### Operators & Ranges in Swift
Swift features standard operators with overflow safety.
Ranges provide intuitive intervals: closed `a...b`, half-open `a..<b`, and one-sided ranges.
""",
                codeSnippet: """
let threshold = 50
let reading = 72

let level = reading > threshold ? "Высокий" : "В норме"
print("Статус уровня:", level)

for i in 1...3 {
    print("Итерация закрытого диапазона #\\(i)")
}
""",
                xpReward: 35,
                quiz: [
                    QuizQuestion(
                        questionRU: "Сколько элементов содержит диапазон `0..<5`?",
                        questionEN: "How many items are in the range `0..<5`?",
                        optionsRU: ["5 (от 0 до 4)", "6 (от 0 до 5)", "4 (от 1 до 4)", "Бесконечно"],
                        optionsEN: ["5 (0 through 4)", "6 (0 through 5)", "4 (1 through 4)", "Infinite"],
                        correctIndex: 0,
                        explanationRU: "Полуоткрытый диапазон 0..<5 включает числа 0, 1, 2, 3, 4 (всего 5 элементов).",
                        explanationEN: "Half-open range 0..<5 contains 0, 1, 2, 3, 4 (5 elements)."
                    )
                ]
            ),
            
            Lesson(
                id: "basics_tuples_alias",
                category: .swiftBasics,
                titleRU: "Кортежи (Tuples) и Псевдонимы (typealias)",
                titleEN: "Tuples & Type Aliases",
                summaryRU: "Группировка значений без создания struct и повышение читаемости через typealias.",
                summaryEN: "Grouping values without custom struct and expressive type aliases.",
                contentMarkdownRU: """
### Кортежи (Tuples)
Кортеж группирует несколько значений в единое составное значение. Элементы кортежа могут иметь разные типы:

```swift
let httpResponse = (statusCode: 200, message: "OK", isSuccess: true)
print(httpResponse.statusCode) // 200
```

### Деструктуризация кортежей
Кортежи можно моментально раскладывать на отдельные константы:
```swift
let (code, msg, _) = httpResponse
print("Код:", code, "Сообщение:", msg)
```

### Псевдонимы типов (`typealias`)
Ключевое слово `typealias` позволяет дать существующему типу новое выразительное имя:
```swift
typealias CompletionHandler = (Result<Data, Error>) -> Void
typealias UserID = UUID
```
""",
                contentMarkdownEN: """
### Tuples
Tuples group multiple values into a single compound value with optional named elements and decomposition.

### Type Aliases
`typealias` creates an alternative name for an existing type, boosting semantic clarity.
""",
                codeSnippet: """
typealias Coordinates = (lat: Double, lon: Double)

let userLocation: Coordinates = (lat: 55.7558, lon: 37.6173)
let (latitude, longitude) = userLocation

print("Широта: \\(latitude), Долгота: \\(longitude)")
""",
                xpReward: 35,
                quiz: [
                    QuizQuestion(
                        questionRU: "Для чего используется символ `_` при деструктуризации кортежа?",
                        questionEN: "What does `_` represent during tuple decomposition?",
                        optionsRU: ["Пропуск (игнорирование) значения", "Указание на опционал", "Присвоение значения по умолчанию", "Ошибка"],
                        optionsEN: ["Wildcard to ignore value", "Optional specifier", "Default assignment", "Syntax error"],
                        correctIndex: 0,
                        explanationRU: "Символ подчеркивания _ в Swift используется для игнорирования неиспользуемых значений.",
                        explanationEN: "Underscore is the wildcard character in Swift used to discard values."
                    )
                ]
            ),
            
            // ==========================================
            // MODULE 2: ПОТОК ВЫПОЛНЕНИЯ И ОПЦИОНАЛЫ
            // ==========================================
            Lesson(
                id: "control_optionals",
                category: .controlFlow,
                titleRU: "Опционалы, if let, guard let и ??",
                titleEN: "Optionals, Unwrapping & Nil-Coalescing",
                summaryRU: "Решение проблемы Null Pointer Exception: Optional Chaining, if let, guard let и ??.",
                summaryEN: "Eliminating Null Pointers: Optional Chaining, if let, guard let, and nil-coalescing.",
                contentMarkdownRU: """
### Концепция Опционалов (Optionals)
В Swift переменная обычного типа **никогда не может быть `nil`**. Если значение может отсутствовать, оно объявляется как `Type?`. Под капотом `Optional` — это перечисление:
```swift
enum Optional<Wrapped> {
    case none
    case some(Wrapped)
}
```

### Безопасное развертывание:
1. **`if let`**: создает локальную область видимости со значением.
2. **`guard let`**: техника раннего выхода (Early Exit). Обязывает выйти из функции (`return`, `throw`), если значение `nil`, оставляя распакованную переменную доступной в оставшейся части функции!
3. **Nil-Coalescing (`??`)**: предоставляет значение по умолчанию, если опционал равен `nil`:
```swift
let username = serverName ?? "Анонимный пользователь"
```
4. **Optional Chaining (`?.`)**: безопасный вызов свойств и методов цепочкой.
""",
                contentMarkdownEN: """
### Optionals in Swift
Variables cannot be nil by default. `Optional<Wrapped>` indicates either a value or absence of value.
Safe unwrapping via `if let`, `guard let`, optional chaining `?.`, and nil-coalescing `??` eliminates null pointer crashes.
""",
                codeSnippet: """
let userInput: String? = "42"

func parseScore(input: String?) -> Int {
    guard let input, let value = Int(input) else {
        print("Некорректный ввод, используем дефолт")
        return 0
    }
    return value
}

let score = parseScore(input: userInput)
print("Итоговые баллы:", score)
""",
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "В чем главное преимущество `guard let` перед `if let`?",
                        questionEN: "What is the primary advantage of `guard let` over `if let`?",
                        optionsRU: [
                            "Распакованная переменная доступна в коде после guard",
                            "guard выполняется быстрее компилятором",
                            "guard не требует оператора return",
                            "Нет разницы"
                        ],
                        optionsEN: [
                            "Unwrapped variable remains in scope after guard block",
                            "guard executes faster",
                            "guard doesn't require return",
                            "No difference"
                        ],
                        correctIndex: 0,
                        explanationRU: "guard let оставляет переменную доступной в области видимости функции после проверки, избегая вложенности pyramid of doom.",
                        explanationEN: "guard unwraps variables into outer function scope while enforcing early exit."
                    )
                ]
            ),
            
            Lesson(
                id: "control_loops_flow",
                category: .controlFlow,
                titleRU: "Циклы (for-in, while) и Управление Потоком",
                titleEN: "Loops & Control Statements",
                summaryRU: "Итерации по коллекциям, условия where в циклах, repeat-while и Labeled Statements.",
                summaryEN: "Collection iteration, where conditions in loops, repeat-while, and loop labels.",
                contentMarkdownRU: """
### Цикл `for-in`
Основной цикл Swift для обхода последовательностей и диапазонов.
Поддерживает фильтрацию `where` прямо в объявлении:
```swift
for number in 1...20 where number % 2 == 0 {
    print(number) // только четные
}
```

### `while` и `repeat-while`
- `while`: проверяет условие перед итерацией.
- `repeat-while` (аналог do-while): гарантирует выполнение тела хотя бы один раз.

### Labeled Statements (Метки циклов)
При вложенных циклах метка позволяет сделать `break` или `continue` для внешнего цикла:
```swift
outerLoop: for row in 1...5 {
    for col in 1...5 {
        if row * col > 15 { break outerLoop }
    }
}
```
""",
                contentMarkdownEN: """
### Loops in Swift
`for-in` handles collection iteration with optional inline `where` filtering.
`while` and `repeat-while` handle condition loops. Labeled statements allow breaking outer loops.
""",
                codeSnippet: """
var balance = 1000
let monthlyWithdrawal = 250
var months = 0

while balance >= monthlyWithdrawal {
    balance -= monthlyWithdrawal
    months += 1
}

print("Средств хватило на месяцев:", months, "Остаток:", balance)
""",
                xpReward: 35,
                quiz: [
                    QuizQuestion(
                        questionRU: "Чем `repeat-while` отличается от обычного `while`?",
                        questionEN: "How does `repeat-while` differ from `while`?",
                        optionsRU: [
                            "Тело цикла всегда выполняется минимум один раз",
                            "Он выполняется бесконечно",
                            "Он не проверяет условие",
                            "Он выполняется в фоновом потоке"
                        ],
                        optionsEN: [
                            "The loop body executes at least once before condition evaluation",
                            "It runs infinitely",
                            "It never checks conditions",
                            "It runs on a background thread"
                        ],
                        correctIndex: 0,
                        explanationRU: "repeat-while сначала выполняет тело цикла, и только затем проверяет условие продолжения.",
                        explanationEN: "repeat-while checks the loop condition after the initial iteration."
                    )
                ]
            ),
            
            Lesson(
                id: "control_switch_pattern",
                category: .controlFlow,
                titleRU: "Продвинутый switch и Pattern Matching",
                titleEN: "Advanced switch & Pattern Matching",
                summaryRU: "Сопоставление с шаблонами, value binding, кортежи, интервалы и оператор fallthrough.",
                summaryEN: "Pattern matching, value binding, tuples, interval checks, and fallthrough keyword.",
                contentMarkdownRU: """
### Преимущества `switch` в Swift
1. **Исчерпывающий (Exhaustive)**: компилятор требует обработать все возможные случаи либо указать `default`.
2. **Не требует `break`**: выполнение не проваливается автоматически в следующий case (если не указано ключевое слово `fallthrough`).
3. **Value Binding (`let`)**: можно извлекать значения прямо в условии case.
4. **Условия `where`**: дополнительная фильтрация совпадения.

```swift
let point = (2, 0)
switch point {
case (0, 0):
    print("Начало координат")
case (let x, 0):
    print("На оси X при x = \\(x)")
case (0, let y):
    print("На оси Y при y = \\(y)")
case let (x, y) where x == y:
    print("На диагонали x == y")
default:
    print("Произвольная точка")
}
```
""",
                contentMarkdownEN: """
### Advanced switch in Swift
Swift's switch statement is exhaustive and does not fall through by default.
Supports pattern matching on ranges, tuples, value binding, and `where` clauses.
""",
                codeSnippet: """
let httpStatus = 404

switch httpStatus {
case 200..<300:
    print("Успешный ответ (2xx)")
case 400..<500:
    print("Ошибка клиента: код \\(httpStatus)")
case 500..<600:
    print("Ошибка сервера (5xx)")
default:
    print("Неизвестный статус код")
}
""",
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что нужно сделать в Swift, чтобы `switch` перешел к следующему `case`?",
                        questionEN: "How do you cause execution to continue into the next `case` in Swift?",
                        optionsRU: ["Использовать ключевое слово fallthrough", "Убрать break", "Поставить точку с запятой", "Ничего, это поведение по умолчанию"],
                        optionsEN: ["Use the fallthrough keyword", "Omit break", "Add semicolon", "Nothing, it's default"],
                        correctIndex: 0,
                        explanationRU: "В Swift switch не проваливается по умолчанию; для явного перехода используется ключевое слово fallthrough.",
                        explanationEN: "Swift switches do not fall through by default; fallthrough must be explicitly stated."
                    )
                ]
            ),
            
            Lesson(
                id: "control_defer",
                category: .controlFlow,
                titleRU: "Отложенное выполнение с defer",
                titleEN: "Deferred Execution with defer",
                summaryRU: "Гарантированная очистка ресурсов, порядок выполнения LIFO и защита от утечек дескрипторов.",
                summaryEN: "Guaranteed resource cleanup, LIFO execution order, and resource safety.",
                contentMarkdownRU: """
### Оператор `defer`
Блок `defer` гарантирует, что содержащийся в нем код будет выполнен **непосредственно перед выходом из текущей области видимости** (независимо от того, как произошел выход: через `return`, `throw` или обычное завершение функции).

### Порядок выполнения нескольких `defer`:
Если в одной области видимости объявлено несколько блоков `defer`, они выполняются **в обратном порядке (LIFO — Last In, First Out)**:

```swift
func processFile() {
    print("1. Открытие файла")
    defer { print("3. Закрытие файла (LIFO #2)") }
    defer { print("2. Очистка буфера (LIFO #1)") }
    print("Выполнение операций...")
}
```
""",
                contentMarkdownEN: """
### The `defer` Statement
A `defer` block executes right before code exits the current scope, guaranteeing cleanup regardless of how exit occurs (return, throw, break). Multiple defers run in reverse order (LIFO).
""",
                codeSnippet: """
func executeDatabaseTransaction() {
    print("-> Начало транзакции")
    defer {
        print("<- Закрытие соединения с БД (defer)")
    }
    
    print("Выполнение записи данных...")
    print("Данные успешно сохранены.")
}

executeDatabaseTransaction()
""",
                xpReward: 35,
                quiz: [
                    QuizQuestion(
                        questionRU: "В каком порядке выполняются несколько блоков `defer`?",
                        questionEN: "In what order do multiple `defer` blocks execute?",
                        optionsRU: ["В обратном порядке объявления (LIFO)", "В порядке объявления (FIFO)", "Одновременно в потоках", "Случайно"],
                        optionsEN: ["Reverse order of declaration (LIFO)", "Order of declaration (FIFO)", "Concurrently in threads", "Randomly"],
                        correctIndex: 0,
                        explanationRU: "Блоки defer складываются в стек и вызываются в обратном порядке (последний объявленный выполнится первым).",
                        explanationEN: "defer statements execute in reverse order (Last In, First Out)."
                    )
                ]
            ),
            
            // ==========================================
            // MODULE 3: КОЛЛЕКЦИИ И ФУНКЦИИ ВЫСШЕГО ПОРЯДКА
            // ==========================================
            Lesson(
                id: "collections_arrays_slices",
                category: .collections,
                titleRU: "Массивы (Array) и Срезы (ArraySlice)",
                titleEN: "Arrays, Mutability & ArraySlice",
                summaryRU: "Упорядоченные списки, эффективное выделение памяти, индексы и срезы без лишнего копирования.",
                summaryEN: "Ordered lists, reserveCapacity, memory safety, and zero-copy ArraySlice.",
                contentMarkdownRU: """
### Массивы в Swift
`Array<Element>` — это упорядоченная коллекция значений одного типа.
- Объявляется через `[Element]`.
- Мутабельность контролируется `let` (неизменяемый) и `var` (изменяемый).
- Реализует семантику значений (**Copy-on-Write**): память копируется только при реальной модификации копии.

### Оптимизация емкости (`reserveCapacity`)
Если размер известен заранее, `reserveCapacity(_:)` предотвращает постоянные перевыделения буфера:
```swift
var items: [Int] = []
items.reserveCapacity(1000)
```

### Срезы массивов (`ArraySlice`)
Срез массива `let slice = array[1...3]` ссылается на память исходного массива без аллокации нового буфера.
""",
                contentMarkdownEN: """
### Arrays in Swift
`Array<Element>` is an ordered collection with Copy-on-Write semantics.
`ArraySlice` references existing storage for zero-copy efficiency.
""",
                codeSnippet: """
var frameworkStack: [String] = ["UIKit", "CoreData", "Combine"]
frameworkStack.append("SwiftUI")

print("Всего фреймворков:", frameworkStack.count)
let modernFrameworks = frameworkStack.suffix(2)
print("Современный стек:", Array(modernFrameworks))
""",
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что такое Copy-on-Write (CoW) в массивах Swift?",
                        questionEN: "What is Copy-on-Write (CoW) in Swift arrays?",
                        optionsRU: [
                            "Копирование памяти происходит только при попытке изменить общую копию",
                            "Массив копируется на диск каждые 5 минут",
                            "Массив всегда передается по ссылке как класс",
                            "Массивы нельзя копировать"
                        ],
                        optionsEN: [
                            "Underlying buffer is only cloned when a shared instance is mutated",
                            "Array is copied to disk periodically",
                            "Array is a reference type",
                            "Arrays cannot be copied"
                        ],
                        correctIndex: 0,
                        explanationRU: "Copy-on-Write позволяет передавать массивы без накладных расходов, копируя буфер памяти только при мутации.",
                        explanationEN: "Copy-on-Write optimizes value semantics by postponing buffer duplication until mutation."
                    )
                ]
            ),
            
            Lesson(
                id: "collections_dict_sets",
                category: .collections,
                titleRU: "Словари (Dictionary) и Множества (Set)",
                titleEN: "Dictionaries, Sets & Hashable",
                summaryRU: "Пары ключ-значение, дефолтные значения в словарях, математические операции множеств и Hashable.",
                summaryEN: "Key-value dictionaries, default values, Set algebra, and the Hashable protocol.",
                contentMarkdownRU: """
### Словари (`Dictionary<Key, Value>`)
Неупорядоченная коллекция пар ключ-значение.
- Доступ по ключу возвращает **опционал** (`Value?`), так как ключ может отсутствовать.
- **Безопасное значение по умолчанию**:
```swift
var counts: [String: Int] = ["swift": 10]
counts["swift", default: 0] += 1
```

### Множества (`Set<Element>`)
Хранят только уникальные элементы с константной скоростью поиска O(1).
Элементы обязаны реализовывать протокол `Hashable`.

### Операции над множествами:
- `union` (объединение)
- `intersection` (пересечение)
- `subtracting` (вычитание)
- `symmetricDifference` (симметрическая разность)
""",
                contentMarkdownEN: """
### Dictionaries & Sets
Dictionaries store key-value pairs with O(1) average lookup. Subscripting returns optionals unless provided with `default:`.
Sets store unique elements complying with `Hashable`.
""",
                codeSnippet: """
let registeredUsers: Set<String> = ["alice", "bob", "charlie"]
let activeNow: Set<String> = ["bob", "david"]

let onlineRegistered = registeredUsers.intersection(activeNow)
print("Зарегистрированы и онлайн:", onlineRegistered)
""",
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какому протоколу должен соответствовать тип, чтобы быть ключом в Dictionary или элементом Set?",
                        questionEN: "Which protocol must a type conform to in order to be stored in a Set or Dictionary key?",
                        optionsRU: ["Hashable", "Codable", "Identifiable", "CustomStringConvertible"],
                        optionsEN: ["Hashable", "Codable", "Identifiable", "CustomStringConvertible"],
                        correctIndex: 0,
                        explanationRU: "Для вычисления хеш-кода и быстрой индексации O(1) элементы обязаны соответствовать протоколу Hashable.",
                        explanationEN: "Hashable provides the hashValue needed for O(1) bucket lookups."
                    )
                ]
            ),
            
            Lesson(
                id: "collections_higher_order",
                category: .collections,
                titleRU: "Функции высшего порядка (map, filter, reduce)",
                titleEN: "Higher-Order Functions in Swift",
                summaryRU: "Декларативная обработка: map, compactMap, flatMap, filter, reduce, sorted и allSatisfy.",
                summaryEN: "Functional data transformations: map, compactMap, flatMap, filter, reduce, and sorted.",
                contentMarkdownRU: """
### Функции высшего порядка
Функции, принимающие другие замыкания в качестве аргументов:

1. **`map`**: трансформирует каждый элемент коллекции: `[1, 2, 3].map { $0 * 2 }` -> `[2, 4, 6]`.
2. **`compactMap`**: трансформирует элементы и **автоматически отбрасывает `nil`**:
```swift
let strings = ["10", "apple", "30"]
let numbers = strings.compactMap { Int($0) } // [10, 30]
```
3. **`flatMap`**: объединяет вложенные массивы в один плоский список.
4. **`filter`**: возвращает элементы, удовлетворяющие условию: `numbers.filter { $0 > 15 }`.
5. **`reduce`**: сворачивает коллекцию в единое результирующее значение:
```swift
let sum = [1, 2, 3, 4].reduce(0, +) // 10
```
6. **`allSatisfy` / `contains`**: быстрая предикатная проверка всей коллекции.
""",
                contentMarkdownEN: """
### Higher-Order Functions
Transform collections cleanly without mutable loops using `map`, `compactMap` (filters out nils), `filter`, and `reduce`.
""",
                codeSnippet: """
let rawScores = ["85", "N/A", "92", "40", "100"]

let validPassingScores = rawScores
    .compactMap { Int($0) }
    .filter { $0 >= 60 }
    .sorted(by: >)

let averageScore = Double(validPassingScores.reduce(0, +)) / Double(validPassingScores.count)
print("Сдавшие студенты:", validPassingScores)
print("Средний балл:", String(format: "%.1f", averageScore))
""",
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "В чем разница между `map` и `compactMap`?",
                        questionEN: "What is the difference between `map` and `compactMap`?",
                        optionsRU: [
                            "compactMap автоматически разворачивает опционалы и удаляет nil",
                            "compactMap сортирует массив",
                            "compactMap работает только со строками",
                            "map работает быстрее"
                        ],
                        optionsEN: [
                            "compactMap unwraps optionals and discards nil values",
                            "compactMap sorts items",
                            "compactMap is string-only",
                            "map is faster"
                        ],
                        correctIndex: 0,
                        explanationRU: "compactMap отфильтровывает все результаты замыкания, равные nil, возвращая массив не-опциональных значений.",
                        explanationEN: "compactMap filters out nil transformations, producing an array of unwrapped elements."
                    )
                ]
            ),
            
            // ==========================================
            // MODULE 4: ФУНКЦИИ И ЗАМЫКАНИЯ
            // ==========================================
            Lesson(
                id: "funcs_inout_variadic",
                category: .closures,
                titleRU: "Функции: Аргументы, inout и Вариадические параметры",
                titleEN: "Functions: Parameter Labels & inout",
                summaryRU: "Внешние и внутренние имена аргументов, значения по умолчанию, inout и вариадические параметры T...",
                summaryEN: "Argument labels, default parameters, inout mutation semantics, and variadics.",
                contentMarkdownRU: """
### Имена параметров функций
В Swift функции читаются как естественные предложения. У каждого параметра может быть:
- **Внешнее имя (Argument Label)**: используется при вызове.
- **Внутреннее имя (Parameter Name)**: используется внутри тела функции.
- `_` скрывает внешнее имя.

```swift
func greet(_ person: String, from city: String = "Москва") {
    print("Привет, \\(person) из \\(city)!")
}
greet("Дмитрий") // использует город по умолчанию
```

### Параметры `inout`
По умолчанию параметры функций являются константами `let`. Ключевое слово `inout` позволяет модифицировать переданную переменную напрямую:
```swift
func swapValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}
```
При вызове перед переменной обязателен символ `&`: `swapValues(&x, &y)`.
""",
                contentMarkdownEN: """
### Functions & Parameter Semantics
Swift functions feature expressive argument labels, default arguments, and `inout` parameters for in-place mutation.
""",
                codeSnippet: """
func doubleNumber(_ value: inout Int) {
    value *= 2
}

var currentEnergy = 25
doubleNumber(&currentEnergy)
print("Удвоенная энергия:", currentEnergy)
""",
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какой символ обязателен перед переменной при передаче ее в `inout` параметр?",
                        questionEN: "Which symbol must precede an argument passed into an `inout` parameter?",
                        optionsRU: ["&", "*", "#", "$"],
                        optionsEN: ["&", "*", "#", "$"],
                        correctIndex: 0,
                        explanationRU: "Символ амперсанда (&) указывает, что переменная передается для прямой модификации (in-place).",
                        explanationEN: "The ampersand (&) indicates passing a variable for direct mutation."
                    )
                ]
            ),
            
            Lesson(
                id: "closures_syntax_capture",
                category: .closures,
                titleRU: "Замыкания: Синтаксис и Захват Значений",
                titleEN: "Closures: Syntax & Capture Mechanics",
                summaryRU: "Анонимные функции, shorthand-синтаксис $0, $1, Trailing Closures и захват переменных.",
                summaryEN: "Anonymous functions, shorthand syntax, trailing closures, and value capture.",
                contentMarkdownRU: """
### Замыкания (Closures)
Замыкания — это автономные блоки кода, которые могут передаваться и использоваться в приложении.

```swift
let multiply: (Int, Int) -> Int = { (a, b) in
    return a * b
}
```

### Сокращенный синтаксис (Shorthand Argument Names)
Swift позволяет опускать имена параметров, заменяя их на `$0`, `$1`, `$2`:
```swift
let sortedNames = names.sorted { $0 < $1 }
```

### Trailing Closure Syntax
Если замыкание является **последним аргументом** функции, круглые скобки вызова можно закрыть раньше, а замыкание написать за скобками:
```swift
UIView.animate(withDuration: 0.3) {
    self.view.alpha = 1.0
}
```
""",
                contentMarkdownEN: """
### Closures in Swift
Closures capture and store references to variables from surrounding context.
Trailing closure syntax and shorthand arguments `$0, $1` enable clean, concise code.
""",
                codeSnippet: """
let numbers = [5, 12, 8, 20, 1]
let filtered = numbers.filter { $0 > 7 }
let doubled = filtered.map { $0 * 2 }

print("Отфильтрованные и удвоенные:", doubled)
""",
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что означает `$0` внутри замыкания?",
                        questionEN: "What does `$0` represent inside a closure?",
                        optionsRU: [
                            "Первый позиционный аргумент замыкания",
                            "Нулевой индекс массива",
                            "Возвращаемое значение",
                            "Указатель на self"
                        ],
                        optionsEN: [
                            "First positional parameter of the closure",
                            "Array index zero",
                            "Return value",
                            "Pointer to self"
                        ],
                        correctIndex: 0,
                        explanationRU: "$0, $1, $2 — это shorthand-имена для позиционных аргументов замыкания.",
                        explanationEN: "$0 refers to the first positional argument in closure shorthand syntax."
                    )
                ]
            ),
            
            Lesson(
                id: "closures_escaping_capturelist",
                category: .closures,
                titleRU: "@escaping, @autoclosure и Capture Lists",
                titleEN: "@escaping, @autoclosure & Capture Lists",
                summaryRU: "Асинхронные замыкания @escaping, отложенные вычисления и списки захвата [weak self].",
                summaryEN: "Asynchronous escaping closures, deferred autoclosures, and weak capture lists.",
                contentMarkdownRU: """
### Убегающие замыкания (`@escaping`)
По умолчанию замыкания являются **non-escaping** (выполняются до того, как завершится вызывающая функция).
Если замыкание сохраняется в свойство или передается в асинхронную очередь (`DispatchQueue.main.async`, сетевой запрос), компилятор требует ключевое слово `@escaping`.

### Capture List: `[weak self]`
Замыкания захватывают объекты по сильной ссылке, что может приводить к **утечкам памяти (Retain Cycles)**.
Список захвата `[weak self]` преобразует ссылку в опционал, разрывая цикл удержания:

```swift
class NetworkService {
    var onDataLoaded: (() -> Void)?
    
    func start() {
        onDataLoaded = { [weak self] in
            guard let self else { return }
            self.refreshUI()
        }
    }
}
```

### `@autoclosure`
Автоматически оборачивает переданное выражение в замыкание без явных фигурных скобок `{}` (используется в операторах `assert` и `??`).
""",
                contentMarkdownEN: """
### @escaping & Capture Lists
Closures passed as callbacks that outlive function execution require `@escaping`.
Capture lists `[weak self]` prevent strong reference cycles and memory leaks.
""",
                codeSnippet: """
class DataLoader {
    var title = "Data"
    
    func fetch(completion: @escaping (String) -> Void) {
        // Симуляция отложенного ответа
        completion("Loaded: \\(title)")
    }
}

let loader = DataLoader()
loader.fetch { result in
    print("Результат запроса:", result)
}
""",
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Почему в асинхронных замыканиях рекомендуется использовать `[weak self]`?",
                        questionEN: "Why is `[weak self]` recommended inside async closures?",
                        optionsRU: [
                            "Для предотвращения retain cycle и утечек памяти",
                            "Чтобы код работал быстрее",
                            "Это обязательное требование компилятора Swift 6",
                            "Чтобы self не был равен nil"
                        ],
                        optionsEN: [
                            "To prevent retain cycles and memory leaks",
                            "To speed up execution",
                            "Mandatory compiler requirement in Swift 6",
                            "To ensure self is never nil"
                        ],
                        correctIndex: 0,
                        explanationRU: "weak self ослабляет захват экземпляра класса, предотвращая взаимное удержание объекта и замыкания.",
                        explanationEN: "weak self avoids reference cycles between the closure and the owning object."
                    )
                ]
            ),
            
            // ==========================================
            // MODULE 5: СТРУКТУРЫ, КЛАССЫ И ARC
            // ==========================================
            Lesson(
                id: "types_structs_value",
                category: .oopAndPop,
                titleRU: "Структуры (struct) и Value Semantics",
                titleEN: "Structs & Value Semantics",
                summaryRU: "Основа архитектуры Swift: структуры, семантика значений, mutating методы и инициализаторы.",
                summaryEN: "Core Swift architecture: value types, mutating methods, and memberwise initializers.",
                contentMarkdownRU: """
### Структуры в Swift
В отличие от многих языков, в Swift **структуры являются предпочтительным типом** для моделирования данных.
Практически все фундаментальные типы (`Int`, `String`, `Array`, `Dictionary`, и все `View` в SwiftUI) — это структуры!

### Семантика значений (Value Types)
При присваивании или передаче в функцию структура **копируется**:
```swift
struct Point {
    var x: Int
    var y: Int
}
var p1 = Point(x: 10, y: 20)
var p2 = p1 // p2 - независимая копия!
p2.x = 99
print(p1.x) // 10 (исходный p1 не изменился!)
```

### Модифицирующие методы (`mutating`)
Поскольку структуры неизменяемы по умолчанию, методы, изменяющие хранимые свойства, должны быть помечены словом `mutating`:
```swift
mutating func moveBy(dx: Int, dy: Int) {
    x += dx
    y += dy
}
```
""",
                contentMarkdownEN: """
### Structs and Value Semantics
Structs are value types in Swift. Modifying a copy never affects the original value.
Methods modifying internal state must be marked `mutating`.
""",
                codeSnippet: """
struct TaskItem {
    let id: UUID = UUID()
    var title: String
    var isDone: Bool = false
    
    mutating func complete() {
        isDone = true
    }
}

var task = TaskItem(title: "Реализовать модули")
task.complete()
print("Задача: \\(task.title), статус: \\(task.isDone ? "Выполнена" : "В работе")")
""",
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что происходит при передаче структуры `struct` в качестве аргумента функции?",
                        questionEN: "What happens when passing a `struct` as a function argument?",
                        optionsRU: [
                            "Передается копия значения (Value Semantics)",
                            "Передается ссылка на исходный объект",
                            "Структура преобразуется в класс",
                            "Вызывается deinit"
                        ],
                        optionsEN: [
                            "A copy of the value is passed (Value Semantics)",
                            "A shared reference pointer is passed",
                            "It transforms into a class",
                            "deinit is triggered"
                        ],
                        correctIndex: 0,
                        explanationRU: "Структуры — это Value Types, они копируются при присваивании и передаче.",
                        explanationEN: "Structs are value types copied upon assignment and parameter passing."
                    )
                ]
            ),
            
            Lesson(
                id: "types_classes_arc",
                category: .oopAndPop,
                titleRU: "Классы (class), Наследование и ARC",
                titleEN: "Classes, Inheritance & ARC",
                summaryRU: "Ссылочные типы, полиморфизм, deinit, strong/weak/unowned ссылки и циклы удержания.",
                summaryEN: "Reference types, subclassing, deinit, ARC reference counting, and retain cycles.",
                contentMarkdownRU: """
### Классы (Reference Types)
Классы передаются **по ссылке**. Несколько переменных могут ссылаться на один и тот же экземпляр в куче (Heap):
```swift
class Account {
    var balance: Double = 0
}
let a1 = Account()
let a2 = a1
a2.balance = 500
print(a1.balance) // 500!
```

### Возможности классов:
1. **Наследование (`class Subclass: Superclass`)** с переопределением (`override`).
2. **Деинициализатор (`deinit`)**: вызывается перед удалением объекта из памяти.
3. **Запрет наследования (`final`)**: оптимизирует диспетчеризацию методов.

### Управление памятью ARC (Automatic Reference Counting)
ARC отслеживает количество сильных ссылок на объект. Когда счетчик равен 0, вызывается `deinit`.
- `weak`: слабая ссылка, автоматически становится `nil` при уничтожении объекта.
- `unowned`: бесхозная ссылка (предполагает, что объект никогда не станет `nil` во время жизни ссылки).
""",
                contentMarkdownEN: """
### Classes and ARC Memory Management
Classes are reference types residing on the heap. ARC counts strong references.
`weak` references prevent cycles by zeroing out when the target deallocates.
""",
                codeSnippet: """
class Vehicle {
    var speed: Double = 0
    func makeNoise() { print("...") }
}

final class Train: Vehicle {
    override func makeNoise() {
        print("Чоо-чоо!")
    }
}

let express = Train()
express.makeNoise()
""",
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что произойдет со слабой ссылкой `weak`, когда целевой объект будет уничтожен ARC?",
                        questionEN: "What happens to a `weak` reference when its target object is deallocated by ARC?",
                        optionsRU: [
                            "Она автоматически становится nil",
                            "Приложение падает с крашем",
                            "Она сохраняет битый адрес памяти",
                            "Объект восстанавливается"
                        ],
                        optionsEN: [
                            "It automatically becomes nil",
                            "The app crashes with fatal exception",
                            "It retains a dangling pointer",
                            "The object is revived"
                        ],
                        correctIndex: 0,
                        explanationRU: "Слабая ссылка weak всегда опциональна и автоматически обнуляется (nil) при деаллокации объекта.",
                        explanationEN: "Weak references are always optional and zeroed out automatically by the ARC runtime."
                    )
                ]
            ),
            
            Lesson(
                id: "types_enums_associated",
                category: .oopAndPop,
                titleRU: "Перечисления (enum) и Associated Values",
                titleEN: "Enums, Raw Values & Associated Values",
                summaryRU: "Моделирование состояний через enum, ассоциированные значения, indirect enum и CaseIterable.",
                summaryEN: "State modeling with enums, associated values, recursive indirect enums, and CaseIterable.",
                contentMarkdownRU: """
### Перечисления в Swift
Перечисления в Swift значительно мощнее, чем в C/Java. Они могут содержать методы, вычисляемые свойства и сложные данные.

### 1. Исходные значения (Raw Values)
Фиксированные значения (`Int`, `String`):
```swift
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
```

### 2. Ассоциированные значения (Associated Values)
Каждый кейс может нести в себе кортеж любых данных:
```swift
enum ViewState {
    case loading
    case success(data: [String])
    case error(code: Int, message: String)
}
```

### 3. Рекурсивные перечисления (`indirect enum`)
Позволяют enum ссылаться на самого себя (идеально для деревьев, JSON и связных списков):
```swift
indirect enum BinaryTree<T> {
    case leaf(T)
    case node(left: BinaryTree<T>, right: BinaryTree<T>)
}
```
""",
                contentMarkdownEN: """
### Enums & Associated Values
Swift enums model finite states. Associated values allow variants to hold custom payload data safely.
`indirect` enums enable recursive data structures.
""",
                codeSnippet: """
enum NetworkResult {
    case success(statusCode: Int, payload: String)
    case failure(reason: String)
}

let response = NetworkResult.success(statusCode: 200, payload: "OK")

switch response {
case .success(let code, let payload):
    print("Успех: код \\(code), данные: \\(payload)")
case .failure(let reason):
    print("Ошибка сети: \\(reason)")
}
""",
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какое ключевое слово необходимо для создания рекурсивного перечисления?",
                        questionEN: "Which keyword is required to define a recursive enum in Swift?",
                        optionsRU: ["indirect", "recursive", "lazy", "mutating"],
                        optionsEN: ["indirect", "recursive", "lazy", "mutating"],
                        correctIndex: 0,
                        explanationRU: "Ключевое слово indirect сообщает компилятору хранить значение enum через слой индирекции (указатель в куче).",
                        explanationEN: "indirect tells the compiler to allocate storage via an indirection pointer."
                    )
                ]
            ),
            
            Lesson(
                id: "types_properties_observers",
                category: .oopAndPop,
                titleRU: "Свойства: Computed, Lazy и Наблюдатели",
                titleEN: "Properties: Computed, Lazy & Observers",
                summaryRU: "Stored vs Computed свойства, ленивая инициализация lazy var и наблюдатели willSet / didSet.",
                summaryEN: "Stored vs computed properties, lazy evaluation, and willSet/didSet property observers.",
                contentMarkdownRU: """
### Виды свойств в Swift:
1. **Хранимые (Stored Properties)**: хранят значения в памяти.
2. **Вычисляемые (Computed Properties)**: вычисляются на лету при каждом обращении:
```swift
var diameter: Double {
    get { radius * 2 }
    set { radius = newValue / 2 }
}
```
3. **Ленивые (`lazy var`)**: инициализируются только при первом фактическом обращении.
4. **Наблюдатели свойств (`willSet` и `didSet`)**:
   - `willSet`: вызывается непосредственно ПЕРЕД сохранением нового значения (`newValue`).
   - `didSet`: вызывается сразу ПОСЛЕ изменения значения (`oldValue`):
```swift
var steps: Int = 0 {
    didSet {
        print("Шагов пройдено: \\(steps), прирост: \\(steps - oldValue)")
    }
}
```
""",
                contentMarkdownEN: """
### Properties in Swift
Swift provides stored properties, computed properties with getters/setters, `lazy var` for deferred heavy allocation, and `willSet`/`didSet` observers.
""",
                codeSnippet: """
struct TemperatureSensor {
    var celsius: Double = 0.0 {
        didSet {
            print("Температура изменена с \\(oldValue)°C на \\(celsius)°C")
        }
    }
    
    var fahrenheit: Double {
        (celsius * 9 / 5) + 32
    }
}

var sensor = TemperatureSensor()
sensor.celsius = 25.0
print("По Фаренгейту:", sensor.fahrenheit)
""",
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какая специальная переменная доступна внутри блока `didSet`?",
                        questionEN: "Which special variable is automatically available inside a `didSet` block?",
                        optionsRU: ["oldValue", "newValue", "previousValue", "initialValue"],
                        optionsEN: ["oldValue", "newValue", "previousValue", "initialValue"],
                        correctIndex: 0,
                        explanationRU: "Внутри didSet автоматически доступна константа oldValue с предыдущим значением свойства.",
                        explanationEN: "oldValue holds the prior value inside a didSet property observer."
                    )
                ]
            ),
            
            // ==========================================
            // MODULE 6: ПРОТОКОЛЫ, РАСШИРЕНИЯ И GENERICS
            // ==========================================
            Lesson(
                id: "pop_protocols_composition",
                category: .protocolsAndGenerics,
                titleRU: "Протоколы (Protocols) и Протокольно-Ориентированное Программирование",
                titleEN: "Protocols & Protocol-Oriented Programming",
                summaryRU: "Основа POP в Swift: контракты типов, композиция ProtocolA & ProtocolB, Equatable и Codable.",
                summaryEN: "Contracts, protocol composition, Equatable, Comparable, and Protocol-Oriented Architecture.",
                contentMarkdownRU: """
### Протоколы (Protocols)
Протокол определяет чертеж (blueprint) методов, свойств и требований, которым должен соответствовать тип.
Swift называют **протокольно-ориентированным языком** (POP).

```swift
protocol IdentifiableEntity {
    var id: UUID { get }
    func serialize() -> String
}
```

### Стандартные протоколы Swift:
- `Equatable`: позволяет сравнивать экземпляры через `==`.
- `Comparable`: позволяет сортировать и сравнивать через `<`, `>`.
- `Hashable`: позволяет быть ключом в Dictionary и элементом Set.
- `Codable`: объединение `Encodable & Decodable` для автоматической сериализации JSON!

### Композиция протоколов
Использование оператора `&`: `func render(item: IdentifiableEntity & Equatable)`.
""",
                contentMarkdownEN: """
### Protocols & POP
Protocols define contracts that structs, classes, or enums conform to.
Protocol composition (`Encodable & Decodable`) avoids monolithic class hierarchies.
""",
                codeSnippet: """
protocol Describable {
    var descriptionText: String { get }
}

struct ServerConfig: Describable, Equatable {
    let host: String
    let port: Int
    
    var descriptionText: String {
        "\\(host):\\(port)"
    }
}

let c1 = ServerConfig(host: "api.apple.com", port: 443)
let c2 = ServerConfig(host: "api.apple.com", port: 443)
print(c1.descriptionText, "| Равны?", c1 == c2)
""",
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что такое протокол `Codable` в Swift?",
                        questionEN: "What is `Codable` in Swift?",
                        optionsRU: [
                            "Композиция протоколов Encodable & Decodable для работы с JSON",
                            "Протокол для компиляции кода",
                            "Шифрование данных AES",
                            "Протокол для сравнения объектов"
                        ],
                        optionsEN: [
                            "A typealias for Encodable & Decodable protocol composition",
                            "A protocol for compiler optimization",
                            "An encryption interface",
                            "A sorting protocol"
                        ],
                        correctIndex: 0,
                        explanationRU: "typealias Codable = Encodable & Decodable обеспечивает двустороннюю сериализацию данных.",
                        explanationEN: "Codable combines Encodable and Decodable for automated JSON serialization."
                    )
                ]
            ),
            
            Lesson(
                id: "pop_extensions_defaults",
                category: .protocolsAndGenerics,
                titleRU: "Расширения (Extensions) и Дефолтная Реализация",
                titleEN: "Extensions & Default Implementations",
                summaryRU: "Добавление функционала без наследования, расширение протоколов и условное соответствие where.",
                summaryEN: "Adding methods without subclassing, protocol default implementations, and conditional conformance.",
                contentMarkdownRU: """
### Расширения (Extensions)
`extension` позволяет добавлять новые вычисляемые свойства, методы и инициализаторы к любому существующему типу (даже системным, вроде `Int` или `String`).

### Дефолтные реализации протоколов (Секрет POP)
Если расширить сам протокол, все реализующие его типы автоматически получают реализацию по умолчанию:
```swift
protocol Greeter {
    func greet()
}
extension Greeter {
    func greet() {
        print("Привет по умолчанию!")
    }
}
```

### Условное соответствие (Conditional Conformance)
```swift
extension Array: CustomStringConvertible where Element: CustomStringConvertible {
    // Реализация только если элементы массива conform to CustomStringConvertible
}
```
""",
                contentMarkdownEN: """
### Extensions in Swift
Extensions add new functionality to existing types without inheritance.
Extending protocols enables shared default implementations across all conforming types.
""",
                codeSnippet: """
extension Int {
    var squared: Int { self * self }
    func times(_ action: () -> Void) {
        for _ in 0..<self { action() }
    }
}

print("5 в квадрате:", 5.squared)
3.times { print("Повторение через extension") }
""",
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Можно ли в `extension` объявить новое хранимое свойство (Stored Property)?",
                        questionEN: "Can an extension add a new Stored Property to a type?",
                        optionsRU: [
                            "Нет, только вычисляемые свойства (Computed Properties)",
                            "Да, если оно приватное",
                            "Да, если это константа let",
                            "Да, в любых случаях"
                        ],
                        optionsEN: [
                            "No, only computed properties can be added",
                            "Yes, if private",
                            "Yes, if let constant",
                            "Yes, always"
                        ],
                        correctIndex: 0,
                        explanationRU: "Расширения не могут изменять размер памяти типа, поэтому хранимые свойства запрещены.",
                        explanationEN: "Extensions cannot alter the memory layout of types; stored properties are prohibited."
                    )
                ]
            ),
            
            Lesson(
                id: "generics_types_constraints",
                category: .protocolsAndGenerics,
                titleRU: "Обобщения (Generics) и Type Constraints",
                titleEN: "Generics & Type Constraints",
                summaryRU: "Написание гибкого переиспользуемого кода, struct Stack<T>, ограничения where и associatedtype.",
                summaryEN: "Writing reusable generic code, generic types, where constraints, and associatedtype.",
                contentMarkdownRU: """
### Обобщения (Generics)
Generics позволяют писать функции и структуры данных, работающие с любым типом, сохраняя 100% безопасность типов во время компиляции:

```swift
func findIndex<T: Equatable>(of item: T, in array: [T]) -> Int? {
    for (idx, val) in array.enumerated() {
        if val == item { return idx }
    }
    return nil
}
```

### Ограничения типов (Type Constraints)
Синтаксис `<T: Protocol>` или `where T: Comparable` требует, чтобы обобщенный тип поддерживал необходимые операции.

### Ассоциированные типы в протоколах (`associatedtype`)
Протоколы используют `associatedtype` вместо параметров типов `<T>`:
```swift
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
}
```
""",
                contentMarkdownEN: """
### Generics
Generics write abstract, reusable functions and types. Type constraints (`<T: Equatable>`) ensure required functionality is present.
Protocols declare generic placeholders using `associatedtype`.
""",
                codeSnippet: """
struct Pair<First, Second> {
    let first: First
    let second: Second
}

let pair = Pair(first: "HTTP", second: 200)
print("Протокол: \\(pair.first), код: \\(pair.second)")
""",
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Как протокол объявляет обобщенный placeholder типа?",
                        questionEN: "How does a protocol specify a generic placeholder type in Swift?",
                        optionsRU: [
                            "С помощью ключевого слова associatedtype",
                            "Через protocol MyProtocol<T>",
                            "Через generic type T",
                            "Используя AnyObject"
                        ],
                        optionsEN: [
                            "Using the associatedtype keyword",
                            "Using protocol MyProtocol<T>",
                            "Using generic type T",
                            "Using AnyObject"
                        ],
                        correctIndex: 0,
                        explanationRU: "В Swift протоколы используют ключевое слово associatedtype для объявления абстрактных ассоциированных типов.",
                        explanationEN: "Swift protocols declare generic placeholders using the associatedtype keyword."
                    )
                ]
            ),
            
            Lesson(
                id: "generics_some_any",
                category: .protocolsAndGenerics,
                titleRU: "Непрозрачные типы (some) и Экзистенциальные (any)",
                titleEN: "Opaque Types (some) vs Existentials (any)",
                summaryRU: "Разница между some View и any Protocol, статическая диспетчеризация и производительность.",
                summaryEN: "Opaque return types (some) vs existential containers (any), static dispatch, and performance.",
                contentMarkdownRU: """
### Ключевые слова `some` и `any`

### 1. `some Protocol` (Opaque Return Type)
- Означает: **«Возвращается один конкретный фиксированный тип, реализующий данный протокол, но вызывающий код не знает его точное имя»**.
- Компилятор видит точный тип и использует **статическую быструю диспетчеризацию** (Zero Overhead).
- Именно поэтому в SwiftUI пишется:
```swift
var body: some View { ... }
```

### 2. `any Protocol` (Existential Type)
- Означает: **«Коробка (экзистенциальный контейнер), которая в рантайме может содержать ЛЮБОЙ тип, реализующий протокол»**.
- Позволяет хранить разнородные типы в одном массиве: `[any Shape]`.
- Использует динамическую диспетчеризацию и аллокацию коробки (existential box), что дает небольшие накладные расходы.
""",
                contentMarkdownEN: """
### `some` vs `any` in Swift
`some Protocol` creates an opaque type fixed at compile time (fast static dispatch).
`any Protocol` represents an existential box holding dynamic types at runtime.
""",
                codeSnippet: """
protocol Shape {
    func area() -> Double
}

struct Square: Shape {
    let side: Double
    func area() -> Double { side * side }
}

func makeShape() -> some Shape {
    Square(side: 4.0)
}

let s = makeShape()
print("Площадь фигуры:", s.area())
""",
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Почему в теле `var body: some View` в SwiftUI используется именно `some`?",
                        questionEN: "Why does `var body: some View` in SwiftUI use `some` instead of `any`?",
                        optionsRU: [
                            "Позволяет компилятору сохранить статическую оптимизацию без накладных расходов динамических контейнеров",
                            "Потому что View не является протоколом",
                            "any запрещено использовать в структурах",
                            "Разницы в производительности нет"
                        ],
                        optionsEN: [
                            "Enables static compile-time optimization without existential box overhead",
                            "View is not a protocol",
                            "any is banned in structs",
                            "There is no performance difference"
                        ],
                        correctIndex: 0,
                        explanationRU: "some View гарантирует возврат одного конкретного типа View hierarchy, позволяя компилятору Swift применять максимальные оптимизации.",
                        explanationEN: "some View preserves concrete type identity for compiler static optimizations."
                    )
                ]
            ),
            
            // ==========================================
            // MODULE 7: ОБРАБОТКА ОШИБОК И RESULT
            // ==========================================
            Lesson(
                id: "error_handling_result",
                category: .errorHandling,
                titleRU: "Обработка Ошибок (throws, do-catch, Result, Typed Throws)",
                titleEN: "Error Handling, Result & Typed Throws",
                summaryRU: "Протокол Error, throw, try?, try!, перехват в do-catch, тип Result и Typed Throws в Swift 6.",
                summaryEN: "Error protocol, throwing functions, do-catch patterns, Result type, and Swift 6 typed throws.",
                contentMarkdownRU: """
### Обработка ошибок в Swift
Ошибки в Swift моделируются типами (обычно `enum`), реализующими протокол `Error`.

```swift
enum PaymentError: Error {
    case insufficientFunds(missing: Double)
    case cardExpired
}
```

### Выбрасывание и обработка:
1. `throws`: объявляет функцию, способную выбросить ошибку.
2. `throw`: выбрасывает ошибку.
3. `try`: обязателен перед вызовом метательного метода.
4. `try?`: превращает результат в опционал (при ошибке возвращает `nil`).
5. `try!`: принудительное выполнение (краш при ошибке).
6. `do-catch`: полный перехват и разбор ошибки:
```swift
do {
    try processPayment()
} catch PaymentError.insufficientFunds(let missing) {
    print("Не хватает: \\(missing)")
} catch {
    print("Другая ошибка: \\(error)")
}
```

### Типизированные ошибки (Typed Throws в Swift 6)
В Swift 6 появилась возможность указывать точный тип ошибки:
`func fetch() throws(PaymentError) -> String`
""",
                contentMarkdownEN: """
### Error Handling in Swift
Errors conform to `Error`. Handled via `do-catch`, `try?`, or encapsulated in `Result<Success, Failure>`.
Swift 6 introduces Typed Throws: `func load() throws(FileError) -> Data`.
""",
                codeSnippet: """
enum CalculationError: Error {
    case divisionByZero
}

func divide(_ a: Double, by b: Double) throws -> Double {
    guard b != 0 else { throw CalculationError.divisionByZero }
    return a / b
}

do {
    let result = try divide(100, by: 4)
    print("Результат деления:", result)
} catch {
    print("Ошибка при расчете:", error)
}
""",
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что вернет выражение `try? divide(10, by: 0)`, если функция выбросила ошибку?",
                        questionEN: "What does `try? divide(10, by: 0)` return when an error is thrown?",
                        optionsRU: ["nil", "Краш приложения", "0", "CalculationError"],
                        optionsEN: ["nil", "App crash", "0", "CalculationError"],
                        correctIndex: 0,
                        explanationRU: "Оператор try? преобразует результат бросающей функции в Optional, возвращая nil в случае любой ошибки.",
                        explanationEN: "try? safely turns thrown errors into nil."
                    )
                ]
            ),
            
            // ==========================================
            // MODULE 8: ASYNC / AWAIT И CONCURRENCY (SWIFT 6)
            // ==========================================
            Lesson(
                id: "concurrency_async_actors",
                category: .concurrency,
                titleRU: "Swift Concurrency: async/await, Task, Акторы и Swift 6",
                titleEN: "Swift Concurrency: async/await & Actors",
                summaryRU: "Структурированная конкурентность, TaskGroup, изоляция акторов, @MainActor и Sendable в Swift 6.",
                summaryEN: "Structured concurrency, TaskGroup, actor isolation, @MainActor, and Swift 6 Sendable.",
                contentMarkdownRU: """
### Современная асинхронность Swift Concurrency
Swift 6 полностью заменяет устаревшие completion handlers на кооперативную модель потоков:

1. **`async` / `await`**:
   - `async`: объявляет асинхронную функцию.
   - `await`: точка возможной приостановки потока (suspension point). Поток не блокируется!

2. **Задачи (`Task`)**:
   - Создает асинхронную задачу в структурированном контексте.
   - Наследует приоритет и отменяется при вызове `task.cancel()`.

3. **Модель Акторов (`actor`)**:
   - Решает фундаментальную проблему **Data Races** (гонок данных).
   - Актор гарантирует, что к его изменяемому состоянию в каждый момент времени имеет доступ только один поток:
```swift
actor BankVault {
    private var gold: Int = 1000
    func withdraw(amount: Int) -> Bool { ... }
}
```

4. **`@MainActor`**:
   - Глобальный актор, привязанный к главному UI-потоку. Все обновления SwiftUI интерфейса обязаны происходить на `@MainActor`.

5. **Протокол `Sendable` (Swift 6)**:
   - Гарантирует, что тип безопасно передавать между потоками (Value Types, акторы или иммутабельные классы).
""",
                contentMarkdownEN: """
### Swift 6 Concurrency & Actors
`async`/`await` eliminates callback hell. `actor` isolates mutable state to prevent data races at compile time.
`@MainActor` enforces UI synchronization. `Sendable` verifies thread safety.
""",
                codeSnippet: """
actor AnalyticsTracker {
    private var eventCount: Int = 0
    
    func track(event: String) -> Int {
        eventCount += 1
        return eventCount
    }
}

let tracker = AnalyticsTracker()

Task {
    let count = await tracker.track(event: "app_launch")
    print("Счетчик событий в акторе:", count)
}
""",
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какую фундаментальную проблему устраняет модель акторов (`actor`) в Swift?",
                        questionEN: "What fundamental issue does the `actor` model prevent in Swift?",
                        optionsRU: [
                            "Data Races (состояние гонки данных при параллельном доступе)",
                            "Утечки памяти ARC",
                            "Ошибки приведения типов",
                            "Медленную работу сети"
                        ],
                        optionsEN: [
                            "Data races during concurrent mutable access",
                            "ARC memory leaks",
                            "Type casting errors",
                            "Network latency"
                        ],
                        correctIndex: 0,
                        explanationRU: "Акторы сериализуют доступ к своему изменяемому состоянию, исключая data races на этапе компиляции в Swift 6.",
                        explanationEN: "Actors synchronize mutable state access, preventing data races at compile time."
                    )
                ]
            ),
            
            // ============================================================
            // SWIFTUI MASTER TRACK (МОДУЛИ 1 - 8)
            // ============================================================
            
            // 1. АНАТОМИЯ VIEW И ДЕКЛАРАТИВНОСТЬ
            Lesson(
                id: "swiftui_anatomy_viewbuilder",
                category: .swiftuiAnatomy,
                titleRU: "Анатомия View, some View и @ViewBuilder",
                titleEN: "View Anatomy, some View & @ViewBuilder",
                summaryRU: "Почему View это структура, непрозрачный тип some View, построитель @ViewBuilder и идентичность объектов.",
                summaryEN: "Why Views are structs, opaque return types, @ViewBuilder mechanics, and structural identity.",
                contentMarkdownRU: """
### Архитектурная революция: Struct вместо Class

В UIKit каждый `UIView` был тяжеловесным классом: сотни полей в памяти, управление жизненным циклом и удержание ссылок в куче (heap).

В SwiftUI **каждый View — это обычная структура (Value Type)**, подчиняющаяся протоколу `View`:
- Создание структуры View занимает считанные наносекунды и выделяется в стеке.
- View в SwiftUI — это не сам экранный пиксель, а **рецепт (чертеж)** того, как интерфейс должен выглядеть при текущем состоянии.
- SwiftUI непрерывно сравнивает (diffing) старое и новое дерево структур, обновляя только изменившиеся графические слои.

---

### Непрозрачный тип: `var body: some View`

Ключевое слово `some` означает **Opaque Return Type** (непрозрачный тип возврата):
- Вы говорите компилятору: «Я возвращаю конкретный тип, удовлетворяющий протоколу `View`, но я скрываю его чудовищную внутреннюю сигнатуру».
- Под капотом `body` может иметь тип `VStack<TupleView<(Text, Image, Button<Text>)>>`. Использование `some View` избавляет от необходимости вручную выписывать этот гигантский тип.

---

### Роль `@ViewBuilder`

Тело `body` неявно помечено атрибутом `@ViewBuilder` — специальным компиляторным механизмом (Result Builder):
- Он позволяет перечислять дочерние элементы построчно, без запятых и операторов `return`.
- Поддерживает логику `if / else`, преобразуя ветвления во внутренний тип `_ConditionalContent`.

---

### Structural Identity vs Explicit Identity

- **Structural Identity (Структурная идентичность)**: SwiftUI определяет элементы по их положению в иерархии кода. Если вы пишете `if condition { MyView() } else { MyView() }`, для SwiftUI это ДВА РАЗНЫХ представления! При смене условия старое View удалится, а новое создастся с нуля (сбросив весь `@State`).
- **Explicit Identity (Явная идентичность)**: задается через модификатор `.id(...)` или протокол `Identifiable`.
""",
                contentMarkdownEN: """
### The SwiftUI Revolution: Structs over Classes
Views in SwiftUI are lightweight structs conforming to the `View` protocol. They represent declarative blueprints rather than actual on-screen nodes.

### Opaque Return Type: `some View`
`some View` hides the complex generic compile-time hierarchy (`VStack<TupleView<...>>`) while preserving static type safety.

### @ViewBuilder & Structural Identity
Conditional rendering (`if-else`) alters structural identity, recreating views and resetting local state.
""",
                codeSnippet: """
import SwiftUI

// Пользовательский компонент с поддержкой @ViewBuilder
struct EngineeringCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(.blue)
            
            // Внедрение дочернего содержимого
            content()
        }
        .padding(14)
        .background(Color.secondary.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

let sampleView = EngineeringCard(title: "Архитектура") {
    Text("View как Value Type гарантирует O(1) создание.")
    Text("Состояние надежно изолировано.")
}

print("Компонент EngineeringCard успешно скомпилирован.")
""",
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Почему в SwiftUI интерфейсы строятся на структурах (`struct`), а не классах (`class`)?",
                        questionEN: "Why are SwiftUI views represented as structs rather than classes?",
                        optionsRU: [
                            "Структуры легковесны, создаются в стеке и исключают циклические утечки памяти",
                            "В Swift запрещено создавать классы",
                            "Классы не могут иметь метод body",
                            "Структуры работают только в iOS 17"
                        ],
                        optionsEN: [
                            "Structs are lightweight value types with stack allocation, eliminating retain cycles",
                            "Swift forbids classes for UI",
                            "Classes cannot implement body",
                            "Structs only exist in iOS 17"
                        ],
                        correctIndex: 0,
                        explanationRU: "Структуры в SwiftUI представляют собой легкие рецепты для рендеринга. Они мгновенно создаются и уничтожаются без накладных расходов на кучу (heap).",
                        explanationEN: "Views are transient declarative blueprints created in nanoseconds without heap allocation overhead."
                    )
                ]
            ),
            
            // 2. СТЕКИ, ВЫРАВНИВАНИЕ И SAFE AREA
            Lesson(
                id: "swiftui_stacks_alignment_safearea",
                category: .swiftuiStacks,
                titleRU: "Стеки (VStack, HStack, ZStack), Spacing и Safe Area",
                titleEN: "Stacks, Alignment & Safe Area",
                summaryRU: "Позиционирование элементов в 1D и 2D: стеки, жадный Spacer(), AlignmentGuides и управление Safe Area.",
                summaryEN: "1D & 2D layout: VStack, HStack, ZStack, greedy Spacer(), AlignmentGuides, and Safe Area edges.",
                contentMarkdownRU: """
### Системы компоновки SwiftUI: 3 базовых стека

Для размещения объектов в пространстве SwiftUI предлагает 3 фундаментальных контейнера:

1. **`VStack(alignment:spacing:)`**:
   - Выстраивает дочерние элементы **по вертикали** (Y-ось).
   - `alignment`: `.leading`, `.center`, `.trailing`.
   - `spacing`: точное расстояние в точках между соседними элементами (по умолчанию система использует адаптивный отступ).

2. **`HStack(alignment:spacing:)`**:
   - Выстраивает дочерние элементы **по горизонтали** (X-ось).
   - `alignment`: `.top`, `.center`, `.bottom`, `.firstTextBaseline` (идеально для выравнивания текста разного шрифта по базовой линии!).

3. **`ZStack(alignment:)`**:
   - Наслаивает элементы **друг на друга вдоль оси глубины** (Z-ось: от заднего плана к переднему).

---

### Магия `Spacer()`

`Spacer` — это специальное гибкое представление (flexible view), которое:
- Внутри `HStack` жадно расширяется по горизонтали, прижимая соседей к краям.
- Внутри `VStack` жадно расширяется по вертикали.
- Имеет параметр минимального размера: `Spacer(minLength: 20)`.

```swift
HStack {
    Text("Лево")
    Spacer() // Забирает всё доступное место
    Text("Право")
}
```

---

### Безопасная область экрана: Safe Area

По умолчанию SwiftUI **не пускает** контент под челку, Dynamic Island, статус-бар и системный индикатор жеста Home Bar:
- Чтобы фоновые градиенты или карты заливали экран целиком:
```swift
Color.black
    .ignoresSafeArea() // Полная заливка от края до края
```
- Можно игнорировать только конкретные края: `.ignoresSafeArea(.keyboard)` или `.ignoresSafeArea(edges: .bottom)`.
""",
                contentMarkdownEN: """
### Core SwiftUI Stacks
- `VStack`: vertical arrangement with leading/center/trailing alignments.
- `HStack`: horizontal placement; supports `firstTextBaseline` for typography alignment.
- `ZStack`: layers children depth-wise along the Z-axis.

### Spacer & Safe Area
`Spacer` greedily expands along the primary axis. `.ignoresSafeArea()` allows edge-to-edge backgrounds.
""",
                codeSnippet: """
import SwiftUI

struct ProfileBadgeView: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Задний слой: карточка
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 44, height: 44)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Swift Архитектор")
                        .font(.headline)
                    Text("В сети")
                        .font(.caption)
                        .foregroundColor(.green)
                }
                
                Spacer() // Прижимает кнопку вправо
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding(14)
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            
            // Передний слой: индикатор статуса
            Circle()
                .fill(Color.green)
                .frame(width: 12, height: 12)
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .offset(x: -8, y: -8)
        }
    }
}

print("ProfileBadgeView скомпонован")
""",
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что произойдет, если поместить два `Spacer()` внутри одного `HStack` между тремя элементами?",
                        questionEN: "What happens when two `Spacer()` instances are placed inside an `HStack` between three elements?",
                        optionsRU: [
                            "Спейсеры поровну поделят свободное пространство, равномерно распределив элементы",
                            "Произойдет краш компоновщика",
                            "Первый спейсер заберет все место, второй сожмется в 0",
                            "Спейсеры работают только внутри VStack"
                        ],
                        optionsEN: [
                            "Both spacers share available space equally, distributing elements evenly",
                            "Layout engine crashes",
                            "First spacer takes all space, second collapses to zero",
                            "Spacers only work in VStack"
                        ],
                        correctIndex: 0,
                        explanationRU: "В SwiftUI гибкие элементы (Spacers) делят остаточное свободное пространство вдоль оси стека поровну.",
                        explanationEN: "Flexible spacers negotiate with the stack engine to divide remaining space equally."
                    )
                ]
            ),
            
            // 3. АЛГОРИТМ LAYOUT И ГЕОМЕТРИЯ
            Lesson(
                id: "swiftui_layout_engine_geometry",
                category: .swiftuiLayout,
                titleRU: "3-шаговый алгоритм Layout, frame и GeometryReader",
                titleEN: "Layout Engine, frame & GeometryReader",
                summaryRU: "Как SwiftUI рассчитывает размеры пикселей: предложение размера, выбор дочерним View, frame и GeometryReader.",
                summaryEN: "The 3-step layout negotiation: proposed sizes, child resolution, frame ranges, and GeometryReader.",
                contentMarkdownRU: """
### 3-Шаговый алгоритм компоновки SwiftUI

Многие новички думают, что родительское View жестко задает размер дочерним. В SwiftUI это не так! Компоновка — это **диалог из 3 шагов**:

1. **Шаг 1: Родитель предлагает размер (Proposed Size)**:
   - Родитель говорит дочернему элементу: «У меня есть 300x200 pt. Сколько из этого ты хочешь взять?».
   - Предложение может быть: точным числом, нулевым (`zero`), или бесконечным (`unspecified / infinity`).

2. **Шаг 2: Дочерний View сам решает свой размер (Child decides its own size)**:
   - Дочерний элемент учитывает свое содержимое:
     - `Text` возьмет ровно столько места, сколько нужно его строке.
     - `Image` без `.resizable()` возьмет размер исходного графического файла.
     - `Color.red` жадно возьмет весь предложенный объем (300x200).

3. **Шаг 3: Родитель размещает ребенка в своей системе координат**:
   - Родитель центрирует или прижимает дочерний элемент согласно `alignment`.

---

### Модификатор `.frame()` не меняет дочерний View!

Модификатор `.frame(width: 100, height: 100)` **не меняет** само представление. Он **оборачивает** его в невидимый контейнер фиксированного размера, который на Шаге 1 предлагает дочернему представлению 100x100!

```swift
// Диапазоны гибких размеров:
Text("Адаптивный блок")
    .frame(minWidth: 80, idealWidth: 150, maxWidth: .infinity)
```

---

### Разрешение конфликтов: `.layoutPriority`

Если на экране не хватает места для всех соседей, SwiftUI начинает сжимать элементы.
- По умолчанию у всех `layoutPriority = 0`.
- Элемент с `.layoutPriority(1)` гарантированно получит весь требуемый ему размер, а сожмутся его соседи с приоритетом 0!

---

### Чтение размеров: `GeometryReader`

`GeometryReader` — это контейнер, который предоставляет доступ к структуре `GeometryProxy`:
- `geo.size`: доступная ширина и высота.
- `geo.frame(in: .global)` или `.local`: координаты в глобальной системе окна или локальной системе предка.
""",
                contentMarkdownEN: """
### The 3-Step Layout Negotiation
1. Parent proposes a size.
2. Child determines its own actual size.
3. Parent places the child in its coordinate space.

### Frame, Priorities & GeometryReader
`.frame()` creates a proxy container. `.layoutPriority()` resolves space contention. `GeometryReader` provides `GeometryProxy` dimensions.
""",
                codeSnippet: """
import SwiftUI

struct ResponsiveProgressBar: View {
    let progress: Double // от 0.0 до 1.0
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                // Фон шкалы
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 12)
                
                // Активная полоса
                Capsule()
                    .fill(Color.blue)
                    .frame(width: geo.size.width * CGFloat(progress), height: 12)
                    .animation(.spring(response: 0.35), value: progress)
            }
        }
        .frame(height: 12)
    }
}

print("ResponsiveProgressBar готов к работе")
""",
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что происходит на шаге 2 алгоритма компоновки SwiftUI?",
                        questionEN: "What happens during step 2 of SwiftUI's layout process?",
                        optionsRU: [
                            "Дочернее View самостоятельно определяет и сообщает родителю свой итоговый размер",
                            "Родитель принудительно обрезает дочернее View",
                            "SwiftUI удаляет не уместившиеся элементы",
                            "Система переключается на UIKit"
                        ],
                        optionsEN: [
                            "The child view calculates and chooses its own final size",
                            "Parent forcibly clips the child view",
                            "SwiftUI deletes overflowing elements",
                            "The system falls back to UIKit"
                        ],
                        correctIndex: 0,
                        explanationRU: "В SwiftUI дочернее представление всегда обладает абсолютным правом выбрать свой итоговый размер на основе предложения родителя.",
                        explanationEN: "The child view maintains sovereignty over its final dimensions based on the proposed constraints."
                    )
                ]
            ),
            
            // 4. СОСТОЯНИЕ И ПОТОКИ ДАННЫХ
            Lesson(
                id: "swiftui_state_observation_dataflow",
                category: .swiftuiState,
                titleRU: "Потоки данных: @State, @Binding и макрос @Observable",
                titleEN: "State, Binding & @Observable Macro",
                summaryRU: "Single Source of Truth, локальное состояние @State, двухсторонняя связь @Binding и стандарт iOS 17+ @Observable.",
                summaryEN: "Single Source of Truth, @State storage, two-way @Binding, and the modern iOS 17 @Observable standard.",
                contentMarkdownRU: """
### Архитектура Single Source of Truth

Главное правило SwiftUI: **любой фрагмент данных на экране должен иметь ровно один источник истины (Single Source of Truth)**. Интерфейс является производной от данных: `UI = f(State)`.

---

### 1. `@State`: локальное приватное состояние

`@State` управляет данными, которые принадлежат конкретному View:
- Выделяет память в специальном внешнем хранилище SwiftUI, которое не уничтожается при пересоздании структуры View.
- При изменении значения `@State` SwiftUI автоматически вызывает `body` для обновления экрана.
- **Всегда объявляйте `@State private`**.

---

### 2. `@Binding`: двухсторонняя проекция без владения

Когда дочернему экрану (например, кнопке-переключателю) нужно читать и изменять состояние родителя, используется `@Binding`:
- `@Binding` не хранит свои данные — это «ссылка» на состояние другого View.
- Чтобы передать `@State` в `@Binding`, используется префикс `$`:
```swift
Toggle("Звук", isOn: $isSoundEnabled) // $ создает Binding
```

---

### 3. Макрос `@Observable` (iOS 17+ Observation)

До iOS 17 использовался протокол `ObservableObject` и обертки `@Published`, вызывавшие лишние перерисовки.

В современном Swift действует макрос **`@Observable`**:
- Не требует ручной расстановки `@Published`.
- **Точечное отслеживание (Fine-grained tracking)**: SwiftUI строит карту зависимостей на уровне отдельных свойств. Если экран читает только `user.name`, он **НЕ будет перерисовываться**, когда меняется `user.age`!
- Работает напрямую с классами:
```swift
@Observable
final class AppSession {
    var username: String = "Alex"
    var isPremium: Bool = false
}
```

---

### 4. `@Environment`: глобальные зависимости

Позволяет внедрять данные и службы в глубину дерева представлений без проброса через каждый инициализатор:
```swift
@Environment(\\.dismiss) private var dismiss
@Environment(\\.colorScheme) private var colorScheme
```
""",
                contentMarkdownEN: """
### Single Source of Truth Architecture
UI is a function of state: `UI = f(State)`.

### Core Data Wrappers
- `@State`: view-owned local mutable state.
- `@Binding`: two-way non-owning reference (projected with `$`).
- `@Observable`: iOS 17+ macro delivering property-level fine-grained UI invalidation.
- `@Environment`: dependency injection down the view hierarchy.
""",
                codeSnippet: """
import SwiftUI

@Observable
final class TaskManager {
    var tasks: [String] = ["Изучить Swift Core", "Освоить SwiftUI"]
    
    func addTask(_ task: String) {
        tasks.append(task)
    }
}

struct TaskListView: View {
    @State private var manager = TaskManager()
    @State private var newTaskTitle: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Новая задача", text: $newTaskTitle)
                    .textFieldStyle(.roundedBorder)
                
                Button("Добавить") {
                    guard !newTaskTitle.isEmpty else { return }
                    manager.addTask(newTaskTitle)
                    newTaskTitle = ""
                }
            }
            .padding()
            
            List(manager.tasks, id: \\.self) { task in
                Text(task)
            }
        }
    }
}

print("TaskListView с @Observable моделью инициализирован")
""",
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "В чем фундаментальное преимущество макроса `@Observable` перед старым `ObservableObject`?",
                        questionEN: "What is the key advantage of `@Observable` over `ObservableObject`?",
                        optionsRU: [
                            "Отслеживание изменений происходит на уровне отдельных прочитанных свойств, исключая лишние перерисовки View",
                            "Он работает только со структурами",
                            "Он автоматически сохраняет данные в базу данных",
                            "Он ускоряет компилятор Swift в 10 раз"
                        ],
                        optionsEN: [
                            "Property-level tracking ensures only views accessing that specific property re-render",
                            "It only works with structs",
                            "It automatically saves data to a database",
                            "It accelerates the Swift compiler 10x"
                        ],
                        correctIndex: 0,
                        explanationRU: "Макрос @Observable отслеживает чтение конкретных полей внутри body. Изменение неиспользуемых полей не приводит к инвалидации View.",
                        explanationEN: "Observation records individual property accesses, avoiding blanket view invalidations."
                    )
                ]
            ),
            
            // 5. СПИСКИ, LAZYVGRID И СЕТКИ
            Lesson(
                id: "swiftui_lists_lazygrids_and_grid",
                category: .swiftuiCollections,
                titleRU: "Коллекции: List, LazyVGrid и Декларативный Grid",
                titleEN: "Lists, LazyVGrid & Declarative Grid",
                summaryRU: "Виртуализация ячеек в List, свайпы и секции, адаптивные сетки через LazyVGrid и матричный Grid в iOS 16+.",
                summaryEN: "List cell virtualization, swipe actions, adaptive multi-column LazyVGrid, and iOS 16 Grid.",
                contentMarkdownRU: """
### Виртуализация: `List` против `ScrollView`

Когда в приложении нужно показать 1 000 элементов, обычный `VStack` создаст в памяти сразу 1 000 структур View. Это вызовет лаг интерфейса и утечку оперативной памяти.

Решения SwiftUI:
1. **`List`**:
   - Обладает встроенным механизмом **виртуализации ячеек** (Cell Reuse): память выделяется только под те строки, которые сейчас видны на экране.
   - Поддерживает стандартные жесты: `.swipeActions`, удаление `.onDelete`, перемещение `.onMove` и группировку по секциям `Section(header:footer:)`.

2. **`ScrollView` + `LazyVStack`**:
   - Приставка `Lazy` заставляет стек инстанциировать дочерние View только в момент приближения к области видимости. Используется, когда нужен нестандартный скроллируемый интерфейс без разделителей `List`.

---

### Адаптивные сетки: `LazyVGrid`

Двумерные галереи и карточки создаются через `LazyVGrid(columns:)`:
Колонки настраиваются через массив `GridItem`:
- **`.fixed(CGFloat)`**: колонка фиксированной ширины.
- **`.flexible(minimum:maximum:)`**: колонка делит строку поровну с соседями.
- **`.adaptive(minimum:maximum:)`**: **лучший выбор для универсальных интерфейсов**! SwiftUI автоматически разместит столько колонок, сколько помещается на экране текущего iPhone или iPad:
```swift
let columns = [
    GridItem(.adaptive(minimum: 140), spacing: 12)
]
```

---

### Декларативный матричный `Grid` (iOS 16+)

В отличие от `LazyVGrid`, компонент `Grid` выравнивает ячейки строго по строкам и столбцам одновременно (как HTML-таблица), без потребности в вычислениях через `GeometryReader`:
```swift
Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 8) {
    GridRow {
        Text("Модель")
        Text("Статус")
        Text("Пинг")
    }
    .font(.headline)
    
    GridRow {
        Text("iPhone 17")
        Text("Online").foregroundColor(.green)
        Text("12 ms")
    }
}
```
""",
                contentMarkdownEN: """
### Virtualization & Collections
`List` virtualizes rows for high performance. `LazyVStack` defers view instantiation.

### Grids
`LazyVGrid` with `.adaptive` items effortlessly adapts between compact iPhones and large iPads. iOS 16 `Grid` introduces rigid matrix alignment.
""",
                codeSnippet: """
import SwiftUI

struct ProductCatalogView: View {
    let items = ["Swift 6 Book", "Xcode Pro Theme", "Keyboard Guide", "AppIcon Kit"]
    
    // Адаптивная сетка: плитки минимум 140 pt
    let columns = [
        GridItem(.adaptive(minimum: 140), spacing: 14)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(items, id: \\.self) { item in
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue.opacity(0.15))
                            .frame(height: 100)
                            .overlay(Image(systemName: "cube.fill").font(.largeTitle).foregroundColor(.blue))
                        
                        Text(item)
                            .font(.subheadline.bold())
                            .lineLimit(1)
                    }
                    .padding(8)
                    .background(Color.secondary.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
        }
    }
}

print("ProductCatalogView с адаптивным LazyVGrid готов")
""",
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какой тип конфигурации `GridItem` автоматически создает больше колонок при переходе с iPhone на iPad?",
                        questionEN: "Which `GridItem` type automatically expands column count on larger screens like iPads?",
                        optionsRU: [
                            "GridItem(.adaptive(minimum: ...))",
                            "GridItem(.fixed(100))",
                            "GridItem(.rigid)",
                            "GridItem(.horizontalOnly)"
                        ],
                        optionsEN: [
                            "GridItem(.adaptive(minimum: ...))",
                            "GridItem(.fixed(100))",
                            "GridItem(.rigid)",
                            "GridItem(.horizontalOnly)"
                        ],
                        correctIndex: 0,
                        explanationRU: "Режим .adaptive вычисляет максимальное число колонок, которое может поместиться на экране с соблюдением минимальной ширины.",
                        explanationEN: "Adaptive GridItem fits as many columns as possible within available width based on minimum bounds."
                    )
                ]
            ),
            
            // 6. МОДИФИКАТОРЫ И КАСТОМНЫЕ СТИЛИ
            Lesson(
                id: "swiftui_modifiers_and_custom_styling",
                category: .swiftuiModifiers,
                titleRU: "Магия модификаторов, ViewModifier и Кастомные Стили",
                titleEN: "ViewModifier & Custom Styling",
                summaryRU: "Почему порядок модификаторов критичен, протокол ViewModifier, расширения View и протокол ButtonStyle.",
                summaryEN: "Modifier order semantics, reusable ViewModifier protocol, View extensions, and ButtonStyle.",
                contentMarkdownRU: """
### Архитектура модификаторов: Обертка, а не мутация

В императивном UIKit вы писали `button.backgroundColor = .blue`. Это была прямая мутация объекта в памяти.

В SwiftUI модификаторы **не мутируют существующий объект** — они **оборачивают его в новую структуру**:
```swift
// Тип: ModifiedContent<Text, _BackgroundModifier<Color>>
Text("Pro").background(Color.blue)
```

Именно поэтому **порядок модификаторов имеет решающее значение**:
```swift
// Вариант 1: Фон окрасит область С УЧЕТОМ отступов
Text("Apple")
    .padding(16)
    .background(Color.blue)

// Вариант 2: Фон окрасит только буквы, а паддинг добавит пустоту вокруг синего прямоугольника!
Text("Apple")
    .background(Color.blue)
    .padding(16)
```

---

### Создание кастомного `ViewModifier`

Чтобы не копировать цепочки из 10 модификаторов по всем экранам, создается переиспользуемый модификатор:
```swift
struct ProCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .shadow(color: Color.black.opacity(0.08), radius: 6, y: 3)
    }
}

// Создаем удобное расширение View:
extension View {
    func proCardStyle() -> some View {
        modifier(ProCardModifier())
    }
}
```

---

### Системная стилизация кнопок: `ButtonStyle`

Протокол `ButtonStyle` позволяет создать интерактивную кнопку с физическим откликом при нажатии:
- Имеет параметр `configuration.isPressed`: флаг, нажат ли палец прямо сейчас.
```swift
struct BouncyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: configuration.isPressed)
    }
}
```
""",
                contentMarkdownEN: """
### Modifiers as Enclosing Wrappers
SwiftUI modifiers do not mutate in-place; they wrap the view into nested `ModifiedContent` structures. Sequence dictates layout.

### ViewModifier & ButtonStyle
Create custom design systems via `ViewModifier` protocols and interactive feedback with `ButtonStyle.Configuration.isPressed`.
""",
                codeSnippet: """
import SwiftUI

struct GlassCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
    }
}

extension View {
    func glassCard() -> some View {
        modifier(GlassCardModifier())
    }
}

struct ShowcaseView: View {
    var body: some View {
        Text("Стеклянный морфизм в SwiftUI")
            .font(.headline)
            .glassCard()
    }
}

print("GlassCardModifier успешно внедрен")
""",
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что происходит внутри SwiftUI при вызове модификатора `.background()`?",
                        questionEN: "What internally happens when `.background()` is called on a SwiftUI view?",
                        optionsRU: [
                            "Исходное View оборачивается в новую промежуточную структуру, содержащую оба слоя",
                            "Мутируется внутреннее свойство UIView.layer",
                            "Создается новый поток выполнения",
                            "Вызывается метод drawRect"
                        ],
                        optionsEN: [
                            "The original view is wrapped inside a new container structure enclosing both elements",
                            "UIView.layer is directly mutated",
                            "A background thread is spawned",
                            "drawRect is invoked"
                        ],
                        correctIndex: 0,
                        explanationRU: "В SwiftUI модификаторы не мутируют View на месте, а оборачивают его в новый тип ModifiedContent.",
                        explanationEN: "Modifiers wrap views into new nested type-safe struct definitions."
                    )
                ]
            ),
            
            // 7. АНИМАЦИИ, ПЕРЕХОДЫ И ЖЕСТЫ
            Lesson(
                id: "swiftui_animations_springs_gestures",
                category: .swiftuiAnimations,
                titleRU: "Анимации, Пружинная физика (Springs) и Жесты",
                titleEN: "Animations, Springs & Gestures",
                summaryRU: "Неявные vs явные анимации withAnimation, физика пружин .spring, анимированные переходы и жесты Drag/Tap.",
                summaryEN: "Implicit vs explicit animations, spring physics parameters, animated transitions, and DragGesture.",
                contentMarkdownRU: """
### Природа анимаций в SwiftUI

В SwiftUI анимируются не координаты пикселей, а **изменения состояния во времени**:
`State Change -> Animated Value Interpolation -> Rendered Frames`

Существует два фундаментальных способа анимации:

1. **Неявная анимация (`.animation(...)`)**:
   - Привязывается к конкретному значению состояния:
```swift
Circle()
    .scaleEffect(isExpanded ? 1.5 : 1.0)
    .animation(.spring(response: 0.35, dampingFraction: 0.7), value: isExpanded)
```

2. **Явная анимация (`withAnimation`)**:
   - Запускает анимацию для всех представлений, затронутых изменением состояния внутри блока:
```swift
withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
    isExpanded.toggle()
}
```

---

### Физика пружин: `.spring(response:dampingFraction:)`

Интерфейсы Apple знамениты естественным физическим откликом благодаря пружинам:
- **`response`** (секунды): определяет жесткость пружины (время прохождения одного полупериода). Меньше число — резче и быстрее анимация.
- **`dampingFraction`** (коэффициент демпфирования):
  - `1.0`: критическое затухание (без отскока).
  - `0.7`: стандартный приятный отскок Apple.
  - `< 0.5`: упругие длительные колебания.

---

### Распознавание жестов: `DragGesture`

Жесты в SwiftUI компонуются как декларативные модификаторы:
- `onChanged`: вызывается на каждый сдвиг пальца с текущим смещением (`value.translation`).
- `onEnded`: вызывается при отрыве пальца от экрана.
```swift
@State private var offset: CGSize = .zero

CardView()
    .offset(offset)
    .gesture(
        DragGesture()
            .onChanged { gesture in offset = gesture.translation }
            .onEnded { _ in 
                withAnimation(.spring()) { offset = .zero } 
            }
    )
```
""",
                contentMarkdownEN: """
### Animation Mechanics
Animations interpolate state transitions.
- `withAnimation`: explicit trigger scoped to closures.
- `.animation(_:value:)`: implicit trigger keyed to value updates.

### Physics-Based Springs & DragGestures
Configure fluid motion via `response` and `dampingFraction`. Chain gestures with `onChanged` and `onEnded` handlers.
""",
                codeSnippet: """
import SwiftUI

struct InteractiveSwipeCard: View {
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.blue)
            .frame(width: 200, height: 120)
            .overlay(Text("Свайпни меня").foregroundColor(.white).bold())
            .offset(x: dragOffset.width, y: dragOffset.height)
            .gesture(
                DragGesture()
                    .onChanged { val in
                        dragOffset = val.translation
                    }
                    .onEnded { _ in
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.65)) {
                            dragOffset = .zero // Пружинный возврат в центр
                        }
                    }
            )
    }
}

print("InteractiveSwipeCard готов к демонстрации")
""",
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какое значение `dampingFraction` в пружинной анимации `.spring()` дает классический упругий отскок в стиле Apple?",
                        questionEN: "What `dampingFraction` value provides Apple's characteristic fluid bounce in `.spring()`?",
                        optionsRU: [
                            "0.7",
                            "0.0",
                            "5.0",
                            "-1.0"
                        ],
                        optionsEN: [
                            "0.7",
                            "0.0",
                            "5.0",
                            "-1.0"
                        ],
                        correctIndex: 0,
                        explanationRU: "Значение 0.7 обеспечивает легкий гармонический отскок без чрезмерного дребезга (underdamped). Значение 1.0 убирает отскок полностью.",
                        explanationEN: "0.7 provides natural underdamped restitution without erratic oscillation."
                    )
                ]
            ),
            
            // 8. НАВИГАЦИЯ И МОДАЛЬНЫЕ ЭКРАНЫ
            Lesson(
                id: "swiftui_navigation_and_modal_presentation",
                category: .swiftuiNavigation,
                titleRU: "Архитектура навигации: NavigationStack и Модальные экраны",
                titleEN: "NavigationStack & Modal Presentation",
                summaryRU: "Современная навигация в iOS 16+, стек маршрутизации через NavigationPath, листы .sheet с detents и fullScreenCover.",
                summaryEN: "Type-safe NavigationStack routing with NavigationPath, sheet presentation detents, and fullScreenCover.",
                contentMarkdownRU: """
### Современная навигация: `NavigationStack` (iOS 16+)

Старый `NavigationView` вызывал множество проблем при передаче данных. На смену ему пришел **`NavigationStack`** с поддержкой типобезопасной маршрутизации на основе данных (Data-Driven Navigation):

```swift
@State private var path = NavigationPath()

NavigationStack(path: $path) {
    List(categories) { cat in
        NavigationLink(cat.title, value: cat) // Передаем значение, а не View!
    }
    .navigationDestination(for: Category.self) { cat in
        CategoryDetailView(category: cat) // Обработчик типа
    }
}
```

**Преимущества Data-Driven Navigation**:
- Программный возврат на домашний экран (Pop to Root): `path.removeLast(path.count)`.
- Поддержка Deep Links: вы можете программно наполнить массив `path` цепочкой объектов для восстановления состояния приложения из Push-уведомления.

---

### Модальные представления: `.sheet` и `.fullScreenCover`

1. **Всплывающая шторка (`.sheet`)**:
   - Открывает карточку поверх текущего контекста.
   - Настройка высоты шторки в iOS 16+ через **`presentationDetents`**:
```swift
.sheet(isPresented: $showSettings) {
    SettingsView()
        .presentationDetents([.medium, .fraction(0.85)])
        .presentationDragIndicator(.visible)
}
```

2. **Полноэкранный режим (`.fullScreenCover`)**:
   - Полностью перекрывает интерфейс (используется для онбординга или экранов камеры).

3. **Закрытие экрана изнутри**:
   - С помощью переменной окружения:
```swift
@Environment(\\.dismiss) private var dismiss
...
Button("Закрыть") { dismiss() }
```
""",
                contentMarkdownEN: """
### Data-Driven NavigationStack
Decouple navigation triggers from destination views using `NavigationPath` and `.navigationDestination(for:)`.

### Modals & Presentation Detents
`.sheet` accommodates flexible sheet heights via `.presentationDetents([.medium, .large])`. `.fullScreenCover` hosts immersive flows.
""",
                codeSnippet: """
import SwiftUI

struct NavigationArchitectureDemo: View {
    @State private var showSettingsSheet = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Главный экран приложения")
                    .font(.title2.bold())
                
                Button("Открыть шторку настроек") {
                    showSettingsSheet = true
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Панель управления")
            .sheet(isPresented: $showSettingsSheet) {
                VStack(spacing: 16) {
                    Text("Настройки")
                        .font(.headline)
                    Text("Кастомная шторка с detents")
                        .foregroundColor(.secondary)
                }
                .presentationDetents([.medium, .fraction(0.7)])
                .presentationDragIndicator(.visible)
            }
        }
    }
}

print("NavigationArchitectureDemo готов к работе")
""",
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Как в `NavigationStack` мгновенно сбросить весь стек переходов и вернуться на самый первый экран (Pop to Root)?",
                        questionEN: "How do you programmatically pop to root using `NavigationStack` and `NavigationPath`?",
                        optionsRU: [
                            "Очистить массив или путь: path.removeLast(path.count)",
                            "Перезагрузить приложение",
                            "Вызвать dismiss() 10 раз",
                            "NavigationStack не поддерживает возврат в корень"
                        ],
                        optionsEN: [
                            "Clear the path collection: path.removeLast(path.count)",
                            "Restart the application",
                            "Invoke dismiss() repeatedly",
                            "NavigationStack does not support pop to root"
                        ],
                        correctIndex: 0,
                        explanationRU: "Поскольку навигация управляется состоянием (NavigationPath), очистка пути немедленно возвращает стек в начальное состояние.",
                        explanationEN: "Because navigation is state-driven, clearing the navigation path instantly pops all views to root."
                    )
                ]
            ),

            Lesson(
                id: "basics_strings_unicode",
                category: .swiftBasics,
                titleRU: "Строки, Символы, Unicode и Substring",
                titleEN: "Strings, Characters, Unicode & Substrings",
                summaryRU: "Grapheme clusters, String.Index, безопасная навигация по символам и zero-copy архитектура Substring.",
                summaryEN: "Grapheme clusters, String.Index, character navigation, and zero-copy Substrings.",
                contentMarkdownRU: ##"""
### Почему в Swift нет `string[0]`?

В большинстве старых языков (C, Java, Python) строка — это простой массив байт или 16-битных символов. В Swift строки полностью соответствуют стандарту **Unicode 15+** и состоят из **графемных кластеров (Extended Grapheme Clusters)**.

Графемный кластер — это последовательность одного или нескольких скаляров Unicode, которые человеческий глаз воспринимает как один неделимый символ:
```swift
let emoji = "👨‍👩‍👧‍👦" // Семейство: 1 Character для пользователя
print(emoji.count)             // 1
print(emoji.utf8.count)        // 25 байт в памяти!
```

Поскольку каждый визуальный символ может занимать разное количество байт в памяти, компилятор не может перейти к n-му символу за константное время $O(1)$. Для нахождения n-го символа Swift обязан последовательно проанализировать все предыдущие графемные кластеры от начала строки.

---

### Безопасная навигация: `String.Index`

Для работы с позициями символов используется специальный тип `String.Index`:

```swift
let greeting = "Hello, Swift 6!"
let start = greeting.startIndex
let fourthChar = greeting[greeting.index(start, offsetBy: 3)] // "l"

// Безопасный диапазон
let range = start..<greeting.index(start, offsetBy: 5)
let word = greeting[range] // "Hello"
```

---

### Архитектура `Substring` и Copy-on-Write

Когда вы получаете срез строки (например через диапазон `str[start..<end]`), Swift возвращает тип `Substring`. 

> [!IMPORTANT]
> `Substring` не выделяет новую память под текст — он ссылается напрямую на буфер исходной большой строки. Это делает операции среза сверхбыстрыми за $O(1)$.
> Однако если вам нужно сохранить результат надолго (например в свойстве класса), обязательно преобразуйте его в полноценную `String(sub)`, иначе исходная строка никогда не освободится из оперативной памяти!

```swift
let rawLog = "2026-11-17 [ERROR] Connection timed out after 3000ms"
let errorPrefix = rawLog.dropFirst(11) // Substring
let persistentError = String(errorPrefix) // Выделен собственный буфер
```
"""##,
                contentMarkdownEN: ##"""
### Why Swift Disallows `string[0]`

In Swift, strings conform strictly to Unicode standards and consist of **extended grapheme clusters**. A single visible character may be composed of multiple Unicode scalars:
```swift
let family = "👨‍👩‍👧‍👦" // 1 Character visually
print(family.count)      // 1
print(family.utf8.count) // 25 bytes in memory!
```
Because characters have variable byte lengths, random indexing via integer subscript is disallowed to avoid misleading developers about $O(1)$ complexity.

### Navigating with `String.Index`
Use `String.Index` to traverse grapheme boundaries:
```swift
let text = "Swift"
let third = text[text.index(text.startIndex, offsetBy: 2)] // "i"
```

### Substrings and Memory
Substrings reuse the storage buffer of the original string for zero-copy efficiency. Convert to `String(substring)` for long-term storage.
"""##,
                codeSnippet: ##"""
let message = "Swift 6 Concurrency & Design"
let firstWord = message.prefix(while: { $0 != " " })
print("Substring: \(firstWord), тип: \(type(of: firstWord))")

let independentString = String(firstWord)
print("Самостоятельная String: \(independentString)")

// Безопасный сабскрипт расширением
extension String {
    subscript(safe offset: Int) -> Character? {
        guard offset >= 0 && offset < count else { return nil }
        return self[index(startIndex, offsetBy: offset)]
    }
}

if let ch = message[safe: 6] {
    print("Символ на индексе 6: '\(ch)'")
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Почему в Swift нельзя обратиться к символу строки через целочисленный индекс str[2]?",
                        questionEN: "Why does Swift forbid direct integer indexing like str[2]?",
                        optionsRU: [
                            "Символы Unicode имеют разную длину байт, и доступ за O(1) невозможен без прохода от начала",
                            "В Swift нет строк, только массивы байтов",
                            "Целые числа зарезервированы только для массивов",
                            "Это ограничение будет снято в Swift 7"
                        ],
                        optionsEN: [
                            "Unicode characters have variable byte length, so O(1) access requires scanning grapheme boundaries",
                            "Swift has no strings, only byte buffers",
                            "Integers are reserved exclusively for Array subscripts",
                            "It is a temporary compiler restriction"
                        ],
                        correctIndex: 0,
                        explanationRU: "Графемные кластеры Unicode имеют разную длину, поэтому для нахождения смещения требуется последовательный проход.",
                        explanationEN: "Unicode grapheme clusters vary in byte size, requiring a sequential scan to determine character boundaries."
                    ),
                    QuizQuestion(
                        questionRU: "В чем опасность долгосрочного хранения Substring в свойствах модели?",
                        questionEN: "What is the primary danger of retaining Substrings for a long time?",
                        optionsRU: [
                            "Substring удерживает ссылку на весь буфер памяти исходной большой строки",
                            "Substring автоматически удаляется через 1 секунду",
                            "Substring не поддерживает сравнение через ==",
                            "Опасности нет, Substring идентичен String"
                        ],
                        optionsEN: [
                            "A Substring keeps the entire memory buffer of the original string alive",
                            "Substrings are deallocated after 1 second automatically",
                            "Substrings cannot be compared using ==",
                            "There is no difference between Substring and String"
                        ],
                        correctIndex: 0,
                        explanationRU: "Substring разделяет память с исходной строкой. Если исходная строка занимала мегабайты, эти мегабайты останутся в памяти.",
                        explanationEN: "Substrings share storage with the parent string, preventing the entire original buffer from being deallocated."
                    )
                ]
            ),

            Lesson(
                id: "types_initializers_lifecycle",
                category: .oopAndPop,
                titleRU: "Инициализаторы и Жизненный Цикл (init & deinit)",
                titleEN: "Initializers & Object Lifecycle (init & deinit)",
                summaryRU: "Designated и Convenience инициализаторы, Failable init?, двухфазная инициализация и освобождение памяти в deinit.",
                summaryEN: "Designated and convenience initializers, failable inits, two-phase initialization, and deinit.",
                contentMarkdownRU: ##"""
### Иерархия инициализаторов в классах

Swift гарантирует абсолютную безопасность памяти при создании объектов. В классах существует два типа инициализаторов:

1. **Designated (Основной) инициализатор:**
   - Обязан полностью проинициализировать все собственные хранимые свойства класса.
   - Обязан вызвать Designated инициализатор своего суперкласса через `super.init(...)`.
   - Делегирует инициализацию **вверх** по иерархии наследования.

2. **Convenience (Вспомогательный) инициализатор:**
   - Помечен ключевым словом `convenience init(...)`.
   - Предоставляет удобные значения по умолчанию для части параметров.
   - Обязан вызвать другой инициализатор своего же класса (делегирует **по горизонтали**), в конечном итоге вызывая designated.

---

### Двухфазная инициализация (Two-Phase Initialization)

Компилятор Swift выполняет создание экземпляра строго в 2 фазы:
- **Фаза 1:** Каждое хранимое свойство класса и всех его предков получает начальное значение снизу вверх по цепочке наследования до корня. На этой фазе **запрещено** обращаться к `self` или вызывать методы экземпляра.
- **Фаза 2:** После успешного завершения Фазы 1 объект считается валидным в оперативной памяти. Теперь разрешено обращаться к `self`, модифицировать свойства и вызывать любые методы.

---

### Провальные инициализаторы (`init?`)
Если объект не может быть создан с переданными аргументами, используется `init?`, возвращающий `nil`:
```swift
struct ServerPort {
    let number: Int
    init?(number: Int) {
        guard (1...65535).contains(number) else { return nil }
        self.number = number
    }
}
```

---

### Метод `deinit`
Вызывается автоматически системой автоматического подсчета ссылок (ARC) непосредственно перед уничтожением экземпляра класса и освобождением памяти.
"""##,
                contentMarkdownEN: ##"""
### Initializers Architecture in Swift

1. **Designated Initializer**: Fully initializes all stored properties of the current class and delegates up to `super.init()`.
2. **Convenience Initializer**: Delegates horizontally to another initializer within the same class, configuring sensible defaults.

### Two-Phase Initialization
- **Phase 1**: Every stored property across the entire inheritance chain is assigned an initial value. Accessing `self` is forbidden during Phase 1.
- **Phase 2**: Once all properties are initialized, `self` becomes accessible and methods may be invoked.

### Deinitialization (`deinit`)
Only classes (reference types) can implement `deinit`. ARC invokes it right before reclaiming allocated heap memory.
"""##,
                codeSnippet: ##"""
class HardwareDevice {
    let serialNumber: String
    
    init(serialNumber: String) {
        self.serialNumber = serialNumber
        print("HardwareDevice #\(serialNumber) выделен в памяти")
    }
    
    deinit {
        print("HardwareDevice #\(serialNumber) уничтожен (deinit)")
    }
}

class SmartSensor: HardwareDevice {
    var samplingRateHz: Int
    
    // Designated
    init(serialNumber: String, samplingRateHz: Int) {
        self.samplingRateHz = samplingRateHz
        super.init(serialNumber: serialNumber) // Завершение Фазы 1
    }
    
    // Convenience
    convenience init(serialNumber: String) {
        self.init(serialNumber: serialNumber, samplingRateHz: 60)
    }
}

do {
    let sensor = SmartSensor(serialNumber: "SN-90210")
    print("Датчик готов: \(sensor.serialNumber), частота: \(sensor.samplingRateHz) Гц")
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что разрешено делать во время Фазы 1 двухфазной инициализации класса?",
                        questionEN: "What is permitted during Phase 1 of class two-phase initialization?",
                        optionsRU: [
                            "Присваивать значения собственным хранимым свойствам класса",
                            "Вызывать методы экземпляра через self.myMethod()",
                            "Передавать self как аргумент в другие функции",
                            "Читать вычисляемые свойства"
                        ],
                        optionsEN: [
                            "Assigning initial values to the class's own stored properties",
                            "Calling instance methods via self.myMethod()",
                            "Passing self as an argument to other functions",
                            "Reading computed properties"
                        ],
                        correctIndex: 0,
                        explanationRU: "В первой фазе разрешено только присваивать начальные значения хранимым свойствам. Доступ к self открывается во второй фазе.",
                        explanationEN: "During Phase 1, only stored property initialization is permitted before self is considered fully safe."
                    ),
                    QuizQuestion(
                        questionRU: "Какому типу данных запрещено объявлять метод deinit?",
                        questionEN: "Which data type is strictly forbidden from declaring a deinit method?",
                        optionsRU: [
                            "Структурам (struct) и Перечислениям (enum)",
                            "Классам (class)",
                            "Акторам (actor)",
                            "Подклассам NSObject"
                        ],
                        optionsEN: [
                            "Structures (struct) and Enumerations (enum)",
                            "Classes (class)",
                            "Actors (actor)",
                            "NSObject subclasses"
                        ],
                        correctIndex: 0,
                        explanationRU: "Метод deinit доступен только для ссылочных типов (class, actor), управляемых счетчиком ссылок ARC.",
                        explanationEN: "Only reference types managed on the heap by ARC can declare deinit methods."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_forms_and_inputs",
                category: .swiftuiState,
                titleRU: "Формы, Системный Ввод Данных и @FocusState",
                titleEN: "Forms, Data Input & @FocusState",
                summaryRU: "Form, Section, TextField, SecureField, Toggle, Slider, Picker и программное управление фокусом через @FocusState.",
                summaryEN: "Forms, Sections, TextFields, SecureFields, Toggles, and keyboard control with @FocusState.",
                contentMarkdownRU: ##"""
### Контейнер `Form` и Секции

Контейнер `Form` — это специализированный декларативный компонент, который автоматически применяет платформенные стили iOS (группированные списки, отступы ячеек, системные разделители и скролл):

```swift
Form {
    Section(header: Text("Учетная запись")) {
        TextField("Имя пользователя", text: $username)
        SecureField("Пароль", text: $password)
    }
}
```

---

### Управление фокусом и клавиатурой: `@FocusState`

В iOS ввод текста тесно связан с экранной клавиатурой. Обертка `@FocusState` позволяет программно переносить курсор между полями ввода и закрывать клавиатуру:

```swift
enum Field: Hashable {
    case username
    case email
    case password
}

@FocusState private var focusedField: Field?

// Внутри body:
TextField("Email", text: $email)
    .focused($focusedField, equals: .email)
    .submitLabel(.next)
    .onSubmit {
        focusedField = .password // Переход к следующему полю!
    }
```

---

### Настройка системной клавиатуры
- `.keyboardType(.emailAddress)` / `.keyboardType(.numberPad)`
- `.textContentType(.oneTimeCode)` (для SMS-кодов подтверждения)
- `.autocorrectionDisabled()`
- `.textInputAutocapitalization(.never)`
"""##,
                contentMarkdownEN: ##"""
### SwiftUI `Form` Container
`Form` adapts layout to the host platform (grouped list styling on iOS, flat on macOS).

### Programmatic Focus with `@FocusState`
Control first responder status and keyboard transitions declaratively:
```swift
@FocusState private var isFieldFocused: Bool
TextField("Name", text: $name)
    .focused($isFieldFocused)
```
"""##,
                codeSnippet: ##"""
import SwiftUI

struct LoginFormDemo: View {
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = true
    @FocusState private var focusedField: FormField?
    
    enum FormField {
        case email, password
    }
    
    var body: some View {
        Form {
            Section(header: Text("Авторизация")) {
                TextField("Email", text: $email)
                    .focused($focusedField, equals: .email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .submitLabel(.next)
                    .onSubmit { focusedField = .password }
                
                SecureField("Пароль", text: $password)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.done)
                    .onSubmit { focusedField = nil }
                
                Toggle("Запомнить меня", isOn: $rememberMe)
            }
        }
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Как программно скрыть экранную клавиатуру при использовании @FocusState?",
                        questionEN: "How do you programmatically dismiss the keyboard using @FocusState?",
                        optionsRU: [
                            "Присвоить переменной фокуса значение nil: focusedField = nil",
                            "Вызвать UIApplication.shared.closeKeyboard()",
                            "Удалить текстовое поле из иерархии",
                            "Клавиатуру в SwiftUI закрыть программно невозможно"
                        ],
                        optionsEN: [
                            "Set the focused property to nil: focusedField = nil",
                            "Call UIApplication.shared.closeKeyboard()",
                            "Remove the TextField from the view tree",
                            "Keyboards cannot be dismissed programmatically in SwiftUI"
                        ],
                        correctIndex: 0,
                        explanationRU: "Сброс значения переменной @FocusState в nil снимает фокус с активного поля и закрывает клавиатуру.",
                        explanationEN: "Assigning nil to a @FocusState variable resigns first responder status and hides the on-screen keyboard."
                    ),
                    QuizQuestion(
                        questionRU: "Какой модификатор меняет надпись на синей кнопке 'Ввод' клавиатуры на 'Далее' или 'Готово'?",
                        questionEN: "Which modifier changes the action button label on the keyboard to 'Next' or 'Done'?",
                        optionsRU: [
                            ".submitLabel(.next) / .submitLabel(.done)",
                            ".keyboardTitle(\"Done\")",
                            ".returnKeyType(\"Next\")",
                            ".actionButton(.done)"
                        ],
                        optionsEN: [
                            ".submitLabel(.next) / .submitLabel(.done)",
                            ".keyboardTitle(\"Done\")",
                            ".returnKeyType(\"Next\")",
                            ".actionButton(.done)"
                        ],
                        correctIndex: 0,
                        explanationRU: "Модификатор .submitLabel настраивает стиль и текст кнопки подтверждения системной клавиатуры.",
                        explanationEN: "The .submitLabel modifier configures the label displayed on the primary action return key."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_environment_keys",
                category: .swiftuiAnatomy,
                titleRU: "Окружение SwiftUI: Кастомные EnvironmentKey",
                titleEN: "SwiftUI Environment & Custom EnvironmentKey",
                summaryRU: "Внедрение зависимостей через @Environment, системные ключи и создание собственных ключей через Entry().",
                summaryEN: "Dependency injection via @Environment, system keys, and custom keys using Entry().",
                contentMarkdownRU: ##"""
### Как устроен `@Environment`

`@Environment` — это механизм **внедрения зависимостей (Dependency Injection)** в SwiftUI. Вместо того чтобы прокидывать параметры вручную через конструкторы десятков промежуточных представлений («prop drilling»), вы устанавливаете значение один раз на корневой View:

```swift
RootView()
    .environment(\.colorScheme, .dark)
```

И любое дочернее представление на любой глубине вложенности может мгновенно прочитать его:
```swift
@Environment(\.colorScheme) private var colorScheme
```

---

### Создание собственного кастомного ключа

В современных версиях Swift и SwiftUI создание кастомного ключа окружения занимает несколько строк:

```swift
private struct AppVersionKey: EnvironmentKey {
    static let defaultValue: String = "2.0.0-PRO"
}

extension EnvironmentValues {
    var appVersion: String {
        get { self[AppVersionKey.self] }
        set { self[AppVersionKey.self] = newValue }
    }
}
```

Теперь ключ готов к использованию во всем дереве представлений:
```swift
Text("Версия: \(version)")
    .environment(\.appVersion, "2.4.1")
```
"""##,
                contentMarkdownEN: ##"""
### Dependency Injection via `@Environment`
`@Environment` eliminates prop drilling by allowing child views to read shared system or user-defined values directly from the view hierarchy.

### Defining Custom Environment Values
Conform to `EnvironmentKey` with a `defaultValue` and extend `EnvironmentValues`.
"""##,
                codeSnippet: ##"""
import SwiftUI

private struct ThemeAccentKey: EnvironmentKey {
    static let defaultValue: Color = Color.blue
}

extension EnvironmentValues {
    var customAccent: Color {
        get { self[ThemeAccentKey.self] }
        set { self[ThemeAccentKey.self] = newValue }
    }
}

struct DeepChildView: View {
    @Environment(\.customAccent) private var accent
    
    var body: some View {
        Text("Стиль получен из Environment")
            .foregroundColor(accent)
            .bold()
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что произойдет, если View читает @Environment(\\.customKey), но родительская View не передала его?",
                        questionEN: "What happens if a View reads an @Environment value not explicitly injected by any parent?",
                        optionsRU: [
                            "Будет использовано значение по умолчанию defaultValue из регистрации ключа",
                            "Произойдет аварийное завершение (fatalError)",
                            "Вернется nil",
                            "View не скомпилируется"
                        ],
                        optionsEN: [
                            "It uses the defaultValue specified in the EnvironmentKey declaration",
                            "The app crashes with fatalError",
                            "It evaluates to nil",
                            "The view fails to compile"
                        ],
                        correctIndex: 0,
                        explanationRU: "Каждый ключ EnvironmentKey обязан предоставить defaultValue, которое используется при отсутствии явного внедрения.",
                        explanationEN: "All EnvironmentKey definitions provide a defaultValue that serves as a guaranteed fallback."
                    ),
                    QuizQuestion(
                        questionRU: "Какую архитектурную проблему решает использование @Environment?",
                        questionEN: "Which architectural problem does @Environment effectively solve?",
                        optionsRU: [
                            "Проблему прокидывания пропсов (Prop Drilling) через множество слоев вложенных View",
                            "Заменяет собой SwiftData",
                            "Увеличивает FPS графики",
                            "Удаляет классы из приложения"
                        ],
                        optionsEN: [
                            "Prop drilling through many layers of intermediate views",
                            "Replaces SwiftData databases",
                            "Boosts GPU rendering frame rates",
                            "Eliminates classes from Swift"
                        ],
                        correctIndex: 0,
                        explanationRU: "Environment позволяет передавать общие зависимости напрямую дочерним компонентам без их передачи через каждый конструктор.",
                        explanationEN: "Environment allows views to access shared configuration values without requiring every parent view to pass them down."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_gestures_and_interactions",
                category: .swiftuiAnimations,
                titleRU: "Жесты и Продвинутые Взаимодействия (Gestures)",
                titleEN: "Gestures & Advanced Interactions",
                summaryRU: "Tap, LongPress, Drag, Magnification, отслеживание фаз onChanged/onEnded и композиция жестов.",
                summaryEN: "Tap, LongPress, Drag, Magnification gestures, and gesture composition.",
                contentMarkdownRU: ##"""
### Палитра жестов в SwiftUI

1. `TapGesture(count: 2)` — двойной тап.
2. `LongPressGesture(minimumDuration: 0.6)` — длительное удержание.
3. `DragGesture()` — перетаскивание пальцем. Предоставляет `value.translation` (смещение от начала жеста) и `value.velocity` (скорость свайпа).
4. `MagnificationGesture()` — масштабирование двумя пальцами (pinch to zoom).
5. `RotationGesture()` — вращение двумя пальцами.

---

### Композиция жестов: совместная работа

- `.simultaneously(with:)`: оба жеста распознаются одновременно (например, перетаскивание объекта с одновременным изменением масштаба).
- `.sequenced(before:)`: второй жест начинается только после успешного завершения первого (например, сначала удержание 1 секунду, затем перетаскивание).
- `.exclusively(before:)`: побеждает один из двух жестов.
"""##,
                contentMarkdownEN: ##"""
### SwiftUI Gesture System
Supports discrete taps, continuous drags, magnifications, and rotations.

### Gesture Composition
- `simultaneously(with:)`: Run both concurrently.
- `sequenced(before:)`: Strict state transition from gesture A to gesture B.
"""##,
                codeSnippet: ##"""
import SwiftUI

struct InteractiveCardDemo: View {
    @State private var offset = CGSize.zero
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.blue)
            .frame(width: 200, height: 120)
            .offset(offset)
            .scaleEffect(scale)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            offset = .zero
                        }
                    }
            )
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какой метод композиции жестов позволяет активировать Drag только после долгого нажатия?",
                        questionEN: "Which composition method enables a Drag gesture only after completing a LongPress?",
                        optionsRU: [
                            "LongPressGesture().sequenced(before: DragGesture())",
                            "DragGesture().simultaneously(with: LongPressGesture())",
                            "DragGesture().repeat()",
                            "Жесты нельзя комбинировать последовательно"
                        ],
                        optionsEN: [
                            "LongPressGesture().sequenced(before: DragGesture())",
                            "DragGesture().simultaneously(with: LongPressGesture())",
                            "DragGesture().repeat()",
                            "Gestures cannot be sequenced in SwiftUI"
                        ],
                        correctIndex: 0,
                        explanationRU: "Метод .sequenced(before:) требует успешного завершения первого жеста до запуска следующего.",
                        explanationEN: "The .sequenced(before:) method enforces that the first gesture must succeed before the second activates."
                    ),
                    QuizQuestion(
                        questionRU: "Какое свойство в DragGesture.Value содержит смещение пальца от начальной точки касания?",
                        questionEN: "Which property in DragGesture.Value contains the translation vector from touch origin?",
                        optionsRU: [
                            "value.translation",
                            "value.distance",
                            "value.speed",
                            "value.absoluteDelta"
                        ],
                        optionsEN: [
                            "value.translation",
                            "value.distance",
                            "value.speed",
                            "value.absoluteDelta"
                        ],
                        correctIndex: 0,
                        explanationRU: "value.translation хранит размер CGSize (смещение по X и Y от начала касания).",
                        explanationEN: "value.translation stores the CGSize vector offset representing total drag travel distance."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_alerts_dialogs_menus",
                category: .swiftuiNavigation,
                titleRU: "Интерактивные Диалоги, Алерты и Context Menus",
                titleEN: "Alerts, Confirmation Dialogs & Menus",
                summaryRU: "Нативные предупреждения .alert, модальные шторки confirmationDialog, выпадающие Menu и свайпы в List.",
                summaryEN: "Native .alert dialogs, confirmation dialog sheets, context menus, and swipe actions.",
                contentMarkdownRU: ##"""
### Системные Алерты (`.alert`)
Алерты отображаются по центру экрана для важных предупреждений:
```swift
.alert("Удалить файл?", isPresented: $showAlert) {
    Button("Удалить", role: .destructive) { deleteFile() }
    Button("Отмена", role: .cancel) {}
} message: {
    Text("Это действие невозможно отменить.")
}
```

---

### Листы действий (`.confirmationDialog`)
Замена `UIActionSheet` из UIKit. Появляется снизу экрана для выбора одного из нескольких вариантов:
```swift
.confirmationDialog("Выберите действие", isPresented: $showDialog) {
    Button("Экспорт в PDF") {}
    Button("Отправить ссылкой") {}
    Button("Удалить", role: .destructive) {}
}
```

---

### Свайп-действия в списках (`.swipeActions`)
```swift
List(items) { item in
    Text(item.name)
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) { delete(item) } label: {
                Label("Удалить", systemImage: "trash")
            }
        }
}
```
"""##,
                contentMarkdownEN: ##"""
### SwiftUI Dialogs
- `.alert`: Modal popups for critical confirmations.
- `.confirmationDialog`: Action sheets anchored at the bottom.
- `.swipeActions`: Leading and trailing cell swipe buttons.
"""##,
                codeSnippet: ##"""
import SwiftUI

struct ActionSheetDemoView: View {
    @State private var showConfirm = false
    
    var body: some View {
        Button("Удалить проект") {
            showConfirm = true
        }
        .foregroundColor(.red)
        .confirmationDialog("Вы уверены?", isPresented: $showConfirm) {
            Button("Стереть все данные", role: .destructive) {
                print("Данные удалены")
            }
            Button("Отмена", role: .cancel) {}
        }
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какая роль кнопки (ButtonRole) автоматически окрашивает ее в красный цвет в Alert и ConfirmationDialog?",
                        questionEN: "Which ButtonRole automatically styles a button in red for destructive operations?",
                        optionsRU: [
                            "role: .destructive",
                            "role: .danger",
                            "role: .warning",
                            "role: .delete"
                        ],
                        optionsEN: [
                            "role: .destructive",
                            "role: .danger",
                            "role: .warning",
                            "role: .delete"
                        ],
                        correctIndex: 0,
                        explanationRU: "Кнопка с role: .destructive получает системный красный цвет и сигнализирует об опасном действии.",
                        explanationEN: "Buttons initialized with role: .destructive receive native red accent colors indicating danger."
                    ),
                    QuizQuestion(
                        questionRU: "В чем разница между .alert и .confirmationDialog?",
                        questionEN: "What is the primary visual difference between .alert and .confirmationDialog on iOS?",
                        optionsRU: [
                            ".alert появляется по центру экрана, а .confirmationDialog выезжает снизу как Action Sheet",
                            ".alert работает только на macOS",
                            ".confirmationDialog не поддерживает кнопки отмены",
                            "Это полные синонимы"
                        ],
                        optionsEN: [
                            ".alert appears centrally, whereas .confirmationDialog slides up from the bottom",
                            ".alert only functions on macOS",
                            ".confirmationDialog cannot display cancel buttons",
                            "They are identical"
                        ],
                        correctIndex: 0,
                        explanationRU: "Alert предназначен для критических предупреждений в центре экрана, а confirmationDialog — для выбора из нескольких действий снизу.",
                        explanationEN: ".alert is a centered alert modal, whereas .confirmationDialog is an action sheet sliding from the bottom."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_graphics_shapes_canvas",
                category: .swiftuiModifiers,
                titleRU: "Векторная Графика, Кастомные Shapes и Canvas",
                titleEN: "Vector Graphics, Custom Shapes & Canvas",
                summaryRU: "Рисование кривых Безье через Path, протокол Shape, градиенты и 120 FPS рендеринг через Canvas.",
                summaryEN: "Bezier curves with Path, conforming to Shape protocol, and high-performance Canvas rendering.",
                contentMarkdownRU: ##"""
### Протокол `Shape`

Для создания собственных геометрических фигур реализуйте протокол `Shape` с единственным методом:
```swift
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
```

Любая фигура автоматически поддерживает модификаторы `.fill()`, `.stroke(lineWidth:)` и `.strokeBorder()`.

---

### Высокопроизводительный `Canvas`

Когда вам нужно отрисовать сотни или тысячи динамических элементов (графики котировок, частицы, салюты), создание тысяч отдельных SwiftUI `View` приведет к просадке частоты кадров.

Компонент `Canvas` предоставляет прямой доступ к аппаратно ускоренному `GraphicsContext` (Metal):
```swift
Canvas { context, size in
    for i in 0..<500 {
        context.fill(Path(ellipseIn: ...), with: .color(.orange))
    }
}
```
"""##,
                contentMarkdownEN: ##"""
### Custom Shapes in SwiftUI
Implement `path(in rect: CGRect) -> Path` to build reusable vector shapes.

### High-Performance `Canvas`
Canvas leverages hardware-accelerated GraphicsContext to draw thousands of primitives at 120 FPS.
"""##,
                codeSnippet: ##"""
import SwiftUI

struct CustomProgressArc: Shape {
    var progress: Double // 0.0 ... 1.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        path.addArc(
            center: center,
            radius: radius,
            startAngle: .degrees(-90),
            endAngle: .degrees(-90 + (progress * 360)),
            clockwise: false
        )
        return path
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какой метод протокола Shape обязан вернуть векторный контур фигуры?",
                        questionEN: "Which Shape protocol method must return the vector contour path?",
                        optionsRU: [
                            "func path(in rect: CGRect) -> Path",
                            "func draw(context: CGContext)",
                            "func createVector() -> CGPath",
                            "func makeShape() -> View"
                        ],
                        optionsEN: [
                            "func path(in rect: CGRect) -> Path",
                            "func draw(context: CGContext)",
                            "func createVector() -> CGPath",
                            "func makeShape() -> View"
                        ],
                        correctIndex: 0,
                        explanationRU: "Метод path(in rect: CGRect) принимает прямоугольник выделенной области и строит Path.",
                        explanationEN: "path(in:) receives the bounding rect and constructs the vector Path outline."
                    ),
                    QuizQuestion(
                        questionRU: "В чем главное преимущество Canvas перед ScrollView с сотнями отдельных View?",
                        questionEN: "What is the primary performance benefit of Canvas over rendering hundreds of individual Views?",
                        optionsRU: [
                            "Canvas выполняет прямой рендеринг через GraphicsContext без накладных расходов дерева View",
                            "Canvas поддерживает 3D графику, а View — нет",
                            "Canvas не расходует аккумулятор",
                            "Canvas автоматически переводит код на C++"
                        ],
                        optionsEN: [
                            "Canvas draws directly via GraphicsContext without SwiftUI view hierarchy overhead",
                            "Canvas exclusively supports 3D rendering",
                            "Canvas consumes zero battery",
                            "Canvas transpiles code to C++"
                        ],
                        correctIndex: 0,
                        explanationRU: "Canvas рисует все элементы как один единый растровый слой Metal, исключая затраты на создание и отслеживание сотен структур View.",
                        explanationEN: "Canvas collapses drawing operations into a single GraphicsContext Metal layer, bypassing view hierarchy allocations."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_view_lifecycle_scenephase",
                category: .swiftuiNavigation,
                titleRU: "Жизненный Цикл View и Фазы Приложения (ScenePhase)",
                titleEN: "View Lifecycle & ScenePhase",
                summaryRU: "События появления и исчезновения View (onAppear/onDisappear), task, onChange и обработка перехода в фон через scenePhase.",
                summaryEN: "View lifecycle events, task cancellation, onChange, and app state tracking with scenePhase.",
                contentMarkdownRU: ##"""
### Жизненный цикл `View`

В отличие от UIKit UIViewController, структуры SwiftUI не хранятся в памяти постоянно — они создаются и уничтожаются декларативно.

1. `.onAppear { }` — вызывается в момент отображения представления на экране.
2. `.onDisappear { }` — вызывается при уходе представления с экрана.
3. `.task { }` — **лучшая практика для асинхронных операций**. Автоматически стартует `Task` при появлении и автоматически отменяет (`Task.cancel()`) ее при уходе с экрана.

---

### Фазы приложения: `@Environment(\.scenePhase)`

Позволяет отслеживать жизненный цикл всего приложения:
- `.active` — приложение активно и взаимодействует с пользователем.
- `.inactive` — переходное состояние (экран многозадачности, входящий звонок).
- `.background` — приложение свернуто. В этот момент необходимо сохранять данные в базу и останавливать тяжелые вычисления.
"""##,
                contentMarkdownEN: ##"""
### Lifecycle Modifiers in SwiftUI
- `.onAppear`: View renders on screen.
- `.onDisappear`: View is removed.
- `.task`: Concurrency-safe task automatically cancelled when the view leaves the hierarchy.

### Monitoring App State with ScenePhase
`@Environment(\.scenePhase)` tracks active, inactive, and background states.
"""##,
                codeSnippet: ##"""
import SwiftUI

struct LifecycleDemoView: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var networkData: [String] = []
    
    var body: some View {
        List(networkData, id: \.self) { item in
            Text(item)
        }
        .task {
            // Задача автоматически отменится при уходе с экрана
            networkData = ["Модуль 1", "Модуль 2", "Модуль 3"]
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .background {
                print("Приложение свернуто: сохраняем состояние")
            }
        }
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что происходит с асинхронной операцией внутри .task, когда пользователь закрывает экран?",
                        questionEN: "What happens to a running async operation inside .task when the view leaves screen?",
                        optionsRU: [
                            "Операция автоматически получает сигнал отмены (Task.isCancelled == true)",
                            "Операция вызывает аварийное завершение приложения",
                            "Операция навсегда зависает в фоновом потоке",
                            "Ничего, задача выполняется вечно"
                        ],
                        optionsEN: [
                            "The task is automatically cancelled cooperative-style",
                            "The app crashes with an unhandled exception",
                            "The thread freezes indefinitely",
                            "Nothing, the task runs endlessly"
                        ],
                        correctIndex: 0,
                        explanationRU: "Модификатор .task автоматически отменяет запущенную им асинхронную задачу при исчезновении View.",
                        explanationEN: "The .task modifier binds task lifetime to view visibility, triggering cancellation when the view unmounts."
                    ),
                    QuizQuestion(
                        questionRU: "Какая фаза ScenePhase указывает на то, что приложение свернуто пользователем?",
                        questionEN: "Which ScenePhase represents the app being backgrounded?",
                        optionsRU: [
                            ".background",
                            ".inactive",
                            ".terminated",
                            ".sleeping"
                        ],
                        optionsEN: [
                            ".background",
                            ".inactive",
                            ".terminated",
                            ".sleeping"
                        ],
                        correctIndex: 0,
                        explanationRU: "Состояние .background означает, что интерфейс приложения скрыт и приложение находится в фоне.",
                        explanationEN: ".background signifies the application is no longer visible on screen and is executing in the background."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_uikit_integration",
                category: .swiftuiNavigation,
                titleRU: "Интеграция с UIKit: UIViewRepresentable",
                titleEN: "UIKit Integration: UIViewRepresentable",
                summaryRU: "Мост между SwiftUI и UIKit, оборачивание контролов, протокол Coordinator и двусторонний биндинг данных.",
                summaryEN: "Bridging UIKit and SwiftUI, lifecycle callbacks, and delegate coordination.",
                contentMarkdownRU: ##"""
### Зачем нужен UIKit в современном коде?

Несмотря на мощь SwiftUI, многие системные компоненты (кастомные текстовые редакторы с подсветкой, сканеры документов `VNDocumentCameraViewController`, сложные графические камеры `AVFoundation`) по-прежнему требуют UIKit.

---

### Структура `UIViewRepresentable`

1. `makeUIView(context:) -> UIView`: Создает и настраивает UIKit-объект **один раз** при первом появлении.
2. `updateUIView(_:context:)`: Вызывается всякий раз, когда изменяется состояние SwiftUI. Синхронизирует свойства из SwiftUI в UIKit.
3. `makeCoordinator() -> Coordinator`: Создает объект-координатор, который реализует протоколы делегатов UIKit (`UITextViewDelegate`, `UIScrollViewDelegate`) и передает пользовательские события обратно в SwiftUI через `@Binding`.
"""##,
                contentMarkdownEN: ##"""
### UIViewRepresentable Protocol
Wraps UIKit views into native SwiftUI components.
- `makeUIView`: One-time setup.
- `updateUIView`: Synchronizes state updates.
- `makeCoordinator`: Implements UIKit delegates to update SwiftUI bindings.
"""##,
                codeSnippet: ##"""
import SwiftUI
import UIKit

struct CustomActivityIndicator: UIViewRepresentable {
    var isAnimating: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какую ключевую роль выполняет класс Coordinator в UIViewRepresentable?",
                        questionEN: "What is the primary role of the Coordinator class in UIViewRepresentable?",
                        optionsRU: [
                            "Служит делегатом UIKit-контрола для передачи событий обратно в SwiftUI",
                            "Оптимизирует скорость компиляции",
                            "Удаляет память UIKit",
                            "Преобразует верстку в Auto Layout"
                        ],
                        optionsEN: [
                            "Acts as a delegate to propagate events from UIKit back to SwiftUI bindings",
                            "Accelerates compilation times",
                            "Deallocates UIKit memory",
                            "Translates frames into Auto Layout constraints"
                        ],
                        correctIndex: 0,
                        explanationRU: "Coordinator принимает вызовы делегатов UIKit и мутирует связанные переменные @Binding в SwiftUI.",
                        explanationEN: "The Coordinator intercepts UIKit delegate callbacks and updates SwiftUI state/bindings accordingly."
                    ),
                    QuizQuestion(
                        questionRU: "Сколько раз вызывается метод makeUIView при отображении экрана?",
                        questionEN: "How many times is makeUIView invoked during a view lifecycle?",
                        optionsRU: [
                            "Один раз при первом создании представления",
                            "При каждом обновлении экрана (60 раз в секунду)",
                            "Столько же раз, сколько вызывается body",
                            "Каждый раз при повороте экрана"
                        ],
                        optionsEN: [
                            "Once during initial view creation",
                            "Every frame (60/120 times per second)",
                            "Every time body re-evaluates",
                            "Whenever device orientation changes"
                        ],
                        correctIndex: 0,
                        explanationRU: "makeUIView вызывается ровно один раз для создания экземпляра. Все последующие обновления передаются в updateUIView.",
                        explanationEN: "makeUIView is executed once to instantiate the view. Subsequent data mutations are handled by updateUIView."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_persistence_swiftdata",
                category: .swiftuiNavigation,
                titleRU: "Хранение Данных: @AppStorage и SwiftData",
                titleEN: "Data Persistence: @AppStorage & SwiftData",
                summaryRU: "Персистентность настроек через @AppStorage и современная декларативная база данных SwiftData (@Model, @Query).",
                summaryEN: "Persisting preferences with @AppStorage and declarative database modeling with SwiftData.",
                contentMarkdownRU: ##"""
### Настройки пользователя: `@AppStorage`

Для сохранения настроек (тема, язык, флаги онбординга) используется `@AppStorage`. Он автоматически синхронизируется с `UserDefaults` и обновляет View при изменении значения:

```swift
@AppStorage("isDarkMode") private var isDarkMode = false
```

---

### Современная база данных: `SwiftData` (iOS 17+)

SwiftData полностью заменяет громоздкий Core Data современным декларативным подходом:

1. **Макрос `@Model`:** превращает чистый Swift-класс в сохраняемую сущность базы данных:
```swift
@Model
final class TaskEntity {
    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}
```

2. **Макрос `@Query`:** автоматически загружает данные из БД и реактивно обновляет UI при любых изменениях:
```swift
@Query(sort: \.title) private var tasks: [TaskEntity]
```

3. **Контекст модели:** доступен через окружение `@Environment(\.modelContext) private var context` (`context.insert(task)`, `context.delete(task)`).
"""##,
                contentMarkdownEN: ##"""
### Persistence in Modern SwiftUI
- `@AppStorage`: Direct UserDefaults binding for primitives.
- `SwiftData`: Declarative SQLite-backed persistence using `@Model` and `@Query`.
"""##,
                codeSnippet: ##"""
import SwiftUI
import SwiftData

@Model
final class NoteItem {
    var text: String
    var createdAt: Date
    
    init(text: String) {
        self.text = text
        self.createdAt = Date()
    }
}

struct NotesListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \NoteItem.createdAt, order: .reverse) private var notes: [NoteItem]
    
    var body: some View {
        List {
            ForEach(notes) { note in
                Text(note.text)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    modelContext.delete(notes[index])
                }
            }
        }
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какой макрос превращает обычный Swift-класс в сущность базы данных SwiftData?",
                        questionEN: "Which macro transforms a standard Swift class into a SwiftData persisted entity?",
                        optionsRU: [
                            "@Model",
                            "@Entity",
                            "@DatabaseTable",
                            "@Persisted"
                        ],
                        optionsEN: [
                            "@Model",
                            "@Entity",
                            "@DatabaseTable",
                            "@Persisted"
                        ],
                        correctIndex: 0,
                        explanationRU: "Макрос @Model автоматически генерирует схему таблицы и отслеживание изменений для SwiftData.",
                        explanationEN: "The @Model macro inspects class properties and automatically synthesizes schema and metadata for SwiftData."
                    ),
                    QuizQuestion(
                        questionRU: "Как макрос @Query взаимодействует с интерфейсом SwiftUI?",
                        questionEN: "How does the @Query macro interact with SwiftUI views?",
                        optionsRU: [
                            "Автоматически читает данные и мгновенно перерисовывает View при любых изменениях в БД",
                            "Требует ручного вызова refresh() каждую секунду",
                            "Работает только при перезапуске приложения",
                            "Блокирует главный поток"
                        ],
                        optionsEN: [
                            "It executes fetch requests and reactively triggers view updates when data mutates",
                            "Requires manual refresh() polling",
                            "Only updates on app relaunch",
                            "Blocks the main UI thread"
                        ],
                        correctIndex: 0,
                        explanationRU: "@Query непрерывно наблюдает за хранилищем и автоматически обновляет массив данных при вставках и удалениях.",
                        explanationEN: "@Query establishes a live subscription to the model context and invalidates views when underlying records change."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_advanced_property_wrappers",
                category: .swiftuiState,
                titleRU: "Продвинутые Property Wrappers: @ScaledMetric",
                titleEN: "Advanced Property Wrappers & @ScaledMetric",
                summaryRU: "Специализированные обертки свойств: поддержка Dynamic Type (@ScaledMetric), сохранение UI-состояния сцены и кастомные обертки.",
                summaryEN: "Specialized property wrappers, accessibility scaling with @ScaledMetric, and custom wrappers.",
                contentMarkdownRU: ##"""
### Доступность и `@ScaledMetric`

При создании кастомного UI важно, чтобы иконки и отступы масштабировались пропорционально размеру шрифта пользователя (Dynamic Type):

```swift
@ScaledMetric(relativeTo: .body) private var iconSize: CGFloat = 24
@ScaledMetric private var cardPadding: CGFloat = 16
```

Если пользователь увеличит шрифт в настройках iOS до уровня Accessibility, `iconSize` автоматически вырастет с 24 до 38+ pt!

---

### Разработка собственного `@propertyWrapper`

```swift
@propertyWrapper
struct Clamped<T: Comparable> {
    private var value: T
    private let range: ClosedRange<T>
    
    var wrappedValue: T {
        get { value }
        set { value = min(max(newValue, range.lowerBound), range.upperBound) }
    }
    
    init(wrappedValue: T, _ range: ClosedRange<T>) {
        self.range = range
        self.value = min(max(wrappedValue, range.lowerBound), range.upperBound)
    }
}
```
"""##,
                contentMarkdownEN: ##"""
### Dynamic Type Scaling with `@ScaledMetric`
Automatically adjusts dimensions proportionally to the user's system font preference.

### Custom Property Wrappers
Use `wrappedValue` for main access and `projectedValue` for binding/metadata projections.
"""##,
                codeSnippet: ##"""
import SwiftUI

struct ScaledMetricCard: View {
    @ScaledMetric(relativeTo: .title) private var avatarSize: CGFloat = 48
    
    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(Color.orange)
                .frame(width: avatarSize, height: avatarSize)
            
            VStack(alignment: .leading) {
                Text("Инженер Apple")
                    .font(.title2.bold())
                Text("Размер аватара масштабируется: \(Int(avatarSize)) pt")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что делает обертка свойства @ScaledMetric?",
                        questionEN: "What is the purpose of the @ScaledMetric property wrapper?",
                        optionsRU: [
                            "Автоматически масштабирует числовое значение в зависимости от размера Dynamic Type пользователя",
                            "Переводит дюймы в сантиметры",
                            "Масштабирует View только на iPad",
                            "Уменьшает потребление памяти"
                        ],
                        optionsEN: [
                            "Automatically scales numerical values in alignment with user Dynamic Type preferences",
                            "Converts imperial to metric units",
                            "Applies only to iPad layouts",
                            "Reduces memory consumption"
                        ],
                        correctIndex: 0,
                        explanationRU: "@ScaledMetric масштабирует числовые метрики (отступы, размеры иконок) синхронно с системным шрифтом для доступности.",
                        explanationEN: "@ScaledMetric dynamically adjusts floating-point values proportionally to user accessibility text size options."
                    ),
                    QuizQuestion(
                        questionRU: "Как в кастомном @propertyWrapper объявляется свойство, доступное через проекцию $значение?",
                        questionEN: "In a custom @propertyWrapper, which variable defines projected access via the $ prefix?",
                        optionsRU: [
                            "var projectedValue: ...",
                            "var dollarValue: ...",
                            "var shadowValue: ...",
                            "var bindingValue: ..."
                        ],
                        optionsEN: [
                            "var projectedValue: ...",
                            "var dollarValue: ...",
                            "var shadowValue: ...",
                            "var bindingValue: ..."
                        ],
                        correctIndex: 0,
                        explanationRU: "Свойство projectedValue объявляет значение, возвращаемое при обращении через префикс $.",
                        explanationEN: "The projectedValue property defines what is returned when the wrapper is referenced with the $ symbol."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_custom_layout_protocol",
                category: .swiftuiStacks,
                titleRU: "Кастомные Контейнеры: Протокол Layout (iOS 16+)",
                titleEN: "Custom Layout Containers (iOS 16+)",
                summaryRU: "Создание собственных алгоритмов компоновки через протокол Layout: FlowLayout (облако тегов) и круговое размещение.",
                summaryEN: "Building custom layout algorithms using the Layout protocol: FlowLayout, tag clouds, and circular placements.",
                contentMarkdownRU: ##"""
### Зачем нужен протокол `Layout`?

Стандартные контейнеры `HStack` и `VStack` одномерны. Если у вас есть 20 тегов разной длины, `HStack` выйдет за границы экрана. Протокол `Layout` позволяет написать полноценный **FlowLayout (Chips / Tags Cloud)**, который автоматически переносит элементы на новую строку!

---

### Два главных метода протокола `Layout`

1. `sizeThatFits(proposal:subviews:cache:) -> CGSize`
   - Измеряет суммарный размер, который займет контейнер с учетом размеров дочерних элементов `subviews[i].sizeThatFits(...)`.

2. `placeSubviews(in:proposal:subviews:cache:)`
   - Размещает каждое представление в вычисленной точке координат: `subview.place(at: point, proposal: ...)`
"""##,
                contentMarkdownEN: ##"""
### Layout Protocol
Allows writing 2D custom layout containers like flow layouts, radial layouts, or cascading grids.
Implement `sizeThatFits` and `placeSubviews`.
"""##,
                codeSnippet: ##"""
import SwiftUI

// Пример FlowLayout
struct SimpleHFlow: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        return proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        var y = bounds.minY
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX {
                x = bounds.minX
                y += size.height + spacing
            }
            subview.place(at: CGPoint(x: x, y: y), proposal: .unspecified)
            x += size.width + spacing
        }
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какой метод протокола Layout отвечает за вычисление итоговых координат размещения каждого дочернего представления?",
                        questionEN: "Which Layout protocol method assigns coordinates to each individual subview?",
                        optionsRU: [
                            "placeSubviews(in:proposal:subviews:cache:)",
                            "sizeThatFits(proposal:subviews:cache:)",
                            "layoutSubviews(frame:)",
                            "render(context:)"
                        ],
                        optionsEN: [
                            "placeSubviews(in:proposal:subviews:cache:)",
                            "sizeThatFits(proposal:subviews:cache:)",
                            "layoutSubviews(frame:)",
                            "render(context:)"
                        ],
                        correctIndex: 0,
                        explanationRU: "Метод placeSubviews вызывает subview.place(at:) для каждого элемента для точного позиционирования.",
                        explanationEN: "placeSubviews iterates over subviews and calls subview.place(at:) with concrete target coordinates."
                    ),
                    QuizQuestion(
                        questionRU: "В какой версии iOS появился протокол Layout?",
                        questionEN: "In which iOS version was the Layout protocol introduced?",
                        optionsRU: [
                            "iOS 16.0",
                            "iOS 13.0",
                            "iOS 14.0",
                            "iOS 18.0"
                        ],
                        optionsEN: [
                            "iOS 16.0",
                            "iOS 13.0",
                            "iOS 14.0",
                            "iOS 18.0"
                        ],
                        correctIndex: 0,
                        explanationRU: "Протокол Layout был представлен на WWDC 2022 в iOS 16.",
                        explanationEN: "The Layout protocol was added to SwiftUI in iOS 16 / macOS 13."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_phase_and_keyframe_animations",
                category: .swiftuiAnimations,
                titleRU: "Кинематографические Анимации: Phase & Keyframe",
                titleEN: "PhaseAnimator & KeyframeAnimator (iOS 17+)",
                summaryRU: "Создание кинематографических анимаций в iOS 17+: циклы состояний, фазы и кривые интерполяции ключевых кадров.",
                summaryEN: "Cinematic animations with PhaseAnimator and KeyframeAnimator tracks in iOS 17+.",
                contentMarkdownRU: ##"""
### Модификатор `.phaseAnimator` (iOS 17+)

Вместо ручного переключения булевых флагов `.phaseAnimator` циклически или по триггеру прогоняет представление через набор дискретных фаз:

```swift
enum PulsePhase: CaseIterable {
    case initial, expanded, shrunk
}

Circle()
    .phaseAnimator(PulsePhase.allCases) { content, phase in
        content
            .scaleEffect(phase == .expanded ? 1.4 : 1.0)
            .opacity(phase == .shrunk ? 0.4 : 1.0)
    }
```

---

### `KeyframeAnimator`: Покадровая хореография

Позволяет независимо анимировать несколько параметров (смещение, вращение, масштаб) по временной шкале:
- `LinearKeyframe`: равномерное линейное изменение.
- `CubicKeyframe`: плавная кривая Безье.
- `SpringKeyframe`: пружинный отскок с физикой затухания.
"""##,
                contentMarkdownEN: ##"""
### Modern Animation Capabilities in iOS 17
- `phaseAnimator`: Steps views through an array of states.
- `KeyframeAnimator`: Choreographs multiple property tracks across timelines.
"""##,
                codeSnippet: ##"""
import SwiftUI

struct KeyframeButtonDemo: View {
    @State private var trigger = 0
    
    struct AnimationValues {
        var scale = 1.0
        var verticalOffset = 0.0
    }
    
    var body: some View {
        Button("Пульс") {
            trigger += 1
        }
        .keyframeAnimator(initialValue: AnimationValues(), trigger: trigger) { content, value in
            content
                .scaleEffect(value.scale)
                .offset(y: value.verticalOffset)
        } keyframes: { _ in
            KeyframeTrack(\.scale) {
                CubicKeyframe(1.2, duration: 0.15)
                SpringKeyframe(1.0, duration: 0.25)
            }
            KeyframeTrack(\.verticalOffset) {
                CubicKeyframe(-10.0, duration: 0.15)
                SpringKeyframe(0.0, duration: 0.25)
            }
        }
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Чем KeyframeAnimator превосходит стандартный withAnimation?",
                        questionEN: "What advantage does KeyframeAnimator provide over standard withAnimation?",
                        optionsRU: [
                            "Позволяет задавать независимые ключевые кадры для разных свойств по временной шкале",
                            "KeyframeAnimator работает без использования GPU",
                            "KeyframeAnimator доступен начиная с iOS 13",
                            "Он автоматически экспортирует видеофайл"
                        ],
                        optionsEN: [
                            "Enables independent multi-track timelines across different visual properties",
                            "KeyframeAnimator runs purely without GPU",
                            "KeyframeAnimator has been available since iOS 13",
                            "It exports animations as video files"
                        ],
                        correctIndex: 0,
                        explanationRU: "KeyframeAnimator дает покадровый контроль над масштабом, сдвигом и поворотом независимо друг от друга.",
                        explanationEN: "Keyframe tracks enable multi-dimensional timing curves for scale, offset, and rotation simultaneously."
                    ),
                    QuizQuestion(
                        questionRU: "Какой тип ключевого кадра добавляет эффект пружинящего отскока?",
                        questionEN: "Which keyframe type produces an elastic spring bounce effect?",
                        optionsRU: [
                            "SpringKeyframe",
                            "LinearKeyframe",
                            "CubicKeyframe",
                            "BounceKeyframe"
                        ],
                        optionsEN: [
                            "SpringKeyframe",
                            "LinearKeyframe",
                            "CubicKeyframe",
                            "BounceKeyframe"
                        ],
                        correctIndex: 0,
                        explanationRU: "SpringKeyframe использует параметры жесткости и затухания для реалистичной пружинной анимации.",
                        explanationEN: "SpringKeyframe calculates realistic physical damping and oscillation at that timeline waypoint."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_scrollview_enhancements",
                category: .swiftuiLayout,
                titleRU: "Продвинутый ScrollView в iOS 17+: ScrollTarget & Transitions",
                titleEN: "Advanced ScrollView: ScrollTargets & Transitions",
                summaryRU: "Программный скролл scrollPosition, привязка к элементам scrollTargetBehavior, пейджинг и 3D-переходы.",
                summaryEN: "Programmatic scrollPosition, view-aligned paging, and visual scrollTransitions.",
                contentMarkdownRU: ##"""
### Программная прокрутка через `scrollPosition` (iOS 17+)

Больше не нужно использовать `ScrollViewReader` и прокси! В iOS 17 позиция скролла привязывается напрямую к `@State`:

```swift
@State private var scrolledID: Int? = 5

ScrollView {
    LazyVStack {
        ForEach(1...50, id: \.self) { i in
            Text("Элемент \(i)").id(i)
        }
    }
}
.scrollPosition(id: $scrolledID)
```

---

### Привязка и Пейджинг (`scrollTargetBehavior`)
- `.scrollTargetBehavior(.paging)` — постраничный скролл.
- `.scrollTargetBehavior(.viewAligned)` — автоматическая центровка на ячейке.

---

### Эффекты переходов: `.scrollTransition`
Позволяет анимировать элементы прямо во время прокрутки в зависимости от их видимости:
```swift
.scrollTransition { content, phase in
    content
        .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
        .opacity(phase.isIdentity ? 1.0 : 0.5)
}
```
"""##,
                contentMarkdownEN: ##"""
### Modern ScrollView Features in iOS 17
- Direct binding to position via `.scrollPosition(id:)`.
- View-aligned paging with `.scrollTargetBehavior(.viewAligned)`.
- Fluid animations with `.scrollTransition`.
"""##,
                codeSnippet: ##"""
import SwiftUI

struct PagingCarouselDemo: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(1...10, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.blue.gradient)
                        .frame(width: 280, height: 180)
                        .overlay(Text("Карточка #\(index)").foregroundColor(.white).font(.title.bold()))
                        .scrollTransition { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.85)
                                .opacity(phase.isIdentity ? 1.0 : 0.6)
                        }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что означает phase.isIdentity внутри замыкания модификатора .scrollTransition?",
                        questionEN: "What does phase.isIdentity signify inside .scrollTransition?",
                        optionsRU: [
                            "Элемент находится полностью в центре/фокусе области видимости скролла",
                            "Элемент полностью скрыт за границей экрана",
                            "Скролл сейчас заблокирован",
                            "Пользователь нажал на элемент"
                        ],
                        optionsEN: [
                            "The item is resting fully within the active viewport region",
                            "The item is completely scrolled off-screen",
                            "Scrolling is currently locked",
                            "The user tapped on the element"
                        ],
                        correctIndex: 0,
                        explanationRU: "phase.isIdentity означает исходное неискаженное состояние ячейки, когда она полностью видима.",
                        explanationEN: "phase.isIdentity indicates the resting identity state when the view occupies the primary viewport focal area."
                    ),
                    QuizQuestion(
                        questionRU: "Какой модификатор необходимо применить к контейнеру LazyHStack, чтобы работала привязка .scrollTargetBehavior(.viewAligned)?",
                        questionEN: "Which modifier must be attached to the inner stack for view-aligned scroll snapping to work?",
                        optionsRU: [
                            ".scrollTargetLayout()",
                            ".snapItems()",
                            ".enablePaging()",
                            ".alignAll()"
                        ],
                        optionsEN: [
                            ".scrollTargetLayout()",
                            ".snapItems()",
                            ".enablePaging()",
                            ".alignAll()"
                        ],
                        correctIndex: 0,
                        explanationRU: ".scrollTargetLayout() сообщает ScrollView, что дочерние элементы этого стека являются целями для привязки.",
                        explanationEN: ".scrollTargetLayout() flags the contained subviews as discrete snap targets for the parent scroll container."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_searchable_and_filtering",
                category: .swiftuiCollections,
                titleRU: "Системный Поиск: .searchable и Scopes",
                titleEN: "System Search: .searchable & Scopes",
                summaryRU: "Полнофункциональная поисковая строка, области фильтрации searchScopes, подсказки и мгновенный поиск.",
                summaryEN: "Native search fields, category scopes, autocomplete suggestions, and instant filtering.",
                contentMarkdownRU: ##"""
### Модификатор `.searchable`

Встраивает нативную поисковую строку iOS прямо в верхнюю панель навигации:
```swift
NavigationStack {
    List(filteredUsers) { user in
        Text(user.name)
    }
    .navigationTitle("Пользователи")
    .searchable(text: $searchQuery, prompt: "Поиск по имени...")
}
```

---

### Области поиска (`.searchScopes`)

Позволяет пользователю быстро переключаться между фильтрами прямо внутри строки поиска:
```swift
enum Scope: String, CaseIterable {
    case all = "Все"
    case active = "Активные"
    case archived = "Архив"
}

@State private var selectedScope: Scope = .all

.searchScopes($selectedScope) {
    ForEach(Scope.allCases, id: \.self) { scope in
        Text(scope.rawValue).tag(scope)
    }
}
```
"""##,
                contentMarkdownEN: ##"""
### Search Architecture in SwiftUI
- `.searchable`: Embeds native iOS search bar in navigation headers.
- `.searchScopes`: Category segmented filters inside the search interface.
"""##,
                codeSnippet: ##"""
import SwiftUI

struct SearchDemoView: View {
    @State private var query = ""
    let items = ["Swift 6", "SwiftUI", "Xcode 16", "VisionOS", "Concurrency"]
    
    var filteredItems: [String] {
        if query.isEmpty { return items }
        return items.filter { $0.localizedCaseInsensitiveContains(query) }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredItems, id: \.self) { item in
                Text(item)
            }
            .navigationTitle("Технологии")
            .searchable(text: $query, prompt: "Поиск...")
        }
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Где по умолчанию размещается поисковая строка при вызове .searchable внутри NavigationStack?",
                        questionEN: "Where is the search bar positioned by default when using .searchable inside a NavigationStack?",
                        optionsRU: [
                            "Непосредственно под заголовком навигационной панели",
                            "В нижней панели TabBar",
                            "Поверх экрана модальным окном",
                            "В самом низу списка"
                        ],
                        optionsEN: [
                            "Directly beneath the navigation bar title",
                            "Inside the bottom TabBar",
                            "As a modal overlay",
                            "At the footer of the List"
                        ],
                        correctIndex: 0,
                        explanationRU: "В iOS поисковая строка нативно интегрируется в UINavigationBar и может скрываться при прокрутке.",
                        explanationEN: "On iOS, .searchable integrates seamlessly into the navigation header bar and collapses during scroll."
                    ),
                    QuizQuestion(
                        questionRU: "Какой метод строки безопасен для поиска с игнорированием регистра букв?",
                        questionEN: "Which String method is best suited for case-insensitive substring search in Swift?",
                        optionsRU: [
                            "localizedCaseInsensitiveContains",
                            "containsLowercase",
                            "findSubstring",
                            "hasMatchingCharacters"
                        ],
                        optionsEN: [
                            "localizedCaseInsensitiveContains",
                            "containsLowercase",
                            "findSubstring",
                            "hasMatchingCharacters"
                        ],
                        correctIndex: 0,
                        explanationRU: "localizedCaseInsensitiveContains учитывает регистр и языковые особенности локали пользователя.",
                        explanationEN: "localizedCaseInsensitiveContains accurately handles Unicode case folding and locale specific sorting."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_localization_and_dynamic_type",
                category: .swiftuiModifiers,
                titleRU: "Интернационализация, Pluralization и Dynamic Type",
                titleEN: "Localization, Pluralization & Dynamic Type",
                summaryRU: "Каталоги строк (.xcstrings), поддержка множественных чисел, адаптация под крупные шрифты доступности и RTL.",
                summaryEN: "String Catalogs (.xcstrings), pluralization rules, accessibility fonts, and RTL layouts.",
                contentMarkdownRU: ##"""
### Строковые каталоги (`String Catalogs`)

В современных проектах Xcode все тексты хранятся в файлах `.xcstrings`. Они автоматически находят все строки `Text("Hello")` в коде и поддерживают склонения:

```swift
Text("^[\(taskCount) задача](inflect: true)")
```
Система автоматически подставит:
- `1 задача`
- `2 задачи`
- `5 задач`

---

### Поддержка письма справа налево (RTL)

При переключении на языки с письмом справа налево (арабский, иврит) SwiftUI **автоматически отзеркаливает интерфейс**:
- `HStack` начинает раскладывать элементы справа налево.
- Отступы `leading` становятся справа, а `trailing` — слева.
"""##,
                contentMarkdownEN: ##"""
### Modern Localization with String Catalogs
Automatic extraction, pluralization syntax, and native Right-To-Left (RTL) mirroring.
"""##,
                codeSnippet: ##"""
import SwiftUI

struct LocalizedCounterDemo: View {
    @State private var count = 5
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Решено задач: \(count)")
                .font(.headline)
            
            Button("Добавить задачу") {
                count += 1
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что происходит со стеком HStack при переключении языка устройства на арабский (RTL)?",
                        questionEN: "What happens to HStack layout when the device locale switches to Arabic (RTL)?",
                        optionsRU: [
                            "SwiftUI автоматически меняет направление раскладки справа налево",
                            "Интерфейс не меняется, только текст становится арабским",
                            "Приложение падает с ошибкой LayoutError",
                            "HStack превращается в VStack"
                        ],
                        optionsEN: [
                            "SwiftUI automatically mirrors the layout direction from right to left",
                            "Layout remains unchanged, only text changes",
                            "App crashes with LayoutError",
                            "HStack converts to VStack"
                        ],
                        correctIndex: 0,
                        explanationRU: "В SwiftUI понятия leading и trailing автоматически адаптируются к направлению чтения языка.",
                        explanationEN: "SwiftUI treats leading and trailing as relative directional vectors, automatically flipping layouts for RTL locales."
                    ),
                    QuizQuestion(
                        questionRU: "Какой современный формат файлов используется в Xcode для централизованного перевода строк?",
                        questionEN: "Which modern file format is used in Xcode for centralized string translations?",
                        optionsRU: [
                            "String Catalog (.xcstrings)",
                            "Strings File (.strings)",
                            "JSON (.json)",
                            "XML (.xml)"
                        ],
                        optionsEN: [
                            "String Catalog (.xcstrings)",
                            "Strings File (.strings)",
                            "JSON (.json)",
                            "XML (.xml)"
                        ],
                        correctIndex: 0,
                        explanationRU: "Формат .xcstrings заменяет старые .strings файлы, объединяя все языки и плюрализацию в один файл.",
                        explanationEN: "The .xcstrings format unifies multi-language translations and pluralization grammar into a single interactive editor."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_performance_optimization",
                category: .swiftuiNavigation,
                titleRU: "Оптимизация Производительности: Render Graph и Рефакторинг",
                titleEN: "Performance Optimization & Render Graph",
                summaryRU: "Граф зависимостей SwiftUI, отладка через Self._printChanges(), правила разделения View и устранение зависаний.",
                summaryEN: "SwiftUI dependency graph, profiling with Self._printChanges(), view breakdown rules, and 120 FPS tuning.",
                contentMarkdownRU: ##"""
### Как работает Render Graph в SwiftUI

SwiftUI — это не просто обертка над UIKit. Под капотом работает **Граф Зависимостей (Attribute Graph)**. Когда состояние изменяется, SwiftUI сверяет старые структуры View с новыми по значению (Value Semantics). 

Если свойства структуры не изменились, `body` этого поддерева **не вызывается повторно**!

---

### Секретный инструмент: `Self._printChanges()`

Вставьте вызов прямо в тело `body`, чтобы увидеть в консоли точную причину перерисовки:
```swift
var body: some View {
    let _ = Self._printChanges()
    VStack { ... }
}
```
В консоли отобразится: `@self, @identity, _userState changed`.

---

### Главные правила высокой производительности
1. **Дробите монолитные View:** одна гигантская структура View на 400 строк будет перерисовываться целиком при изменении любого внутреннего свойства. Разбейте ее на 5 маленьких структур.
2. **Никаких тяжелых расчетов в `body`:** `body` может вызываться 120 раз в секунду. Сортировки и фильтрации делайте заранее в моделях.
"""##,
                contentMarkdownEN: ##"""
### The Attribute Graph
SwiftUI compares view structs by value. Unchanged branches are skipped during render passes.

### Profiling with `Self._printChanges()`
Use `Self._printChanges()` inside `body` to pinpoint the exact dependency causing re-evaluation.
"""##,
                codeSnippet: ##"""
import SwiftUI

struct OptimizedRow: View, Equatable {
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack {
            Text(title).font(.headline)
            Spacer()
            Text(subtitle).foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какая встроенная команда выводит в консоль причину перерисовки представления в SwiftUI?",
                        questionEN: "Which built-in command logs the exact cause of a view re-render to the Xcode console?",
                        optionsRU: [
                            "Self._printChanges()",
                            "SwiftUI.debugRender()",
                            "print(self.changedProperties)",
                            "ViewDebugger.inspect()"
                        ],
                        optionsEN: [
                            "Self._printChanges()",
                            "SwiftUI.debugRender()",
                            "print(self.changedProperties)",
                            "ViewDebugger.inspect()"
                        ],
                        correctIndex: 0,
                        explanationRU: "Self._printChanges() — это официальный инструмент отладки графа зависимостей от инженеров Apple.",
                        explanationEN: "Self._printChanges() is Apple's diagnostic utility that inspects the Attribute Graph and prints mutated inputs."
                    ),
                    QuizQuestion(
                        questionRU: "Почему разбиение монолитного View на маленькие структуры struct улучшает производительность?",
                        questionEN: "Why does decomposing large monolithic views into smaller structs improve rendering speed?",
                        optionsRU: [
                            "SwiftUI сравнивает структуры по значению и пропускает вызов body тех веток, свойства которых не менялись",
                            "Маленькие структуры компилируются в ассемблер быстрее",
                            "В SwiftUI действует лимит в 10 модификаторов на View",
                            "Это просто стилистическая рекомендация"
                        ],
                        optionsEN: [
                            "SwiftUI diffs small structs by value and skips body evaluation for unchanged branches",
                            "Small structs compile to assembly faster",
                            "There is an artificial 10-modifier limit per view",
                            "It is merely a stylistic preference"
                        ],
                        correctIndex: 0,
                        explanationRU: "Изолированные маленькие View локализуют перерисовки, не заставляя весь экран пересчитываться заново.",
                        explanationEN: "Smaller structs establish narrower dependency scopes, allowing the runtime to prune evaluation for untouched subviews."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_architecture_clean_code",
                category: .swiftuiNavigation,
                titleRU: "Архитектура Приложений: MVVM vs Clean State",
                titleEN: "App Architecture: MVVM vs Clean State",
                summaryRU: "Организация кода в современных iOS-приложениях: макрос @Observable, сервисный слой, Dependency Injection и UDF.",
                summaryEN: "Structuring modern iOS applications: @Observable macro, state flows, dependency injection, and clean architecture.",
                contentMarkdownRU: ##"""
### Эволюция архитектуры в SwiftUI

В первые годы SwiftUI разработчики слепо копировали классический MVVM из UIKit. Но в современных версиях с макросом `@Observable` (iOS 17+) архитектура стала намного чище:

- **State-Driven Views:** простые экраны не требуют отдельного файла ViewModel. Достаточно легковесного `@State`.
- **Domain ViewModel:** для экранов со сложной бизнес-логикой создается класс с макросом `@Observable`.

---

### Однонаправленный поток данных (UDF)

1. **View** отображает текущее состояние `State`.
2. Пользователь совершает действие (`Intent` / `Action`).
3. **Модель или Сервис** асинхронно обрабатывает действие и мутирует `State`.
4. **View** автоматически обновляется.
"""##,
                contentMarkdownEN: ##"""
### Modern Architecture with `@Observable`
- Keep presentation state close to views.
- Isolate business logic into domain services and repositories.
- Enforce Unidirectional Data Flow (State -> Action -> Mutation -> Render).
"""##,
                codeSnippet: ##"""
import SwiftUI
import Observation

@Observable
final class ProfileViewModel {
    var username = "alex_ios"
    var isSaving = false
    
    func saveProfile() async {
        isSaving = true
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        isSaving = false
    }
}

struct ProfileFeatureView: View {
    @State private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Имя", text: $viewModel.username)
                .textFieldStyle(.roundedBorder)
            
            Button("Сохранить") {
                Task { await viewModel.saveProfile() }
            }
            .disabled(viewModel.isSaving)
        }
        .padding()
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "В чем главное архитектурное преимущество макроса @Observable перед ObservableObject?",
                        questionEN: "What is the primary architectural advantage of the @Observable macro over ObservableObject?",
                        optionsRU: [
                            "View наблюдает за каждым свойством точечно и не перерисовывается при изменении неиспользуемых полей",
                            "@Observable работает без сборщика мусора",
                            "@Observable автоматически сохраняет данные в iCloud",
                            "@Observable требует писать objectWillChange.send()"
                        ],
                        optionsEN: [
                            "Views subscribe granularly to individual property accesses, avoiding renders on unused field mutations",
                            "@Observable operates without ARC memory management",
                            "@Observable synchronizes data with iCloud automatically",
                            "It requires manual objectWillChange.send() calls"
                        ],
                        correctIndex: 0,
                        explanationRU: "В отличие от ObservableObject, вызывающего перерисовку при изменении любого @Published поля, @Observable отслеживает только реально прочитанные свойства.",
                        explanationEN: "@Observable establishes field-level property tracking, eliminating unnecessary redraws triggered by unused properties."
                    ),
                    QuizQuestion(
                        questionRU: "Что такое однонаправленный поток данных (Unidirectional Data Flow)?",
                        questionEN: "What defines Unidirectional Data Flow (UDF)?",
                        optionsRU: [
                            "Данные движутся по замкнутому одностороннему циклу: State -> View -> Action -> State",
                            "Все данные отправляются только на сервер",
                            "Пользователь не может вводить данные с клавиатуры",
                            "Код пишется в один файл"
                        ],
                        optionsEN: [
                            "Data flows strictly in a single circular direction: State -> View -> Action -> State",
                            "All data is pushed exclusively to network sockets",
                            "User input is disabled",
                            "All code is placed in a single monolithic file"
                        ],
                        correctIndex: 0,
                        explanationRU: "UDF предотвращает хаотичное изменение данных из разных мест и делает поведение приложения предсказуемым.",
                        explanationEN: "UDF guarantees single-source-of-truth reliability by channeling mutations through a structured state cycle."
                    )
                ]
            ),

            Lesson(
                id: "swiftui_production_app_structure",
                category: .swiftuiNavigation,
                titleRU: "Архитектура Production Приложения: @main, Scene и Deep Links",
                titleEN: "Production App Architecture: @main, Scene & Deep Links",
                summaryRU: "Точка входа @main struct App, WindowGroup, ScenePhase, обработка Deep Links через onOpenURL и Splash Screen.",
                summaryEN: "Production entry points, WindowGroup, Deep Link handling with onOpenURL, and lifecycle architecture.",
                contentMarkdownRU: ##"""
### Точка входа `@main`

Каждое приложение на SwiftUI начинается со структуры, реализующей протокол `App`:
```swift
@main
struct ProductionApp: App {
    @StateObject private var storage = StorageService.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    handleIncomingDeepLink(url)
                }
        }
    }
}
```

---

### Обработка Deep Links (`.onOpenURL`)

Когда пользователь нажимает на ссылку в браузере или мессенджере (например `swiftlearn://challenge/expert_rate_limiter`), система передает `URL` в замыкание `.onOpenURL`:
```swift
.onOpenURL { url in
    guard url.scheme == "swiftlearn" else { return }
    let host = url.host // "challenge"
    let id = url.path.trimmingCharacters(in: ["/"])
    router.openChallenge(id: id)
}
```
"""##,
                contentMarkdownEN: ##"""
### Production Entry Point
`@main struct App` declares the top-level scene root.
Handle custom URL schemes and Universal Links with `.onOpenURL`.
"""##,
                codeSnippet: ##"""
import SwiftUI

@main
struct CleanAppTemplate: App {
    init() {
        print("Приложение запущено: инициализация кэша и сервисов")
    }
    
    var body: some Scene {
        WindowGroup {
            Text("Добро пожаловать в Swift 6!")
                .onOpenURL { url in
                    print("Получен Deep Link: \(url)")
                }
        }
    }
}
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какой атрибут указывает компилятору точку входа в приложение SwiftUI?",
                        questionEN: "Which attribute designates the main entry point in a SwiftUI executable?",
                        optionsRU: [
                            "@main",
                            "@entry",
                            "@appDelegate",
                            "@start"
                        ],
                        optionsEN: [
                            "@main",
                            "@entry",
                            "@appDelegate",
                            "@start"
                        ],
                        correctIndex: 0,
                        explanationRU: "Атрибут @main указывает компилятору Swift, какая структура является точкой входа программы.",
                        explanationEN: "The @main attribute designates the top-level entry point function synthesizing main()."
                    ),
                    QuizQuestion(
                        questionRU: "Какой модификатор используется для обработки входящих Deep Links и Universal Links?",
                        questionEN: "Which modifier handles incoming Deep Links and Universal Links?",
                        optionsRU: [
                            ".onOpenURL { url in }",
                            ".handleLink { link in }",
                            ".deepLinkReceiver { }",
                            ".onReceiveNetworkURL { }"
                        ],
                        optionsEN: [
                            ".onOpenURL { url in }",
                            ".handleLink { link in }",
                            ".deepLinkReceiver { }",
                            ".onReceiveNetworkURL { }"
                        ],
                        correctIndex: 0,
                        explanationRU: "Модификатор .onOpenURL перехватывает любые URL, переданные приложению операционной системой iOS.",
                        explanationEN: "The .onOpenURL modifier registers a callback when the application receives a custom scheme or Universal Link."
                    )
                ]
            )
,

            // ==========================================
            // PYTHON CORE & ADVANCED CURRICULUM
            // ==========================================
            Lesson(
                id: "py_syntax_pep8",
                category: .pythonBasics,
                titleRU: "Синтаксис Python 3.12, Отступы и PEP 8",
                titleEN: "Python 3.12 Syntax, Indentation & PEP 8",
                summaryRU: "Фундамент языка Python: отступы как семантика блоков кода, комментарии, стиль PEP 8 и функция print().",
                summaryEN: "Python foundations: indentation-based blocks, comments, PEP 8 standards, and the print() function.",
                contentMarkdownRU: ##"""
### Философия Python и Отступы (PEP 8)
В Python отступы (ровно 4 пробела) определяют структуру вложенности кода, заменяя фигурные скобки `{ }` из C/Swift:

```python
age = 20
if age >= 18:
    print("Совершеннолетний")
    print("Доступ разрешен")
```

### Динамическая типизация
Переменная — это метка-указатель на объект в динамической памяти:
```python
x = 42         # int
x = "Python"   # теперь str
print(type(x)) # <class 'str'>
```
"""##,
                contentMarkdownEN: ##"""
### Python Philosophy & Indentation
Python uses 4-space indentation for code blocks instead of curly braces:
```python
if True:
    print("Hello, Python 3.12!")
```
"""##,
                codeSnippet: ##"""
# Приветствие в Python
user_name = "Александр"
print(f"Добро пожаловать в Python 3.12, {user_name}!")
"""##,
                xpReward: 30
            ),
            Lesson(
                id: "py_numbers_math",
                category: .pythonBasics,
                titleRU: "Числа, Деление //, Степень ** и модуль math",
                titleEN: "Numbers, Integer Division, Power & math",
                summaryRU: "Целые числа int произвольной точности, вещественные float, целочисленное деление //, остаток % и возведение в степень **.",
                summaryEN: "Arbitrary precision integers, IEEE-754 floats, integer division //, modulo %, and power **.",
                contentMarkdownRU: ##"""
### Арифметика в Python
- Обычное деление `/` всегда возвращает `float` (даже `4 / 2 == 2.0`).
- Целочисленное деление `//` отбрасывает дробную часть.
- Оператор `%` вычисляет остаток от деления.
- Оператор `**` возводит в степень: `2 ** 10 == 1024`.

```python
x = 17 // 3  # 5
rem = 17 % 3 # 2
sq = 5 ** 2  # 25
```
"""##,
                contentMarkdownEN: ##"""
### Python Arithmetic Operators
Division `/` always returns a float. Floor division `//` discards the fractional part.
"""##,
                codeSnippet: ##"""
# Вычисление гипотенузы
a, b = 3, 4
c = (a**2 + b**2) ** 0.5
print(f"Гипотенуза треугольника со сторонами {a} и {b} равна {c}")
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_strings_fstrings",
                category: .pythonBasics,
                titleRU: "Строки, Срезы [::] и f-strings",
                titleEN: "Strings, Slicing [::] & f-strings",
                summaryRU: "Неизменяемые строки str: форматирование f-строк, методы split/join/strip и срезы [start:stop:step].",
                summaryEN: "Immutable str objects: modern f-strings, split/join/strip methods, and [start:stop:step] slicing.",
                contentMarkdownRU: ##"""
### Срезы строк (Slicing)
Синтаксис среза: `string[start:stop:step]`
```python
s = "Python3"
print(s[0:2])   # "Py"
print(s[::-1])  # "3nohtyP" (разворот строки)
```

### f-строки (PEP 498)
```python
name = "Alice"
score = 98.456
print(f"Студент {name}: {score:.2f} баллов")
```
"""##,
                contentMarkdownEN: ##"""
### Slicing & f-strings
Extract substrings cleanly with slicing syntax `[start:stop:step]`.
"""##,
                codeSnippet: ##"""
text = "hello world"
reversed_text = text[::-1]
print(f"Оригинал: {text} | Разворот: {reversed_text}")
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_booleans_truthiness",
                category: .pythonBasics,
                titleRU: "Булева Логика, and/or/not и Truthiness",
                titleEN: "Boolean Logic, and/or/not & Truthiness",
                summaryRU: "Тип bool (True/False), логические связки and, or, not, и концепция 'истинности' пустых объектов.",
                summaryEN: "bool types, short-circuit evaluation with and/or/not, and object truthiness.",
                contentMarkdownRU: ##"""
### Truthiness в Python
В Python любые пустые коллекции (`[]`, `{}`, `set()`, `""`), число `0`, `0.0` и значение `None` считаются ложными (`False`) в логическом контексте:

```python
items = []
if not items:
    print("Список пуст!")
```
"""##,
                contentMarkdownEN: ##"""
### Truth Value Testing
Empty sequences and numbers equal to zero evaluate to False in boolean contexts.
"""##,
                codeSnippet: ##"""
val = ""
if not val:
    print("Строка пустая (Falsy)")
else:
    print("Строка заполнена (Truthy)")
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_control_if_elif",
                category: .pythonControlFlow,
                titleRU: "Ветвление if, elif, else и Тернарный Оператор",
                titleEN: "Conditionals: if, elif, else & Ternary",
                summaryRU: "Множественные условия с elif, вложенные проверки и компактный тернарный оператор x if cond else y.",
                summaryEN: "Chained conditionals with elif and one-line ternary expressions x if cond else y.",
                contentMarkdownRU: ##"""
### Синтаксис if-elif-else
```python
score = 85
if score >= 90:
    grade = "A"
elif score >= 80:
    grade = "B"
else:
    grade = "C"
```

### Тернарный оператор
```python
status = "Взрослый" if age >= 18 else "Несовершеннолетний"
```
"""##,
                contentMarkdownEN: ##"""
### Conditional Branching
Use `if`, `elif`, and `else` to control program execution flow.
"""##,
                codeSnippet: ##"""
age = 22
status = "Доступ разрешен" if age >= 18 else "Отказ"
print(status)
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_loops_while_for",
                category: .pythonControlFlow,
                titleRU: "Циклы while, for .. in, range и enumerate",
                titleEN: "Loops: while, for .. in, range & enumerate",
                summaryRU: "Итерация по последовательностям: генератор диапазона range, счетчик enumerate, параллельный обход zip и break/continue.",
                summaryEN: "Iteration patterns: range(), enumerate() indexing, zip() pairing, and loop control.",
                contentMarkdownRU: ##"""
### range и enumerate
```python
# Итерация с индексом
fruits = ["яблоко", "банан", "груша"]
for idx, fruit in enumerate(fruits, start=1):
    print(f"{idx}: {fruit}")
```

### zip для параллельного обхода
```python
names = ["Аня", "Борис"]
ages = [25, 30]
for name, age in zip(names, ages):
    print(f"{name} -> {age}")
```
"""##,
                contentMarkdownEN: ##"""
### Iterating Sequences
Use `range()` for counting and `enumerate()` for index-value pairs.
"""##,
                codeSnippet: ##"""
total = 0
for i in range(1, 11):
    total += i
print(f"Сумма чисел от 1 до 10: {total}")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_match_case_patterns",
                category: .pythonControlFlow,
                titleRU: "Сопоставление с Образцом match .. case",
                titleEN: "Pattern Matching: match .. case",
                summaryRU: "Структурное сопоставление с образцом (Structural Pattern Matching, Python 3.10+): деструктуризация, guards и wildcard _.",
                summaryEN: "Python 3.10+ pattern matching: sequence destructuring, guards, and wildcard handling.",
                contentMarkdownRU: ##"""
### Структурный match .. case
```python
command = ["move", 10, 20]
match command:
    case ["move", x, y]:
        print(f"Перемещение в ({x}, {y})")
    case ["quit"]:
        print("Выход")
    case _:
        print("Неизвестная команда")
```
"""##,
                contentMarkdownEN: ##"""
### Structural Pattern Matching
Python 3.10 introduced `match` / `case` for expressive branching.
"""##,
                codeSnippet: ##"""
code = 200
match code:
    case 200:
        print("OK: Успех")
    case 404:
        print("Not Found: Не найдено")
    case _:
        print("Другой статус")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_lists_methods",
                category: .pythonCollections,
                titleRU: "Динамические Списки (list): Методы и Срезы",
                titleEN: "Lists (list): Methods, Mutability & Slicing",
                summaryRU: "Главная коллекция Python: append, extend, pop, insert, remove, inplace-сортировка sort() и функция sorted().",
                summaryEN: "Mutable list sequences: append, extend, pop, insert, sorting, and slicing semantics.",
                contentMarkdownRU: ##"""
### Операции со списками
```python
nums = [3, 1, 4, 1, 5]
nums.append(9)       # Добавление в конец
nums.pop()           # Удаление с конца
nums.sort()          # Сортировка на месте
print(nums)
```
"""##,
                contentMarkdownEN: ##"""
### Working with Lists
Lists are ordered, mutable collections of arbitrary objects.
"""##,
                codeSnippet: ##"""
numbers = [10, 50, 20, 40, 30]
numbers.sort()
print(f"Отсортированный список: {numbers}")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_tuples_unpacking",
                category: .pythonCollections,
                titleRU: "Кортежи (tuple) и Распаковка Переменных",
                titleEN: "Tuples (tuple) & Star Unpacking",
                summaryRU: "Неизменяемые кортежи tuple, защита данных от мутаций, использование как ключей словарей и расширенная распаковка *rest.",
                summaryEN: "Immutable tuples, dictionary key validity, and extended star unpacking syntax a, *rest, b = tuple.",
                contentMarkdownRU: ##"""
### Кортежи и Распаковка
```python
point = (10, 20, 30, 40)
first, *middle, last = point
# first = 10, middle = [20, 30], last = 40
```
"""##,
                contentMarkdownEN: ##"""
### Tuples & Unpacking
Tuples are immutable sequences often used for fixed records and multiple return values.
"""##,
                codeSnippet: ##"""
data = ("Сергей", 28, "Москва")
name, age, city = data
print(f"Имя: {name}, Возраст: {age}, Город: {city}")
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_dicts_hashmaps",
                category: .pythonCollections,
                titleRU: "Словари (dict): Хэш-таблицы и Поиск O(1)",
                titleEN: "Dictionaries (dict): Hash Maps & O(1) Lookup",
                summaryRU: "Ассоциативные массивы ключ-значение: метод .get() с дефолтом, обход keys(), values(), items() и объединение словарей через |.",
                summaryEN: "Fast hash tables: safe access with .get(), key-value iterations, and dictionary union with |.",
                contentMarkdownRU: ##"""
### Словари в Python
```python
user = {"name": "Иван", "role": "admin"}
# Безопасное чтение
email = user.get("email", "unknown@domain.com")

# Обход пар
for key, val in user.items():
    print(f"{key} -> {val}")
```
"""##,
                contentMarkdownEN: ##"""
### Python Dictionaries
Fast key-value mappings powered by optimized hash tables.
"""##,
                codeSnippet: ##"""
capitals = {"Россия": "Москва", "Франция": "Париж", "Япония": "Токио"}
print(f"Столица Франции: {capitals.get('Франция')}")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_sets_unique",
                category: .pythonCollections,
                titleRU: "Множества (set): Уникальность и Теория Множеств",
                titleEN: "Sets (set): Uniqueness & Math Operations",
                summaryRU: "Коллекции уникальных хэшируемых элементов: объединение |, пересечение &, разность - и быстрая проверка in за O(1).",
                summaryEN: "Unique collections: mathematical unions |, intersections &, differences -, and O(1) membership testing.",
                contentMarkdownRU: ##"""
### Операции над множествами
```python
a = {1, 2, 3, 4}
b = {3, 4, 5, 6}
print(a | b) # Объединение: {1, 2, 3, 4, 5, 6}
print(a & b) # Пересечение: {3, 4}
print(a - b) # Разность: {1, 2}
```
"""##,
                contentMarkdownEN: ##"""
### Mathematical Sets
Sets contain unique elements and support rapid membership checks.
"""##,
                codeSnippet: ##"""
raw_tags = ["swift", "python", "swift", "csharp", "python"]
unique_tags = list(set(raw_tags))
print(f"Уникальные теги: {unique_tags}")
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_comprehensions_power",
                category: .pythonCollections,
                titleRU: "List, Dict & Set Comprehensions",
                titleEN: "List, Dict & Set Comprehensions",
                summaryRU: "Идиоматичный лаконичный синтаксис создания коллекций: фильтрация if, вложенные генераторы и оптимизация скорости CPython.",
                summaryEN: "Declarative collection construction with list, dictionary, and set comprehensions.",
                contentMarkdownRU: ##"""
### Comprehensions в действии
```python
# List comprehension
squares = [x**2 for x in range(10) if x % 2 == 0]

# Dict comprehension
word_lens = {w: len(w) for w in ["apple", "banana", "kiwi"]}
```
"""##,
                contentMarkdownEN: ##"""
### Expressive Comprehensions
Build transformed and filtered collections in a single concise line.
"""##,
                codeSnippet: ##"""
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
even_squares = [n**2 for n in numbers if n % 2 == 0]
print(f"Квадраты четных: {even_squares}")
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_functions_defaults",
                category: .pythonFunctions,
                titleRU: "Функции: Аргументы по Умолчанию и Возврат",
                titleEN: "Functions: Default Arguments & Return",
                summaryRU: "Объявление def, позиционные и именованные аргументы, ловушка изменяемых значений по умолчанию (mutable default argument trap).",
                summaryEN: "Function definitions: positional vs keyword arguments and avoiding the mutable default trap.",
                contentMarkdownRU: ##"""
### Аргументы по умолчанию
> Осторожно: никогда не используйте изменяемые типы (`[]`, `{}`) как значения по умолчанию! Используйте `None`:

```python
def add_item(item, target_list=None):
    if target_list is None:
        target_list = []
    target_list.append(item)
    return target_list
```
"""##,
                contentMarkdownEN: ##"""
### Functions & Defaults
Define functions with `def` and supply sensible default parameters.
"""##,
                codeSnippet: ##"""
def greet(name, prefix="Привет"):
    return f"{prefix}, {name}!"

print(greet("Дмитрий"))
print(greet("Алексей", prefix="Здравствуйте"))
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_args_kwargs_unpack",
                category: .pythonFunctions,
                titleRU: "Вариативные Аргументы: *args и **kwargs",
                titleEN: "Arbitrary Arguments: *args & **kwargs",
                summaryRU: "Упаковка позиционных аргументов в tuple (*args) и именованных в dict (**kwargs), проброс аргументов в другие функции.",
                summaryEN: "Packing variable positional arguments into *args and keyword arguments into **kwargs.",
                contentMarkdownRU: ##"""
### *args и **kwargs
```python
def make_request(url, *params, **headers):
    print(f"URL: {url}")
    print(f"Позиционные параметры: {params}")
    print(f"Заголовки: {headers}")
```
"""##,
                contentMarkdownEN: ##"""
### Variable Arguments
Use `*args` to accept any number of positional arguments and `**kwargs` for keywords.
"""##,
                codeSnippet: ##"""
def calculate_sum(*numbers):
    return sum(numbers)

print(f"Сумма: {calculate_sum(10, 20, 30, 40)}")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_lambda_scopes",
                category: .pythonFunctions,
                titleRU: "Лямбда-функции, Замыкания и Области Видимости",
                titleEN: "Lambdas, Closures, global & nonlocal",
                summaryRU: "Анонимные однострочные функции lambda, захват контекста в замыканиях и управление переменными через nonlocal и global.",
                summaryEN: "Anonymous lambda expressions, lexical closures, and the nonlocal keyword.",
                contentMarkdownRU: ##"""
### Лямбды и Сортировка
```python
users = [("Иван", 25), ("Ольга", 21), ("Петр", 30)]
users.sort(key=lambda u: u[1]) # Сортировка по возрасту
```

### Замыкания (Closures)
```python
def make_multiplier(n):
    def multiplier(x):
        return x * n
    return multiplier

double = make_multiplier(2)
print(double(5)) # 10
```
"""##,
                contentMarkdownEN: ##"""
### Lambdas & Closures
Lightweight anonymous functions with `lambda` and state encapsulation via closures.
"""##,
                codeSnippet: ##"""
pairs = [(1, "b"), (2, "a"), (3, "c")]
sorted_pairs = sorted(pairs, key=lambda p: p[1])
print(f"Отсортировано по букве: {sorted_pairs}")
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_type_hints_typing",
                category: .pythonFunctions,
                titleRU: "Аннотации Типов: PEP 484 и модуль typing",
                titleEN: "Type Hints: PEP 484 & typing Module",
                summaryRU: "Современная статическая типизация: Optional, Union, List, Dict, Callable, статический анализ mypy и самодокументируемый код.",
                summaryEN: "Modern type hints: typing primitives, static type checking with mypy, and clean APIs.",
                contentMarkdownRU: ##"""
### Type Hints в Python 3.12
```python
def process_user(name: str, age: int | None = None) -> dict[str, str | int]:
    return {"name": name, "age": age if age is not None else 0}
```
"""##,
                contentMarkdownEN: ##"""
### Type Annotations
Clarify intent and enable IDE autocompletion with Python 3.12 type hints.
"""##,
                codeSnippet: ##"""
def add_tax(amount: float, tax_rate: float = 0.20) -> float:
    return amount * (1.0 + tax_rate)

print(f"Сумма с НДС: {add_tax(1000.0):.2f}")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_oop_classes_init",
                category: .pythonOOP,
                titleRU: "Классы, Экземпляры и Конструктор __init__",
                titleEN: "Classes, Instances & __init__ Constructor",
                summaryRU: "Объектная модель Python: определение class, ссылка self, инициализация атрибутов и инкапсуляция состояния.",
                summaryEN: "Object-oriented model: class definitions, self references, instance initialization in __init__.",
                contentMarkdownRU: ##"""
### Определение Класса
```python
class BankAccount:
    def __init__(self, owner: str, balance: float = 0.0):
        self.owner = owner
        self.balance = balance
        
    def deposit(self, amount: float):
        if amount > 0:
            self.balance += amount
```
"""##,
                contentMarkdownEN: ##"""
### Classes and Instances
Build stateful objects with attributes and bound methods.
"""##,
                codeSnippet: ##"""
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

p = Person("Елена", 24)
print(f"{p.name}, возраст: {p.age}")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_oop_encapsulation_prop",
                category: .pythonOOP,
                titleRU: "Инкапсуляция, Приватные Поля и @property",
                titleEN: "Encapsulation, Private Attributes & @property",
                summaryRU: "Конвенция _protected, сокрытие имен __private (name mangling), питонические геттеры и сеттеры через декоратор @property.",
                summaryEN: "Attributes privacy conventions, name mangling with double underscore, and @property getters/setters.",
                contentMarkdownRU: ##"""
### Свойства (@property)
```python
class Temperature:
    def __init__(self, celsius: float):
        self._celsius = celsius
        
    @property
    def fahrenheit(self) -> float:
        return (self._celsius * 9/5) + 32
        
    @fahrenheit.setter
    def fahrenheit(self, value: float):
        self._celsius = (value - 32) * 5/9
```
"""##,
                contentMarkdownEN: ##"""
### @property Decorator
Control attribute reading and writing without breaking backward compatibility.
"""##,
                codeSnippet: ##"""
class Rectangle:
    def __init__(self, w, h):
        self.w = w
        self.h = h
    @property
    def area(self):
        return self.w * self.h

r = Rectangle(10, 5)
print(f"Площадь прямоугольника: {r.area}")
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_oop_classmethod_static",
                category: .pythonOOP,
                titleRU: "Методы Класса @classmethod и @staticmethod",
                titleEN: "Class Methods @classmethod & @staticmethod",
                summaryRU: "Альтернативные фабричные конструкторы через cls (@classmethod) и независимые утилиты без доступа к состоянию (@staticmethod).",
                summaryEN: "Alternative constructors with @classmethod (cls) and utility functions with @staticmethod.",
                contentMarkdownRU: ##"""
### @classmethod как фабрика
```python
class Date:
    def __init__(self, year, month, day):
        self.year, self.month, self.day = year, month, day
        
    @classmethod
    def from_string(cls, date_str: str):
        y, m, d = map(int, date_str.split("-"))
        return cls(y, m, d)
```
"""##,
                contentMarkdownEN: ##"""
### Class and Static Methods
Differentiate between instance, class, and static methods.
"""##,
                codeSnippet: ##"""
class MathUtils:
    @staticmethod
    def is_even(num):
        return num % 2 == 0

print(f"Число 4 четное? {MathUtils.is_even(4)}")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_oop_inheritance_mro",
                category: .pythonOOP,
                titleRU: "Наследование, super() и Алгоритм MRO",
                titleEN: "Inheritance, super() & C3 MRO Algorithm",
                summaryRU: "Расширение поведения базовых классов, вызов super(), множественное наследование и порядок поиска методов (Method Resolution Order).",
                summaryEN: "Class inheritance hierarchies, super() resolution, and C3 Linearization (MRO).",
                contentMarkdownRU: ##"""
### super() и MRO
```python
class Animal:
    def speak(self):
        return "Звук"

class Dog(Animal):
    def speak(self):
        base = super().speak()
        return f"{base}: Гав!"

# Порядок поиска методов:
print(Dog.mro())
```
"""##,
                contentMarkdownEN: ##"""
### Inheritance & super()
Reuse code and extend behavior across hierarchical classes.
"""##,
                codeSnippet: ##"""
class Animal:
    def sound(self): return "..."

class Cat(Animal):
    def sound(self): return "Мяу"

print(Cat().sound())
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_oop_dataclasses_modern",
                category: .pythonOOP,
                titleRU: "Датаклассы (@dataclass) и Иммутабельность",
                titleEN: "Data Classes (@dataclass) & Immutability",
                summaryRU: "Модуль dataclasses (PEP 557): автоматическая генерация __init__, __repr__, __eq__, поддержка frozen=True и дефолтных значений.",
                summaryEN: "Modern dataclasses: boilerplate elimination, automatic equality/repr, and frozen immutability.",
                contentMarkdownRU: ##"""
### Датаклассы
```python
from dataclasses import dataclass

@dataclass(frozen=True)
class UserDTO:
    id: int
    name: str
    email: str
    is_active: bool = True
```
"""##,
                contentMarkdownEN: ##"""
### Data Classes
Eliminate boilerplate code when writing data holder objects.
"""##,
                codeSnippet: ##"""
class Point:
    def __init__(self, x, y):
        self.x, self.y = x, y
    def __repr__(self):
        return f"Point({self.x}, {self.y})"

print(Point(10, 20))
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_dunder_str_repr",
                category: .pythonDunder,
                titleRU: "Магические Методы: __str__ и __repr__",
                titleEN: "Dunder Methods: __str__ vs __repr__",
                summaryRU: "Два строковых представления: __repr__ для разработчиков (однозначный код) и __str__ для пользователя (читаемый текст).",
                summaryEN: "Readable user output with __str__ and unambiguous debug representation with __repr__.",
                contentMarkdownRU: ##"""
### __repr__ против __str__
```python
class Product:
    def __init__(self, title, price):
        self.title = title
        self.price = price
        
    def __repr__(self):
        return f"Product({self.title!r}, {self.price})"
        
    def __str__(self):
        return f"{self.title} за {self.price} руб."
```
"""##,
                contentMarkdownEN: ##"""
### String Representation
Implement `__repr__` for debugging and `__str__` for human-facing output.
"""##,
                codeSnippet: ##"""
class Item:
    def __init__(self, name): self.name = name
    def __str__(self): return f"Item: {self.name}"

print(str(Item('Книга')))
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_dunder_operators",
                category: .pythonDunder,
                titleRU: "Перегрузка Операторов: __add__, __eq__, __lt__",
                titleEN: "Operator Overloading: __add__, __eq__, __lt__",
                summaryRU: "Арифметические (+, -, *) и сравнительные (==, <, >) dunder-методы для интеграции пользовательских типов в синтаксис языка.",
                summaryEN: "Overloading math and comparison operators for intuitive custom object behavior.",
                contentMarkdownRU: ##"""
### Сложение объектов через __add__
```python
class Vector:
    def __init__(self, x, y):
        self.x, self.y = x, y
        
    def __add__(self, other):
        return Vector(self.x + other.x, self.y + other.y)
        
    def __eq__(self, other):
        return self.x == other.x and self.y == other.y
```
"""##,
                contentMarkdownEN: ##"""
### Custom Operators
Allow custom types to be added, compared, and sorted naturally.
"""##,
                codeSnippet: ##"""
class Number:
    def __init__(self, val): self.val = val
    def __add__(self, other): return Number(self.val + other.val)

n = Number(10) + Number(20)
print(f"Результат сложения: {n.val}")
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_dunder_container_proto",
                category: .pythonDunder,
                titleRU: "Протокол Контейнера: __len__ и __getitem__",
                titleEN: "Container Protocol: __len__ & __getitem__",
                summaryRU: "Создание собственных коллекций: поддержка len() через __len__, квадратных скобок obj[idx] через __getitem__ и срезов.",
                summaryEN: "Building custom collections implementing len() and indexing syntax obj[key].",
                contentMarkdownRU: ##"""
### Протокол последовательности
```python
class Playlist:
    def __init__(self, songs):
        self._songs = list(songs)
        
    def __len__(self):
        return len(self._songs)
        
    def __getitem__(self, index):
        return self._songs[index]
```
"""##,
                contentMarkdownEN: ##"""
### Emulating Sequences
Enable indexing and length queries on custom objects.
"""##,
                codeSnippet: ##"""
class Bag:
    def __init__(self, items): self.items = items
    def __len__(self): return len(self.items)

bag = Bag([1, 2, 3])
print(f"Количество элементов: {len(bag)}")
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_iterators_protocol",
                category: .pythonGenerators,
                titleRU: "Итераторы: iter(), next() и StopIteration",
                titleEN: "Iterators: iter(), next() & StopIteration",
                summaryRU: "Механизм цикла for под капотом: протокол итератора (__iter__ и __next__), ленивые вычисления и исчерпание итератора.",
                summaryEN: "Under the hood of loops: the iterator protocol, lazy evaluation, and StopIteration.",
                contentMarkdownRU: ##"""
### Протокол Итератора
```python
class Countdown:
    def __init__(self, start):
        self.current = start
        
    def __iter__(self):
        return self
        
    def __next__(self):
        if self.current <= 0:
            raise StopIteration
        self.current -= 1
        return self.current + 1
```
"""##,
                contentMarkdownEN: ##"""
### The Iterator Protocol
Make custom types iterable using `__iter__` and `__next__`.
"""##,
                codeSnippet: ##"""
nums = [10, 20]
it = iter(nums)
print(next(it))
print(next(it))
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_generators_yield",
                category: .pythonGenerators,
                titleRU: "Генераторы: Ключевое Слово yield и Память",
                titleEN: "Generators: yield Keyword & Memory Savings",
                summaryRU: "Потоковая обработка неограниченных последовательностей: функции с yield, пауза состояния выполнения и generator expressions.",
                summaryEN: "Stream massive datasets with zero memory footprint using yield functions.",
                contentMarkdownRU: ##"""
### Генераторы с yield
```python
def fibonacci(limit):
    a, b = 0, 1
    while a < limit:
        yield a
        a, b = b, a + b

for num in fibonacci(50):
    print(num, end=" ")
```
"""##,
                contentMarkdownEN: ##"""
### Generator Functions
`yield` pauses execution and yields values one at a time on demand.
"""##,
                codeSnippet: ##"""
def count_up(n):
    for i in range(1, n + 1):
        yield i

for x in count_up(3):
    print(x)
"""##,
                xpReward: 50
            ),
            Lesson(
                id: "py_context_managers_with",
                category: .pythonGenerators,
                titleRU: "Менеджеры Контекста: Оператор with и __exit__",
                titleEN: "Context Managers: with Statement & __exit__",
                summaryRU: "Гарантированное освобождение ресурсов (файлы, сокеты, блокировки): методы __enter__/__exit__ и декоратор @contextmanager.",
                summaryEN: "Deterministic resource management: with statements, __enter__/__exit__, and contextlib.",
                contentMarkdownRU: ##"""
### Менеджер контекста
```python
class Timer:
    def __enter__(self):
        print("Старт задачи...")
        return self
        
    def __exit__(self, exc_type, exc_val, exc_tb):
        print("Завершение задачи и очистка ресурсов.")
        return False
```
"""##,
                contentMarkdownEN: ##"""
### Resource Safety with `with`
Ensure cleanup even when unexpected exceptions occur.
"""##,
                codeSnippet: ##"""
class ContextExample:
    def __enter__(self):
        print("Вход в контекст")
        return self
    def __exit__(self, a, b, c):
        print("Выход из контекста")

with ContextExample():
    print("Выполнение внутри")
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_decorators_func",
                category: .pythonDecorators,
                titleRU: "Декораторы Функций и functools.wraps",
                titleEN: "Function Decorators & functools.wraps",
                summaryRU: "Паттерн Декоратор в Python: функции высшего порядка, синтаксический сахар @, замер времени и логирование вызовов.",
                summaryEN: "First-class decorators: wrapping callables, caching, logging, and preserving metadata with wraps.",
                contentMarkdownRU: ##"""
### Создание декоратора
```python
from functools import wraps

def logger(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        print(f"Вызов {func.__name__}...")
        result = func(*args, **kwargs)
        print("Готово!")
        return result
    return wrapper

@logger
def compute(x):
    return x * 2
```
"""##,
                contentMarkdownEN: ##"""
### Python Decorators
Modify function behavior dynamically with clean `@decorator` syntax.
"""##,
                codeSnippet: ##"""
def simple_decorator(fn):
    def wrapper():
        print("До вызова")
        fn()
        print("После вызова")
    return wrapper

@simple_decorator
def greet():
    print("Привет мир!")

greet()
"""##,
                xpReward: 50
            ),
            Lesson(
                id: "py_exceptions_hierarchy",
                category: .pythonDecorators,
                titleRU: "Обработка Ошибок: try, except, else и finally",
                titleEN: "Exception Handling: try, except, else & finally",
                summaryRU: "Надежная обработка сбоев: перехват конкретных типов ошибок, блок else (при успехе), блок finally (всегда) и raise ... from.",
                summaryEN: "Robust error handling with try/except/else/finally, re-raising, and exception chaining.",
                contentMarkdownRU: ##"""
### Структура try-except-else-finally
```python
try:
    val = int("123")
except ValueError as e:
    print(f"Ошибка парсинга: {e}")
else:
    print(f"Успешно получено: {val}")
finally:
    print("Блок очистки выполнен всегда.")
```
"""##,
                contentMarkdownEN: ##"""
### Error Handling Flow
Handle anticipated exceptions gracefully and clean up state in `finally`.
"""##,
                codeSnippet: ##"""
try:
    res = 10 / 2
    print(f"Результат: {res}")
except ZeroDivisionError:
    print("Деление на ноль запрещено")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_asyncio_eventloop",
                category: .pythonAsync,
                titleRU: "Асинхронность: async/await, Tasks и Event Loop",
                titleEN: "Asynchronous Python: async/await & Event Loop",
                summaryRU: "Кооперативная многозадачность: корутины async def, ожидание await, запуск задач через asyncio.gather() и модуль asyncio.",
                summaryEN: "Non-blocking cooperative concurrency: async/await primitives, Tasks, and the event loop.",
                contentMarkdownRU: ##"""
### Корутины и asyncio
```python
import asyncio

async def fetch_user(user_id: int):
    await asyncio.sleep(0.1) # Неблокирующая пауза
    return {"id": user_id, "name": f"User_{user_id}"}

async def main():
    u1, u2 = await asyncio.gather(fetch_user(1), fetch_user(2))
    print(u1, u2)
```
"""##,
                contentMarkdownEN: ##"""
### Modern Asyncio
Handle thousands of concurrent I/O operations with single-threaded cooperative multitasking.
"""##,
                codeSnippet: ##"""
async def get_data():
    return 42

print("Асинхронная корутина готова к выполнению")
"""##,
                xpReward: 50
            ),
            Lesson(
                id: "py_gil_architecture",
                category: .pythonAsync,
                titleRU: "Архитектура CPython: GIL, Threads и Processes",
                titleEN: "CPython Internals: GIL, Threading & Multiprocessing",
                summaryRU: "Внутреннее устройство CPython: Global Interpreter Lock (GIL), потоки threading для I/O-bound задач и multiprocessing для CPU-bound задач.",
                summaryEN: "CPython internals: understanding the Global Interpreter Lock, threading for I/O and multiprocessing for CPU.",
                contentMarkdownRU: ##"""
### GIL и Многозадачность
- **GIL (Global Interpreter Lock)**: гарантирует, что только один поток исполняет байткод Python в единицу времени.
- **I/O-Bound задачи** (сеть, файлы, БД): отлично подходят для `asyncio` и `threading`.
- **CPU-Bound задачи** (машинное обучение, расчеты): требуют `multiprocessing` для задействования всех ядер процессора.
"""##,
                contentMarkdownEN: ##"""
### Global Interpreter Lock (GIL)
Learn when to choose threading versus multiprocessing based on workload profile.
"""##,
                codeSnippet: ##"""
import sys
print(f"Версия Python: {sys.version.split()[0]} | Платформа: {sys.platform}")
"""##,
                xpReward: 50
            ),

            // ==========================================
            // C# CORE & ADVANCED CURRICULUM
            // ==========================================
            Lesson(
                id: "cs_basics_types",
                category: .csharpBasics,
                titleRU: "Синтаксис C#, Типы Данных и Управление",
                titleEN: "C# Syntax, Value Types & Control Flow",
                summaryRU: "Основы языка C# 12 и .NET: строгая статическая типизация, var, ссылочные и значимые типы, switch expressions.",
                summaryEN: "C# 12 & .NET fundamentals: static typing, var, value vs reference types, and switch expressions.",
                contentMarkdownRU: """
### Структура программы C#
Начиная с C# 9 и .NET 6 поддерживаются **Top-Level Statements** (инструкции верхнего уровня без громоздкого `class Program` и `static void Main`):

```csharp
using System;

string greeting = "Привет, C# 12!";
Console.WriteLine(greeting);
```

### Типы значений (Value Types) и Ссылочные типы (Reference Types)
- **Значимые типы** (`struct`): хранятся на стеке (`int`, `double`, `bool`, `DateTime`).
- **Ссылочные типы** (`class`): хранятся в куче (`string`, `object`, массивы, пользовательские классы).

```csharp
int counter = 42;
double price = 99.99;
bool isEnabled = true;
var title = "Разработка на .NET"; // Неявная типизация компилятором
```

### Современный Switch Expression
```csharp
int status = 200;
string message = status switch {
    200 => "OK",
    404 => "Not Found",
    500 => "Server Error",
    _ => "Unknown"
};
```
""",
                contentMarkdownEN: """
### Top-Level Statements in C#
```csharp
using System;

string greeting = "Hello, C# 12!";
Console.WriteLine(greeting);
```

### Value Types vs Reference Types
- Value types (`int`, `double`, `bool`, `struct`) live on the stack.
- Reference types (`class`, `string`, arrays) live on the heap.

```csharp
var status = 200;
string description = status switch {
    200 => "OK",
    _ => "Other"
};
```
""",
                codeSnippet: """
int width = 10;
int height = 20;
int area = width * height;
Console.WriteLine($"Rectangle Area: {area}");
""",
                xpReward: 35
            ),
            Lesson(
                id: "cs_oop_classes_props",
                category: .csharpOOP,
                titleRU: "Классы, Свойства { get; set; } и Инкапсуляция",
                titleEN: "Classes, Properties { get; set; } & Encapsulation",
                summaryRU: "Объектно-ориентированное программирование в C#: автоматические свойства, модификаторы доступа, конструкторы и ключевое слово this.",
                summaryEN: "OOP in C#: auto-properties, access modifiers, constructors, and encapsulation.",
                contentMarkdownRU: """
### Классы и Автосвойства (Auto-Properties)
В C# свойства заменяют рутинные геттеры и сеттеры:

```csharp
public class User {
    public string Name { get; set; }
    public int Age { get; private set; } // Изменение только внутри класса

    public User(string name, int age) {
        Name = name;
        Age = age;
    }

    public void CelebrateBirthday() {
        Age++;
    }
}
```

### Вычисляемые свойства (Expression-Bodied Members)
```csharp
public class Rectangle {
    public double Width { get; set; }
    public double Height { get; set; }

    public double Area => Width * Height; // Вычисляемое свойство
}
```
""",
                contentMarkdownEN: """
### Auto-Implemented Properties
```csharp
public class Account {
    public string Owner { get; set; }
    public decimal Balance { get; private set; }

    public Account(string owner, decimal balance) {
        Owner = owner;
        Balance = balance;
    }
}
```
""",
                codeSnippet: """
public class Device {
    public string Model { get; set; } = "iPhone";
    public int Battery { get; set; } = 100;
}

var d = new Device();
Console.WriteLine($"{d.Model}: {d.Battery}%");
""",
                xpReward: 40
            ),
            Lesson(
                id: "cs_interfaces_polymorphism",
                category: .csharpInterfaces,
                titleRU: "Интерфейсы (interface) и Полиморфизм",
                titleEN: "Interfaces & Polymorphism in C#",
                summaryRU: "Определение контрактов через interface, реализация нескольких интерфейсов, абстрактные классы и ключевые слова virtual / override.",
                summaryEN: "Defining contracts with interface, multi-interface implementation, abstract classes, and virtual/override polymorphism.",
                contentMarkdownRU: """
### Интерфейсы (`interface`)
Интерфейс задает контракт методов и свойств без их реализации (по конвенции C# имена начинаются с буквы `I`):

```csharp
public interface IPayable {
    decimal CalculatePayment();
}

public class Freelancer : IPayable {
    public decimal HourlyRate { get; set; }
    public int HoursWorked { get; set; }

    public decimal CalculatePayment() {
        return HourlyRate * HoursWorked;
    }
}
```

### Полиморфизм через `virtual` и `override`
```csharp
public class BaseLogger {
    public virtual void Log(string msg) => Console.WriteLine($"[INFO]: {msg}");
}

public class ErrorLogger : BaseLogger {
    public override void Log(string msg) => Console.WriteLine($"[ERROR]: {msg}");
}
```
""",
                contentMarkdownEN: """
### Interfaces
```csharp
public interface IRepository<T> {
    T GetById(int id);
    void Save(T item);
}
```
""",
                codeSnippet: """
public interface IShape {
    double GetArea();
}

public class Square : IShape {
    public double Side { get; set; }
    public Square(double s) => Side = s;
    public double GetArea() => Side * Side;
}

IShape shape = new Square(5);
Console.WriteLine(shape.GetArea()); // 25
""",
                xpReward: 45
            ),
            Lesson(
                id: "cs_collections_linq",
                category: .csharpLINQ,
                titleRU: "Коллекции List<T>, Dictionary и Запросы LINQ",
                titleEN: "List<T>, Dictionary & LINQ Queries",
                summaryRU: "Мощный декларативный язык запросов LINQ: методы Where, Select, OrderBy, FirstOrDefault, Any и агрегация данных.",
                summaryEN: "Declarative data querying with LINQ: Where, Select, OrderBy, FirstOrDefault, Any, and grouping operations.",
                contentMarkdownRU: """
### Дженерик-коллекции: `List<T>` и `Dictionary<TKey, TValue>`
```csharp
var numbers = new List<int> { 5, 12, 8, 21, 3, 18 };
var scores = new Dictionary<string, int> {
    ["Alice"] = 95,
    ["Bob"] = 80
};
```

### Запросы LINQ (Language Integrated Query)
LINQ позволяет фильтровать, трансформировать и сортировать коллекции так же просто, как в SQL:

```csharp
using System.Linq;

var numbers = new List<int> { 1, 2, 3, 4, 5, 6, 7, 8 };

// Method Syntax
var evenSquares = numbers
    .Where(n => n % 2 == 0)
    .Select(n => n * n)
    .OrderByDescending(n => n)
    .ToList();

int maxEven = numbers.Where(n => n % 2 == 0).Max();
bool hasLarge = numbers.Any(n => n > 100); // false
```
""",
                contentMarkdownEN: """
### LINQ Method Syntax
```csharp
using System.Linq;

var names = new List<string> { "Alice", "Bob", "Charlie" };
var result = names.Where(n => n.Length > 3).Select(n => n.ToUpper());
```
""",
                codeSnippet: """
using System.Linq;
var list = new int[] { 10, 45, 32, 88, 5 };
var topScores = list.Where(x => x > 20).OrderBy(x => x).ToArray();
Console.WriteLine(string.Join(", ", topScores));
""",
                xpReward: 45
            ),
            Lesson(
                id: "cs_modern_async_records",
                category: .csharpModern,
                titleRU: "Records, Pattern Matching и Асинхронность (async/await)",
                titleEN: "Records, Pattern Matching & Async (Task)",
                summaryRU: "Современные возможности C# 12: неизменяемые типы record, позиционный синтаксис, асинхронные задачи Task и ключевые слова async/await.",
                summaryEN: "Modern C# 12: immutable record types, positional syntax, pattern matching, and async/await with Task.",
                contentMarkdownRU: """
### Неизменяемые рекорды (`record`)
Рекорды предоставляют встроенную семантику сравнения по значениям (value equality) и лаконичный синтаксис:

```csharp
public record UserRecord(string Name, int Age);

var u1 = new UserRecord("Иван", 25);
var u2 = new UserRecord("Иван", 25);
Console.WriteLine(u1 == u2); // True! Сравнение по свойствам
```

### Асинхронность: `async` и `await`
Модель асинхронности на основе задач (Task-based Asynchronous Pattern, TAP):

```csharp
using System.Threading.Tasks;
using System.Net.Http;

public async Task<string> DownloadWebPageAsync(string url) {
    using var client = new HttpClient();
    string content = await client.GetStringAsync(url);
    return content;
}
```
""",
                contentMarkdownEN: """
### Records
```csharp
public record Point(int X, int Y);
var p1 = new Point(1, 2);
var p2 = new Point(1, 2);
Console.WriteLine(p1 == p2); // True
```

### Async / Await
```csharp
public async Task<int> FetchDataAsync() {
    await Task.Delay(100);
    return 42;
}
```
""",
                codeSnippet: """
public record Coordinate(double Lat, double Lon);
var c = new Coordinate(55.75, 37.61);
Console.WriteLine($"Location: {c.Lat}, {c.Lon}");
""",
                xpReward: 50
            ),

            // MARK: - SQL Lessons
            Lesson(
                id: "sql_basics_select",
                category: .sqlBasics,
                titleRU: "Выборка данных: SELECT, AS и DISTINCT",
                titleEN: "Data Querying: SELECT, AS & DISTINCT",
                summaryRU: "Основы языка SQL: операторы SELECT, выбор конкретных колонок, переименование через AS и исключение дубликатов DISTINCT.",
                summaryEN: "Core SQL syntax: querying data with SELECT, column aliasing with AS, and eliminating duplicates with DISTINCT.",
                contentMarkdownRU: ##"""
# Основы SQL и Оператор SELECT

SQL (Structured Query Language) — декларативный язык структурированных запросов для взаимодействия с реляционными базами данных (PostgreSQL, SQLite, MySQL).

## Простейший запрос
Символ `*` выбирает абсолютно все доступные колонки из таблицы:
```sql
SELECT * FROM employees;
```

## Выбор конкретных колонок и псевдонимы (AS)
Для минимизации сетевого трафика и расхода памяти рекомендуется запрашивать только нужные поля, а также давать им понятные имена:
```sql
SELECT 
    first_name AS name,
    salary * 12 AS annual_salary
FROM employees;
```

## Устранение дубликатов (DISTINCT)
Ключевое слово `DISTINCT` оставляет только уникальные комбинации значений:
```sql
SELECT DISTINCT department FROM employees;
```

## Ограничение выборки (LIMIT и OFFSET)
```sql
SELECT name, price FROM products 
ORDER BY price DESC 
LIMIT 5 OFFSET 0;
```
"""##,
                contentMarkdownEN: ##"""
# SQL Fundamentals: SELECT Statement

SQL is the universal declarative language for relational database management systems.

## Basic Query
```sql
SELECT first_name AS name, salary 
FROM employees;
```

## Removing Duplicates
```sql
SELECT DISTINCT country FROM customers;
```
"""##,
                codeSnippet: ##"""
SELECT 
    name, 
    department, 
    salary 
FROM employees 
WHERE salary > 50000;
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "sql_filtering_where",
                category: .sqlFiltering,
                titleRU: "Фильтрация строк: WHERE, IN, BETWEEN и LIKE",
                titleEN: "Row Filtering: WHERE, IN, BETWEEN & LIKE",
                summaryRU: "Построение предикатов и условий: сравнение, логические операторы AND/OR, проверка вхождения IN и поиск по шаблону LIKE.",
                summaryEN: "Filter rows with WHERE clauses, logical operators AND/OR, range checks BETWEEN, and wildcard pattern matching LIKE.",
                contentMarkdownRU: ##"""
# Фильтрация данных с помощью WHERE

Предложение `WHERE` фильтрует строки таблицы до их попадания в итоговую выборку.

## Операторы сравнения и логика
```sql
SELECT * FROM orders 
WHERE amount >= 100.00 AND status = 'completed';
```

## Поиск в диапазоне (BETWEEN)
```sql
SELECT * FROM products 
WHERE price BETWEEN 50 AND 150;
```

## Проверка множества (IN)
```sql
SELECT * FROM users 
WHERE role IN ('admin', 'moderator', 'editor');
```

## Поиск по подстроке (LIKE)
- `%` — любая последовательность символов (ноль или больше).
- `_` — ровно один любой символ.
```sql
SELECT * FROM customers 
WHERE email LIKE '%@gmail.com';
```
"""##,
                contentMarkdownEN: ##"""
# Filtering Rows with WHERE

```sql
SELECT * FROM employees
WHERE department = 'IT' AND salary >= 70000;
```
"""##,
                codeSnippet: ##"""
SELECT title, rating FROM movies
WHERE release_year >= 2020 AND rating >= 8.0;
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "sql_aggregations_group",
                category: .sqlAggregations,
                titleRU: "Агрегатные функции и GROUP BY",
                titleEN: "Aggregate Functions & GROUP BY",
                summaryRU: "Вычисление итоговых метрик: COUNT, SUM, AVG, MIN, MAX. Группировка строк через GROUP BY и фильтрация групп HAVING.",
                summaryEN: "Compute dataset aggregates with COUNT, SUM, AVG, MIN, MAX. Group rows with GROUP BY and filter group metrics with HAVING.",
                contentMarkdownRU: ##"""
# Агрегатные функции и Группировка

Агрегатные функции сворачивают множество значений в одно итоговое число.

## Базовые агрегаты
- `COUNT(*)` — общее количество строк.
- `SUM(column)` — сумма числовых значений.
- `AVG(column)` — среднее арифметическое.
- `MIN(column)` / `MAX(column)` — минимальное и максимальное значения.

```sql
SELECT 
    COUNT(*) AS total_workers,
    AVG(salary) AS average_salary,
    MAX(salary) AS max_salary
FROM employees;
```

## Предложение GROUP BY
Разбивает строки на непересекающиеся группы по указанному признаку:
```sql
SELECT 
    department, 
    COUNT(*) AS employee_count, 
    AVG(salary) AS avg_sal
FROM employees
GROUP BY department;
```

## Разница между WHERE и HAVING
- `WHERE` фильтрует строки **до** группировки.
- `HAVING` фильтрует группы **после** вычисления агрегатов:
```sql
SELECT department, COUNT(*) AS cnt
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;
```
"""##,
                contentMarkdownEN: ##"""
# Aggregations & GROUP BY

```sql
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING COUNT(*) >= 3;
```
"""##,
                codeSnippet: ##"""
SELECT category, COUNT(*) AS items_count, AVG(price) AS avg_price
FROM store_products
GROUP BY category;
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "sql_joins_types",
                category: .sqlJoins,
                titleRU: "Объединение таблиц: INNER, LEFT и FULL JOIN",
                titleEN: "Table Joins: INNER, LEFT & FULL JOIN",
                summaryRU: "Связывание реляционных данных по ключам. Строгое пересечение INNER JOIN и сохранение родительских записей в LEFT JOIN.",
                summaryEN: "Link data across tables with foreign keys. Compare strict INNER JOIN with non-matching preserved rows in LEFT JOIN.",
                contentMarkdownRU: ##"""
# Реляционные связи: Табличные JOIN

Реляционные базы данных нормализуют информацию, разнося сущности по разным таблицам. Операторы `JOIN` восстанавливают целостную картину.

## INNER JOIN
Возвращает только те строки, для которых условие связи истинно в **обеих** таблицах:
```sql
SELECT 
    users.name,
    orders.amount,
    orders.created_at
FROM users
INNER JOIN orders ON users.id = orders.user_id;
```

## LEFT JOIN (LEFT OUTER JOIN)
Возвращает **все** строки из левой таблицы. Если в правой таблице совпадений нет, её поля заполняются значением `NULL`:
```sql
SELECT 
    users.name,
    COUNT(orders.id) AS total_orders
FROM users
LEFT JOIN orders ON users.id = orders.user_id
GROUP BY users.name;
```
"""##,
                contentMarkdownEN: ##"""
# Combining Tables with JOIN

```sql
SELECT u.username, o.product_name, o.price
FROM users u
INNER JOIN orders o ON u.id = o.user_id;
```
"""##,
                codeSnippet: ##"""
SELECT employees.name, departments.title
FROM employees
INNER JOIN departments ON employees.dept_id = departments.id;
"""##,
                xpReward: 50
            ),
            Lesson(
                id: "sql_ddl_tables",
                category: .sqlDdlDml,
                titleRU: "DDL & DML: Создание таблиц и Изменение данных",
                titleEN: "DDL & DML: Schema Design & Data Mutation",
                summaryRU: "Проектирование схемы: CREATE TABLE, PRIMARY KEY, типы данных. Вставка строк INSERT INTO, модификация UPDATE и удаление DELETE.",
                summaryEN: "Schema definition with CREATE TABLE, primary keys, and data types. Data mutation with INSERT, UPDATE, and DELETE.",
                contentMarkdownRU: ##"""
# DDL и DML Операции

SQL делится на две ключевые подсистемы:
- **DDL (Data Definition Language)** — структура и схема БД.
- **DML (Data Manipulation Language)** — работа со строками данных.

## Создание таблицы (CREATE TABLE)
```sql
CREATE TABLE tasks (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    priority INTEGER DEFAULT 1,
    is_completed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Вставка данных (INSERT INTO)
```sql
INSERT INTO tasks (title, priority) 
VALUES ('Изучить SQL', 5), ('Собрать проект', 3);
```

## Обновление данных (UPDATE)
> Внимание: всегда указывайте условие `WHERE`, иначе обновятся абсолютно все строки в таблице!
```sql
UPDATE tasks 
SET is_completed = TRUE 
WHERE id = 1;
```

## Удаление данных (DELETE)
```sql
DELETE FROM tasks 
WHERE is_completed = TRUE;
```
"""##,
                contentMarkdownEN: ##"""
# DDL and DML in SQL

```sql
CREATE TABLE authors (id INTEGER PRIMARY KEY, name TEXT);
INSERT INTO authors (id, name) VALUES (1, 'Leo Tolstoy');
UPDATE authors SET name = 'Lev Tolstoy' WHERE id = 1;
```
"""##,
                codeSnippet: ##"""
CREATE TABLE courses (id INT PRIMARY KEY, name TEXT, hours INT);
INSERT INTO courses VALUES (1, 'SQL Mastery', 40);
SELECT * FROM courses;
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "sql_window_functions",
                category: .sqlWindow,
                titleRU: "Оконные функции: OVER, ROW_NUMBER и RANK",
                titleEN: "Window Functions: OVER, ROW_NUMBER & Analytics",
                summaryRU: "Аналитические вычисления без схлопывания строк: нумерация строк с ROW_NUMBER(), ранжирование RANK() и секционирование PARTITION BY.",
                summaryEN: "Advanced row analytics without collapsing: calculate running totals, ROW_NUMBER(), and RANK() across PARTITION BY windows.",
                contentMarkdownRU: ##"""
# Оконные функции в SQL

В отличие от `GROUP BY`, оконные функции вычисляют агрегатные и ранжирующие значения, **сохраняя каждую индивидуальную строку** выборки.

## Синтаксис OVER
Окно вычисления задается с помощью конструкции `OVER(...)`:
- `PARTITION BY <колонка>` — секционирует строки (как локальный GROUP BY).
- `ORDER BY <колонка>` — упорядочивает строки внутри каждого окна.

## Нумерация строк: ROW_NUMBER()
```sql
SELECT 
    name, 
    department, 
    salary,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank
FROM employees;
```

## Ранжирование: RANK() и DENSE_RANK()
```sql
SELECT 
    name, 
    score,
    RANK() OVER (ORDER BY score DESC) AS rank_pos
FROM students_results;
```

## Накопительный итог (Running Total)
```sql
SELECT 
    date, 
    amount,
    SUM(amount) OVER (ORDER BY date) AS cumulative_sales
FROM daily_revenue;
```
"""##,
                contentMarkdownEN: ##"""
# Window Functions in SQL

```sql
SELECT 
    employee_name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) as rank
FROM company_salaries;
```
"""##,
                codeSnippet: ##"""
SELECT name, salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank
FROM employees;
"""##,
                xpReward: 50
            )

        ]
    }
}

