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
                summaryRU: "Фундамент языка Python: отступы как семантика блоков, стиль PEP 8, комментарии и функция print().",
                summaryEN: "Python fundamentals: indentation semantics, PEP 8 code style, and print() function.",
                contentMarkdownRU: ##"""
### Философия Python и Отступы (PEP 8)
В Python отступы (4 пробела) определяют границы блоков кода вместо фигурных скобок `{ }`:
```python
age = 20
if age >= 18:
    print("Совершеннолетний")
    print("Доступ открыт")
```
### Динамическая типизация
Имена переменных ссылаются на объекты в куче:
```python
x = 100       # int
x = "Строка"  # str
```
"""##,
                contentMarkdownEN: ##"""
### Indentation Semantics
Python enforces clean visual hierarchy using 4 spaces per indentation level.
"""##,
                codeSnippet: ##"""
user = "Разработчик"
print(f"Привет, {user}! Добро пожаловать в Python 3.12")
"""##,
                xpReward: 30
            ),
            Lesson(
                id: "py_numbers_math",
                category: .pythonBasics,
                titleRU: "Числа, Деление //, Степень ** и модуль math",
                titleEN: "Numbers, Integer Division, Power & math",
                summaryRU: "Целые числа int произвольной точности, float IEEE-754, деление //, остаток % и модуль math.",
                summaryEN: "Arbitrary-precision integers, IEEE-754 floats, floor division, modulo, and math module.",
                contentMarkdownRU: ##"""
### Арифметика в Python
- Деление `/` всегда возвращает `float`.
- Целочисленное деление `//` отбрасывает дробную часть.
- Оператор `%` возвращает остаток от деления.
- Оператор `**` возводит в степень.
```python
print(17 // 3) # 5
print(17 % 3)  # 2
print(2 ** 10) # 1024
```
"""##,
                contentMarkdownEN: ##"""
### Arithmetic in Python
Use `//` for floor division, `%` for remainder, and `**` for exponentiation.
"""##,
                codeSnippet: ##"""
a, b = 7, 3
print(f"Целое: {a // b}, Остаток: {a % b}, Степень: {b ** 3}")
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_strings_fstrings",
                category: .pythonBasics,
                titleRU: "Строки, Срезы [::] и f-strings",
                titleEN: "Strings, Slicing [::] & f-strings",
                summaryRU: "Неизменяемый тип str, интернирование, срезы [start:stop:step], методы строк и f-строки.",
                summaryEN: "Immutable str objects, string interning, slicing syntax, methods, and f-strings.",
                contentMarkdownRU: ##"""
### Срезы строк (Slicing)
`string[start:stop:step]`
```python
s = "Python3"
print(s[0:2])  # "Py"
print(s[::-1]) # "3nohtyP" (разворот)
```
### f-строки
```python
name = "Alice"
score = 99.456
print(f"Студент {name}: {score:.1f}")
```
"""##,
                contentMarkdownEN: ##"""
### String Manipulation
Slicing allows fast substring extraction and reversing with step -1.
"""##,
                codeSnippet: ##"""
s = "swiftlearn"
print(f"Оригинал: {s} | Разворот: {s[::-1]}")
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_booleans_truthiness",
                category: .pythonBasics,
                titleRU: "Булева Логика, and/or/not и Truthiness",
                titleEN: "Boolean Logic, and/or/not & Truthiness",
                summaryRU: "Тип bool, короткое замыкание (short-circuit), и истинность пустых структур.",
                summaryEN: "bool types, short-circuit boolean evaluation, and truthiness of empty collections.",
                contentMarkdownRU: ##"""
### Truthiness
Пустые коллекции (`[]`, `{}`, `""`), число `0` и `None` вычисляются как `False`:
```python
data = []
if not data:
    print("Коллекция пуста")
```
"""##,
                contentMarkdownEN: ##"""
### Truth Value Testing
Empty sequences evaluate to False in boolean statements.
"""##,
                codeSnippet: ##"""
items = ["Python"]
print("Есть элементы" if items else "Пусто")
"""##,
                xpReward: 30
            ),
            Lesson(
                id: "py_bytes_bytearray",
                category: .pythonBasics,
                titleRU: "Байтовые Строки bytes и Изменяемый bytearray",
                titleEN: "Byte Strings (bytes) & Mutable bytearray",
                summaryRU: "Работа с бинарными данными: неизменяемый bytes, изменяемый массив байтов bytearray и кодеки.",
                summaryEN: "Binary representations: immutable bytes, mutable bytearray, and encoding/decoding.",
                contentMarkdownRU: ##"""
### bytes vs str
`str` — это символы Unicode, `bytes` — это сырые байты (0-255):
```python
b = b"Hello"
raw = "Привет".encode("utf-8")
text = raw.decode("utf-8")
```
"""##,
                contentMarkdownEN: ##"""
### Binary Data
Distinguish between human text strings and raw network/file bytes.
"""##,
                codeSnippet: ##"""
b = "Data".encode("ascii")
print(f"Байты: {b}, длина: {len(b)}")
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_bitwise_ops",
                category: .pythonBasics,
                titleRU: "Битовые Операции (&, |, ^, ~, <<, >>)",
                titleEN: "Bitwise Operations (&, |, ^, ~, <<, >>)",
                summaryRU: "Низкоуровневая побитовая логика: сдвиги влево/вправо, маски флагов и побитовое XOR.",
                summaryEN: "Low-level bitwise manipulation: shifts, bitmasks, AND, OR, and XOR.",
                contentMarkdownRU: ##"""
### Битовые операторы
- `&` (AND), `|` (OR), `^` (XOR), `~` (NOT)
- `<<` (сдвиг влево), `>>` (сдвиг вправо)
```python
flags = 0b0101
mask = 0b0001
is_active = bool(flags & mask)
```
"""##,
                contentMarkdownEN: ##"""
### Bitwise Logic
Manipulate individual bits for performance and binary protocol parsing.
"""##,
                codeSnippet: ##"""
x = 4 # 0b100
print(f"x << 1: {x << 1} (умножение на 2)")
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_control_if_elif",
                category: .pythonControlFlow,
                titleRU: "Ветвление if, elif, else и Тернарный Оператор",
                titleEN: "Conditionals: if, elif, else & Ternary",
                summaryRU: "Логические развилки, вложенные проверки и тернарный оператор x if cond else y.",
                summaryEN: "Branching with if/elif/else and concise ternary expressions.",
                contentMarkdownRU: ##"""
### Тернарный оператор
```python
status = "Совершеннолетний" if age >= 18 else "Ребенок"
```
"""##,
                contentMarkdownEN: ##"""
### Conditionals
Direct code flow based on logical criteria.
"""##,
                codeSnippet: ##"""
temp = 25
weather = "Тепло" if temp > 20 else "Прохладно"
print(f"Погода: {weather}")
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_loops_while_break",
                category: .pythonControlFlow,
                titleRU: "Цикл while, break, continue и блок else",
                titleEN: "while Loop, break, continue & else Clause",
                summaryRU: "Циклы с предусловием, досрочный выход break, переход continue и блок else при исчерпании.",
                summaryEN: "Indefinite iteration with while, loop control, and the loop-else pattern.",
                contentMarkdownRU: ##"""
### Блок else в циклах
Выполняется, если цикл завершился **естественно**, без вызова `break`:
```python
i = 0
while i < 3:
    i += 1
else:
    print("Цикл завершен штатно")
```
"""##,
                contentMarkdownEN: ##"""
### Loop Else
The else block executes only if the loop terminates normally without break.
"""##,
                codeSnippet: ##"""
n = 3
while n > 0:
    print(n)
    n -= 1
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_loops_for_range",
                category: .pythonControlFlow,
                titleRU: "Цикл for .. in, range и счетчик enumerate",
                titleEN: "for Loops, range Sequence & enumerate Indexing",
                summaryRU: "Итерация по последовательностям, диапазон range(start, stop, step) и нумерация через enumerate.",
                summaryEN: "Sequence iteration, range generators, and 0-based/1-based indexing with enumerate.",
                contentMarkdownRU: ##"""
### range и enumerate
```python
fruits = ["яблоко", "банан", "апельсин"]
for idx, item in enumerate(fruits, start=1):
    print(f"{idx}. {item}")
```
"""##,
                contentMarkdownEN: ##"""
### Iteration with Index
Use `enumerate()` to retrieve index and value pairs cleanly.
"""##,
                codeSnippet: ##"""
for i in range(1, 4):
    print(f"Шаг #{i}")
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_zip_parallel",
                category: .pythonControlFlow,
                titleRU: "Функция zip() и Параллельный Обход",
                titleEN: "Parallel Iteration with zip() & zip_longest()",
                summaryRU: "Объединение нескольких последовательностей в кортежи пар, распаковка zip(*matrix).",
                summaryEN: "Pairing multiple sequences into tuples with zip and matrix transposition.",
                contentMarkdownRU: ##"""
### zip в действии
```python
names = ["Алиса", "Боб"]
scores = [95, 87]
for name, score in zip(names, scores):
    print(f"{name}: {score}")
```
"""##,
                contentMarkdownEN: ##"""
### Parallel Iteration
Iterate through multiple iterables simultaneously.
"""##,
                codeSnippet: ##"""
keys = ["a", "b"]
vals = [1, 2]
mapping = dict(zip(keys, vals))
print(mapping)
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_match_case_patterns",
                category: .pythonControlFlow,
                titleRU: "Сопоставление с Образцом match .. case",
                titleEN: "Pattern Matching: match .. case",
                summaryRU: "Структурный pattern matching (Python 3.10+): позиционные паттерны, guards и деструктуризация.",
                summaryEN: "Structural pattern matching with patterns, guards, and wildcard handling.",
                contentMarkdownRU: ##"""
### Синтаксис match .. case
```python
point = (0, 5)
match point:
    case (0, 0):
        print("Начало координат")
    case (0, y):
        print(f"На оси Y: {y}")
    case _:
        print("Другая точка")
```
"""##,
                contentMarkdownEN: ##"""
### Pattern Matching
Expressive control flow introduced in Python 3.10.
"""##,
                codeSnippet: ##"""
cmd = "start"
match cmd:
    case "start": print("Запуск")
    case _: print("Неизвестно")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_lists_methods",
                category: .pythonCollections,
                titleRU: "Динамические Списки (list): Методы и Срезы",
                titleEN: "Lists: Methods, Mutability & Slicing",
                summaryRU: "Упорядоченные изменяемые массивы: append, pop, extend, insert, inplace-сортировка sort().",
                summaryEN: "Mutable ordered sequences: amortized O(1) appending, popping, and sorting.",
                contentMarkdownRU: ##"""
### Списки
```python
nums = [3, 1, 4]
nums.append(1)
nums.sort()
print(nums) # [1, 1, 3, 4]
```
"""##,
                contentMarkdownEN: ##"""
### Python Lists
Dynamic arrays with fast random access by index.
"""##,
                codeSnippet: ##"""
lst = [5, 2, 8]
lst.sort()
print(f"Сортировка: {lst}")
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_tuples_unpacking",
                category: .pythonCollections,
                titleRU: "Кортежи (tuple) и Распаковка Переменных",
                titleEN: "Tuples (tuple) & Star Unpacking",
                summaryRU: "Неизменяемые кортежи, хэшируемость для словарей и распаковка first, *rest, last = items.",
                summaryEN: "Immutable sequences, dictionary key validity, and starred unpacking.",
                contentMarkdownRU: ##"""
### Распаковка кортежей
```python
coords = (10, 20, 30, 40)
first, *middle, last = coords
# middle: [20, 30]
```
"""##,
                contentMarkdownEN: ##"""
### Immutable Tuples
Tuples protect structured records against unexpected mutation.
"""##,
                codeSnippet: ##"""
x, y = 10, 20
x, y = y, x # Своп значений
print(f"x={x}, y={y}")
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_dicts_hashmaps",
                category: .pythonCollections,
                titleRU: "Словари (dict): Хэш-таблицы и Поиск O(1)",
                titleEN: "Dictionaries (dict): Hash Tables & Fast Lookup",
                summaryRU: "Ассоциативные массивы: компактная память CPython, безопасный .get(), keys, values, items.",
                summaryEN: "Fast key-value hash maps with O(1) average lookup and insertion.",
                contentMarkdownRU: ##"""
### Словари
```python
user = {"name": "Дмитрий", "role": "admin"}
print(user.get("age", 0)) # Безопасное чтение
```
"""##,
                contentMarkdownEN: ##"""
### Hash Map Storage
Fast key-value lookup relying on immutable hashable keys.
"""##,
                codeSnippet: ##"""
d = {"lang": "Python", "ver": 3.12}
print(f"Язык: {d['lang']}")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_sets_unique",
                category: .pythonCollections,
                titleRU: "Множества (set): Уникальность и Теория Множеств",
                titleEN: "Sets (set): Uniqueness & Math Operations",
                summaryRU: "Хэш-коллекции уникальных значений: объединение |, пересечение &, разность - и frozenset.",
                summaryEN: "Unordered collections of unique elements with set-theoretic operations.",
                contentMarkdownRU: ##"""
### Множества
```python
s1 = {1, 2, 3}
s2 = {2, 3, 4}
print(s1 & s2) # Пересечение: {2, 3}
```
"""##,
                contentMarkdownEN: ##"""
### Set Arithmetic
Find intersections, unions, and symmetric differences in O(N).
"""##,
                codeSnippet: ##"""
vals = [1, 2, 2, 3, 3]
print(f"Уникальные: {set(vals)}")
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_comprehensions_power",
                category: .pythonCollections,
                titleRU: "List, Dict и Set Comprehensions",
                titleEN: "Comprehensions: List, Dict & Set Generation",
                summaryRU: "Декларативное создание коллекций в одну строку: фильтрация if, вложенные циклы.",
                summaryEN: "Declarative and expressive collection construction in a single statement.",
                contentMarkdownRU: ##"""
### Генераторы коллекций
```python
evens = [x**2 for x in range(10) if x % 2 == 0]
lookup = {x: x*10 for x in range(3)}
```
"""##,
                contentMarkdownEN: ##"""
### Expressive Comprehensions
Transform data efficiently without manual accumulator loops.
"""##,
                codeSnippet: ##"""
sq = [x*x for x in [1, 2, 3]]
print(sq)
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_functions_defaults",
                category: .pythonFunctions,
                titleRU: "Функции: Аргументы по Умолчанию и Возврат",
                titleEN: "Functions: Default Arguments & Mutability Trap",
                summaryRU: "Объявление def, возвращаемые значения и опасность изменяемых аргументов по умолчанию.",
                summaryEN: "Function parameters, return values, and avoiding mutable default traps.",
                contentMarkdownRU: ##"""
### Ловушка аргументов по умолчанию
> Никогда не пишите `def f(arg=[])`. Используйте `None`:
```python
def add_item(item, lst=None):
    if lst is None: lst = []
    lst.append(item)
    return lst
```
"""##,
                contentMarkdownEN: ##"""
### Mutable Default Trap
Default argument expressions are evaluated once at function definition time.
"""##,
                codeSnippet: ##"""
def greet(name, greeting="Привет"):
    return f"{greeting}, {name}!"
print(greet("Анна"))
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_args_kwargs_unpack",
                category: .pythonFunctions,
                titleRU: "Вариативные Аргументы: *args и **kwargs",
                titleEN: "Variadic Arguments: *args & **kwargs",
                summaryRU: "Прием произвольного числа позиционных и именованных параметров, распаковка при вызове.",
                summaryEN: "Accept arbitrary positional and keyword parameters with tuple/dict packing.",
                contentMarkdownRU: ##"""
### *args и **kwargs
```python
def log_event(event, *details, **metadata):
    print(event, details, metadata)
```
"""##,
                contentMarkdownEN: ##"""
### Parameter Packing
Pass variable arguments cleanly across abstraction layers.
"""##,
                codeSnippet: ##"""
def total(*nums):
    return sum(nums)
print(f"Сумма: {total(1, 2, 3, 4)}")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_lambda_scopes",
                category: .pythonFunctions,
                titleRU: "Лямбда-функции, Замыкания, global и nonlocal",
                titleEN: "Lambdas, Closures, global & nonlocal",
                summaryRU: "Анонимные функции lambda, лексические замыкания и управление областями видимости LEGB.",
                summaryEN: "One-line lambda functions, closure scopes, and the LEGB resolution rule.",
                contentMarkdownRU: ##"""
### Замыкания и nonlocal
```python
def make_counter():
    count = 0
    def inc():
        nonlocal count
        count += 1
        return count
    return inc
```
"""##,
                contentMarkdownEN: ##"""
### Closures & Scopes
Inner functions retain access to enclosing local scope variables.
"""##,
                codeSnippet: ##"""
square = lambda x: x * x
print(f"Квадрат: {square(5)}")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_type_hints_typing",
                category: .pythonFunctions,
                titleRU: "Аннотации Типов: PEP 484 и модуль typing",
                titleEN: "Type Hints: PEP 484 & typing Module",
                summaryRU: "Статические подсказки типов: Union, Optional, Callable, синтаксис X | Y в Python 3.10+.",
                summaryEN: "Static type annotations for code documentation and mypy verification.",
                contentMarkdownRU: ##"""
### Type Hints в Python 3.12
```python
def find_user(user_id: int) -> str | None:
    return "Alex" if user_id == 1 else None
```
"""##,
                contentMarkdownEN: ##"""
### Type Annotations
Clarify parameter expectations and return types.
"""##,
                codeSnippet: ##"""
def double(x: int) -> int:
    return x * 2
print(double(10))
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_oop_classes_init",
                category: .pythonOOP,
                titleRU: "Классы, Экземпляры и Конструктор __init__",
                titleEN: "Classes, Instances & __init__ Constructor",
                summaryRU: "Объектная модель Python: определение class, ссылка self, инициализация атрибутов экземпляра.",
                summaryEN: "Class blueprint definition, self reference, and instance state initialization.",
                contentMarkdownRU: ##"""
### Классы в Python
```python
class User:
    def __init__(self, name: str, age: int):
        self.name = name
        self.age = age
```
"""##,
                contentMarkdownEN: ##"""
### Classes and State
Encapsulate attributes and behavior inside class instances.
"""##,
                codeSnippet: ##"""
class Car:
    def __init__(self, brand):
        self.brand = brand
c = Car("Tesla")
print(c.brand)
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_oop_encapsulation_prop",
                category: .pythonOOP,
                titleRU: "Инкапсуляция, Приватные Поля и @property",
                titleEN: "Encapsulation, Private Attributes & @property",
                summaryRU: "Конвенции именования (_protected, __private name mangling), вычисляемые свойства @property.",
                summaryEN: "Controlling attribute access, name mangling, and property getters/setters.",
                contentMarkdownRU: ##"""
### Свойства (@property)
```python
class Circle:
    def __init__(self, r): self.r = r
    @property
    def area(self): return 3.14159 * self.r**2
```
"""##,
                contentMarkdownEN: ##"""
### @property Getters
Expose methods with attribute syntax cleanly.
"""##,
                codeSnippet: ##"""
class Box:
    def __init__(self, s): self.s = s
    @property
    def volume(self): return self.s ** 3
print(Box(2).volume)
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_oop_classmethod_static",
                category: .pythonOOP,
                titleRU: "Методы Класса @classmethod и @staticmethod",
                titleEN: "Class Methods (@classmethod) & @staticmethod",
                summaryRU: "Фабричные конструкторы через cls (@classmethod) и статические вспомогательные функции.",
                summaryEN: "Alternative constructors with classmethod and decoupled utilities with staticmethod.",
                contentMarkdownRU: ##"""
### @classmethod
```python
class Point:
    def __init__(self, x, y): self.x, self.y = x, y
    @classmethod
    def origin(cls): return cls(0, 0)
```
"""##,
                contentMarkdownEN: ##"""
### Class vs Static
Differentiate methods needing class reference (cls) vs none.
"""##,
                codeSnippet: ##"""
class Converter:
    @staticmethod
    def km_to_m(km): return km * 1000
print(Converter.km_to_m(5))
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_oop_inheritance_mro",
                category: .pythonOOP,
                titleRU: "Наследование, super() и Алгоритм MRO",
                titleEN: "Inheritance, super() & C3 MRO Linearization",
                summaryRU: "Расширение поведения классов, делегирование super(), множественное наследование и MRO.",
                summaryEN: "Inheritance hierarchies, super() method resolution, and the C3 linearization algorithm.",
                contentMarkdownRU: ##"""
### super() и MRO
```python
class Parent:
    def greet(self): return "Привет"
class Child(Parent):
    def greet(self): return super().greet() + " от потомка"
```
"""##,
                contentMarkdownEN: ##"""
### Method Resolution Order
Python resolves multiple inheritance predictably using C3 linearization.
"""##,
                codeSnippet: ##"""
class Base:
    def f(self): return "Base"
class Sub(Base):
    def f(self): return super().f() + "+Sub"
print(Sub().f())
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_oop_dataclasses_modern",
                category: .pythonOOP,
                titleRU: "Датаклассы (@dataclass) и Иммутабельность",
                titleEN: "Data Classes (@dataclass) & Immutability",
                summaryRU: "Модуль dataclasses: устранение шаблонного кода, frozen=True, автогенерация __repr__ и __eq__.",
                summaryEN: "Boilerplate elimination, value equality, and immutable frozen data holders.",
                contentMarkdownRU: ##"""
### Датаклассы
```python
from dataclasses import dataclass
@dataclass(frozen=True)
class Coordinate:
    lat: float
    lon: float
```
"""##,
                contentMarkdownEN: ##"""
### Clean Data Holders
Declarative class generation for pure data structures.
"""##,
                codeSnippet: ##"""
class SimpleDTO:
    def __init__(self, id, val): self.id, self.val = id, val
    def __repr__(self): return f"DTO({self.id}, {self.val})"
print(SimpleDTO(1, "Data"))
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_oop_abstract_abc",
                category: .pythonOOP,
                titleRU: "Абстрактные Базовые Классы (модуль abc)",
                titleEN: "Abstract Base Classes (abc Module) & Interfaces",
                summaryRU: "Проектирование строгих интерфейсов: модуль abc, декоратор @abstractmethod и контракты.",
                summaryEN: "Enforcing interface contracts and preventing instantiation of incomplete bases.",
                contentMarkdownRU: ##"""
### Модуль abc
```python
from abc import ABC, abstractmethod
class Shape(ABC):
    @abstractmethod
    def area(self) -> float: pass
```
"""##,
                contentMarkdownEN: ##"""
### Abstract Base Classes
Define structural contracts subclasses must implement.
"""##,
                codeSnippet: ##"""
class Interface:
    def execute(self): raise NotImplementedError
print("Интерфейс определен")
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_dunder_str_repr",
                category: .pythonDunder,
                titleRU: "Магические Методы: __str__ и __repr__",
                titleEN: "Dunder Methods: __str__ vs __repr__",
                summaryRU: "Два строковых представления: __repr__ для отладки разработчиком и __str__ для пользователя.",
                summaryEN: "Differentiating user-friendly string conversion from unambiguous debug representation.",
                contentMarkdownRU: ##"""
### __str__ vs __repr__
```python
class Money:
    def __init__(self, amt): self.amt = amt
    def __repr__(self): return f"Money({self.amt})"
    def __str__(self): return f"{self.amt} руб."
```
"""##,
                contentMarkdownEN: ##"""
### String Protocols
Implement __repr__ so eval(repr(obj)) can recreate identical state when possible.
"""##,
                codeSnippet: ##"""
class Tag:
    def __init__(self, t): self.t = t
    def __str__(self): return f"#{self.t}"
print(str(Tag('python')))
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_dunder_operators",
                category: .pythonDunder,
                titleRU: "Перегрузка Операторов: __add__, __eq__, __lt__",
                titleEN: "Operator Overloading: __add__, __eq__, __lt__",
                summaryRU: "Интеграция типов в синтаксис языка: арифметические dunder-методы и сортировка __lt__.",
                summaryEN: "Overloading arithmetic and comparison operators for natural syntax integration.",
                contentMarkdownRU: ##"""
### Перегрузка операторов
```python
class Vector:
    def __init__(self, x, y): self.x, self.y = x, y
    def __add__(self, other):
        return Vector(self.x + other.x, self.y + other.y)
```
"""##,
                contentMarkdownEN: ##"""
### Custom Arithmetic
Allow custom domain objects to be added and compared directly.
"""##,
                codeSnippet: ##"""
class Val:
    def __init__(self, v): self.v = v
    def __add__(self, o): return Val(self.v + o.v)
res = Val(5) + Val(10)
print(res.v)
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_dunder_container_proto",
                category: .pythonDunder,
                titleRU: "Протокол Контейнеров: __len__, __getitem__",
                titleEN: "Container Protocol: __len__, __getitem__, __contains__",
                summaryRU: "Создание собственных коллекций: поддержка len(), индексации obj[k] и оператора in.",
                summaryEN: "Emulating standard sequences and mappings with length and bracket subscripting.",
                contentMarkdownRU: ##"""
### Протокол контейнера
```python
class Deck:
    def __init__(self): self.cards = [1, 2, 3]
    def __len__(self): return len(self.cards)
    def __getitem__(self, idx): return self.cards[idx]
```
"""##,
                contentMarkdownEN: ##"""
### Container Emulation
Enable sequence indexing and iteration on custom objects.
"""##,
                codeSnippet: ##"""
class MiniList:
    def __init__(self, d): self.d = d
    def __len__(self): return len(self.d)
print(len(MiniList([1, 2])))
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_dunder_call_callable",
                category: .pythonDunder,
                titleRU: "Вызываемые Объекты: Метод __call__",
                titleEN: "Callable Objects: Implementing __call__",
                summaryRU: "Превращение экземпляров классов в вызываемые функции со скрытым состоянием.",
                summaryEN: "Making instances behave like callable functions with internal state retention.",
                contentMarkdownRU: ##"""
### Метод __call__
```python
class Multiplier:
    def __init__(self, factor): self.factor = factor
    def __call__(self, x): return x * self.factor
double = Multiplier(2)
print(double(5)) # 10
```
"""##,
                contentMarkdownEN: ##"""
### Callable Instances
Store state across function invocations cleanly.
"""##,
                codeSnippet: ##"""
class Greeter:
    def __init__(self, w): self.w = w
    def __call__(self, n): return f"{self.w}, {n}!"
g = Greeter("Hello")
print(g("World"))
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_descriptors_protocol",
                category: .pythonMetaprogramming,
                titleRU: "Протокол Дескрипторов: __get__, __set__",
                titleEN: "Descriptor Protocol: __get__, __set__ & __set_name__",
                summaryRU: "Механизм под капотом @property, методов и ORM: Data vs Non-data дескрипторы.",
                summaryEN: "Low-level attribute access control: building custom properties and ORM fields.",
                contentMarkdownRU: ##"""
### Дескриптор
```python
class PositiveNumber:
    def __set_name__(self, owner, name): self.name = name
    def __get__(self, obj, objtype=None): return obj.__dict__.get(self.name, 0)
    def __set__(self, obj, val):
        if val < 0: raise ValueError("Отрицательное число")
        obj.__dict__[self.name] = val
```
"""##,
                contentMarkdownEN: ##"""
### The Descriptor Protocol
Powers properties, bound methods, classmethods, and ORM columns.
"""##,
                codeSnippet: ##"""
print("Дескриптор управляет доступом к атрибутам")
"""##,
                xpReward: 50
            ),
            Lesson(
                id: "py_slots_memory_opt",
                category: .pythonMetaprogramming,
                titleRU: "Оптимизация Памяти: Атрибут __slots__",
                titleEN: "Memory Optimization with __slots__",
                summaryRU: "Устранение словаря экземпляра __dict__, сокращение расхода RAM на 60% и ускорение доступа.",
                summaryEN: "Suppressing instance __dict__ overhead for memory optimization in millions of objects.",
                contentMarkdownRU: ##"""
### __slots__
```python
class Node:
    __slots__ = ("val", "next")
    def __init__(self, val):
        self.val = val
        self.next = None
```
"""##,
                contentMarkdownEN: ##"""
### Memory Efficiency
Save significant memory allocations when instantiating millions of objects.
"""##,
                codeSnippet: ##"""
class PointSlots:
    __slots__ = ('x', 'y')
    def __init__(self, x, y): self.x, self.y = x, y
p = PointSlots(1, 2)
print(p.x, p.y)
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_metaclasses_new",
                category: .pythonMetaprogramming,
                titleRU: "Метаклассы и Метод __init_subclass__",
                titleEN: "Metaclasses (type) & __init_subclass__ (PEP 487)",
                summaryRU: "Классы как объекты: создание классов через type(), валидация структуры в __init_subclass__.",
                summaryEN: "Classes as runtime objects: customization with type and lightweight __init_subclass__.",
                contentMarkdownRU: ##"""
### __init_subclass__ (PEP 487)
```python
class PluginBase:
    registry = []
    def __init_subclass__(cls, **kwargs):
        super().__init_subclass__(**kwargs)
        cls.registry.append(cls)
```
"""##,
                contentMarkdownEN: ##"""
### Class Construction Hooks
Intercept subclass creation without heavy metaclass syntax.
"""##,
                codeSnippet: ##"""
print("Метапрограммирование позволяет автоматизировать реестры классов")
"""##,
                xpReward: 50
            ),
            Lesson(
                id: "py_dynamic_attributes",
                category: .pythonMetaprogramming,
                titleRU: "Динамический Доступ: __getattr__ и __getattribute__",
                titleEN: "Dynamic Attributes: __getattr__ vs __getattribute__",
                summaryRU: "Перехват обращений к отсутствующим полям, создание прокси-объектов и встроенные getattr/setattr.",
                summaryEN: "Intercepting attribute lookups, building transparent proxies, and reflection.",
                contentMarkdownRU: ##"""
### __getattr__
Вызывается **только** если атрибут не найден в объекте:
```python
class DynamicBox:
    def __getattr__(self, name):
        return f"Поле {name} отсутствует, но обработано динамически"
```
"""##,
                contentMarkdownEN: ##"""
### Attribute Trapping
Safely handle missing attributes or build dynamic API wrappers.
"""##,
                codeSnippet: ##"""
class DictObj:
    def __init__(self, d): self.d = d
    def __getattr__(self, k): return self.d.get(k)
o = DictObj({"env": "prod"})
print(o.env)
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_collections_defaultdict",
                category: .pythonAdvancedCollections,
                titleRU: "Модуль collections: defaultdict",
                titleEN: "collections Module: defaultdict Pattern",
                summaryRU: "Автоматическая инициализация отсутствующих ключей через фабрику типов (list, int, set).",
                summaryEN: "Eliminating KeyError exceptions with factory-initialized dictionary defaults.",
                contentMarkdownRU: ##"""
### defaultdict
```python
from collections import defaultdict
grouped = defaultdict(list)
grouped["admins"].append("Alex")
```
"""##,
                contentMarkdownEN: ##"""
### Automatic Key Initialization
Group elements into lists without verbose if-key-not-in checks.
"""##,
                codeSnippet: ##"""
from collections import defaultdict
counts = defaultdict(int)
counts['views'] += 1
print(counts['views'])
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_collections_counter",
                category: .pythonAdvancedCollections,
                titleRU: "Модуль collections: Counter и Подсчет Частот",
                titleEN: "collections.Counter: Frequencies & Multiset Math",
                summaryRU: "Эффективный подсчет повторяющихся элементов, метод most_common() и сложение счетчиков.",
                summaryEN: "Rapid frequency distribution counting, most_common() queries, and multiset arithmetic.",
                contentMarkdownRU: ##"""
### Counter
```python
from collections import Counter
words = ["яблоко", "банан", "яблоко"]
c = Counter(words)
print(c.most_common(1)) # [('яблоко', 2)]
```
"""##,
                contentMarkdownEN: ##"""
### Frequency Counting
Count hashable objects cleanly with the Counter multiset.
"""##,
                codeSnippet: ##"""
from collections import Counter
c = Counter("abracadabra")
print(c['a'])
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_collections_deque",
                category: .pythonAdvancedCollections,
                titleRU: "Двусторонняя Очередь collections.deque",
                titleEN: "Double-Ended Queue: collections.deque",
                summaryRU: "Кольцевой буфер O(1) для добавления и извлечения с обоих концов (appendleft, popleft).",
                summaryEN: "O(1) append and pop operations on both ends for high-performance queues and buffers.",
                contentMarkdownRU: ##"""
### deque
```python
from collections import deque
q = deque(maxlen=3) # Скользящее окно
q.append(1); q.append(2); q.append(3); q.append(4)
print(q) # deque([2, 3, 4], maxlen=3)
```
"""##,
                contentMarkdownEN: ##"""
### Fast FIFO Queues
Avoid O(N) list pop(0) penalties using ring buffers.
"""##,
                codeSnippet: ##"""
from collections import deque
d = deque([1, 2])
d.appendleft(0)
print(list(d))
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_itertools_magic",
                category: .pythonAdvancedCollections,
                titleRU: "Модуль itertools: Бесконечные и Комбинаторные Итераторы",
                titleEN: "itertools Module: Infinite & Combinatoric Iterators",
                summaryRU: "Генераторы цепочек chain, декартово произведение product, permutations, combinations.",
                summaryEN: "Memory-efficient iterator algebra: cycle, count, chain, product, and combinations.",
                contentMarkdownRU: ##"""
### itertools
```python
import itertools
pairs = list(itertools.combinations(["A", "B", "C"], 2))
# [('A', 'B'), ('A', 'C'), ('B', 'C')]
```
"""##,
                contentMarkdownEN: ##"""
### Iterator Building Blocks
Compose complex sequences with zero intermediate array allocation.
"""##,
                codeSnippet: ##"""
import itertools
chained = list(itertools.chain([1, 2], [3, 4]))
print(chained)
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_heapq_priority",
                category: .pythonAdvancedCollections,
                titleRU: "Модуль heapq: Двоичная Куча и Приоритеты",
                titleEN: "heapq Module: Min-Heap & Priority Queues",
                summaryRU: "Структура данных Двоичная Куча (Min-Heap): heappush, heappop, nlargest за O(log N).",
                summaryEN: "Logarithmic priority queue operations with standard binary min-heaps.",
                contentMarkdownRU: ##"""
### heapq
```python
import heapq
data = [10, 1, 5, 2]
heapq.heapify(data)
smallest = heapq.heappop(data) # 1
```
"""##,
                contentMarkdownEN: ##"""
### Binary Min-Heaps
Efficiently retrieve top elements and maintain priority orders.
"""##,
                codeSnippet: ##"""
import heapq
h = [5, 2, 8]
heapq.heapify(h)
print(heapq.heappop(h))
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_bisect_binary_search",
                category: .pythonAdvancedCollections,
                titleRU: "Модуль bisect: Бинарный Поиск в Списках",
                titleEN: "bisect Module: Binary Search in Sorted Lists",
                summaryRU: "Быстрый поиск точки вставки за O(log N): bisect_left, insort_left и интервалы оценок.",
                summaryEN: "Logarithmic bisection algorithms for maintaining sorted sequences efficiently.",
                contentMarkdownRU: ##"""
### bisect
```python
import bisect
scores = [60, 70, 80, 90]
pos = bisect.bisect(scores, 75) # индекс 2
```
"""##,
                contentMarkdownEN: ##"""
### Binary Search
Find insertion points in pre-sorted lists without scanning.
"""##,
                codeSnippet: ##"""
import bisect
arr = [10, 20, 30]
print(f"Индекс вставки 15: {bisect.bisect_left(arr, 15)}")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_iterators_protocol",
                category: .pythonGenerators,
                titleRU: "Итераторы: iter(), next() и StopIteration",
                titleEN: "Iterator Protocol: iter(), next() & StopIteration",
                summaryRU: "Низкоуровневый цикл for: метод __iter__ возвращает итератор, метод __next__ выбрасывает StopIteration.",
                summaryEN: "Under the hood of iteration: consumer and producer contracts.",
                contentMarkdownRU: ##"""
### Итератор
```python
nums = [1, 2]
it = iter(nums)
print(next(it)) # 1
print(next(it)) # 2
# next(it) вызовет StopIteration
```
"""##,
                contentMarkdownEN: ##"""
### Iteration Mechanics
Custom iterators implement __iter__ and __next__.
"""##,
                codeSnippet: ##"""
it = iter([42])
print(next(it))
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_generators_yield",
                category: .pythonGenerators,
                titleRU: "Генераторы: Ключевое Слово yield и Сопрограммы",
                titleEN: "Generators: yield & Coroutine Delegation (yield from)",
                summaryRU: "Ленивые последовательности: функции с yield, экономия памяти и делегирование yield from.",
                summaryEN: "Lazy data streaming, pausing execution frames, and delegating subgenerators with yield from.",
                contentMarkdownRU: ##"""
### yield from
```python
def sub_gen():
    yield 1
    yield 2
def main_gen():
    yield from sub_gen()
    yield 3
```
"""##,
                contentMarkdownEN: ##"""
### Streaming with Generators
Process gigabytes of logs or streams in constant memory footprint.
"""##,
                codeSnippet: ##"""
def numbers():
    yield 1; yield 2
print(list(numbers()))
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_context_managers_with",
                category: .pythonGenerators,
                titleRU: "Менеджеры Контекста: Оператор with и __exit__",
                titleEN: "Context Managers: with Statement & @contextmanager",
                summaryRU: "Гарантированная очистка ресурсов, перехват исключений в __exit__ и генераторный @contextmanager.",
                summaryEN: "Deterministic resource management using the with protocol and contextlib.",
                contentMarkdownRU: ##"""
### @contextmanager
```python
from contextlib import contextmanager
@contextmanager
def open_tag(tag):
    print(f"<{tag}>")
    yield
    print(f"</{tag}>")
```
"""##,
                contentMarkdownEN: ##"""
### Deterministic Cleanup
Safely release database transactions, locks, and file handles.
"""##,
                codeSnippet: ##"""
print("Менеджер контекста гарантирует очистку")
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_decorators_func",
                category: .pythonDecorators,
                titleRU: "Декораторы Функций и functools.wraps",
                titleEN: "Function Decorators & functools.wraps",
                summaryRU: "Функции высшего порядка, синтаксический сахар @ и сохранение сигнатуры/документации через wraps.",
                summaryEN: "Wrapping callables cleanly while preserving name, docstrings, and signature via wraps.",
                contentMarkdownRU: ##"""
### Декоратор с wraps
```python
from functools import wraps
def logger(fn):
    @wraps(fn)
    def wrapper(*args, **kwargs):
        print(f"Вызов {fn.__name__}")
        return fn(*args, **kwargs)
    return wrapper
```
"""##,
                contentMarkdownEN: ##"""
### Transparent Wrappers
Extend function behavior without mutating the original implementation.
"""##,
                codeSnippet: ##"""
def dec(fn):
    def w(): return fn() * 2
    return w
@dec
def num(): return 5
print(num())
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_decorators_factories",
                category: .pythonDecorators,
                titleRU: "Декораторы с Аргументами (Фабрики Декораторов)",
                titleEN: "Decorator Factories: Decorators with Arguments",
                summaryRU: "Трехуровневые замыкания: передача параметров в декоратор (@repeat(num=3)) и декорирование классов.",
                summaryEN: "Three-level closure architectures for configurable parameterized decorators.",
                contentMarkdownRU: ##"""
### Декоратор с аргументами
```python
def repeat(times):
    def decorator(fn):
        def wrapper(*args, **kwargs):
            for _ in range(times):
                res = fn(*args, **kwargs)
            return res
        return wrapper
    return decorator
```
"""##,
                contentMarkdownEN: ##"""
### Parameterized Decorators
Configure decorator behavior per function call site.
"""##,
                codeSnippet: ##"""
print("Фабрика декораторов создает настроенную обертку")
"""##,
                xpReward: 50
            ),
            Lesson(
                id: "py_functools_cache",
                category: .pythonDecorators,
                titleRU: "Модуль functools: lru_cache, cache и partial",
                titleEN: "functools Module: lru_cache, cache & partial",
                summaryRU: "Мемоизация вычислений `@lru_cache`, бесконечный `@cache` и фиксация аргументов через `partial`.",
                summaryEN: "Automatic memoization caching and partial argument application for functional programming.",
                contentMarkdownRU: ##"""
### lru_cache
```python
from functools import lru_cache, partial
@lru_cache(maxsize=128)
def fib(n):
    if n < 2: return n
    return fib(n-1) + fib(n-2)
```
"""##,
                contentMarkdownEN: ##"""
### Memoization
Dramatically accelerate recursive and expensive deterministic functions.
"""##,
                codeSnippet: ##"""
from functools import partial
add5 = partial(lambda a, b: a + b, 5)
print(add5(10))
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_pathlib_files",
                category: .pythonIOAndFiles,
                titleRU: "Работа с Файлами: Объектный Модуль pathlib.Path",
                titleEN: "File I/O: Object-Oriented pathlib.Path",
                summaryRU: "Кроссплатформенная работа с файловой системой: оператор /, чтение read_text(), glob и mkdir.",
                summaryEN: "Modern object-oriented file paths, directory traversal, and safe atomic writes.",
                contentMarkdownRU: ##"""
### pathlib.Path
```python
from pathlib import Path
p = Path("data") / "logs" / "app.log"
p.parent.mkdir(parents=True, exist_ok=True)
p.write_text("Лог записан", encoding="utf-8")
```
"""##,
                contentMarkdownEN: ##"""
### Object-Oriented Paths
Replace legacy os.path string concatenations with intuitive slash syntax.
"""##,
                codeSnippet: ##"""
from pathlib import Path
p = Path("test.txt")
print(p.suffix)
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_json_serialization",
                category: .pythonIOAndFiles,
                titleRU: "Сериализация JSON: dumps, loads и Custom Encoders",
                titleEN: "JSON Serialization: dumps, loads & Custom Encoders",
                summaryRU: "Парсинг и экспорт JSON, обработка дат и кастомных классов через параметр default в json.dumps.",
                summaryEN: "Serializing native objects to JSON and decoding nested structures.",
                contentMarkdownRU: ##"""
### json.dumps и Custom Encoder
```python
import json
data = {"user": "Alex", "active": True}
json_str = json.dumps(data, indent=2)
parsed = json.loads(json_str)
```
"""##,
                contentMarkdownEN: ##"""
### Structured JSON
Work with REST API payloads and configuration files seamlessly.
"""##,
                codeSnippet: ##"""
import json
raw = '{"x": 10}'
d = json.loads(raw)
print(d['x'])
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_regex_re",
                category: .pythonIOAndFiles,
                titleRU: "Регулярные Выражения: Модуль re",
                titleEN: "Regular Expressions: re Module & Pattern Matching",
                summaryRU: "Сложные текстовые шаблоны: re.search, re.findall, re.sub, именованные группы (?P<name>...).",
                summaryEN: "Text pattern search, matching, extraction, and substitution with regular expressions.",
                contentMarkdownRU: ##"""
### Модуль re
```python
import re
text = "Email: user@example.com"
match = re.search(r"([\w.]+)@([\w.]+)", text)
if match:
    print(match.group(1)) # user
```
"""##,
                contentMarkdownEN: ##"""
### Regular Expressions
Parse and validate structured string formats.
"""##,
                codeSnippet: ##"""
import re
nums = re.findall(r"\d+", "Заказ 45 на сумму 1200")
print(nums)
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_exceptions_hierarchy",
                category: .pythonExceptions,
                titleRU: "Иерархия Исключений: try, except, else и finally",
                titleEN: "Exception Hierarchy: try, except, else & finally",
                summaryRU: "Иерархия классов BaseException/Exception, блоки else и finally, цепочки raise ... from e.",
                summaryEN: "Structured error handling, clean resource release in finally, and exception chaining.",
                contentMarkdownRU: ##"""
### Исключения
```python
try:
    x = int("abc")
except ValueError as e:
    print(f"Ошибка: {e}")
else:
    print("Успешно")
finally:
    print("Очистка")
```
"""##,
                contentMarkdownEN: ##"""
### Exception Hierarchy
Catch specific subclasses to prevent swallowing unintended system interrupts.
"""##,
                codeSnippet: ##"""
try:
    1 / 1
    print("Успех")
except ZeroDivisionError:
    pass
"""##,
                xpReward: 35
            ),
            Lesson(
                id: "py_custom_exceptions",
                category: .pythonExceptions,
                titleRU: "Пользовательские Классы Исключений",
                titleEN: "Custom Exception Classes & Domain Errors",
                summaryRU: "Создание собственных доменных исключений, наследование от Exception и атрибуты ошибок.",
                summaryEN: "Building clear domain error types with structured diagnostic attributes.",
                contentMarkdownRU: ##"""
### Пользовательское исключение
```python
class InsufficientFundsError(Exception):
    def __init__(self, required, available):
        super().__init__(f"Требуется {required}, доступно {available}")
        self.required = required
        self.available = available
```
"""##,
                contentMarkdownEN: ##"""
### Domain Exceptions
Express business logic failures as distinct typed exceptions.
"""##,
                codeSnippet: ##"""
class AppError(Exception): pass
print("Кастомная ошибка готова к вызову")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_logging_production",
                category: .pythonExceptions,
                titleRU: "Промышленное Логирование: Модуль logging",
                titleEN: "Production Logging: logging Module & Handlers",
                summaryRU: "Иерархия логгеров getLogger(), уровни DEBUG..CRITICAL, FileHandler, Formatter и StreamHandler.",
                summaryEN: "Configuring robust loggers, formatters, and stream/file outputs for production observability.",
                contentMarkdownRU: ##"""
### Модуль logging
```python
import logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(message)s")
logging.info("Сервер запущен")
```
"""##,
                contentMarkdownEN: ##"""
### Logging Standards
Replace unformatted print statements with production-grade loggers.
"""##,
                codeSnippet: ##"""
import logging
logging.warning("Внимание: тестовое предупреждение")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_asyncio_eventloop",
                category: .pythonAsync,
                titleRU: "Асинхронность: async/await, Tasks и Event Loop",
                titleEN: "Asynchronous Python: async/await, Tasks & Event Loop",
                summaryRU: "Кооперативная многозадачность: корутины async def, ключевое слово await и запуск через asyncio.run().",
                summaryEN: "Cooperative concurrency with async/await coroutines executed by the single-threaded event loop.",
                contentMarkdownRU: ##"""
### async / await
```python
import asyncio
async def fetch_data():
    await asyncio.sleep(0.01) # Неблокирующий сон
    return 42

async def main():
    result = await fetch_data()
    print(result)
```
"""##,
                contentMarkdownEN: ##"""
### Non-blocking Async
Handle thousands of concurrent sockets without creating operating system threads.
"""##,
                codeSnippet: ##"""
print("asyncio обеспечивает кооперативную многозадачность")
"""##,
                xpReward: 50
            ),
            Lesson(
                id: "py_asyncio_gather_tasks",
                category: .pythonAsync,
                titleRU: "Параллельное Исполнение: asyncio.gather и Tasks",
                titleEN: "Concurrent Execution: asyncio.gather & Background Tasks",
                summaryRU: "Запуск группы корутин параллельно с asyncio.gather, создание фоновых задач create_task.",
                summaryEN: "Running groups of coroutines concurrently and handling cancellation and timeouts.",
                contentMarkdownRU: ##"""
### asyncio.gather
```python
import asyncio
async def task(n):
    return n * 2
async def main():
    r1, r2 = await asyncio.gather(task(10), task(20))
    print(r1, r2)
```
"""##,
                contentMarkdownEN: ##"""
### Gathering Tasks
Fan-out concurrent network requests and aggregate results efficiently.
"""##,
                codeSnippet: ##"""
print("asyncio.gather объединяет результаты параллельных корутин")
"""##,
                xpReward: 50
            ),
            Lesson(
                id: "py_asyncio_primitives",
                category: .pythonAsync,
                titleRU: "Асинхронные Примитивы: Queue, Lock и Semaphore",
                titleEN: "Async Synchronization: Queue, Lock & Semaphore",
                summaryRU: "Безопасная коммуникация между корутинами: неблокирующая очередь asyncio.Queue и ограничения скорости.",
                summaryEN: "Safe communication and rate-limiting across async coroutines.",
                contentMarkdownRU: ##"""
### asyncio.Queue
```python
import asyncio
queue = asyncio.Queue()
async def producer():
    await queue.put("Message")
async def consumer():
    msg = await queue.get()
```
"""##,
                contentMarkdownEN: ##"""
### Async Queues
Coordinate producer-consumer pipelines in async architectures.
"""##,
                codeSnippet: ##"""
print("asyncio.Queue координирует передачу данных между корутинами")
"""##,
                xpReward: 50
            ),
            Lesson(
                id: "py_gil_architecture",
                category: .pythonConcurrency,
                titleRU: "Архитектура CPython: Global Interpreter Lock (GIL)",
                titleEN: "CPython Internals: Global Interpreter Lock (GIL)",
                summaryRU: "Зачем нужен GIL: потокобезопасность управления памятью (Reference Counting) и влияние на CPU-bound задачи.",
                summaryEN: "Deep dive into the GIL: why it exists, memory reference safety, and impact on CPU vs I/O.",
                contentMarkdownRU: ##"""
### CPython GIL
- **GIL** предотвращает одновременное выполнение байткода на нескольких ядрах в одном процессе.
- Для **I/O-bound** задач (сеть, диски) потоки освобождают GIL во время ожидания.
- Для **CPU-bound** задач (вычисления) необходимо использовать `multiprocessing`.
```python
import sys
# sys._is_gil_enabled() в Python 3.13+ экспериментальном
```
"""##,
                contentMarkdownEN: ##"""
### The GIL Mechanism
Understand when threads give up the GIL during system calls and I/O.
"""##,
                codeSnippet: ##"""
import sys
print(f"Платформа CPython: {sys.version}")
"""##,
                xpReward: 50
            ),
            Lesson(
                id: "py_threading_locks",
                category: .pythonConcurrency,
                titleRU: "Модуль threading: Потоки и Примитивы Блокировки",
                titleEN: "threading Module: OS Threads & Race Conditions",
                summaryRU: "Запуск потоков ОС через threading.Thread, взаимное исключение Lock, RLock и предотвращение Deadlock.",
                summaryEN: "Creating OS threads, mutual exclusion locks, race condition prevention, and reentrant locks.",
                contentMarkdownRU: ##"""
### threading.Lock
```python
import threading
lock = threading.Lock()
counter = 0
def increment():
    global counter
    with lock:
        counter += 1
```
"""##,
                contentMarkdownEN: ##"""
### Thread Synchronization
Protect shared state from concurrent race conditions with locks.
"""##,
                codeSnippet: ##"""
import threading
t = threading.Thread(target=lambda: None)
t.start(); t.join()
print("Поток выполнен")
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_multiprocessing_pools",
                category: .pythonConcurrency,
                titleRU: "Модуль multiprocessing: Обход GIL на Всех Ядрах",
                titleEN: "multiprocessing Module: Bypassing the GIL on Multiple Cores",
                summaryRU: "Параллельные процессы с изолированной памятью: multiprocessing.Process, пулы Pool.map и IPC Queue.",
                summaryEN: "True CPU parallelism by spawning isolated OS processes with inter-process communication.",
                contentMarkdownRU: ##"""
### multiprocessing.Pool
```python
from multiprocessing import Pool
def square(x): return x * x
# with Pool() as p:
#     results = p.map(square, [1, 2, 3, 4])
```
"""##,
                contentMarkdownEN: ##"""
### Multi-Core Parallelism
Bypass the GIL completely by distributing compute intensive jobs across cores.
"""##,
                codeSnippet: ##"""
print("multiprocessing запускает независимые процессы Python")
"""##,
                xpReward: 50
            ),
            Lesson(
                id: "py_concurrent_futures",
                category: .pythonConcurrency,
                titleRU: "Высокоуровневый Модуль concurrent.futures",
                titleEN: "High-Level Concurrency: concurrent.futures",
                summaryRU: "Унифицированный интерфейс: ThreadPoolExecutor и ProcessPoolExecutor, методы submit() и as_completed().",
                summaryEN: "Modern execution pools: switching seamlessly between thread pools and process pools.",
                contentMarkdownRU: ##"""
### ThreadPoolExecutor
```python
from concurrent.futures import ThreadPoolExecutor
def work(n): return n * 10
with ThreadPoolExecutor(max_workers=4) as executor:
    results = list(executor.map(work, [1, 2, 3]))
```
"""##,
                contentMarkdownEN: ##"""
### Unified Executors
Manage thread and process worker pools with clean context managers.
"""##,
                codeSnippet: ##"""
print("concurrent.futures предоставляет удобный пул исполнителей")
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_unittest_mock",
                category: .pythonTestingAndPerf,
                titleRU: "Модульное Тестирование: unittest и MagicMock",
                titleEN: "Unit Testing: unittest Framework & MagicMock",
                summaryRU: "Написание надежных тестов: TestCase, assertions (assertEqual, assertRaises) и мокирование с unittest.mock.",
                summaryEN: "Standard testing conventions: unit test cases, test fixtures, and mock isolation.",
                contentMarkdownRU: ##"""
### unittest
```python
import unittest
class TestMath(unittest.TestCase):
    def test_add(self):
        self.assertEqual(2 + 2, 4)
```
"""##,
                contentMarkdownEN: ##"""
### Unit Testing
Write isolated test suites verifying software contracts.
"""##,
                codeSnippet: ##"""
import unittest
tc = unittest.TestCase()
tc.assertEqual(10, 10)
print("Тест пройден")
"""##,
                xpReward: 40
            ),
            Lesson(
                id: "py_profiling_timeit",
                category: .pythonTestingAndPerf,
                titleRU: "Профилирование Производительности: timeit и cProfile",
                titleEN: "Performance Profiling: timeit & cProfile",
                summaryRU: "Точный замер времени микро-бенчмарков через timeit и анализ узких мест выполнения с cProfile.",
                summaryEN: "Benchmarking small snippets with timeit and profiling function call bottlenecks with cProfile.",
                contentMarkdownRU: ##"""
### timeit
```python
import timeit
elapsed = timeit.timeit("[x for x in range(100)]", number=10000)
print(f"Время выполнения: {elapsed:.4f} сек")
```
"""##,
                contentMarkdownEN: ##"""
### Micro-Benchmarking
Measure algorithmic speed accurately without manual timestamps.
"""##,
                codeSnippet: ##"""
import timeit
t = timeit.timeit("sum([1, 2, 3])", number=1000)
print(f"Время: {t:.5f}s")
"""##,
                xpReward: 45
            ),
            Lesson(
                id: "py_dis_bytecode",
                category: .pythonTestingAndPerf,
                titleRU: "Как Работает CPython: Байткод и Модуль dis",
                titleEN: "CPython Internals: Bytecode & dis Module",
                summaryRU: "Дизассемблирование байткода CPython, стековая виртуальная машина, инструкции LOAD_FAST и BINARY_OP.",
                summaryEN: "Disassembling compiled Python bytecode to understand the stack virtual machine.",
                contentMarkdownRU: ##"""
### Модуль dis
```python
import dis
def compute(a, b):
    return a + b
dis.dis(compute)
# 0 LOAD_FAST 0 (a)
# 2 LOAD_FAST 1 (b)
# 4 BINARY_OP 0 (+)
# 8 RETURN_VALUE
```
"""##,
                contentMarkdownEN: ##"""
### Python Bytecode
Inspect the virtual machine instructions executed by the CPython interpreter.
"""##,
                codeSnippet: ##"""
import dis
dis.dis(compile("a = 1 + 2", "<string>", "exec"))
"""##,
                xpReward: 50
            ),

                        // ==========================================
            // C# 12 & .NET 8 INDUSTRIAL CURRICULUM (52 LESSONS)
            // ==========================================
            Lesson(
                id: "cs_top_level_clr",
                category: .csharpBasics,
                titleRU: "Top-Level Statements, CLR и Архитектура .NET 8",
                titleEN: "Top-Level Statements, CLR & .NET 8 Architecture",
                summaryRU: "Внутренняя архитектура платформы .NET: Common Language Runtime, сборка IL-байткода, JIT-компиляция (RyuJIT) и инструкции верхнего уровня.",
                summaryEN: "Architecture of .NET: Common Language Runtime, IL bytecode assembly, RyuJIT compilation, and top-level statements.",
                contentMarkdownRU: ##"""
### Архитектура платформы .NET 8 и Среда CLR

Платформа **.NET 8** является современной высокопроизводительной кроссплатформенной средой выполнения. Процесс исполнения C# кода состоит из двух ключевых стадий:

1. **Компилятор Roslyn (csc)** переводит исходный C# код в платформонезависимый промежуточный язык **CIL / IL (Common Intermediate Language)** и метаданные типов.
2. **Среда CLR (Common Language Runtime)** выполняет IL-код, используя динамический компилятор **RyuJIT**, который преобразует IL в машинный код конкретного процессора (x64, ARM64) во время первого выполнения метода.
3. В .NET 8 также поддерживается **Native AOT (Ahead-Of-Time)** компиляция напрямую в нативный машинный бинарник без JIT, обеспечивая мгновенный запуск и минимальное потребление RAM.

### Инструкции верхнего уровня (Top-Level Statements)

Начиная с C# 9 и .NET 6, файл точки входа `Program.cs` не требует обязательного объявления пространства имен `namespace`, класса `class Program` и статического метода `static void Main(string[] args)`:

```csharp
using System;

Console.WriteLine("Добро пожаловать в C# 12 и .NET 8!");

string runtimeVersion = Environment.Version.ToString();
Console.WriteLine($"Версия .NET Среды: {runtimeVersion}");
```

Компилятор автоматически оборачивает этот код в синтетический скрытый метод точки входа. Переменная `args` (массив аргументов командной строки) доступна неявно.
"""##,
                contentMarkdownEN: ##"""
### .NET 8 Architecture & Common Language Runtime

**.NET 8** is an enterprise-grade cross-platform runtime environment. Execution involves two distinct compilation phases:

1. **Roslyn Compiler (csc)** compiles source C# code into platform-agnostic **CIL / IL (Common Intermediate Language)** along with type metadata.
2. **CLR (Common Language Runtime)** executes the IL code using **RyuJIT**, compiling IL into native CPU instructions on demand.
3. **Native AOT (Ahead-Of-Time)** enables compiling directly to a standalone native binary without JIT overhead.

### Top-Level Statements

Top-level statements remove the boilerplate `class Program` and `static void Main`:

```csharp
using System;

Console.WriteLine("Welcome to C# 12 and .NET 8!");
```
"""##,
                codeSnippet: ##"""
using System;

Console.WriteLine("C# 12 & .NET 8 CLR Runtime");
string os = Environment.OSVersion.ToString();
Console.WriteLine($"Operating System: {os}");
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_variables_var",
                category: .csharpBasics,
                titleRU: "Переменные, Константы и Неявная типизация var",
                titleEN: "Variables, Constants & Implicit Typing (var)",
                summaryRU: "Статическая строгая типизация в C#: явное объявление, неявный вывод типов через var, константы const и модификатор readonly.",
                summaryEN: "Static strong typing in C#: explicit types, compile-time inference with var, const, and readonly.",
                contentMarkdownRU: ##"""
### Статическая типизация и ключевое слово `var`

C# — **строго типизированный** язык со статической проверкой типов во время компиляции. Ключевое слово `var` не делает переменную динамической — оно заставляет компилятор Roslyn **автоматически вывести точный тип** из правой части выражения:

```csharp
int explicitNumber = 42;
var inferredNumber = 42; // Тип строго выводится как System.Int32

var title = "SwiftLearn"; // System.String
// title = 100; // Ошибка компиляции: Невозможно преобразовать int в string!
```

### Константы `const` против полей `readonly`

- **`const`**: значение вычисляется **на этапе компиляции**. Значение должно быть литералом или примитивным константным выражением. Константы встраиваются прямо в IL-байткод потребителей.
- **`readonly`**: значение может быть вычислено **во время выполнения** (runtime) при инициализации или внутри конструктора объекта.

```csharp
public class ServerConfig {
    public const int DefaultPort = 8080; // Compile-time константа
    public readonly DateTime StartedAt = DateTime.UtcNow; // Runtime readonly
}
```

### Значения по умолчанию (`default`)
Каждый тип в C# имеет дефолтное состояние (`0` для чисел, `false` для `bool`, `null` для ссылочных типов). Получить его можно через `default` или `default(T)`.
"""##,
                contentMarkdownEN: ##"""
### Static Typing and `var`

C# is statically typed. The `var` keyword instructs the compiler to infer the type at compile-time:

```csharp
var count = 10; // System.Int32
var message = "Hello"; // System.String
```

### `const` vs `readonly`
- `const`: compile-time constant embedded into IL.
- `readonly`: runtime constant initialized inline or within a constructor.
"""##,
                codeSnippet: ##"""
var score = 100;
const double Pi = 3.1415926535;
var isComplete = false;

Console.WriteLine($"Score: {score}, Pi: {Pi}, Completed: {isComplete}");
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_operators_arithmetic",
                category: .csharpBasics,
                titleRU: "Операторы, Приведение типов и checked/unchecked",
                titleEN: "Operators, Type Casting & Checked/Unchecked Contexts",
                summaryRU: "Арифметические и побитовые операции, безопасное и явное приведение типов, контроль целочисленного переполнения checked и unchecked.",
                summaryEN: "Arithmetic and bitwise operators, type casting, and overflow handling with checked/unchecked blocks.",
                contentMarkdownRU: ##"""
### Арифметические операции и контроль переполнения

В C# целочисленные операции по умолчанию выполняются в режиме `unchecked` для максимальной скорости (при превышении `int.MaxValue` происходит круговой сдвиг без ошибки).

Когда требуется гарантировать отсутствие арифметического переполнения, используется контекст `checked`:

```csharp
int max = int.MaxValue;

// Без checked: переполнение происходит молча (становится отрицательным)
int overflowed = max + 1; // -2147483648

// С checked: выбрасывается исключение OverflowException
try {
    checked {
        int fatal = max + 1;
    }
} catch (OverflowException) {
    Console.WriteLine("Переполнение заблокировано!");
}
```

### Явное и неявное приведение (Casting)
- **Неявное (Implicit)**: когда потеря данных невозможна (`int` ➔ `long`, `float` ➔ `double`).
- **Явное (Explicit)**: при риске потери точности или переполнения, с использованием синтаксиса `(targetType)val`.
"""##,
                contentMarkdownEN: ##"""
### Operators and Overflow Detection

By default, integer arithmetic in C# wraps around (`unchecked`). The `checked` keyword throws an `OverflowException` on overflow:

```csharp
int max = int.MaxValue;
checked {
    // Throws OverflowException
    int next = max + 1;
}
```
"""##,
                codeSnippet: ##"""
int a = 15;
int b = 4;
int quotient = a / b;
int remainder = a % b;

Console.WriteLine($"15 / 4 = {quotient}, Remainder = {remainder}");
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_value_vs_reference",
                category: .csharpTypes,
                titleRU: "Значимые типы (struct) против Ссылочных (class)",
                titleEN: "Value Types (struct) vs Reference Types (class)",
                summaryRU: "Стек и управляемая куча в CLR, семантика копирования по значению против копирования указателя, накладные расходы упаковки Boxing и Unboxing.",
                summaryEN: "Stack vs Managed Heap in CLR, value copy semantics vs reference pointer copying, and boxing/unboxing overhead.",
                contentMarkdownRU: ##"""
### Модель памяти CLR: Стек (Stack) и Куча (Managed Heap)

В C# все типы разделены на две фундаментальные категории:

| Характеристика | Значимые типы (Value Types / `struct`) | Ссылочные типы (Reference Types / `class`) |
| :--- | :--- | :--- |
| **Примеры** | `int`, `double`, `bool`, `DateTime`, `struct` | `string`, `object`, массивы `T[]`, `class`, делегаты |
| **Размещение** | В стеке (локальные) или внутри владельца | В управляемой куче (Managed Heap) |
| **Копирование** | Копируется **само значение** байт в байт | Копируется **только адрес/ссылка** на объект в куче |
| **Очистка** | Мгновенно при выходе из скоупа стека | Сборщиком мусора (Garbage Collector) |

```csharp
// Значимый тип:
public struct Point {
    public int X;
    public int Y;
}

Point p1 = new Point { X = 10, Y = 20 };
Point p2 = p1; // Полная копия данных!
p2.X = 99;
Console.WriteLine(p1.X); // Выведет 10 (оригинал не изменился)

// Ссылочный тип:
public class Node {
    public int Value;
}

Node n1 = new Node { Value = 10 };
Node n2 = n1; // Скопирован только указатель в кучу!
n2.Value = 99;
Console.WriteLine(n1.Value); // Выведет 99 (оба указывают на один объект)
```

### Упаковка (Boxing) и Распаковка (Unboxing)
- **Boxing**: преобразование значимого типа в `object` или интерфейс. CLR аллоцирует новый блок памяти в куче и копирует туда значение.
- **Unboxing**: извлечение значимого типа из `object` с проверкой соответствия типов.
Упаковка создает дополнительное давление на сборщик мусора (GC), поэтому дженерики (`List<int>` вместо `ArrayList`) являются критически важным решением.
"""##,
                contentMarkdownEN: ##"""
### Memory Model: Structs vs Classes

- **Value Types (`struct`)**: stored inline on the stack, copied by value.
- **Reference Types (`class`)**: allocated on the managed heap, copied by reference pointer.

Boxing wraps a value type in an object on the heap; unboxing extracts it.
"""##,
                codeSnippet: ##"""
struct Vector2D {
    public double X;
    public double Y;
}

Vector2D v1 = new Vector2D { X = 3.0, Y = 4.0 };
Vector2D v2 = v1; // Value copy
v2.X = 10.0;

Console.WriteLine($"v1.X: {v1.X}, v2.X: {v2.X}");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_nullable_reference_types",
                category: .csharpTypes,
                titleRU: "Nullable Ссылочные Типы (NRT) и Null-Safety",
                titleEN: "Nullable Reference Types (NRT) & Null Safety",
                summaryRU: "Защита от NullReferenceException во время компиляции: директива #nullable enable, типы T?, операторы ?., ??, ??= и null-forgiving оператор !.",
                summaryEN: "Compile-time prevention of NullReferenceException: #nullable enable, T? types, ?., ??, ??=, and null-forgiving !.",
                contentMarkdownRU: ##"""
### Null-Safety в современном C#

Исторически `NullReferenceException` был одной из самых частых причин падения программ («ошибка на миллиард долларов»). Начиная с C# 8, компилятор поддерживает **Nullable Reference Types**:

```csharp
#nullable enable

string nonNullable = "SwiftLearn"; // Не может быть null!
// nonNullable = null; // Предупреждение компилятора CS8600

string? nullableString = null; // Разрешено содержать null
```

### Операторы работы с null

1. **Null-Conditional `?.`**: безопасный вызов метода или свойства:
```csharp
int? length = nullableString?.Length; // Если null, вернет null без выброса исключения
```

2. **Null-Coalescing `??`**: значение по умолчанию, если левый операнд равен `null`:
```csharp
string display = nullableString ?? "Значение по умолчанию";
```

3. **Null-Coalescing Assignment `??=`**: присвоение значения только если переменная равна `null`:
```csharp
nullableString ??= "Инициализировано";
```

4. **Null-Forgiving Operator `!`**: указание компилятору подавить предупреждение, когда разработчик на 100% уверен, что значение не равно `null`:
```csharp
string guaranteed = nullableString!;
```
"""##,
                contentMarkdownEN: ##"""
### Nullable Reference Types

With `#nullable enable`, non-null references cannot hold `null`. Nullable references are explicitly annotated with `?`:

```csharp
string? name = null;
string greeting = name ?? "Anonymous";
Console.WriteLine(greeting);
```
"""##,
                codeSnippet: ##"""
string? input = null;
string resolved = input ?? "Fallback Value";
Console.WriteLine($"Resolved: {resolved}");

input ??= "Assigned now";
Console.WriteLine($"Input: {input}");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_valuetuples",
                category: .csharpTypes,
                titleRU: "Кортежи ValueTuple и Деконструкция",
                titleEN: "ValueTuples & Positional Deconstruction",
                summaryRU: "Легковесные структуры ValueTuple, именование элементов, возврат нескольких значений из метода и синтаксис деконструкции через deconstruct.",
                summaryEN: "Lightweight ValueTuples, named elements, multi-value method returns, and deconstruction syntax.",
                contentMarkdownRU: ##"""
### Кортежи `ValueTuple`

В C# 7 появился тип `ValueTuple` — легковесная значимая структура, не требующая аллокаций в куче в отличие от устаревшего ссылочного `System.Tuple`.

```csharp
// Именованные кортежи:
(int statusCode, string statusMessage, bool isOk) response = (200, "OK", true);

Console.WriteLine($"Status: {response.statusCode}, Message: {response.statusMessage}");
```

### Возврат нескольких значений из функций
Кортежи идеально подходят для возврата нескольких связанных значений без создания лишних DTO-классов:

```csharp
public static (double min, double max, double avg) CalculateStats(int[] numbers) {
    double min = numbers[0];
    double max = numbers[0];
    double sum = 0;
    foreach (var n in numbers) {
        if (n < min) min = n;
        if (n > max) max = n;
        sum += n;
    }
    return (min, max, sum / numbers.Length);
}
```

### Деконструкция кортежей
```csharp
var (low, high, mean) = CalculateStats([10, 20, 30, 40]);
Console.WriteLine($"Min: {low}, Max: {high}, Avg: {mean}");

// Отбрасывание ненужных значений через discard _:
var (_, highest, _) = CalculateStats([10, 20, 30, 40]);
```
"""##,
                contentMarkdownEN: ##"""
### ValueTuples and Multi-Value Returns

`ValueTuple` is an unboxed value type enabling clean multi-value returns:

```csharp
(int id, string role) GetUser() => (42, "Admin");
var (userId, userRole) = GetUser();
```
"""##,
                codeSnippet: ##"""
(string Name, int Level) hero = ("Warrior", 45);
var (heroName, heroLevel) = hero;

Console.WriteLine($"Hero: {heroName}, Level: {heroLevel}");
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_pattern_matching_switch",
                category: .csharpControlFlow,
                titleRU: "Современный Pattern Matching и switch expressions",
                titleEN: "Pattern Matching & Modern switch Expressions",
                summaryRU: "Декларативное сопоставление с шаблонами в C# 12: switch expressions, реляционные шаблоны >, <, логические связки and, or, not.",
                summaryEN: "Declarative pattern matching: switch expressions, relational patterns, and logical combinators.",
                contentMarkdownRU: ##"""
### Switch Expressions в C#

Традиционный `switch-case` с многострочными `break` заменен на лаконичные **switch expressions**:

```csharp
int httpStatus = 404;

string message = httpStatus switch {
    200 => "Успешно",
    201 => "Создано",
    400 => "Неверный запрос",
    404 => "Не найдено",
    500 => "Внутренняя ошибка сервера",
    _ => "Неизвестный статус" // Шаблон по умолчанию (discard)
};
```

### Реляционные и логические шаблоны (`and`, `or`, `not`)
C# позволяет сопоставлять диапазоны чисел напрямую без громоздких условий:

```csharp
string ClassifyTemperature(double temp) => temp switch {
    < -20 => "Экстремальный мороз",
    >= -20 and < 0 => "Мороз",
    >= 0 and < 18 => "Прохладно",
    >= 18 and <= 25 => "Комфортно",
    > 25 and <= 35 => "Жарко",
    > 35 => "Экстремальная жара",
    _ => "Некорректное значение"
};

// Проверка на null через not:
if (message is not null) {
    Console.WriteLine(message);
}
```
"""##,
                contentMarkdownEN: ##"""
### Switch Expressions & Relational Patterns

Modern pattern matching replaces legacy switch statements:

```csharp
string GetTier(int points) => points switch {
    >= 1000 => "Platinum",
    >= 500 => "Gold",
    >= 100 => "Silver",
    _ => "Bronze"
};
```
"""##,
                codeSnippet: ##"""
int score = 85;
string grade = score switch {
    >= 90 => "A",
    >= 80 => "B",
    >= 70 => "C",
    _ => "F"
};

Console.WriteLine($"Score {score} -> Grade {grade}");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_property_and_list_patterns",
                category: .csharpControlFlow,
                titleRU: "Property Patterns, Positional & List Patterns",
                titleEN: "Property, Positional & List Patterns",
                summaryRU: "Глубокая инспекция объектов и коллекций: шаблоны свойств { Prop: pattern }, сопоставление списков и массивов [var head, .., var tail].",
                summaryEN: "Deep object and collection matching: property patterns, positional patterns, and list patterns.",
                contentMarkdownRU: ##"""
### Property Patterns (Шаблоны свойств)

Шаблоны свойств позволяют проверить внутренние поля и свойства объекта внутри сопоставления:

```csharp
public record Order(int Id, double Total, bool IsPriority, string Country);

double CalculateShipping(Order order) => order switch {
    { Total: > 10000, IsPriority: true } => 0.0, // Бесплатная экспресс-доставка
    { Country: "RU", Total: > 3000 } => 250.0,
    { Country: "RU" } => 500.0,
    { Country: "US" or "DE" } => 1500.0,
    _ => 3000.0
};
```

### List Patterns (Сопоставление коллекций)
Начиная с C# 11, поддерживается сопоставление массивов и списков:

```csharp
int[] numbers = [1, 2, 3, 4, 5];

string description = numbers switch {
    [] => "Пустая коллекция",
    [var single] => $"Ровно один элемент: {single}",
    [var first, var second] => $"Пара: {first} и {second}",
    [var head, .., var tail] => $"Начало {head}, срез внутри, конец {tail}",
    _ => "Другой шаблон"
};
```
Срез `..` (slice pattern) сопоставляется с нулем или более промежуточных элементов.
"""##,
                contentMarkdownEN: ##"""
### Property and List Patterns

Property patterns inspect fields directly. List patterns match collection sequences:

```csharp
int[] data = [10, 20, 30];
if (data is [var first, .., var last]) {
    Console.WriteLine($"First: {first}, Last: {last}");
}
```
"""##,
                codeSnippet: ##"""
int[] sequence = [100, 200, 300, 400];
var matchResult = sequence switch {
    [var first, .., var last] => $"Start: {first}, End: {last}",
    _ => "Other"
};

Console.WriteLine(matchResult);
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_loops_iteration",
                category: .csharpControlFlow,
                titleRU: "Циклы: foreach, for, while и duck-typed GetEnumerator",
                titleEN: "Loops: foreach, for, while & Duck-Typed Enumeration",
                summaryRU: "Итерационные конструкции в C#: производительность for vs foreach, контракт GetEnumerator без интерфейсов и прерывание break/continue.",
                summaryEN: "Iteration constructs: for vs foreach performance, duck-typed GetEnumerator, and loop control.",
                contentMarkdownRU: ##"""
### Цикл `foreach` и механизм Enumeration

В отличие от многих языков, в C# цикл `foreach` не обязательно требует реализации интерфейса `IEnumerable`. Компилятор использует **duck typing**: если тип имеет публичный метод `GetEnumerator()`, возвращающий объект с методом `MoveNext()` и свойством `Current`, `foreach` скомпилируется успешно!

```csharp
string[] languages = ["Swift", "Python", "C#", "SQL"];

foreach (var lang in languages) {
    if (lang == "SQL") continue; // Пропуск шага
    Console.WriteLine($"Изучаем: {lang}");
}
```

### Оптимизация массивов в `for` и `foreach`
Для одномерных массивов `T[]` и `Span<T>` JIT-компилятор автоматически преобразует `foreach` в эффективный индексированный цикл `for` и выполняет оптимизацию **BCE (Bounds Check Elimination)** — убирая накладные расходы на проверку выхода за границы массива внутри цикла.
"""##,
                contentMarkdownEN: ##"""
### Loops and Enumeration Mechanics

The `foreach` loop relies on pattern-based duck typing (looking for a `GetEnumerator()` method). For arrays, RyuJIT eliminates bounds checks.
"""##,
                codeSnippet: ##"""
int sum = 0;
int[] numbers = [2, 4, 6, 8, 10];

foreach (var n in numbers) {
    sum += n;
}

Console.WriteLine($"Total sum: {sum}");
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_string_interpolation",
                category: .csharpStringsAndSpans,
                titleRU: "Интерполяция строк, Форматирование и StringBuilder",
                titleEN: "String Interpolation, Format Specifiers & StringBuilder",
                summaryRU: "Неизменяемость строк System.String, эффективная сборка текста через StringBuilder, интерполяция $ и форматирование чисел и дат.",
                summaryEN: "String immutability, high-performance text building with StringBuilder, and string interpolation formatting.",
                contentMarkdownRU: ##"""
### Строки в C# (`System.String`)

Строки в C# являются **неизменяемыми (immutable)** ссылочными типами в куче. Любая модификация строки создает новый строковый объект в памяти.

### Интерполяция и спецификаторы формата
Символ `$` активирует строковую интерполяцию с поддержкой точного форматирования:

```csharp
double price = 1249.954;
DateTime now = DateTime.UtcNow;

Console.WriteLine($"Цена: {price:F2} руб."); // Округление до 2 знаков: 1249.95
Console.WriteLine($"Процент: {0.85:P0}");    // 85 %
Console.WriteLine($"Дата: {now:yyyy-MM-dd HH:mm:ss}");
```

### `StringBuilder` для сборки текста в циклах
Когда текст формируется в цикле, оператор `+` приводит к O(N²) аллокациям в куче. Класс `System.Text.StringBuilder` использует внутренний буфер и выделяет память по мере необходимости:

```csharp
using System.Text;

var sb = new StringBuilder();
for (int i = 0; i < 100; i++) {
    sb.Append(i).Append(", ");
}
string result = sb.ToString();
```
"""##,
                contentMarkdownEN: ##"""
### Strings & StringBuilder

`System.String` is immutable. Repeated concatenations allocate heap objects. `StringBuilder` buffers mutations efficiently:

```csharp
var sb = new StringBuilder();
sb.Append("Value: ").Append(42);
Console.WriteLine(sb.ToString());
```
"""##,
                codeSnippet: ##"""
using System.Text;

var builder = new StringBuilder();
builder.Append("Report: ");
builder.Append(100).Append(" items processed.");

Console.WriteLine(builder.ToString());
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_raw_string_literals",
                category: .csharpStringsAndSpans,
                titleRU: "Raw String Literals, escape-последовательности и UTF-8",
                titleEN: "Raw String Literals & UTF-8 Literals",
                summaryRU: "Многострочные литералы с тройными кавычками \"\"\", интерполяция вложенного JSON через $$ и литералы u8 в байтовом представлении.",
                summaryEN: "Raw multi-line string literals with triple quotes, nested JSON interpolation with $$, and u8 byte literals.",
                contentMarkdownRU: ##"""
### Raw String Literals (C# 11+)

Для вставки JSON, SQL или регулярных выражений раньше приходилось экранировать кавычки `\"` или использовать `@""`. В современном C# используются **сырые строковые литералы** с тремя и более кавычками `"""`:

```csharp
string json = """
{
    "service": "SwiftLearn",
    "version": 12,
    "active": true
}
""";
```

### Интерполяция внутри JSON ($$ синтаксис)
Если внутри строки есть фигурные скобки (например, JSON-объект), количество знаков доллара $$ указывает, сколько скобок требуется для вычисления переменной:

```csharp
string user = "Dmitry";
int age = 28;

// Двойной доллар: {{user}} воспринимается как вычисляемое значение, а одиночные { } остаются текстом JSON!
string userJson = $$"""
{
    "username": "{{user}}",
    "userAge": {{age}}
}
""";
```

### UTF-8 литералы (`u8`)
Постфикс `u8` создает `ReadOnlySpan<byte>` напрямую в сегменте данных без перекодирования в UTF-16:
```csharp
ReadOnlySpan<byte> utf8Bytes = "HTTP/1.1 200 OK"u8;
```
"""##,
                contentMarkdownEN: ##"""
### Raw String Literals & $$ Interpolation

Raw string literals eliminate quote escaping. Using $$ specifies how many curly braces denote interpolation:

```csharp
string id = "101";
string json = $$"""{ "id": "{{id}}" }""";
Console.WriteLine(json);
```
"""##,
                codeSnippet: ##"""
string name = "SwiftLearn";
string snippet = $$"""
{
    "appName": "{{name}}",
    "status": "ready"
}
""";

Console.WriteLine(snippet);
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_spans_memory_basics",
                category: .csharpStringsAndSpans,
                titleRU: "Высокопроизводительная память: ReadOnlySpan<T> и Slice",
                titleEN: "High-Performance Memory: ReadOnlySpan<T> & Slices",
                summaryRU: "Стек-ориентированные типы ref struct, безопасные срезы памяти без аллокаций в куче через ReadOnlySpan<char> и метод Slice.",
                summaryEN: "Stack-only ref struct types, zero-allocation memory slicing via ReadOnlySpan<T> and Slice.",
                contentMarkdownRU: ##"""
### Революция производительности: `Span<T>` и `ReadOnlySpan<T>`

`Span<T>` — это специализированная **`ref struct`**, представляющая непрерывный срез произвольной памяти (массив на куче, буфер на стеке или неуправляемая память).

Главное преимущество: **нулевые аллокации (Zero-Allocation)** при парсинге строк и массивов:

```csharp
string url = "https://swiftlearn.dev/api/v1/lessons";

// Старый способ (Substring аллоцирует новую строку в куче):
// string host = url.Substring(8, 14);

// Современный способ (срез памяти без аллокаций):
ReadOnlySpan<char> span = url.AsSpan();
ReadOnlySpan<char> hostSpan = span.Slice(8, 14);

Console.WriteLine(hostSpan.ToString()); // swiftlearn.dev
```

### Ограничения `ref struct`
Поскольку `Span<T>` содержит указатель на стек, CLR запрещает:
1. Помещать `Span<T>` в поля обычного класса (он не может попасть в кучу).
2. Использовать `Span<T>` внутри асинхронных методов `async/await` через точки ожидания (так как конечный автомат асинхронности сохраняет состояние в куче).
"""##,
                contentMarkdownEN: ##"""
### ReadOnlySpan<T> & Zero-Allocation Slicing

`Span<T>` enables slicing contiguous memory without heap allocations. As a `ref struct`, it lives only on the execution stack:

```csharp
string text = "2026-11-18";
ReadOnlySpan<char> year = text.AsSpan(0, 4);
Console.WriteLine(year.ToString());
```
"""##,
                codeSnippet: ##"""
string log = "ERROR: Connection timed out";
ReadOnlySpan<char> span = log.AsSpan();
ReadOnlySpan<char> level = span.Slice(0, 5);

Console.WriteLine($"Log level: {level.ToString()}");
"""##,
                xpReward: 45
            ),

            Lesson(
                id: "cs_classes_encapsulation",
                category: .csharpOOP,
                titleRU: "Классы, Модификаторы Доступа и Инкапсуляция",
                titleEN: "Classes, Access Modifiers & Encapsulation",
                summaryRU: "Фундамент ООП в C#: состояние и поведение классов, сокрытие реализации, модификаторы public, private, protected, internal и file.",
                summaryEN: "OOP foundations in C#: state and behavior, data hiding, and public/private/protected/internal/file modifiers.",
                contentMarkdownRU: ##"""
### Классы и Модификаторы доступа в C#

Класс — это ссылочный тип, инкапсулирующий данные (поля) и операции над ними (методы).

### 6 уровней доступа в C#
1. **`public`**: доступен из любой сборки и кода.
2. **`private`**: доступен только внутри данного класса или структуры.
3. **`protected`**: доступен внутри класса и его классов-наследников.
4. **`internal`**: доступен из любого кода **внутри той же сборки (.dll / .exe)**.
5. **`protected internal`**: доступен в той же сборке ИЛИ из наследников в других сборках.
6. **`file` (C# 11)**: ограничен областью видимости текущего исходного файла `.cs` (идеально для генераторов исходного кода Source Generators).

```csharp
public class BankAccount {
    private decimal _balance; // Инкапсулированное скрытое поле

    public void Deposit(decimal amount) {
        if (amount <= 0) throw new ArgumentOutOfRangeException(nameof(amount));
        _balance += amount;
    }

    public decimal GetBalance() => _balance;
}
```
"""##,
                contentMarkdownEN: ##"""
### Classes and Encapsulation

Encapsulation hides internal state behind validated methods:

```csharp
public class Counter {
    private int _count;
    public void Increment() => _count++;
    public int Value => _count;
}
```
"""##,
                codeSnippet: ##"""
public class Account {
    private decimal _balance = 1000m;
    public decimal Balance => _balance;
    public void Add(decimal amount) => _balance += amount;
}

var acc = new Account();
acc.Add(250m);
Console.WriteLine($"Balance: {acc.Balance}");
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_properties_init",
                category: .csharpOOP,
                titleRU: "Автосвойства, Expression-Bodied члены и init-only",
                titleEN: "Auto-Properties, Expression-Bodied Members & init",
                summaryRU: "Свойства как замена геттеров/сеттеров: автосвойства get; set;, неизменяемость при создании get; init;, и синтаксис =>.",
                summaryEN: "Properties in C#: auto-properties, init-only setters for post-creation immutability, and expression bodies.",
                contentMarkdownRU: ##"""
### Свойства в C#

Свойства защищают данные класса, притворяясь полями при обращении (`obj.Prop = 5`), но компилируясь в методы `get_Prop()` и `set_Prop()`.

### Автоматические свойства и `init-only`
```csharp
public class UserProfile {
    // get; set; — чтение и запись
    public string DisplayName { get; set; } = string.Empty;

    // get; init; (C# 9+) — инициализируется ТОЛЬКО при создании объекта, затем неизменяемо:
    public string UserId { get; init; } = Guid.NewGuid().ToString();

    // Вычисляемое свойство (Expression-Bodied):
    public bool IsAdmin => DisplayName == "Administrator";
}

var user = new UserProfile {
    DisplayName = "Elena",
    UserId = "usr_007" // Разрешено только в блоке инициализатора!
};
// user.UserId = "new_id"; // Ошибка компиляции: свойство init-only!
```
"""##,
                contentMarkdownEN: ##"""
### Auto-Properties and `init` Setters

Properties expose clean accessors. `init` setters enforce immutability after construction:

```csharp
public class Device {
    public string SerialNumber { get; init; } = "";
}
var dev = new Device { SerialNumber = "SN-9901" };
```
"""##,
                codeSnippet: ##"""
public class Product {
    public string Title { get; init; } = "";
    public decimal Price { get; set; }
}

var p = new Product { Title = "SwiftBook", Price = 49.99m };
Console.WriteLine($"{p.Title} costs ${p.Price}");
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_primary_constructors",
                category: .csharpOOP,
                titleRU: "Конструкторы и Primary Constructors (C# 12)",
                titleEN: "Constructors & Primary Constructors (C# 12)",
                summaryRU: "Инициализация объектов: классические конструкторы, цепочки вызова : this(), и синтаксис первичных конструкторов C# 12 для классов.",
                summaryEN: "Object initialization: classic constructors, : this() chaining, and C# 12 primary constructors on classes.",
                contentMarkdownRU: ##"""
### Первичные конструкторы в C# 12 (Primary Constructors)

В C# 12 синтаксис первичных конструкторов (ранее доступный только для `record`) был расширен на **все классы и структуры**. Параметры объявляются прямо в заголовке класса и доступны во всем теле класса:

```csharp
// Первичный конструктор C# 12:
public class OrderService(ILogger logger, IDatabase db, int maxRetries = 3) {
    public void ProcessOrder(int orderId) {
        logger.Log($"Обработка заказа #{orderId} (макс. попыток: {maxRetries})");
        db.Save(orderId);
    }
}
```

Параметры первичного конструктора не создают автоматически публичные свойства в обычных классах (в отличие от `record`), а служат захваченными значениями конструктора, избавляя от бойлерплейта по объявлению приватных полей `private readonly ILogger _logger`.
"""##,
                contentMarkdownEN: ##"""
### Primary Constructors in C# 12

Declare constructor arguments directly in the class header:

```csharp
public class Greeter(string greetingPrefix) {
    public void Greet(string name) => Console.WriteLine($"{greetingPrefix}, {name}!");
}
```
"""##,
                codeSnippet: ##"""
public class Calculator(int baseValue) {
    public int Add(int x) => baseValue + x;
}

var calc = new Calculator(100);
Console.WriteLine($"100 + 45 = {calc.Add(45)}");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_inheritance_polymorphism",
                category: .csharpInheritance,
                titleRU: "Наследование: virtual, override и base",
                titleEN: "Inheritance: virtual, override & base",
                summaryRU: "Одиночное наследование классов в C#, таблица виртуальных методов vtable, переопределение override и вызов базовой логики base.",
                summaryEN: "Single inheritance in C#, virtual method dispatch, override, and calling base class implementations.",
                contentMarkdownRU: ##"""
### Наследование и динамический полиморфизм

C# поддерживает одиночное наследование классов (`class Derived : Base`).

Методы в C# по умолчанию являются **невиртуальными** (non-virtual). Для включения динамической диспетчеризации метод в базовом классе должен быть явно помечен как `virtual`, а в наследнике — как `override`:

```csharp
public class Notification {
    public virtual void Send(string message) {
        Console.WriteLine($"[Базовое уведомление]: {message}");
    }
}

public class EmailNotification : Notification {
    public override void Send(string message) {
        base.Send(message); // Вызов реализации базового класса
        Console.WriteLine($"Отправлен почтовый пакет SMTP: {message}");
    }
}

Notification notif = new EmailNotification();
notif.Send("Ваш код: 7421"); // Вызовет переопределенный метод EmailNotification!
```
"""##,
                contentMarkdownEN: ##"""
### Virtual Methods and Override

Methods are non-virtual by default. Use `virtual` in the base class and `override` in derived classes:

```csharp
public class Animal {
    public virtual string Speak() => "Sound";
}
public class Dog : Animal {
    public override string Speak() => "Woof";
}
```
"""##,
                codeSnippet: ##"""
public class Shape {
    public virtual double Area() => 0.0;
}
public class Square(double side) : Shape {
    public override double Area() => side * side;
}

Shape s = new Square(5.0);
Console.WriteLine($"Square area: {s.Area()}");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_abstract_sealed",
                category: .csharpInheritance,
                titleRU: "Абстрактные классы (abstract) и Запечатанные типы (sealed)",
                titleEN: "Abstract Classes & Sealed Modifiers",
                summaryRU: "Каркасы логики через abstract class, обязательные к реализации члены, и запрет наследования sealed для безопасности и JIT-девиртуализации.",
                summaryEN: "Template design with abstract classes and preventing derivation using sealed for security and JIT devirtualization.",
                contentMarkdownRU: ##"""
### Абстрактные классы (`abstract`)

Абстрактный класс не может быть инстанциирован напрямую (`new AbstractClass()` запрещен). Он служит шаблоном для производных классов:

```csharp
public abstract class PaymentProcessor {
    public abstract string Name { get; }
    public abstract bool ProcessPayment(decimal amount);

    public void PrintReceipt(decimal amount) {
        Console.WriteLine($"Чек от {Name}: {amount:C2}");
    }
}
```

### Запечатанные классы (`sealed`)
Ключевое слово `sealed` **запрещает наследование** от данного класса.
Преимущества:
1. Защита архитектуры от некорректного переопределения.
2. **JIT-оптимизация (Devirtualization)**: зная, что у `sealed`-класса не может быть потомков, RyuJIT компилирует виртуальные вызовы в прямые вызовы функций, устраняя накладные расходы vtable.
"""##,
                contentMarkdownEN: ##"""
### Abstract and Sealed Modifiers

- `abstract`: defines an incomplete class template that cannot be instantiated.
- `sealed`: prevents other classes from inheriting, enabling JIT devirtualization.
"""##,
                codeSnippet: ##"""
public abstract class Animal {
    public abstract string Sound();
}
public sealed class Cat : Animal {
    public override string Sound() => "Meow";
}

Animal pet = new Cat();
Console.WriteLine(pet.Sound());
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_casting_is_as",
                category: .csharpInheritance,
                titleRU: "Приведение типов: операторы is, as и сопоставление типов",
                titleEN: "Type Casting: is, as & Type Pattern Matching",
                summaryRU: "Безопасное приведение ссылок: оператор is с объявлением переменной, безопасное приведение к null через as и исключение InvalidCastException.",
                summaryEN: "Safe reference conversion: is pattern with declaration, non-throwing as operator, and cast safety.",
                contentMarkdownRU: ##"""
### Операторы `is` и `as`

В иерархиях полиморфизма часто требуется проверить, принадлежит ли объект конкретному производному типу.

```csharp
object data = "SwiftLearn Developer";

// 1. Оператор `as`: пытается привести тип, при неудаче возвращает null (не выбрасывает исключение):
string? strVal = data as string;
if (strVal != null) {
    Console.WriteLine(strVal.Length);
}

// 2. Современный оператор `is` с объявлением переменной (Type Pattern):
if (data is string text && text.Length > 0) {
    Console.WriteLine($"Строка длиной {text.Length}: {text}");
}
```
Оператор `is` предпочтительнее `as`, так как он работает и со значимыми типами (`if (val is int num)`), где `as` запрещен.
"""##,
                contentMarkdownEN: ##"""
### Type Testing with `is` and `as`

The modern `is` pattern checks type and declares a variable simultaneously:

```csharp
object obj = 42;
if (obj is int val) {
    Console.WriteLine($"Number: {val}");
}
```
"""##,
                codeSnippet: ##"""
object input = 125.5;

if (input is double number) {
    Console.WriteLine($"Double detected: {number:F1}");
} else {
    Console.WriteLine("Other type");
}
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_interfaces_contracts",
                category: .csharpInterfaces,
                titleRU: "Интерфейсы: контракты и слабая связанность",
                titleEN: "Interfaces: Contracts & Loose Coupling",
                summaryRU: "Интерфейсы в C#: определение контрактов поведения, множественная реализация и инверсия зависимостей (Dependency Inversion).",
                summaryEN: "Interfaces in C#: behavior contracts, multiple implementation, and the Dependency Inversion Principle.",
                contentMarkdownRU: ##"""
### Интерфейсы как архитектурный контракт

Интерфейс задает набор методов, свойств и событий, которые класс обязан реализовать. По конвенции C# имена интерфейсов начинаются с префикса `I` (`IDisposable`, `IEnumerable`):

```csharp
public interface IMessageSender {
    void SendMessage(string destination, string body);
}

public interface IHealthCheck {
    bool IsHealthy();
}

// Класс может реализовывать несколько интерфейсов:
public class EmailService : IMessageSender, IHealthCheck {
    public void SendMessage(string destination, string body) {
        Console.WriteLine($"Email -> {destination}: {body}");
    }

    public bool IsHealthy() => true;
}
```
Интерфейсы обеспечивают **слабую связанность (loose coupling)** компонентов системы и возможность подмены реализации в unit-тестах с помощью mock-объектов.
"""##,
                contentMarkdownEN: ##"""
### Interfaces & Multiple Implementation

Classes can implement multiple interfaces:

```csharp
public interface IPrinter {
    void Print(string text);
}
public class ConsolePrinter : IPrinter {
    public void Print(string text) => Console.WriteLine(text);
}
```
"""##,
                codeSnippet: ##"""
public interface IValidator {
    bool Validate(string input);
}
public class NonEmptyValidator : IValidator {
    public bool Validate(string input) => !string.IsNullOrWhiteSpace(input);
}

IValidator v = new NonEmptyValidator();
Console.WriteLine($"Valid: {v.Validate("SwiftLearn")}");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_explicit_interface",
                category: .csharpInterfaces,
                titleRU: "Явная реализация интерфейсов (Explicit Implementation)",
                titleEN: "Explicit Interface Implementation",
                summaryRU: "Разрешение конфликтов одинаковых сигнатур в интерфейсах, сокрытие специфических методов из публичного API класса.",
                summaryEN: "Resolving method signature collisions and hiding implementation details via explicit interface implementation.",
                contentMarkdownRU: ##"""
### Явная реализация интерфейса

Если класс реализует два интерфейса с идентичной сигнатурой метода, либо метод интерфейса не должен быть виден напрямую через класс, используется **явная реализация**:

```csharp
public interface IEnglishDimensions {
    double Length();
}

public interface IMetricDimensions {
    double Length();
}

public class Box : IEnglishDimensions, IMetricDimensions {
    // Явная реализация: имя интерфейса указывается перед методом:
    double IEnglishDimensions.Length() => 30.0; // В дюймах
    double IMetricDimensions.Length() => 76.2;  // В сантиметрах
}

Box box = new Box();
// box.Length(); // Ошибка компиляции! Метод скрыт из публичного API Box

// Вызов возможен только через приведение к соответствующему интерфейсу:
IEnglishDimensions english = box;
Console.WriteLine($"Inches: {english.Length()}");

IMetricDimensions metric = box;
Console.WriteLine($"Centimeters: {metric.Length()}");
```
"""##,
                contentMarkdownEN: ##"""
### Explicit Interface Implementation

Prefix method names with interface identifiers to resolve collisions and hide members from the direct class API:

```csharp
public interface IWorker { void DoWork(); }
public class Manager : IWorker {
    void IWorker.DoWork() => Console.WriteLine("Working...");
}
```
"""##,
                codeSnippet: ##"""
public interface IActionA { string Action(); }
public interface IActionB { string Action(); }

public class MultiService : IActionA, IActionB {
    string IActionA.Action() => "Action A";
    string IActionB.Action() => "Action B";
}

var s = new MultiService();
Console.WriteLine(((IActionA)s).Action());
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_default_interface_methods",
                category: .csharpInterfaces,
                titleRU: "Методы по умолчанию в интерфейсах (DIM)",
                titleEN: "Default Interface Methods (DIM)",
                summaryRU: "Эволюция API библиотек: добавление методов с телом по умолчанию в интерфейсы C# 8 без нарушения существующих реализаций.",
                summaryEN: "API evolution: defining default implementations in interfaces without breaking existing consumers.",
                contentMarkdownRU: ##"""
### Default Interface Methods (C# 8+)

Раньше добавление нового метода в интерфейс ломало все существующие классы, реализующие этот интерфейс. С появлением **DIM (Default Interface Methods)** в интерфейс можно поместить реализацию по умолчанию:

```csharp
public interface ILogger {
    void Log(string message);

    // Метод по умолчанию:
    void LogWarning(string message) {
        Log($"[ПРЕДУПРЕЖДЕНИЕ]: {message}");
    }
}

public class SimpleConsoleLogger : ILogger {
    // Реализуем только обязательный метод:
    public void Log(string message) => Console.WriteLine(message);
}

ILogger logger = new SimpleConsoleLogger();
logger.LogWarning("Память заполнена на 80%"); // Вызов метода по умолчанию
```
"""##,
                contentMarkdownEN: ##"""
### Default Interface Methods

Interfaces can provide fallback implementations for new methods:

```csharp
public interface IGreeter {
    void Greet(string name);
    void GreetWorld() => Greet("World");
}
```
"""##,
                codeSnippet: ##"""
public interface ILogger {
    void Log(string text);
    void LogInfo(string text) => Log($"[INFO] {text}");
}
public class OutputLogger : ILogger {
    public void Log(string text) => Console.WriteLine(text);
}

ILogger l = new OutputLogger();
l.LogInfo("System initialized");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_record_classes",
                category: .csharpRecordsAndEnums,
                titleRU: "Неизменяемые типы: record class и неразрушающая мутация with",
                titleEN: "Immutable Records & with Expressions",
                summaryRU: "Семантика записей record class: сравнение по значению полей, компиляторная генерация ToString и Equals, и клонирование через with.",
                summaryEN: "Record classes: value-based equality, auto-generated equality and formatting, and non-destructive with mutation.",
                contentMarkdownRU: ##"""
### Записи (`record class`) в C#

`record` — это ссылочный тип, спроектированный для неизменяемых моделей данных (DTO, события, сообщения).

Ключевые отличия от обычного `class`:
1. **Сравнение по значениям (Value Equality)**: два разных объекта `record` с одинаковыми полями считаются равными (`r1 == r2` вернет `true`).
2. **Первичный конструктор и свойства `init`**: `public record User(int Id, string Name);` автоматически создает свойства и конструктор.
3. **Неразрушающая мутация с `with`**: клонирование объекта с изменением отдельных свойств.

```csharp
public record GeoPoint(double Latitude, double Longitude);

var p1 = new GeoPoint(55.75, 37.61);
var p2 = new GeoPoint(55.75, 37.61);

Console.WriteLine(p1 == p2); // true! Сравнение по полям!

// Клонирование с изменением долготы:
var p3 = p1 with { Longitude = 37.65 };
Console.WriteLine(p3); // GeoPoint { Latitude = 55.75, Longitude = 37.65 }
```
"""##,
                contentMarkdownEN: ##"""
### Records and Non-Destructive Mutation

Records provide value equality out-of-the-box and the `with` operator for cloning with changes:

```csharp
public record User(string Name, int Age);
var u1 = new User("Alex", 30);
var u2 = u1 with { Age = 31 };
```
"""##,
                codeSnippet: ##"""
public record Player(string Nickname, int Score);

var p1 = new Player("Nova", 1500);
var p2 = p1 with { Score = 1600 };

Console.WriteLine($"Old: {p1.Score}, New: {p2.Score}");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_record_structs",
                category: .csharpRecordsAndEnums,
                titleRU: "record struct: Значимые типы с семантикой записей",
                titleEN: "record struct: Value-Type Records",
                summaryRU: "Значимые записи C# 10: размещение на стеке, исключение давления на GC, readonly record struct и сравнение с record class.",
                summaryEN: "C# 10 record structs: stack-based value records, zero-GC pressure, readonly record struct, and class comparisons.",
                contentMarkdownRU: ##"""
### Значимые записи (`record struct`)

В C# 10 появилась возможность создавать записи как структуры:

```csharp
// Мутабельная структура-запись (по умолчанию):
public record struct Color(byte R, byte G, byte B);

// Неизменяемая структура-запись (рекомендуемый паттерн):
public readonly record struct Vector3D(float X, float Y, float Z);
```

### Когда использовать `record struct` вместо `record class`?
- Когда объектов создаются миллионы в секунду (геометрия, физика, торговые котировки), и аллокации в куче перегружают сборщик мусора GC.
- `readonly record struct` передается и копируется на стеке, реализуя при этом все удобства `record` (сравнение, `with`, форматирование).
"""##,
                contentMarkdownEN: ##"""
### record struct Performance

`readonly record struct` combines value type stack storage with record ergonomics, eliminating garbage collector allocations for micro-benchmarks.
"""##,
                codeSnippet: ##"""
public readonly record struct Size2D(int Width, int Height);

var s1 = new Size2D(1920, 1080);
var s2 = s1 with { Height = 1200 };

Console.WriteLine($"{s2.Width}x{s2.Height}");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_enums_flags",
                category: .csharpRecordsAndEnums,
                titleRU: "Перечисления (enum), базовые типы и битовые маски [Flags]",
                titleEN: "Enums, Underlying Types & [Flags] Bitmasks",
                summaryRU: "Типобезопасные перечисления enum, выбор лежащего в основе числового типа byte/int, атрибут [Flags] и побитовые операции.",
                summaryEN: "Type-safe enums, byte/int underlying types, [Flags] attribute, and bitwise mask operations.",
                contentMarkdownRU: ##"""
### Перечисления (`enum`) и битовые флаги

Перечисление связывает имена с целочисленными константами. По умолчанию базовым типом является `int`:

```csharp
public enum HttpStatus : ushort {
    Ok = 200,
    NotFound = 404,
    InternalError = 500
}
```

### Атрибут `[Flags]` для комбинирования прав доступа
С помощью атрибута `[Flags]` перечисление превращается в битовую маску со степенями двойки:

```csharp
[Flags]
public enum Permissions : byte {
    None = 0,
    Read = 1 << 0,    // 1 (0001)
    Write = 1 << 1,   // 2 (0010)
    Execute = 1 << 2, // 4 (0100)
    Admin = Read | Write | Execute // 7 (0111)
}

Permissions myRights = Permissions.Read | Permissions.Write;

// Проверка наличия флага:
bool canWrite = myRights.HasFlag(Permissions.Write); // true
bool canExecute = (myRights & Permissions.Execute) != 0; // false
```
"""##,
                contentMarkdownEN: ##"""
### Enums and [Flags] Bitmasks

Bitwise enums allow multiple flags combined with bitwise OR `|`:

```csharp
[Flags]
public enum FileAccess { Read = 1, Write = 2 }
var access = FileAccess.Read | FileAccess.Write;
```
"""##,
                codeSnippet: ##"""
[Flags]
public enum AccessLevel { Read = 1, Write = 2, Execute = 4 }

var userAccess = AccessLevel.Read | AccessLevel.Write;
Console.WriteLine($"Has write: {userAccess.HasFlag(AccessLevel.Write)}");
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_generics_classes_methods",
                category: .csharpGenerics,
                titleRU: "Обобщения (Generics): Классы и Методы",
                titleEN: "Generics: Generic Classes & Methods",
                summaryRU: "Обобщенное программирование в C#: устранение упаковки Boxing, типобезопасность на этапе компиляции, обобщенные классы и методы.",
                summaryEN: "Generic programming in C#: eliminating boxing overhead, compile-time type safety, generic classes and methods.",
                contentMarkdownRU: ##"""
### Зачем нужны Дженерики в .NET?

До появления дженериков в .NET 2.0 коллекции хранили элементы как `object`. Это приводило к двум тяжелым проблемам:
1. Постоянная упаковка/распаковка (boxing/unboxing) значимых типов (`int`, `struct`), снижавшая скорость в разы.
2. Отсутствие проверки типов компилятором (в список можно было случайно положить и `int`, и `string`).

Дженерики создают специализированный код под конкретный тип `T`:

```csharp
public class Result<T> {
    public bool Success { get; }
    public T Value { get; }
    public string? ErrorMessage { get; }

    public Result(T value) {
        Success = true;
        Value = value;
    }

    public Result(string error) {
        Success = false;
        Value = default!;
        ErrorMessage = error;
    }
}

// Обобщенный метод обмена значениями:
public static void Swap<T>(ref T a, ref T b) {
    T temp = a;
    a = b;
    b = temp;
}
```
"""##,
                contentMarkdownEN: ##"""
### Generics Foundations

Generics ensure compile-time type safety and zero-boxing performance:

```csharp
public class Container<T>(T item) {
    public T Item { get; } = item;
}
```
"""##,
                codeSnippet: ##"""
public class Box<T>(T content) {
    public T Content => content;
}

var stringBox = new Box<string>("Secret Message");
Console.WriteLine($"Box holds: {stringBox.Content}");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_generic_constraints",
                category: .csharpGenerics,
                titleRU: "Ограничения дженериков: where T : class, struct, new()",
                titleEN: "Generic Constraints: where T : class, struct, new()",
                summaryRU: "Сужение допустимых типов параметра T: ограничения ссылочных и значимых типов, интерфейсные контракты, конструктор по умолчанию new().",
                summaryEN: "Constraining type parameter T: class/struct limits, interface contracts, and new() parameterless constructors.",
                contentMarkdownRU: ##"""
### Ограничения параметров типа (`where T : ...`)

Если тип `T` ничем не ограничен, с ним можно работать только как с `System.Object`. Ограничения указывают компилятору свойства типа `T`:

| Ограничение | Смысл |
| :--- | :--- |
| `where T : class` | `T` обязан быть ссылочным типом |
| `where T : struct` | `T` обязан быть значимым типом (не nullable) |
| `where T : notnull` | `T` не может быть `null` |
| `where T : new()` | `T` обязан иметь публичный конструктор без параметров |
| `where T : IEntity` | `T` обязан реализовывать интерфейс `IEntity` |
| `where T : BaseClass` | `T` обязан наследоваться от `BaseClass` |

```csharp
public class EntityRepository<T> where T : class, IIdentifiable, new() {
    public T CreateAndRegister(int id) {
        T instance = new T(); // Разрешено благодаря new()!
        instance.Id = id;     // Разрешено благодаря IIdentifiable!
        return instance;
    }
}
```
"""##,
                contentMarkdownEN: ##"""
### Constraints on Type Parameters

The `where` clause restricts which types can substitute `T`:

```csharp
public T Factory<T>() where T : new() => new T();
```
"""##,
                codeSnippet: ##"""
public static bool AreEqual<T>(T a, T b) where T : IEquatable<T> {
    return a.Equals(b);
}

Console.WriteLine($"Match: {AreEqual(100, 100)}");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_covariance_contravariance",
                category: .csharpGenerics,
                titleRU: "Ковариантность (out) и Контравариантность (in)",
                titleEN: "Covariance (out) & Contravariance (in)",
                summaryRU: "Вариантность обобщенных интерфейсов и делегатов: сохранение направления приведения типов через out и обратное направление через in.",
                summaryEN: "Variance in generic interfaces and delegates: preserving derivation directions via out and in keywords.",
                contentMarkdownRU: ##"""
### Вариантность дженериков в C#

Если класс `Dog` наследуется от `Animal`, можно ли присвоить `IEnumerable<Dog>` переменной `IEnumerable<Animal>`?

- **Ковариантность (`out T`)**: тип `T` выступает **только как результат (выходной параметр)**. Направление наследования сохраняется (`IEnumerable<Dog>` приводится к `IEnumerable<Animal>`):
```csharp
public interface IReadOnlyRepository<out T> {
    T GetById(int id); // T только возвращается!
}
```

- **Контравариантность (`in T`)**: тип `T` выступает **только как аргумент (входной параметр)**. Направление наследования инвертируется (`IComparer<Animal>` может использоваться там, где требуется `IComparer<Dog>`):
```csharp
public interface IConsumer<in T> {
    void Consume(T item); // T только принимается!
}
```
"""##,
                contentMarkdownEN: ##"""
### Covariance (`out`) and Contravariance (`in`)

- `out`: Covariant, outputs only (`IEnumerable<out T>`).
- `in`: Contravariant, inputs only (`IComparer<in T>`).
"""##,
                codeSnippet: ##"""
IEnumerable<string> words = ["alpha", "beta"];
IEnumerable<object> objects = words; // Covariance in action!

Console.WriteLine($"Count: {objects.Count()}");
"""##,
                xpReward: 45
            ),

            Lesson(
                id: "cs_collections_list",
                category: .csharpCollections,
                titleRU: "Динамический массив List<T>: Capacity, Count и Memory",
                titleEN: "List<T> Internals: Capacity, Count & Allocations",
                summaryRU: "Внутреннее устройство List<T> поверх плоского массива T[], стратегия удвоения Capacity, методы Add, RemoveAll, Find и оптимизация TrimExcess.",
                summaryEN: "Internal architecture of List<T> over T[], capacity doubling strategy, mutations, and TrimExcess.",
                contentMarkdownRU: ##"""
### Внутреннее устройство `List<T>`

`List<T>` — самая популярная коллекция в C#. Внутри неё расположен обычный массив `T[] _items` и целочисленный счетчик `int _size`.

### Механика изменения размера
1. При создании `new List<int>()` внутренний массив пуст.
2. При добавлении первого элемента выделяется массив на 4 элемента.
3. Когда `Count` достигает `Capacity`, создается **новый массив удвоенного размера** (`Capacity * 2`), и все элементы копируются туда через `Array.Copy()`.
4. Старый массив отправляется на утилизацию в сборщик мусора GC.

```csharp
// Совет по оптимизации: всегда задавайте начальный Capacity, если примерный размер известен заранее:
var list = new List<string>(capacity: 1000); // 0 переаллокаций при заполнении 1000 элементами!

list.Add("Apple");
list.AddRange(["Banana", "Cherry"]);
list.RemoveAll(x => x.StartsWith("B"));
```
"""##,
                contentMarkdownEN: ##"""
### List<T> Memory Layout

`List<T>` doubles its internal array when full. Pre-allocating `capacity` prevents unnecessary GC allocations.
"""##,
                codeSnippet: ##"""
var cities = new List<string>(4) { "Tokyo", "London", "Paris" };
cities.Add("Berlin");

Console.WriteLine($"Count: {cities.Count}, Capacity: {cities.Capacity}");
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_collections_dictionary",
                category: .csharpCollections,
                titleRU: "Словари Dictionary<TKey, TValue> и Хеширование",
                titleEN: "Dictionary<TKey, TValue> & Hash Table Internals",
                summaryRU: "Устройство хеш-таблицы в .NET: корзины (buckets), цепочки коллизий, поиск O(1) и правила реализации GetHashCode() и Equals().",
                summaryEN: "Hash table architecture in .NET: buckets, collision chains, O(1) lookups, and overriding GetHashCode/Equals.",
                contentMarkdownRU: ##"""
### Устройство `Dictionary<TKey, TValue>`

`Dictionary` в .NET реализован по алгоритму открытого хеширования с разделением на корзины (`buckets`) и массив записей (`Entry[] entries`).

### Как работает поиск O(1)?
1. У ключа вычисляется `key.GetHashCode()`.
2. По хешу определяется индекс корзины: `bucketIndex = (hashCode & 0x7FFFFFFF) % buckets.Length`.
3. В корзине хранится индекс первой записи в массиве `entries`.
4. Если происходят коллизии (разные ключи попадают в одну корзину), они образуют односвязный список, по которому переходят, сравнивая ключи методом `Equals()`.

```csharp
var users = new Dictionary<string, int> {
    ["Dmitry"] = 28,
    ["Elena"] = 25
};

// Безопасное получение через TryGetValue (без выброса KeyNotFoundException):
if (users.TryGetValue("Dmitry", out int age)) {
    Console.WriteLine($"Возраст: {age}");
}
```
"""##,
                contentMarkdownEN: ##"""
### Dictionary<TKey, TValue> Internals

Uses a bucket array and entries table. Always use `TryGetValue` to safely read values without throwing `KeyNotFoundException`.
"""##,
                codeSnippet: ##"""
var cache = new Dictionary<string, string> {
    ["theme"] = "dark",
    ["font"] = "JetBrains Mono"
};

if (cache.TryGetValue("theme", out var theme)) {
    Console.WriteLine($"Active theme: {theme}");
}
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_collections_hashset_queue_stack",
                category: .csharpCollections,
                titleRU: "HashSet<T>, Queue<T> (FIFO) и Stack<T> (LIFO)",
                titleEN: "HashSet<T>, Queue<T> & Stack<T>",
                summaryRU: "Множества уникальных элементов HashSet<T>, математические операции пересечения и объединения, очереди Queue (FIFO) и стеки Stack (LIFO).",
                summaryEN: "Unique element sets with HashSet<T>, set operations (Union, Intersect), queues (FIFO), and stacks (LIFO).",
                contentMarkdownRU: ##"""
### Специализированные коллекции .NET

1. **`HashSet<T>`**: набор уникальных элементов с мгновенной проверкой наличия `Contains(item)` за O(1).
   - `UnionWith(other)`: объединение множеств.
   - `IntersectWith(other)`: пересечение множеств.
   - `ExceptWith(other)`: разность множеств.

2. **`Queue<T>` (FIFO — First In, First Out)**:
   - `Enqueue(item)`: добавить в конец очереди.
   - `Dequeue()`: извлечь первый добавленный элемент.
   - `Peek()`: просмотреть без удаления.

3. **`Stack<T>` (LIFO — Last In, First Out)**:
   - `Push(item)`: положить на вершину стека.
   - `Pop()`: снять с вершины стека.
```csharp
var tags = new HashSet<string> { "swift", "csharp", "dotnet" };
tags.Add("swift"); // Не добавится, так как уже существует!
```
"""##,
                contentMarkdownEN: ##"""
### HashSet, Queue and Stack

- `HashSet<T>`: unique sets, O(1) membership.
- `Queue<T>`: FIFO queuing (`Enqueue`/`Dequeue`).
- `Stack<T>`: LIFO ordering (`Push`/`Pop`).
"""##,
                codeSnippet: ##"""
var queue = new Queue<string>();
queue.Enqueue("Job 1");
queue.Enqueue("Job 2");

Console.WriteLine($"Processed: {queue.Dequeue()}");
Console.WriteLine($"Next in line: {queue.Peek()}");
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_delegates_basics",
                category: .csharpDelegatesEvents,
                titleRU: "Делегаты: сигнатуры методов первого класса",
                titleEN: "Delegates: Type-Safe Function Pointers",
                summaryRU: "Делегаты в C#: строго типизированные указатели на методы, цепочки вызовов MulticastDelegate с операторами += и -=.",
                summaryEN: "C# delegates: type-safe function pointers, multicast invocation chains with += and -=.",
                contentMarkdownRU: ##"""
### Что такое делегат в C#?

Делегат — это ссылочный тип, инкапсулирующий указатель на метод (или цепочку методов) с конкретной сигнатурой возвращаемого типа и параметров:

```csharp
// Объявление делегата:
public delegate int BinaryOperation(int a, int b);

public static int Add(int x, int y) => x + y;
public static int Multiply(int x, int y) => x * y;

BinaryOperation op = Add;
Console.WriteLine(op(10, 5)); // 15

op = Multiply;
Console.WriteLine(op(10, 5)); // 50
```

### Многоадресные делегаты (Multicast)
Делегаты поддерживают операторы `+=` и `-=`. При вызове делегата последовательно исполняются все зарегистрированные в нем методы:

```csharp
public delegate void Notifier(string text);

Notifier n = msg => Console.WriteLine($"Console: {msg}");
n += msg => Console.WriteLine($"File: {msg}");

n("Запуск системы"); // Вызовет оба обработчика!
```
"""##,
                contentMarkdownEN: ##"""
### Delegates & Multicast Chains

Delegates wrap methods as first-class objects. Multiple methods can subscribe with `+=`:

```csharp
delegate void Log(string msg);
Log logger = m => Console.WriteLine(m);
logger("Event recorded");
```
"""##,
                codeSnippet: ##"""
delegate int Transformer(int n);

Transformer doubleIt = x => x * 2;
Console.WriteLine($"Double 21 = {doubleIt(21)}");
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_func_action_predicates",
                category: .csharpDelegatesEvents,
                titleRU: "Стандартные делегаты Func<T>, Action<T> и Predicate<T>",
                titleEN: "Generic Delegates: Func, Action & Predicate",
                summaryRU: "Встроенные универсальные делегаты платформы .NET: Func для возвращающих значений, Action для void-методов и лямбда-синтаксис.",
                summaryEN: "Built-in generic delegates in .NET: Func for value returns, Action for void functions, and lambda syntax.",
                contentMarkdownRU: ##"""
### Стандартные делегаты .NET

Вместо объявления собственных `delegate void ...` в современном C# всегда используют стандартные универсальные типы из пространства имен `System`:

1. **`Action<...>`**: метод, возвращающий `void` (от 0 до 16 параметров):
```csharp
Action<string> print = msg => Console.WriteLine(msg);
print("Hello .NET!");
```

2. **`Func<..., TResult>`**: метод, **возвращающий значение**. Последний параметр в списке дженериков всегда указывает тип результата:
```csharp
Func<int, int, int> multiply = (a, b) => a * b;
int result = multiply(6, 7); // 42
```

3. **`Predicate<T>`**: аналог `Func<T, bool>`, проверяющий условие:
```csharp
Predicate<int> isEven = n => n % 2 == 0;
```
"""##,
                contentMarkdownEN: ##"""
### Func and Action Generic Delegates

- `Action<T>`: returns `void`.
- `Func<T, TResult>`: returns `TResult`.
- `Predicate<T>`: returns `bool`.
"""##,
                codeSnippet: ##"""
Func<int, int, int> add = (x, y) => x + y;
Action<string> log = s => Console.WriteLine($"[LOG]: {s}");

log($"Sum: {add(15, 25)}");
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_closures_captures",
                category: .csharpDelegatesEvents,
                titleRU: "Замыкания (Closures) и Захват Переменных",
                titleEN: "Closures & Variable Capture Pitfalls",
                summaryRU: "Как компилятор реализует замыкания через display class, время жизни захваченных переменных и классическая ловушка цикла for.",
                summaryEN: "Compiler-generated display classes for closures, captured variable lifecycles, and loop capture pitfalls.",
                contentMarkdownRU: ##"""
### Как работают замыкания в C#

Когда лямбда-выражение обращается к переменным из внешнего скоупа, компилятор Roslyn генерирует скрытый служебный класс (часто называемый `<>c__DisplayClass`), переносит туда переменную как поле и создает метод:

```csharp
int factor = 10;
Func<int, int> multiplier = n => n * factor; // factor захвачен!
factor = 20;

Console.WriteLine(multiplier(5)); // Выведет 100, а не 50! Захвачена сама переменная, а не её копия!
```

### Ловушка захвата в циклах
В старых версиях C# цикл `for` захватывал общую переменную счетчика `i`:
```csharp
var actions = new List<Action>();
for (int i = 0; i < 3; i++) {
    int local = i; // Создаем локальную копию для каждого шага
    actions.Add(() => Console.WriteLine(local));
}
foreach (var a in actions) a(); // Напечатает 0, 1, 2
```
"""##,
                contentMarkdownEN: ##"""
### Closures & Compiler Display Classes

Lambdas capture variables by reference using a compiler-generated class. Mutating the variable updates subsequent closure invocations.
"""##,
                codeSnippet: ##"""
int multiplier = 3;
Func<int, int> triple = x => x * multiplier;

Console.WriteLine($"3 * 7 = {triple(7)}");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_events_pattern",
                category: .csharpDelegatesEvents,
                titleRU: "События (events) и стандартный паттерн EventHandler<T>",
                titleEN: "Events & the Standard EventHandler<T> Pattern",
                summaryRU: "Инкапсуляция делегатов через ключевое слово event, предотвращение прямой перезаписи, и архитектурный паттерн EventHandler<TEventArgs>.",
                summaryEN: "Delegate encapsulation with events, preventing external assignment, and the EventHandler<T> pattern.",
                contentMarkdownRU: ##"""
### Ключевое слово `event`

Событие — это защищенная обертка над делегатом. Внешний код может **только подписываться (`+=`)** или **отписываться (`-=`)**, но не может напрямую перезаписать делегат (`event = null`) или вызвать его извне:

```csharp
public class OrderEventArgs : EventArgs {
    public int OrderId { get; init; }
}

public class OrderProcessor {
    // Стандартное событие .NET:
    public event EventHandler<OrderEventArgs>? OrderCompleted;

    public void Complete(int id) {
        Console.WriteLine($"Заказ {id} завершен.");
        // Потокобезопасный вызов через ?.:
        OrderCompleted?.Invoke(this, new OrderEventArgs { OrderId = id });
    }
}

var proc = new OrderProcessor();
proc.OrderCompleted += (sender, args) => {
    Console.WriteLine($"[Слушатель]: получен сигнал о заказе #{args.OrderId}");
};
proc.Complete(101);
```
"""##,
                contentMarkdownEN: ##"""
### Events & EventHandler<T>

Events enforce subscription-only operations (`+=` / `-=`) preventing external invocations:

```csharp
public class Engine {
    public event Action? Started;
    public void Start() => Started?.Invoke();
}
```
"""##,
                codeSnippet: ##"""
public class Clock {
    public event Action? OnTick;
    public void Tick() => OnTick?.Invoke();
}

var clock = new Clock();
clock.OnTick += () => Console.WriteLine("Tick sound");
clock.Tick();
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_linq_deferred_execution",
                category: .csharpLINQ,
                titleRU: "Отложенное выполнение LINQ и генераторы yield return",
                titleEN: "LINQ Deferred Execution & yield return",
                summaryRU: "Ленивые вычисления в IEnumerable<T>, как работает yield return, разница между объявлением запроса и материализацией ToList().",
                summaryEN: "Lazy evaluation in IEnumerable<T>, yield return state machines, and query execution vs ToList() materialization.",
                contentMarkdownRU: ##"""
### Отложенное выполнение (Deferred Execution)

В LINQ методы запросов (`Where`, `Select`, `Take`) **не выполняют вычислений в момент их вызова**. Запрос представляет собой план выполнения (дерево итераторов), который запускается только когда коллекцию начинают перебирать (`foreach`, `ToList()`, `First()`):

```csharp
var numbers = new List<int> { 1, 2, 3, 4, 5 };

// Запрос объявлен, но НИ ОДНО число еще не проверено:
var query = numbers.Where(n => {
    Console.WriteLine($"Фильтрация {n}");
    return n > 2;
});

Console.WriteLine("Запрос объявлен.");
// Только сейчас при вызове ToList() происходит фильтрация:
var result = query.ToList();
```

### Генераторы `yield return`
Ключевое слово `yield return` заставляет компилятор сгенерировать конечный автомат `IEnumerator<T>`:

```csharp
public static IEnumerable<int> Fibonacci() {
    int current = 0, next = 1;
    while (true) {
        yield return current;
        int sum = current + next;
        current = next;
        next = sum;
    }
}
```
"""##,
                contentMarkdownEN: ##"""
### Deferred Execution & yield return

LINQ queries are lazily evaluated upon iteration:

```csharp
IEnumerable<int> Even(int max) {
    for (int i = 0; i <= max; i += 2) yield return i;
}
```
"""##,
                codeSnippet: ##"""
IEnumerable<int> GenerateNumbers() {
    yield return 10;
    yield return 20;
    yield return 30;
}

foreach (var item in GenerateNumbers()) {
    Console.WriteLine($"Item: {item}");
}
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_linq_filtering_projection",
                category: .csharpLINQ,
                titleRU: "Фильтрация и Проекция: Where, Select и SelectMany",
                titleEN: "Filtering & Projection: Where, Select & SelectMany",
                summaryRU: "Базовые операторы LINQ: отбор элементов Where, трансформация Select, и расплющивание вложенных коллекций SelectMany.",
                summaryEN: "Core LINQ operators: Where filtering, Select transformations, and SelectMany collection flattening.",
                contentMarkdownRU: ##"""
### Операторы Where, Select и SelectMany

- **`Where(predicate)`**: фильтрует коллекцию по условию.
- **`Select(selector)`**: проецирует каждый элемент в новую форму или тип.
- **`SelectMany(selector)`**: расплющивает (flatten) вложенные коллекции в единый плоский поток:

```csharp
public record Student(string Name, List<string> Courses);

var students = new List<Student> {
    new("Anna", ["C#", "SQL"]),
    new("Boris", ["Python", "C#"])
};

// SelectMany собирает все курсы всех студентов в один список:
var uniqueCourses = students
    .SelectMany(s => s.Courses)
    .Distinct()
    .OrderBy(c => c)
    .ToList();

Console.WriteLine(string.Join(", ", uniqueCourses)); // C#, Python, SQL
```
"""##,
                contentMarkdownEN: ##"""
### Where, Select and SelectMany

Use `Select` to transform each item, and `SelectMany` to flatten child collections:

```csharp
var numbers = new[] { 1, 2, 3, 4 };
var squares = numbers.Where(n => n % 2 == 0).Select(n => n * n);
```
"""##,
                codeSnippet: ##"""
int[] nums = [1, 2, 3, 4, 5, 6];
var evensSquared = nums.Where(n => n % 2 == 0).Select(n => n * n);

Console.WriteLine(string.Join(", ", evensSquared));
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_linq_grouping_aggregates",
                category: .csharpLINQ,
                titleRU: "Группировка и Агрегация: GroupBy, Aggregate, Sum, Average",
                titleEN: "Grouping & Aggregations: GroupBy & Aggregate",
                summaryRU: "Группировка элементов GroupBy, вычисление статистик Sum, Min, Max, Average и универсальный сверточный редуктор Aggregate.",
                summaryEN: "GroupBy operations, statistical aggregates (Sum, Min, Max, Average), and fold reductions with Aggregate.",
                contentMarkdownRU: ##"""
### Агрегация и Группировка в LINQ

```csharp
public record Employee(string Name, string Department, decimal Salary);

var staff = new List<Employee> {
    new("Иван", "IT", 120000),
    new("Ольга", "IT", 140000),
    new("Сергей", "HR", 80000),
    new("Мария", "HR", 95000)
};

// Группировка по отделам:
var byDept = staff
    .GroupBy(e => e.Department)
    .Select(g => new {
        Department = g.Key,
        Count = g.Count(),
        AvgSalary = g.Average(e => e.Salary),
        TotalBudget = g.Sum(e => e.Salary)
    });

foreach (var d in byDept) {
    Console.WriteLine($"{d.Department}: {d.Count} чел, средняя ЗП: {d.AvgSalary:C0}");
}

// Универсальный Aggregate (аналог reduce):
int[] multipliers = [2, 3, 4];
int product = multipliers.Aggregate(1, (acc, val) => acc * val); // 24
```
"""##,
                contentMarkdownEN: ##"""
### GroupBy and Aggregations

GroupBy partitions sequences by key; Aggregate folds sequences into single scalar values.
"""##,
                codeSnippet: ##"""
int[] numbers = [10, 20, 30, 40];
double avg = numbers.Average();
int sum = numbers.Sum();

Console.WriteLine($"Sum: {sum}, Avg: {avg}");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_linq_joins_zip",
                category: .csharpLINQ,
                titleRU: "Связывание данных: Join, GroupJoin и Zip",
                titleEN: "Relational LINQ: Join, GroupJoin & Zip",
                summaryRU: "Реляционные операции в памяти: эквивалент SQL INNER JOIN через Join, левое соединение с GroupJoin и попарное слияние Zip.",
                summaryEN: "Relational operations in memory: INNER JOIN via Join, outer joining with GroupJoin, and pairwise Zip.",
                contentMarkdownRU: ##"""
### Соединение коллекций: `Join`

Оператор `Join` сопоставляет две коллекции по ключам аналогично SQL INNER JOIN:

```csharp
public record User(int Id, string Name);
public record Order(int OrderId, int UserId, decimal Amount);

var users = new List<User> { new(1, "Alice"), new(2, "Bob") };
var orders = new List<Order> { new(101, 1, 450), new(102, 1, 900), new(103, 3, 200) };

var userOrders = users.Join(
    orders,
    u => u.Id,          // Ключ первой коллекции
    o => o.UserId,      // Ключ второй коллекции
    (u, o) => new { u.Name, o.OrderId, o.Amount }
);

foreach (var row in userOrders) {
    Console.WriteLine($"{row.Name} оформил заказ #{row.OrderId} на {row.Amount} руб.");
}
```

### Попарное объединение `Zip`
Метод `Zip` объединяет две последовательности по индексам:
```csharp
string[] letters = ["A", "B", "C"];
int[] numbers = [1, 2, 3];

var pairs = letters.Zip(numbers, (l, n) => $"{l}{n}"); // A1, B2, C3
```
"""##,
                contentMarkdownEN: ##"""
### Relational Joins & Zip

Join matches collections by key. Zip pairs elements by index.
"""##,
                codeSnippet: ##"""
string[] keys = ["id", "status"];
string[] vals = ["101", "active"];

var mapped = keys.Zip(vals, (k, v) => $"{k}={v}");
Console.WriteLine(string.Join("&", mapped));
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_exception_handling",
                category: .csharpExceptions,
                titleRU: "Иерархия исключений, try-catch-finally и throw",
                titleEN: "Exceptions, try-catch-finally & Stack Unwinding",
                summaryRU: "Иерархия System.Exception, правильный перехват конкретных типов, разница между rethrow через throw; и throw ex;, и гарантии finally.",
                summaryEN: "System.Exception hierarchy, typed catches, rethrowing via throw; vs throw ex;, and finally guarantees.",
                contentMarkdownRU: ##"""
### Обработка исключений в .NET

Все исключения наследуются от `System.Exception`. Порядок блоков `catch` критичен: от наиболее специфичных к общим:

```csharp
try {
    string content = File.ReadAllText("missing.txt");
} catch (FileNotFoundException ex) {
    Console.WriteLine($"Файл отсутствует: {ex.FileName}");
} catch (IOException ex) {
    Console.WriteLine($"Ошибка ввода-вывода: {ex.Message}");
} catch (Exception ex) {
    Console.WriteLine($"Непредвиденная ошибка: {ex.Message}");
} finally {
    // Выполняется ВСЕГДА, даже если произошло исключение:
    Console.WriteLine("Завершение операции.");
}
```

### Критическая ошибка: `throw;` против `throw ex;`
- **`throw;`** (ПРАВИЛЬНО): перевыбрасывает текущее исключение, **сохраняя оригинальный StackTrace** (точную строку, где произошла исходная ошибка).
- **`throw ex;`** (АНТИПАТТЕРН): сбрасывает стек вызовов, перезаписывая его текущей строкой. Никогда так не делайте!
"""##,
                contentMarkdownEN: ##"""
### Exception Hierarchy & Safe Rethrowing

Always rethrow with bare `throw;` to preserve the original stack trace. Never use `throw ex;`.
"""##,
                codeSnippet: ##"""
try {
    int zero = 0;
    int result = 100 / zero;
} catch (DivideByZeroException) {
    Console.WriteLine("Division by zero caught safely.");
}
"""##,
                xpReward: 35
            ),

            Lesson(
                id: "cs_exception_filters",
                category: .csharpExceptions,
                titleRU: "Фильтры исключений: ключевое слово when",
                titleEN: "Exception Filters: The when Keyword",
                summaryRU: "Перехват исключений по условию с помощью when, проверка статус-кодов и инспекция состояния без размотки стека вызовов.",
                summaryEN: "Conditional exception catching using when, inspecting status codes, and preserving the stack without unwinding.",
                contentMarkdownRU: ##"""
### Фильтры исключений (`catch (...) when (...)`)

Начиная с C# 6, блок `catch` можно снабдить предикатом `when`:

```csharp
try {
    SendApiRequest();
} catch (HttpRequestException ex) when (ex.StatusCode == System.Net.HttpStatusCode.NotFound) {
    Console.WriteLine("Ресурс 404 не найден — переключаемся на резервный URL.");
} catch (HttpRequestException ex) when (ex.StatusCode == System.Net.HttpStatusCode.Unauthorized) {
    Console.WriteLine("Токен авторизации истек — выполняем refresh токена.");
}
```

### Архитектурное преимущество: Stack Unwinding
Если предикат `when` возвращает `false`, среда CLR **не начинает размотку стека** (stack unwinding). Стек вызовов сохраняется нетронутым, что позволяет инструментам мониторинга (Crash Dumps, Sentry) видеть точное состояние всех локальных переменных в момент возникновения сбоя.
"""##,
                contentMarkdownEN: ##"""
### Exception Filters (when)

Filters inspect exceptions before the CLR unwinds the call stack:

```csharp
try { /* ... */ }
catch (Exception ex) when (ex.HResult == -2146233088) {
    // Handles specific HResult without stack unwinding
}
```
"""##,
                codeSnippet: ##"""
try {
    throw new ArgumentException("Negative value", "amount");
} catch (ArgumentException ex) when (ex.ParamName == "amount") {
    Console.WriteLine($"Handled specific parameter error: {ex.ParamName}");
}
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_idisposable_using",
                category: .csharpExceptions,
                titleRU: "Управление ресурсами: IDisposable и декларации using",
                titleEN: "Resource Management: IDisposable & using Declarations",
                summaryRU: "Освобождение неуправляемых ресурсов (дескрипторы файлов, сокеты), паттерн Dispose, современный синтаксис using var и IAsyncDisposable.",
                summaryEN: "Unmanaged resource cleanup (handles, sockets), Dispose pattern, modern using var declarations, and IAsyncDisposable.",
                contentMarkdownRU: ##"""
### Паттерн `IDisposable` и `using`

Сборщик мусора (GC) управляет только памятью в куче, но не знает, как освобождать **неуправляемые системные ресурсы** (дескрипторы файлов, подключения к БД, сетевые сокеты).

Для детерминированной очистки таких ресурсов класс реализует интерфейс `IDisposable`:

```csharp
public class ResourceWrapper : IDisposable {
    public void Dispose() {
        // Освобождение неуправляемых ресурсов
        Console.WriteLine("Ресурс освобожден.");
    }
}
```

### Современные `using` декларации (C# 8+)
Вместо громоздких вложенных блоков `using (...) { ... }` используется лаконичный синтаксис `using var`:

```csharp
void ProcessData() {
    using var wrapper = new ResourceWrapper();
    // Работа с ресурсом...
    // Метод wrapper.Dispose() автоматически вызовется при выходе из скоупа функции!
}
```

Для асинхронной очистки потоков ввода-вывода используется интерфейс `IAsyncDisposable` и конструкция `await using var`.
"""##,
                contentMarkdownEN: ##"""
### IDisposable & using Statements

The `using var` declaration calls `.Dispose()` automatically at the end of the enclosing scope:

```csharp
using var stream = new MemoryStream();
stream.WriteByte(42);
```
"""##,
                codeSnippet: ##"""
public class Session : IDisposable {
    public void Dispose() => Console.WriteLine("Session closed.");
}

using (var s = new Session()) {
    Console.WriteLine("Inside active session");
}
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_async_await_fundamentals",
                category: .csharpAsyncAwait,
                titleRU: "Асинхронное программирование: Task и async/await",
                titleEN: "Asynchronous Programming: Task & async/await",
                summaryRU: "Неблокирующий ввод-вывод I/O, конечный автомат (State Machine), генерируемый компилятором, возврат Task и Task<T>.",
                summaryEN: "Non-blocking I/O, compiler-generated async state machines, Task and Task<T> returns.",
                contentMarkdownRU: ##"""
### Асинхронность против Многопоточности

Главная цель `async/await` — **не блокировать рабочий поток пула (ThreadPool)**, пока операционная система ждет завершения ввода-вывода (HTTP-запрос, чтение с диска, запрос к БД).

- Метод с модификатором `async` преобразуется компилятором Roslyn в **структурный конечный автомат (IAsyncStateMachine)**.
- При достижении `await` поток освобождается и возвращается в пул потоков для обслуживания других пользователей.
- По завершении I/O операции ОС сигнализирует драйверу, и CLR возобновляет выполнение метода.

```csharp
public async Task<string> FetchDataAsync(string url) {
    using var client = new HttpClient();
    // Поток не простаивает во время сетевого вызова:
    string html = await client.GetStringAsync(url);
    return html;
}
```
"""##,
                contentMarkdownEN: ##"""
### async and await Mechanics

`await` yields the ThreadPool thread back during I/O operations, resuming execution when the underlying OS completion port signals.
"""##,
                codeSnippet: ##"""
async Task<int> CalculateAsync() {
    await Task.Delay(10);
    return 42;
}

int val = await CalculateAsync();
Console.WriteLine($"Async computed value: {val}");
"""##,
                xpReward: 45
            ),

            Lesson(
                id: "cs_valuetask_perf",
                category: .csharpAsyncAwait,
                titleRU: "Оптимизация производительности: ValueTask<T>",
                titleEN: "High-Performance Async with ValueTask<T>",
                summaryRU: "Устранение аллокаций объекта Task в куче для операций, завершающихся синхронно (кеширование), и правила использования ValueTask.",
                summaryEN: "Eliminating heap allocations for synchronously completing operations using ValueTask<T>.",
                contentMarkdownRU: ##"""
### Зачем нужен `ValueTask<T>`?

Обычный `Task<T>` — это ссылочный тип (`class`). Каждый асинхронный вызов создает новый объект в куче.

Если метод часто возвращает результат **синхронно** (например, значение взято из кеша в оперативной памяти), аллоцировать `Task` в куче бессмысленно. Для этого создана структура `ValueTask<T>`:

```csharp
private readonly Dictionary<int, string> _memoryCache = new();

public ValueTask<string> GetUserNameAsync(int id) {
    // 1. Быстрый синхронный путь (0 аллокаций в куче!):
    if (_memoryCache.TryGetValue(id, out var cachedName)) {
        return ValueTask.FromResult(cachedName);
    }

    // 2. Медленный асинхронный путь (сеть / база):
    return new ValueTask<string>(FetchUserFromDbAsync(id));
}
```

### Важное правило:
`ValueTask` нельзя ожидать (`await`) дважды и нельзя использовать в `Task.WhenAll`.
"""##,
                contentMarkdownEN: ##"""
### ValueTask<T> for Zero-Allocation Hot Paths

When cached results complete synchronously, `ValueTask<T>` avoids creating Task instances on the managed heap.
"""##,
                codeSnippet: ##"""
ValueTask<int> FastGetAsync(bool isCached) {
    if (isCached) return ValueTask.FromResult(100);
    return new ValueTask<int>(Task.FromResult(200));
}

var res = await FastGetAsync(true);
Console.WriteLine($"Result: {res}");
"""##,
                xpReward: 45
            ),

            Lesson(
                id: "cs_cancellation_tokens",
                category: .csharpAsyncAwait,
                titleRU: "Отмена асинхронных операций: CancellationTokenSource",
                titleEN: "Asynchronous Cancellation & CancellationToken",
                summaryRU: "Кооперативная отмена асинхронных цепочек: токен CancellationToken, проверка ThrowIfCancellationRequested и таймауты CancelAfter.",
                summaryEN: "Cooperative cancellation: CancellationToken propagation, ThrowIfCancellationRequested, and CancelAfter timeouts.",
                contentMarkdownRU: ##"""
### Кооперативная отмена в .NET

В .NET потоки и асинхронные задачи нельзя принудительно «убить» извне (это привело бы к повреждению памяти). Отмена является **кооперативной**: вызывающий код передает `CancellationToken`, а вызываемый метод регулярно проверяет, не запрошена ли отмена:

```csharp
using var cts = new CancellationTokenSource();
cts.CancelAfter(TimeSpan.FromSeconds(3)); // Таймаут 3 секунды

try {
    await LongRunningProcessAsync(cts.Token);
} catch (OperationCanceledException) {
    Console.WriteLine("Операция была отменена по таймауту!");
}

async Task LongRunningProcessAsync(CancellationToken ct) {
    for (int i = 0; i < 100; i++) {
        ct.ThrowIfCancellationRequested(); // Выбрасывает исключение при отмене
        await Task.Delay(100, ct);
    }
}
```
"""##,
                contentMarkdownEN: ##"""
### Cooperative Cancellation Pattern

Propagate `CancellationToken` through async call chains to honor cancellation signals gracefully:

```csharp
using var cts = new CancellationTokenSource();
cts.Cancel();
```
"""##,
                codeSnippet: ##"""
using var cts = new CancellationTokenSource();
CancellationToken token = cts.Token;

Console.WriteLine($"Is cancellation requested: {token.IsCancellationRequested}");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_configure_await",
                category: .csharpAsyncAwait,
                titleRU: "Контекст синхронизации и ConfigureAwait(false)",
                titleEN: "SynchronizationContext & ConfigureAwait(false)",
                summaryRU: "Архитектура контекста синхронизации, предотвращение дедлоков в UI-потоках и оптимизация библиотечного кода через ConfigureAwait(false).",
                summaryEN: "SynchronizationContext architecture, preventing UI thread deadlocks, and library optimization with ConfigureAwait(false).",
                contentMarkdownRU: ##"""
### Роль `SynchronizationContext`

По умолчанию после `await` среда выполнения пытается вернуть выполнение метода в **тот же контекст синхронизации**, из которого он был вызван (например, главный UI-поток в WPF, MAUI или iOS).

### Почему библиотеки вызывают `ConfigureAwait(false)`?
Библиотечному коду (утилиты, парсеры, сетевые клиенты) все равно, в каком потоке продолжать выполнение. Вызов `ConfigureAwait(false)` указывает рантайму: «не пытайся захватывать исходный контекст, продолжай в любом свободном потоке пула ThreadPool»:

```csharp
public async Task<byte[]> DownloadBytesAsync(string url) {
    using var client = new HttpClient();
    // ConfigureAwait(false) предотвращает переключение контекста и устраняет риск дедлоков:
    return await client.GetByteArrayAsync(url).ConfigureAwait(false);
}
```
"""##,
                contentMarkdownEN: ##"""
### ConfigureAwait(false) in Library Code

`ConfigureAwait(false)` avoids capturing the calling `SynchronizationContext`, improving performance and eliminating UI deadlocks.
"""##,
                codeSnippet: ##"""
async Task<string> GetDataAsync() {
    await Task.Delay(5).ConfigureAwait(false);
    return "Data loaded";
}

string res = await GetDataAsync();
Console.WriteLine(res);
"""##,
                xpReward: 45
            ),

            Lesson(
                id: "cs_thread_pool_tasks",
                category: .csharpTPLThreading,
                titleRU: "ThreadPool, Task.Run и параллельное выполнение",
                titleEN: "ThreadPool, Task.Run & Parallel Coordination",
                summaryRU: "Пул потоков CLR, отправка CPU-bound задач через Task.Run, координация параллельных задач Task.WhenAll и Task.WhenAny.",
                summaryEN: "CLR ThreadPool, offloading CPU-bound workloads via Task.Run, and coordinating with Task.WhenAll / Task.WhenAny.",
                contentMarkdownRU: ##"""
### Пул потоков (CLR ThreadPool)

Создание операционной системой нативного потока (`new Thread()`) стоит дорого (около 1 МБ стека и сотни микросекунд). Среда .NET содержит оптимизированный **ThreadPool**, повторно использующий готовые потоки.

- **`Task.Run(action)`**: отправляет тяжелую CPU-интенсивную задачу в пул потоков.
- **`Task.WhenAll(tasks)`**: ожидает завершения **всех** параллельных задач одновременно.
- **`Task.WhenAny(tasks)`**: возвращает управление, как только завершится **хотя бы одна** из задач (паттерн гонки или таймаута).

```csharp
var taskA = Task.Run(() => ComputePrime(1000));
var taskB = Task.Run(() => ComputePrime(2000));

// Параллельное ожидание обеих задач:
int[] results = await Task.WhenAll(taskA, taskB);
Console.WriteLine($"Сумма: {results[0] + results[1]}");
```
"""##,
                contentMarkdownEN: ##"""
### ThreadPool and Task Coordination

`Task.Run` offloads work to the ThreadPool. `Task.WhenAll` awaits multiple concurrent tasks efficiently:

```csharp
var t1 = Task.Delay(10);
var t2 = Task.Delay(20);
await Task.WhenAll(t1, t2);
```
"""##,
                codeSnippet: ##"""
var t1 = Task.FromResult(10);
var t2 = Task.FromResult(20);

int[] res = await Task.WhenAll(t1, t2);
Console.WriteLine($"Combined: {res[0] + res[1]}");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_synchronization_lock",
                category: .csharpTPLThreading,
                titleRU: "Синхронизация потоков: lock, Monitor и Interlocked",
                titleEN: "Thread Synchronization: lock, Monitor & Interlocked",
                summaryRU: "Состояние гонки (Race Condition), критические секции lock, класс Monitor и высокоскоростные неблокирующие операции Interlocked.",
                summaryEN: "Race conditions, critical sections with lock and Monitor, and lock-free atomic operations via Interlocked.",
                contentMarkdownRU: ##"""
### Защита от состояния гонки (Race Conditions)

Когда несколько потоков одновременно модифицируют одну общую переменную, данные повреждаются:

```csharp
public class SafeCounter {
    private readonly object _lockObj = new();
    private int _count;

    // 1. Классический lock (компилируется в Monitor.Enter / Monitor.Exit):
    public void Increment() {
        lock (_lockObj) {
            _count++;
        }
    }

    public int Value => _count;
}
```

### Высокопроизводительный `Interlocked`
Для простых арифметических операций `lock` избыточен. Класс `Interlocked` использует инструкции процессора на аппаратном уровне (атомарный инкремент/сравнение без блокировки потоков):

```csharp
public class LockFreeCounter {
    private int _counter;

    // Атомарная аппаратная операция за доли наносекунды:
    public void Add(int amount) => Interlocked.Add(ref _counter, amount);
    public int Value => Volatile.Read(ref _counter);
}
```
"""##,
                contentMarkdownEN: ##"""
### Thread Synchronization & Interlocked

Use `lock` for critical sections and `Interlocked` for lock-free atomic primitive operations.
"""##,
                codeSnippet: ##"""
int counter = 0;
Interlocked.Increment(ref counter);
Interlocked.Add(ref counter, 5);

Console.WriteLine($"Counter: {counter}");
"""##,
                xpReward: 40
            ),

            Lesson(
                id: "cs_async_coordination",
                category: .csharpTPLThreading,
                titleRU: "Асинхронная координация: SemaphoreSlim и Channels",
                titleEN: "Async Coordination: SemaphoreSlim & System.Threading.Channels",
                summaryRU: "Ограничение степени параллелизма через SemaphoreSlim(maxConcurrency), очереди Producer-Consumer высокой производительности с Channels.",
                summaryEN: "Throttling concurrency with SemaphoreSlim and high-throughput Producer-Consumer queues via Channels.",
                contentMarkdownRU: ##"""
### Ограничение параллелизма: `SemaphoreSlim`

Обычный `lock` **запрещено** использовать с `await` внутри критической секции. Для асинхронного ограничения доступа к ресурсу (например, не более 5 одновременных запросов к внешнему API) используется `SemaphoreSlim`:

```csharp
private static readonly SemaphoreSlim _throttle = new(initialCount: 5, maxCount: 5);

public async Task ProcessWithThrottleAsync(int id) {
    await _throttle.WaitAsync(); // Асинхронное ожидание слота
    try {
        await CallExternalApiAsync(id);
    } finally {
        _throttle.Release(); // Освобождение слота
    }
}
```

### Каналы: `System.Threading.Channels`
Современный стандарт паттерна «Производитель-Потребитель» (Producer-Consumer) в .NET. Канал позволяет безопасно передавать миллионы сообщений между потоками с минимальными накладными расходами памяти.
"""##,
                contentMarkdownEN: ##"""
### SemaphoreSlim and Channels

`SemaphoreSlim` throttles concurrent async tasks without thread blocking:

```csharp
var sem = new SemaphoreSlim(2);
await sem.WaitAsync();
try { /* Work */ } finally { sem.Release(); }
```
"""##,
                codeSnippet: ##"""
var sem = new SemaphoreSlim(1);
await sem.WaitAsync();
try {
    Console.WriteLine("Protected section");
} finally {
    sem.Release();
}
"""##,
                xpReward: 45
            ),

            Lesson(
                id: "cs_parallel_plinq",
                category: .csharpTPLThreading,
                titleRU: "Параллельные вычисления: Parallel.ForEachAsync и PLINQ",
                titleEN: "Parallel Computing: Parallel.ForEachAsync & PLINQ",
                summaryRU: "Распараллеливание пакетных операций: Parallel.ForEachAsync в .NET 6+, параллельные LINQ-запросы PLINQ AsParallel и планирование потоков.",
                summaryEN: "Batch parallel operations: Parallel.ForEachAsync in .NET 6+, PLINQ AsParallel, and partitioning.",
                contentMarkdownRU: ##"""
### Параллельная обработка данных

1. **`Parallel.ForEachAsync` (введен в .NET 6)**:
Идеальный инструмент для пакетной асинхронной обработки коллекций с контролем параллелизма:

```csharp
var urls = new[] { "url1", "url2", "url3", "url4" };

await Parallel.ForEachAsync(urls, new ParallelOptions { MaxDegreeOfParallelism = 4 }, async (url, ct) => {
    using var client = new HttpClient();
    string res = await client.GetStringAsync(url, ct);
    Console.WriteLine($"Загружено: {url} ({res.Length} байт)");
});
```

2. **`PLINQ` (Parallel LINQ)**:
Автоматически разделяет коллекцию на сегменты и вычисляет фильтрацию и проекцию на всех ядрах процессора:
```csharp
int[] bigArray = Enumerable.Range(1, 1_000_000).ToArray();
var primes = bigArray.AsParallel()
                     .Where(n => IsPrime(n))
                     .ToArray();
```
"""##,
                contentMarkdownEN: ##"""
### Parallel.ForEachAsync & PLINQ

Execute async operations concurrently across worker cores with controlled degrees of parallelism:

```csharp
await Parallel.ForEachAsync(items, async (item, ct) => {
    await ProcessAsync(item);
});
```
"""##,
                codeSnippet: ##"""
int[] numbers = [1, 2, 3, 4, 5];
var doubled = numbers.AsParallel().Select(n => n * 2).ToArray();

Console.WriteLine($"Doubled count: {doubled.Length}");
"""##,
                xpReward: 45
            ),

            Lesson(
                id: "cs_gc_internals",
                category: .csharpModern,
                titleRU: "Внутреннее устройство Garbage Collection (GC) в .NET",
                titleEN: "Garbage Collection (GC) Internals & Generations",
                summaryRU: "Управляемая память CLR: поколения Gen 0, Gen 1, Gen 2, Large Object Heap (LOH), Pinned Object Heap (POH), фрагментация и уплотнение.",
                summaryEN: "CLR managed memory: Gen 0/1/2 generations, Large Object Heap (LOH), Pinned Object Heap (POH), compaction and GC tuning.",
                contentMarkdownRU: ##"""
### Сборщик мусора (Garbage Collector) в .NET

В .NET используется высокопроизводительный **поколенческий трассирующий сборщик мусора (Generational Tracing GC)**.

### Три поколения объектов
1. **Gen 0 (Поколение 0)**: самые новые короткоживущие объекты (локальные переменные функций). Сборка мусора в Gen 0 занимает доли миллисекунды.
2. **Gen 1 (Поколение 1)**: буферное поколение между молодыми и долгоживущими объектами.
3. **Gen 2 (Поколение 2)**: долгоживущие объекты (статические данные, кеши, синглтоны). Полная сборка (Full GC) охватывает Gen 2 и является наиболее ресурсоемкой.

### Специальные кучи
- **LOH (Large Object Heap)**: объекты размером более 85 000 байт (например, большие массивы) сразу размещаются в LOH, минуя Gen 0, чтобы избежать затрат на их перемещение при уплотнении памяти.
- **POH (Pinned Object Heap, .NET 5+)**: куча для закрепленных объектов, используемых при интеропе с нативным кодом C/C++.
"""##,
                contentMarkdownEN: ##"""
### Generational Garbage Collector

- **Gen 0**: short-lived local objects.
- **Gen 1**: intermediate buffer.
- **Gen 2**: long-lived objects.
- **LOH**: objects >= 85,000 bytes.
"""##,
                codeSnippet: ##"""
long memoryBefore = GC.GetTotalMemory(forceFullCollection: false);
Console.WriteLine($"Allocated memory: {memoryBefore / 1024} KB");
"""##,
                xpReward: 45
            ),

            Lesson(
                id: "cs_reflection_attributes",
                category: .csharpModern,
                titleRU: "Рефлексия (Reflection) и Пользовательские Атрибуты",
                titleEN: "Reflection, Type Metadata & Custom Attributes",
                summaryRU: "Инспекция типов во время выполнения: класс Type, typeof, чтение атрибутов через GetCustomAttributes, и создание декларативных метаданных.",
                summaryEN: "Runtime type inspection with Type, typeof, custom attributes via [AttributeUsage], and metadata querying.",
                contentMarkdownRU: ##"""
### Метаданные и Рефлексия в C#

Рефлексия позволяет программе динамически исследовать собственную структуру и типы во время выполнения через пространство имен `System.Reflection`:

```csharp
Type type = typeof(string);
Console.WriteLine($"Имя типа: {type.FullName}");

// Получение списка публичных методов:
var methods = type.GetMethods().Select(m => m.Name).Take(5);
Console.WriteLine(string.Join(", ", methods));
```

### Пользовательские Атрибуты (Custom Attributes)
Атрибуты позволяют прикреплять декларативные метаданные к классам, свойствам или методам:

```csharp
[AttributeUsage(AttributeTargets.Property)]
public class ColumnAttribute(string name) : Attribute {
    public string Name { get; } = name;
}

public class User {
    [Column("user_id")]
    public int Id { get; set; }
}
```
"""##,
                contentMarkdownEN: ##"""
### Reflection and Attributes

Attributes attach metadata readable at runtime via reflection:

```csharp
var t = typeof(int);
Console.WriteLine(t.IsValueType); // true
```
"""##,
                codeSnippet: ##"""
Type strType = typeof(string);
Console.WriteLine($"Type: {strType.Name}, Assembly: {strType.Assembly.GetName().Name}");
"""##,
                xpReward: 45
            ),

            Lesson(
                id: "cs_dependency_injection",
                category: .csharpModern,
                titleRU: "Dependency Injection: Внедрение зависимостей в .NET 8",
                titleEN: "Dependency Injection & Service Lifetimes in .NET 8",
                summaryRU: "Архитектурный стандарт .NET: контейнер IServiceCollection, жизненные циклы Transient, Scoped, Singleton и инверсия управления IoC.",
                summaryEN: "The .NET architecture standard: IServiceCollection container, Transient, Scoped, Singleton lifetimes, and IoC.",
                contentMarkdownRU: ##"""
### Dependency Injection (DI) в современном .NET

Платформа .NET имеет встроенный высокопроизводительный IoC-контейнер `Microsoft.Extensions.DependencyInjection`.

### 3 времени жизни сервисов (Service Lifetimes)
1. **Transient (`AddTransient`)**: новый экземпляр создается **каждый раз**, когда запрашивается сервис. Идеально для легковесных stateless-компонентов.
2. **Scoped (`AddScoped`)**: создается **один экземпляр на всю область видимости (Scope)**. В веб-приложениях ASP.NET Core один scope создается на каждый входящий HTTP-запрос (идеально для `DbContext`).
3. **Singleton (`AddSingleton`)**: создается **один-единственный экземпляр на всё время жизни приложения**.

```csharp
public interface IMetricsService { void Record(); }
public class CloudMetricsService : IMetricsService {
    public void Record() => Console.WriteLine("Метрика отправлена.");
}

// Регистрация в Program.cs:
// builder.Services.AddSingleton<IMetricsService, CloudMetricsService>();
```
"""##,
                contentMarkdownEN: ##"""
### Dependency Injection Lifetimes

- **Transient**: new instance per request.
- **Scoped**: one instance per HTTP request scope.
- **Singleton**: one instance throughout application lifetime.
"""##,
                codeSnippet: ##"""
Console.WriteLine("DI Lifetimes: Transient, Scoped, Singleton");
"""##,
                xpReward: 45
            ),

            // MARK: - SQL Lessons
            Lesson(
                id: "sql_relational_foundations",
                category: .sqlBasics,
                titleRU: "Реляционная модель, таблицы и атрибуты",
                titleEN: "Relational Model, Tables & Attributes",
                summaryRU: "Фундамент реляционных БД: сущности, кортежи, домены, первичные ключи и декларативный характер SQL.",
                summaryEN: "Relational database foundations: entities, tuples, domains, primary keys, and declarative SQL paradigm.",
                contentMarkdownRU: ##"""
### Реляционная модель данных (РМД)

Реляционная модель, сформулированная Эдгаром Коддом в 1970 году, основана на математической теории множеств и предикатной логике:
- **Отношение (Relation)** — в физическом представлении таблица.
- **Кортеж (Tuple)** — строка таблицы, представляющая единичный экземпляр сущности.
- **Атрибут (Attribute)** — именованная колонка с фиксированным доменом (типом данных).
- **Степень (Arity)** — количество столбцов в таблице.
- **Мощность (Cardinality)** — текущее количество строк в таблице.

### Декларативная парадигма SQL
В отличие от императивных языков (Swift, Python, C#), где программист указывает алгоритм *«как вычислять»*, в SQL формулируется *«какие данные нужны»* (декларативное описание желаемого результата). Оптимизатор запросов (Query Planner) СУБД самостоятельно строит дерево выполнения.

### Первичный ключ (Primary Key)
Каждая таблица должна иметь столбец или группу столбцов, однозначно идентифицирующих запись:
- Гарантирует уникальность кортежа.
- Не допускает значений `NULL`.
- Служит основой для построения кластерных и B-Tree индексов.
"""##,
                contentMarkdownEN: ##"""
### The Relational Model
Formulated by Edgar F. Codd in 1970, the relational model maps real-world entities into mathematical relations (tables):
- **Relation**: Table holding homogenous rows.
- **Tuple**: Single record representing an entity instance.
- **Attribute**: Named column adhering to a defined data type.
- **Cardinality**: Number of rows stored in a relation.

### Declarative Nature of SQL
Unlike imperative languages where developers outline step-by-step algorithms, SQL queries specify *what* data to retrieve, leaving the query planner to determine *how* best to execute it.
"""##,
                codeSnippet: ##"""
-- Создание базовой сущности с первичным ключом
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, email) VALUES 
('alex_dev', 'alex@example.com'),
('elena_qa', 'elena@example.com');

SELECT id, username, email FROM users;
"""##,
                xpReward: 35,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какое понятие реляционной теории соответствует строке физической таблицы?",
                        questionEN: "Which relational concept corresponds to a physical table row?",
                        optionsRU: ["Кортеж (Tuple)", "Домен (Domain)", "Атрибут (Attribute)", "Мощность (Cardinality)"],
                        optionsEN: ["Tuple", "Domain", "Attribute", "Cardinality"],
                        correctIndex: 0,
                        explanationRU: "В реляционной алгебре строка таблицы называется кортежем.",
                        explanationEN: "In relational algebra, a row is termed a tuple."
                    ),
                    QuizQuestion(
                        questionRU: "Может ли первичный ключ (Primary Key) содержать значение NULL?",
                        questionEN: "Can a Primary Key column contain NULL values?",
                        optionsRU: ["Нет, первичный ключ обязан быть уникальным и NOT NULL", "Да, если это SQLite", "Да, если колонка текстовая", "Только для первой строки"],
                        optionsEN: ["No, a Primary Key must be unique and NOT NULL", "Yes, in SQLite only", "Yes, for text columns", "Only for the first row"],
                        correctIndex: 0,
                        explanationRU: "Первичный ключ строго требует уникальности и запрещает значение NULL согласно стандарту SQL.",
                        explanationEN: "Primary Keys strictly mandate uniqueness and disallow NULL per SQL standards."
                    )
                ]
            ),

            Lesson(
                id: "sql_select_syntax",
                category: .sqlBasics,
                titleRU: "Синтаксис SELECT, проекция и вычисления",
                titleEN: "SELECT Syntax, Projections & Expressions",
                summaryRU: "Выборка данных, порядок выполнения операторов SQL, математические вычисления в столбцах и константы.",
                summaryEN: "Data selection, SQL statement execution order, in-flight calculations, and constant projections.",
                contentMarkdownRU: ##"""
### Оператор SELECT и проекция данных

Оператор `SELECT` задает проекцию — список колонок и выражений, возвращаемых клиенту.

```sql
SELECT column1, column2, column3 * 1.2 FROM table_name;
```

### Реальный логический порядок выполнения SQL
Несмотря на то, что запрос начинается со слова `SELECT`, СУБД вычисляет части запроса в совершенно другом порядке:
1. `FROM` — выбор источника данных (и JOIN таблиц).
2. `WHERE` — предварительная фильтрация строк.
3. `GROUP BY` — группировка строк.
4. `HAVING` — фильтрация агрегированных групп.
5. `SELECT` — вычисление выражений, присвоение псевдонимов `AS`.
6. `DISTINCT` — исключение дубликатов.
7. `ORDER BY` — сортировка результатов.
8. `LIMIT` / `OFFSET` — ограничение объема возвращаемых строк.

Именно поэтому псевдоним (alias), объявленный в `SELECT`, нельзя использовать в `WHERE`!

### Вычисления на лету
В блоке `SELECT` можно выполнять арифметические операции, конкатенацию строк и использовать системные функции:
```sql
SELECT 
    name,
    salary,
    salary * 0.13 AS tax_amount,
    salary * 0.87 AS net_income
FROM employees;
```
"""##,
                contentMarkdownEN: ##"""
### The SELECT Statement and Logical Processing
While queries begin with `SELECT`, SQL engines execute clauses in a strict logical sequence:
1. `FROM` (and JOINs)
2. `WHERE`
3. `GROUP BY`
4. `HAVING`
5. `SELECT`
6. `DISTINCT`
7. `ORDER BY`
8. `LIMIT` / `OFFSET`

Because `WHERE` executes before `SELECT`, column aliases declared in `SELECT` cannot be referenced inside `WHERE`.
"""##,
                codeSnippet: ##"""
-- Проекция с вычисляемыми полями
CREATE TABLE products (
    id INTEGER PRIMARY KEY,
    name TEXT,
    cost_price REAL,
    markup_percent REAL
);

INSERT INTO products VALUES 
(1, 'Клавиатура Pro', 4500.0, 25.0),
(2, 'Мышь Master', 2800.0, 30.0);

SELECT 
    name, 
    cost_price, 
    ROUND(cost_price * (1 + markup_percent / 100.0), 2) AS retail_price
FROM products;
"""##,
                xpReward: 35,
                quiz: [
                    QuizQuestion(
                        questionRU: "Почему в блоке WHERE нельзя использовать alias столбца, объявленный в SELECT?",
                        questionEN: "Why can't you reference an alias defined in SELECT inside the WHERE clause?",
                        optionsRU: ["Блок WHERE логически выполняется раньше, чем блок SELECT", "В SQL запрещены псевдонимы колонок", "WHERE работает только с целыми числами", "Это ограничение только в SQLite"],
                        optionsEN: ["WHERE logically executes before the SELECT clause", "SQL forbids column aliases", "WHERE only works with integers", "It is only an SQLite limitation"],
                        correctIndex: 0,
                        explanationRU: "Поскольку WHERE выполняется на шаге 2, а SELECT на шаге 5, на этапе фильтрации алиас еще не существует.",
                        explanationEN: "Because WHERE is evaluated during step 2 while SELECT occurs at step 5, aliases are unknown to WHERE."
                    )
                ]
            ),

            Lesson(
                id: "sql_distinct_aliases",
                category: .sqlBasics,
                titleRU: "Устранение дубликатов DISTINCT и псевдонимы AS",
                titleEN: "Eliminating Duplicates (DISTINCT) & Aliasing (AS)",
                summaryRU: "Модификатор DISTINCT для уникализации строк выборки, мульти-колоночный DISTINCT и правила использования AS.",
                summaryEN: "Eliminating duplicate result tuples with DISTINCT, multi-column uniqueness, and table/column aliasing rules.",
                contentMarkdownRU: ##"""
### Модификатор DISTINCT

По умолчанию реляционный SQL возвращает мультимножество (строки могут повторяться). Ключевое слово `DISTINCT` принудительно удаляет дублирующиеся строки:

```sql
SELECT DISTINCT department FROM employees;
```

### DISTINCT для нескольких колонок
`DISTINCT` применяется ко **всей строке** проекции целиком, а не к первому столбцу:
```sql
-- Возвратит уникальные пары (страна, город)
SELECT DISTINCT country, city FROM offices;
```
Если в таблице 10 офисов в Москве (Россия), в результате останется только одна строка `('Россия', 'Москва')`.

### Псевдонимы колонок и таблиц (AS)
Ключевое слово `AS` переименовывает поля в результирующем наборе и сокращает длинные имена таблиц:
```sql
SELECT 
    e.first_name AS given_name,
    e.last_name AS surname
FROM enterprise_employees AS e;
```
Слово `AS` опционально в большинстве диалектов, однако его явное указание считается стандартом промышленного кода.
"""##,
                contentMarkdownEN: ##"""
### Eliminating Duplicates with DISTINCT
By default, queries return multi-sets with potential duplicate rows. `DISTINCT` enforces set semantics on the output columns.

When multiple columns are specified, uniqueness evaluates the entire tuple of requested attributes, not individual fields.
"""##,
                codeSnippet: ##"""
CREATE TABLE visits (
    user_id INTEGER,
    page_url TEXT,
    visited_at DATE
);

INSERT INTO visits VALUES 
(101, '/home', '2026-03-01'),
(101, '/home', '2026-03-01'),
(101, '/catalog', '2026-03-01'),
(102, '/home', '2026-03-01');

-- Получаем уникальные страницы, посещенные пользователями
SELECT DISTINCT user_id, page_url FROM visits;
"""##,
                xpReward: 35,
                quiz: [
                    QuizQuestion(
                        questionRU: "К каким колонкам применяется DISTINCT в запросе `SELECT DISTINCT city, street FROM addresses;`?",
                        questionEN: "Which columns does DISTINCT evaluate in `SELECT DISTINCT city, street FROM addresses;`?",
                        optionsRU: ["Ко всей совокупности колонок (city, street)", "Только к первой колонке city", "Только ко второй колонке street", "Только к числу строк"],
                        optionsEN: ["To the entire combination of (city, street)", "Only to the first column (city)", "Only to the second column (street)", "Only to the row count"],
                        correctIndex: 0,
                        explanationRU: "DISTINCT оценивает уникальность всей комбинации всех указанных в SELECT полей.",
                        explanationEN: "DISTINCT enforces uniqueness across the entire projected tuple."
                    )
                ]
            ),

            Lesson(
                id: "sql_where_comparison",
                category: .sqlFiltering,
                titleRU: "Фильтрация WHERE: сравнение и логика AND/OR/NOT",
                titleEN: "WHERE Filtering: Comparison & Boolean Logic",
                summaryRU: "Предикаты условий, приоритеты логических операторов, круглые скобки и ловушки смешивания AND с OR.",
                summaryEN: "Condition predicates, boolean operator precedence, parenthesis rules, and pitfalls of mixing AND with OR.",
                contentMarkdownRU: ##"""
### Предложение WHERE и операторы сравнения

Предложение `WHERE` оставляет только те строки, для которых условие вычисляется в `TRUE`:
- Равенство: `=`, неравенство: `<>` или `!=`
- Сравнение величин: `<`, `>`, `<=`, `>=`

### Логические связки: AND, OR, NOT
- `AND` — конъюнкция (оба условия должны быть истинными).
- `OR` — дизъюнкция (хотя бы одно условие истинно).
- `NOT` — логическое отрицание.

### Приоритет операторов (Operator Precedence)
В стандарте SQL оператор **AND имеет более высокий приоритет**, чем оператор **OR** (аналогично умножению перед сложением в арифметике).

Пример опасной ошибки:
```sql
-- ОШИБКА: вернет активных админов ИЛИ любых заблокированных пользователей!
SELECT * FROM users 
WHERE role = 'admin' OR role = 'manager' AND status = 'active';

-- ПРАВИЛЬНО: явные скобки группируют дизъюнкцию
SELECT * FROM users 
WHERE (role = 'admin' OR role = 'manager') AND status = 'active';
```
"""##,
                contentMarkdownEN: ##"""
### WHERE Clause & Comparison Operators
The `WHERE` clause filters candidate records based on boolean predicates.

### Precedence of Boolean Operators
`AND` evaluates before `OR`. Always employ explicit parentheses when combining conjunctions and disjunctions to prevent unintended query outcomes.
"""##,
                codeSnippet: ##"""
CREATE TABLE accounts (
    id INTEGER PRIMARY KEY,
    owner TEXT,
    tier TEXT,
    balance REAL,
    is_active INTEGER
);

INSERT INTO accounts VALUES 
(1, 'Anna', 'VIP', 150000.0, 1),
(2, 'Boris', 'Standard', 3500.0, 0),
(3, 'Cyril', 'Standard', 80000.0, 1);

-- Выбор активных пользователей с балансом свыше 50 000
SELECT owner, tier, balance 
FROM accounts 
WHERE is_active = 1 AND balance >= 50000;
"""##,
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какой оператор в SQL имеет более высокий приоритет выполнения: AND или OR?",
                        questionEN: "Which boolean operator has higher evaluation precedence in SQL: AND or OR?",
                        optionsRU: ["AND", "OR", "Они имеют одинаковый приоритет", "Зависит от порядка колонок в таблице"],
                        optionsEN: ["AND", "OR", "They have equal precedence", "Depends on column order"],
                        correctIndex: 0,
                        explanationRU: "Оператор AND вычисляется раньше оператора OR, поэтому сложные условия требуют скобок.",
                        explanationEN: "AND binds more tightly than OR, mirroring arithmetic multiplication over addition."
                    )
                ]
            ),

            Lesson(
                id: "sql_in_between_operators",
                category: .sqlFiltering,
                titleRU: "Диапазоны BETWEEN и проверка множеств IN",
                titleEN: "Range Checks (BETWEEN) & Set Inclusion (IN)",
                summaryRU: "Операторы IN и NOT IN, оптимизация условий, включение границ в BETWEEN и работа с датами.",
                summaryEN: "IN and NOT IN operators, condition optimization, inclusive boundary behavior in BETWEEN, and temporal ranges.",
                contentMarkdownRU: ##"""
### Оператор IN
Позволяет проверить вхождение значения в заданный список констант или результат подзапроса:
```sql
SELECT title, genre FROM books 
WHERE genre IN ('Sci-Fi', 'Fantasy', 'Cyberpunk');
```
Это эквивалентно цепочке `genre = 'Sci-Fi' OR genre = 'Fantasy' ...`, но выполняется оптимизатором значительно эффективнее.

### Оператор NOT IN и опасность NULL
> [!WARNING]
> Если список для `NOT IN` содержит хотя бы одно значение `NULL`, выражение `col NOT IN (1, 2, NULL)` вернет пустое множество для всех строк из-за трехзначной логики SQL!

### Оператор BETWEEN
Проверяет попадание значения в диапазон. **Обе границы включаются**:
```sql
SELECT product_name, price FROM store 
WHERE price BETWEEN 100 AND 500;
-- Полный эквивалент: price >= 100 AND price <= 500
```
"""##,
                contentMarkdownEN: ##"""
### Set Matching with IN
`IN` verifies whether an expression matches any item in a literal tuple or subquery result set.

### Interval Checking with BETWEEN
`BETWEEN low AND high` is inclusive on both boundary ends (`>= low AND <= high`). Be mindful of temporal comparisons where dates include fractional timestamps.
"""##,
                codeSnippet: ##"""
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    client TEXT,
    status TEXT,
    total REAL
);

INSERT INTO orders VALUES 
(1, 'Acme Corp', 'SHIPPED', 1200.0),
(2, 'Beta LLC', 'PENDING', 450.0),
(3, 'Gamma Inc', 'DELIVERED', 890.0),
(4, 'Delta Ltd', 'CANCELLED', 110.0);

-- Выбираем заказы с валидными успешными статусами в диапазоне чека
SELECT order_id, client, total 
FROM orders 
WHERE status IN ('SHIPPED', 'DELIVERED') 
  AND total BETWEEN 500.0 AND 2000.0;
"""##,
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Включает ли оператор `price BETWEEN 100 AND 200` числа 100 и 200?",
                        questionEN: "Does `price BETWEEN 100 AND 200` include the values 100 and 200?",
                        optionsRU: ["Да, обе границы диапазона включаются", "Нет, только 100", "Нет, только 200", "Нет, границы строго исключаются"],
                        optionsEN: ["Yes, both boundaries are included", "No, only 100 is included", "No, only 200 is included", "No, it is strictly exclusive"],
                        correctIndex: 0,
                        explanationRU: "BETWEEN в стандарте SQL является инклюзивным для обоих концов отрезка.",
                        explanationEN: "BETWEEN is inclusive on both lower and upper bounds."
                    )
                ]
            ),

            Lesson(
                id: "sql_like_wildcards",
                category: .sqlFiltering,
                titleRU: "Поиск по шаблону LIKE и подстановочные знаки",
                titleEN: "Pattern Matching: LIKE & Wildcards",
                summaryRU: "Символы подстановки % и _, регистрозависимость, экранирование ESCAPE и оператор GLOB в SQLite.",
                summaryEN: "Wildcard symbols % and _, case-sensitivity rules, escape sequences, and SQLite GLOB operator.",
                contentMarkdownRU: ##"""
### Оператор LIKE и спецсимволы

Оператор `LIKE` производит сопоставление строки с шаблоном:
- `%` — заменяет любое количество символов (от нуля до бесконечности).
- `_` — заменяет ровно один произвольный символ.

```sql
-- Поиск email адресов на домене .org
SELECT * FROM users WHERE email LIKE '%.org';

-- Поиск кодов вида AB-1, CD-9 (ровно один символ в конце)
SELECT * FROM parts WHERE part_code LIKE '__-_';
```

### Экранирование спецсимволов (ESCAPE)
Если нужно найти сам знак процента или подчеркивания:
```sql
SELECT * FROM discounts WHERE discount_name LIKE '%50!%%' ESCAPE '!';
```

### Регистрозависимость
В SQLite оператор `LIKE` по умолчанию нечувствителен к регистру для латиницы (ASCII). Для регистрозависимого сопоставления SQLite предоставляет оператор `GLOB`, использующий Unix-синтаксис `*` и `?`.
"""##,
                contentMarkdownEN: ##"""
### String Pattern Matching with LIKE
- `%` represents zero or more characters.
- `_` represents exactly one single character.

To search for literal `%` or `_` characters, supply an explicit `ESCAPE` escape clause.
"""##,
                codeSnippet: ##"""
CREATE TABLE staff (
    id INTEGER PRIMARY KEY,
    full_name TEXT,
    phone TEXT
);

INSERT INTO staff VALUES 
(1, 'Иван Иванов', '+7-999-111-22-33'),
(2, 'Иван Петров', '+7-999-222-33-44'),
(3, 'Сергей Иванов', '+7-495-555-66-77');

-- Ищем всех сотрудников с фамилией Иванов
SELECT id, full_name, phone 
FROM staff 
WHERE full_name LIKE '%Иванов';
"""##,
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какой спецсимвол в операторе LIKE заменяет ровно один любой символ?",
                        questionEN: "Which wildcard character in LIKE matches exactly one character?",
                        optionsRU: ["Символ подчеркивания `_`", "Знак процента `%`", "Звездочка `*`", "Знак вопроса `?`"],
                        optionsEN: ["Underscore `_`", "Percent sign `%`", "Asterisk `*`", "Question mark `?`"],
                        correctIndex: 0,
                        explanationRU: "Символ `_` обозначает строго одну позицию символа.",
                        explanationEN: "The underscore `_` matches exactly one character in SQL standard LIKE clauses."
                    )
                ]
            ),

            Lesson(
                id: "sql_null_three_valued_logic",
                category: .sqlFiltering,
                titleRU: "Трехзначная логика SQL: NULL, IS NULL и UNKNOWN",
                titleEN: "Three-Valued Logic: NULL, IS NULL & UNKNOWN",
                summaryRU: "Сущность NULL как отсутствия значения, почему NULL = NULL дает UNKNOWN, и правильная проверка через IS NULL.",
                summaryEN: "Semantics of NULL as missing information, why NULL = NULL evaluates to UNKNOWN, and proper IS NULL predicates.",
                contentMarkdownRU: ##"""
### Природа NULL в SQL

`NULL` — это не число 0, не пустая строка `""` и не пустой массив. Это маркер **отсутствия значения** (unknown / missing information).

### Главное правило: NULL ничему не равен
Попытка сравнить `NULL` через обычные операторы всегда возвращает третье логическое состояние — `UNKNOWN`:
```sql
NULL = 0       --> UNKNOWN
NULL = NULL    --> UNKNOWN
NULL != NULL   --> UNKNOWN
```

Поскольку `WHERE` оставляет только строки со значением `TRUE`, условие `WHERE col = NULL` **никогда не вернет ни одной строки**!

### Правильная проверка: IS NULL и IS NOT NULL
```sql
SELECT employee_name, phone 
FROM contacts 
WHERE phone IS NULL; -- Строки с незаполненным телефоном

SELECT employee_name, phone 
FROM contacts 
WHERE phone IS NOT NULL; -- Строки с существующим телефоном
```
"""##,
                contentMarkdownEN: ##"""
### Three-Valued Logic (3VL)
SQL operates on three truth values: `TRUE`, `FALSE`, and `UNKNOWN`.

Direct comparisons against `NULL` using `=` or `!=` yield `UNKNOWN`, never `TRUE`. Consequently, `WHERE val = NULL` will never evaluate to true. Always use `IS NULL` or `IS NOT NULL`.
"""##,
                codeSnippet: ##"""
CREATE TABLE candidates (
    id INTEGER PRIMARY KEY,
    name TEXT,
    referral_code TEXT
);

INSERT INTO candidates VALUES 
(1, 'Максим', 'REF2026'),
(2, 'Ольга', NULL),
(3, 'Дмитрий', NULL);

-- Корректная выборка кандидатов без реферального кода
SELECT name FROM candidates WHERE referral_code IS NULL;
"""##,
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Каков результат вычисления выражения `NULL = NULL` в стандарте SQL?",
                        questionEN: "What is the result of evaluating `NULL = NULL` in standard SQL?",
                        optionsRU: ["UNKNOWN (Неизвестно)", "TRUE (Истина)", "FALSE (Ложь)", "Синтаксическая ошибка"],
                        optionsEN: ["UNKNOWN", "TRUE", "FALSE", "Syntax Error"],
                        correctIndex: 0,
                        explanationRU: "Любое прямое сравнение с NULL возвращает логическое значение UNKNOWN.",
                        explanationEN: "Comparisons involving NULL produce UNKNOWN in three-valued logic."
                    )
                ]
            ),

            Lesson(
                id: "sql_order_by_multi",
                category: .sqlSortingPagination,
                titleRU: "Сортировка строк ORDER BY: ASC, DESC и NULLS",
                titleEN: "Sorting with ORDER BY: ASC, DESC & NULLS",
                summaryRU: "Многоуровневая сортировка по нескольким колонкам, позиционные номера колонок и размещение NULL значений.",
                summaryEN: "Multi-column ordering, ascending vs descending, positional references, and NULL placement strategies.",
                contentMarkdownRU: ##"""
### Сортировка результатов с ORDER BY

Реляционная таблица по определению является неупорядоченным множеством. Без явного указания `ORDER BY` порядок возврата строк недетерминирован СУБД!

### Направление сортировки
- `ASC` (по умолчанию) — по возрастанию (от А к Я, от 1 к 10).
- `DESC` — по убыванию (от Я к А, от 10 к 1).

### Множественная сортировка
Колонки сортируются слева направо. Вторая колонка учитывается только при равенстве значений в первой:
```sql
SELECT department, last_name, salary 
FROM employees 
ORDER BY department ASC, salary DESC;
```

### Поведение NULL значений
В стандарте SQL поддерживаются спецификаторы `NULLS FIRST` и `NULLS LAST`:
```sql
SELECT name, bonus FROM agents 
ORDER BY bonus DESC NULLS LAST;
```
"""##,
                contentMarkdownEN: ##"""
### Deterministic Results with ORDER BY
Tables maintain no inherent row order. To guarantee consistent ordering across executions, append `ORDER BY`.

Multiple columns evaluate left-to-right. Use `ASC` (default) for ascending and `DESC` for descending order.
"""##,
                codeSnippet: ##"""
CREATE TABLE leaderboard (
    id INTEGER PRIMARY KEY,
    player TEXT,
    division INTEGER,
    score INTEGER
);

INSERT INTO leaderboard VALUES 
(1, 'Ace', 1, 950),
(2, 'Blitz', 2, 880),
(3, 'Nova', 1, 1020),
(4, 'Shadow', 2, 880);

-- Сортировка сначала по дивизиону, затем по очкам (топ игроки вверху)
SELECT division, player, score 
FROM leaderboard 
ORDER BY division ASC, score DESC;
"""##,
                xpReward: 35,
                quiz: [
                    QuizQuestion(
                        questionRU: "Гарантирует ли SQL детерминированный порядок строк в ответе, если в запросе отсутствует ORDER BY?",
                        questionEN: "Does SQL guarantee a deterministic row order without an explicit ORDER BY clause?",
                        optionsRU: ["Нет, без ORDER BY порядок строк не гарантируется", "Да, строки всегда идут в порядке добавления (по id)", "Да, строки сортируются по алфавиту", "Да, если таблица меньше 1000 строк"],
                        optionsEN: ["No, row ordering is non-deterministic without ORDER BY", "Yes, always follows insertion order", "Yes, alphabetical by default", "Yes, for tables under 1000 rows"],
                        correctIndex: 0,
                        explanationRU: "Таблица в реляционной теории — неупорядоченное множество, поэтому порядок гарантирует только ORDER BY.",
                        explanationEN: "Relations are unordered sets; only explicit ORDER BY clauses ensure deterministic order."
                    )
                ]
            ),

            Lesson(
                id: "sql_limit_offset_paging",
                category: .sqlSortingPagination,
                titleRU: "Пагинация данных: LIMIT, OFFSET и Keyset Pagination",
                titleEN: "Data Pagination: LIMIT, OFFSET & Keyset Pagination",
                summaryRU: "Ограничение размера ответа LIMIT, смещение OFFSET, проблема производительности глубокой пагинации и курсорный подход.",
                summaryEN: "Row limits with LIMIT, pagination offsets, deep pagination performance degradation, and keyset cursor optimization.",
                contentMarkdownRU: ##"""
### Ограничение выборки: LIMIT и OFFSET

Для постраничного вывода (pagination) используются операторы:
- `LIMIT N` — вернуть не более N строк.
- `OFFSET M` — пропустить первые M строк перед возвратом.

```sql
-- Страница 3 при размере страницы 20 элементов:
SELECT id, title FROM articles 
ORDER BY created_at DESC 
LIMIT 20 OFFSET 40; -- пропуск 2 страниц (2 * 20)
```

### Проблема производительности глубокого OFFSET
При выполнении `OFFSET 1000000 LIMIT 20` СУБД вынуждена физически прочитать и отсортировать 1 000 020 строк, после чего отбросить миллион. Это вызывает катастрофическую деградацию времени ответа.

### Решение: Keyset (Cursor-based) пагинация
Вместо `OFFSET` фильтруют по значению последнего увиденного первичного ключа:
```sql
SELECT id, title FROM articles 
WHERE id < :last_seen_id 
ORDER BY id DESC 
LIMIT 20;
```
Такой запрос использует индекс и отрабатывает за $O(\log N)$ независимо от глубины страницы!
"""##,
                contentMarkdownEN: ##"""
### Pagination with LIMIT and OFFSET
`LIMIT` caps returned row count, while `OFFSET` skips initial entries.

### The Deep Pagination Pitfall
`OFFSET 1000000` requires database engines to scan, order, and discard one million records. For large datasets, utilize **keyset pagination** (`WHERE id > last_seen_id`) leveraging index seeks.
"""##,
                codeSnippet: ##"""
CREATE TABLE events (
    id INTEGER PRIMARY KEY,
    event_type TEXT,
    payload TEXT
);

INSERT INTO events (event_type, payload) VALUES 
('LOGIN', 'User 1'), ('CLICK', 'Btn A'),
('PURCHASE', 'Order 10'), ('LOGOUT', 'User 1'),
('LOGIN', 'User 2'), ('PAGEVIEW', '/home');

-- Получаем 2 события со второй страницы (пропуская первые 2)
SELECT id, event_type, payload 
FROM events 
ORDER BY id ASC 
LIMIT 2 OFFSET 2;
"""##,
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Почему использование большого значения OFFSET (например, OFFSET 500000) не рекомендуется для больших таблиц?",
                        questionEN: "Why is large OFFSET values (e.g., OFFSET 500000) discouraged on high-scale tables?",
                        optionsRU: ["СУБД вынуждена прочитать и отбросить все 500 000 строк", "OFFSET работает только с текстовыми полями", "В SQL лимит OFFSET ограничен 1000", "База данных блокирует всю таблицу"],
                        optionsEN: ["The engine must physically scan and discard all 500k rows", "OFFSET only works with text columns", "SQL restricts OFFSET to 1000 maximum", "The database places exclusive locks on the table"],
                        correctIndex: 0,
                        explanationRU: "OFFSET требует полного сканирования и пропуска предшествующих строк, что резко замедляет запрос.",
                        explanationEN: "OFFSET incurs full linear scans up to the offset count before returning requested items."
                    )
                ]
            ),

            Lesson(
                id: "sql_aggregate_functions",
                category: .sqlAggregations,
                titleRU: "Агрегатные функции: COUNT, SUM, AVG, MIN, MAX",
                titleEN: "Aggregate Functions: COUNT, SUM, AVG, MIN & MAX",
                summaryRU: "Сворачивание множеств значений в скалярные метрики, разница COUNT(*) и COUNT(column), игнорирование NULL.",
                summaryEN: "Collapsing recordsets into scalar metrics, COUNT(*) vs COUNT(column) distinctions, and NULL avoidance rules.",
                contentMarkdownRU: ##"""
### Скалярные агрегаты

Агрегатные функции принимают набор значений колонки и возвращают одно итоговое число:
- `COUNT(*)` — количество всех строк, включая содержащие `NULL`.
- `COUNT(column)` — количество строк, где `column IS NOT NULL`.
- `COUNT(DISTINCT column)` — количество уникальных не-NULL значений.
- `SUM(column)` — сумма чисел.
- `AVG(column)` — среднее значение (сумма деленная на количество не-NULL).
- `MIN(column)` / `MAX(column)` — минимальное и максимальное значения.

### КРИТИЧЕСКИ ВАЖНО: NULL игнорируется
Все агрегаты (кроме `COUNT(*)`) полностью игнорируют значения `NULL`:
Если в колонке 4 строки со значениями `[10, 20, NULL, 30]`:
- `COUNT(*)` вернет `4`.
- `COUNT(val)` вернет `3`.
- `AVG(val)` вернет `(10 + 20 + 30) / 3 = 20.0` (а НЕ 15.0)!
"""##,
                contentMarkdownEN: ##"""
### Aggregate Functions
Aggregates collapse multiple input rows into a single scalar value.

All mathematical aggregate functions (`SUM`, `AVG`, `MIN`, `MAX`, and `COUNT(col)`) ignore `NULL` entries. Only `COUNT(*)` tallies physical rows regardless of column nullability.
"""##,
                codeSnippet: ##"""
CREATE TABLE sensor_readings (
    id INTEGER PRIMARY KEY,
    device_id TEXT,
    temperature REAL
);

INSERT INTO sensor_readings VALUES 
(1, 'sensor_a', 22.5),
(2, 'sensor_a', 24.1),
(3, 'sensor_a', NULL),
(4, 'sensor_a', 23.0);

SELECT 
    COUNT(*) AS total_records,
    COUNT(temperature) AS valid_readings,
    MIN(temperature) AS min_temp,
    MAX(temperature) AS max_temp,
    ROUND(AVG(temperature), 2) AS avg_temp
FROM sensor_readings;
"""##,
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какая агрегатная функция учитывает строки, содержащие значение NULL?",
                        questionEN: "Which aggregate function accounts for rows containing NULL values?",
                        optionsRU: ["COUNT(*)", "COUNT(column)", "AVG(column)", "SUM(column)"],
                        optionsEN: ["COUNT(*)", "COUNT(column)", "AVG(column)", "SUM(column)"],
                        correctIndex: 0,
                        explanationRU: "COUNT(*) подсчитывает физические строки таблицы независимо от содержимого колонок.",
                        explanationEN: "COUNT(*) tallies row occurrences without inspecting specific column nullability."
                    )
                ]
            ),

            Lesson(
                id: "sql_group_by_having",
                category: .sqlAggregations,
                titleRU: "Группировка GROUP BY и фильтрация групп HAVING",
                titleEN: "Grouping with GROUP BY & Filtering with HAVING",
                summaryRU: "Разделение выборки на группы, правило валидности проекции в GROUP BY и разница WHERE vs HAVING.",
                summaryEN: "Partitioning recordsets into groups, projection validity rules in GROUP BY, and WHERE vs HAVING comparison.",
                contentMarkdownRU: ##"""
### Предложение GROUP BY

Оператор `GROUP BY` объединяет строки с одинаковыми значениями в указанных столбцах в единую сводную запись для агрегации:

```sql
SELECT department, COUNT(*) AS headcount, AVG(salary) AS mean_pay
FROM employees 
GROUP BY department;
```

### Главное синтаксическое правило GROUP BY
Если в запросе присутствует `GROUP BY`, каждый столбец в блоке `SELECT` обязан быть либо:
1. Перечислен в предложении `GROUP BY`.
2. Обернут в агрегатную функцию (`SUM`, `AVG`, `MAX` и т.д.).

Любая колонка вне этого правила приводит к недетерминированному поведению или ошибке `Column must appear in the GROUP BY clause`.

### WHERE против HAVING
- `WHERE` фильтрует **исходные строки до** группировки. В `WHERE` нельзя использовать агрегатные функции!
- `HAVING` фильтрует **сформированные группы после** агрегации:
```sql
SELECT department, AVG(salary) AS avg_sal 
FROM employees 
WHERE is_employed = 1         -- фильтр строк
GROUP BY department 
HAVING AVG(salary) > 80000;   -- фильтр агрегированных групп
```
"""##,
                contentMarkdownEN: ##"""
### GROUP BY & HAVING
`GROUP BY` condenses identical values in target fields into aggregate buckets.

Every unaggregated attribute in the `SELECT` list must be explicitly declared in the `GROUP BY` clause.

Use `WHERE` for row-level pre-filtering and `HAVING` for group-level metric filtering.
"""##,
                codeSnippet: ##"""
CREATE TABLE sales (
    id INTEGER PRIMARY KEY,
    category TEXT,
    revenue REAL
);

INSERT INTO sales VALUES 
(1, 'Электроника', 12000.0),
(2, 'Электроника', 35000.0),
(3, 'Книги', 1500.0),
(4, 'Книги', 2200.0),
(5, 'Мебель', 45000.0);

-- Выводим категории с суммарной выручкой свыше 10 000
SELECT category, COUNT(*) AS items_sold, SUM(revenue) AS total_revenue
FROM sales 
GROUP BY category 
HAVING SUM(revenue) >= 10000.0 
ORDER BY total_revenue DESC;
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "В чем ключевое отличие предложения HAVING от WHERE?",
                        questionEN: "What is the core distinction between HAVING and WHERE?",
                        optionsRU: ["HAVING фильтрует вычисленные группы после GROUP BY, а WHERE фильтрует строки до группировки", "HAVING работает быстрее WHERE", "В HAVING нельзя использовать агрегатные функции", "WHERE используется только для сортировки"],
                        optionsEN: ["HAVING filters aggregated groups after GROUP BY; WHERE filters rows prior to grouping", "HAVING is faster than WHERE", "HAVING disallows aggregate expressions", "WHERE is exclusively used for sorting"],
                        correctIndex: 0,
                        explanationRU: "WHERE отсекает строки до агрегации, а HAVING фильтрует готовые группы по результатам агрегатных функций.",
                        explanationEN: "WHERE acts on base tuples prior to grouping; HAVING evaluates calculated aggregate values."
                    )
                ]
            ),

            Lesson(
                id: "sql_keys_pk_fk",
                category: .sqlRelationalDesign,
                titleRU: "Первичные и внешние ключи: PK, FK и Целостность",
                titleEN: "Primary & Foreign Keys: Referential Integrity",
                summaryRU: "Реляционная целостность, синтаксис FOREIGN KEY, каскадные действия ON DELETE CASCADE и защита данных.",
                summaryEN: "Referential integrity constraints, FOREIGN KEY declarations, ON DELETE CASCADE options, and orphaned record prevention.",
                contentMarkdownRU: ##"""
### Реляционные связи и целостность данных

В реляционных базах данных целостность ссылок (Referential Integrity) гарантирует, что связь между двумя таблицами всегда остается валидной.

### Первичный ключ (PRIMARY KEY)
Уникальный идентификатор строки в родительской таблице.

### Внешний ключ (FOREIGN KEY)
Поле в дочерней таблице, ссылающееся на первичный ключ родительской таблицы:
```sql
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    amount REAL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

### Каскадные действия (ON DELETE / ON UPDATE)
Определяют поведение СУБД при удалении родительской записи:
1. `CASCADE` — автоматически удаляет все дочерние записи.
2. `RESTRICT` / `NO ACTION` — блокирует удаление родителя, если есть дочерние ссылки (вызывает ошибку).
3. `SET NULL` — заменяет поле внешнего ключа в дочерних записях на `NULL`.
4. `SET DEFAULT` — присваивает значение по умолчанию.
"""##,
                contentMarkdownEN: ##"""
### Referential Integrity: PK & FK
Foreign keys enforce relational relationships between parent and child tables.

### Referential Actions on Delete
- `CASCADE`: Propagates deletion to referencing child rows.
- `RESTRICT`: Rejects deletion if dependent children exist.
- `SET NULL`: Nullifies foreign key fields in referencing rows.
"""##,
                codeSnippet: ##"""
PRAGMA foreign_keys = ON;

CREATE TABLE authors (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE books (
    id INTEGER PRIMARY KEY,
    author_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE
);

INSERT INTO authors VALUES (1, 'Лев Толстой');
INSERT INTO books VALUES (101, 1, 'Война и мир');

-- Удаление автора каскадно удалит и его книги
DELETE FROM authors WHERE id = 1;

SELECT COUNT(*) AS remaining_books FROM books;
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что произойдет при попытке удалить запись из родительской таблицы, если внешний ключ настроен как ON DELETE CASCADE?",
                        questionEN: "What happens when deleting a parent row whose foreign key specifies ON DELETE CASCADE?",
                        optionsRU: ["Все связанные записи в дочерней таблице автоматически удалятся", "СУБД выбросит ошибку нарушения целостности", "Значения в дочерних записях станут равны 0", "Таблица заблокируется навсегда"],
                        optionsEN: ["All dependent rows in the child table are deleted automatically", "The engine raises a constraint violation error", "Child foreign key values become 0", "The table locks permanently"],
                        correctIndex: 0,
                        explanationRU: "CASCADE обеспечивает автоматическое удаление всех зависимых дочерних записей.",
                        explanationEN: "CASCADE automatically deletes all referencing child rows, preserving referential integrity."
                    )
                ]
            ),

            Lesson(
                id: "sql_cardinality_relations",
                category: .sqlRelationalDesign,
                titleRU: "Типы связей: 1:1, 1:N и N:M (Junction Tables)",
                titleEN: "Cardinality Relationships: 1:1, 1:N & M:N",
                summaryRU: "Моделирование отношений между сущностями, промежуточные таблицы (Join/Junction table) и составные первичные ключи.",
                summaryEN: "Modeling domain entities: one-to-one, one-to-many, and many-to-many using junction tables and composite keys.",
                contentMarkdownRU: ##"""
### Кардинальность связей в БД

1. **Один к одному (1:1)**:
   - Профиль пользователя и приватные паспортные данные.
   - Реализуется через внешний ключ с ограничением `UNIQUE`:
     ```sql
     CREATE TABLE user_profiles (
         user_id INTEGER PRIMARY KEY,
         bio TEXT,
         FOREIGN KEY (user_id) REFERENCES users(id)
     );
     ```

2. **Один ко многим (1:N)**:
   - Самый распространенный тип связи: один отдел — много сотрудников, один клиент — много заказов.
   - Внешний ключ помещается на стороне «многие».

3. **Многие ко многим (N:M / M:N)**:
   - Один студент посещает много курсов, один курс посещают много студентов.
   - Невозможно выразить одним внешним ключом напрямую.
   - **Решение**: Промежуточная таблица-связка (Junction / Bridge table) с составным ключом:
     ```sql
     CREATE TABLE student_courses (
         student_id INTEGER,
         course_id INTEGER,
         enrolled_at DATE,
         PRIMARY KEY (student_id, course_id),
         FOREIGN KEY (student_id) REFERENCES students(id),
         FOREIGN KEY (course_id) REFERENCES courses(id)
     );
     ```
"""##,
                contentMarkdownEN: ##"""
### Relational Cardinality
- **1:1**: One entity maps to one entity (enforced via `UNIQUE` foreign key).
- **1:N**: Parent entity references multiple children via a child foreign key.
- **M:N**: Implemented via a junction/bridge table carrying foreign keys to both parent entities and a composite primary key.
"""##,
                codeSnippet: ##"""
CREATE TABLE students (
    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE courses (
    id INTEGER PRIMARY KEY,
    title TEXT
);

CREATE TABLE enrollments (
    student_id INTEGER,
    course_id INTEGER,
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO students VALUES (1, 'Анна'), (2, 'Илья');
INSERT INTO courses VALUES (10, 'Базы Данных'), (20, 'Алгоритмы');

INSERT INTO enrollments VALUES (1, 10), (1, 20), (2, 10);

-- Выборка всех курсов Анны через таблицу связку
SELECT s.name, c.title 
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id
WHERE s.id = 1;
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Как правильно смоделировать связь 'многие ко многим' (M:N) между двумя реляционными таблицами?",
                        questionEN: "How should a many-to-many (M:N) relationship be structured in a relational database?",
                        optionsRU: ["Создать промежуточную таблицу-связку с внешними ключами на обе таблицы", "Хранить список ID через запятую в текстовом поле", "Добавить 50 колонок course_id1, course_id2 в таблицу студента", "Связи M:N не поддерживаются в SQL"],
                        optionsEN: ["Introduce a junction table referencing primary keys of both entities", "Store comma-separated IDs inside a text column", "Add multiple columns like course_id1, course_id2", "M:N relations are not possible in SQL"],
                        correctIndex: 0,
                        explanationRU: "Связь многие ко многим моделируется через третью связующую таблицу (Junction table).",
                        explanationEN: "Junction tables resolve many-to-many associations by breaking them down into two 1:N links."
                    )
                ]
            ),

            Lesson(
                id: "sql_inner_join_deep",
                category: .sqlJoins,
                titleRU: "INNER JOIN: строгое объединение по условию ON",
                titleEN: "INNER JOIN: Strict Condition Matching",
                summaryRU: "Механизм пересечения таблиц, синтаксис предиката ON, фильтрация несоответствующих строк и оптимизация Hash/Merge Join.",
                summaryEN: "Table intersection semantics, ON predicate syntax, unmatched row exclusion, and query engine join algorithms.",
                contentMarkdownRU: ##"""
### Оператор INNER JOIN

`INNER JOIN` возвращает только те строки, для которых условие связывания в предикате `ON` является истинным (`TRUE`) в **обеих** таблицах:

```sql
SELECT 
    orders.id AS order_id,
    clients.company_name,
    orders.amount
FROM orders
INNER JOIN clients ON orders.client_id = clients.id;
```

### Как СУБД выполняет JOIN
Оптимизатор запросов выбирает один из алгоритмов соединения в зависимости от размера данных и наличия индексов:
1. **Nested Loop Join** — для каждой строки левой таблицы сканируется правая (эффективно, если правая таблица имеет индекс по ключу).
2. **Hash Join** — строит хеш-таблицу в памяти по меньшей таблице и выполняет мгновенный лукап для второй.
3. **Merge Join** — если обе таблицы отсортированы по ключу объединения, выполняется параллельное линейное слияние за $O(N + M)$.
"""##,
                contentMarkdownEN: ##"""
### INNER JOIN Mechanics
An `INNER JOIN` produces the relational intersection where the `ON` condition evaluates to `TRUE`. Unmatched rows from either side are excluded.

Under the hood, database query engines leverage Nested Loops, Hash Joins, or Sort-Merge Joins depending on indexes and table volumes.
"""##,
                codeSnippet: ##"""
CREATE TABLE departments (
    id INTEGER PRIMARY KEY,
    dept_name TEXT
);

CREATE TABLE employees (
    id INTEGER PRIMARY KEY,
    name TEXT,
    dept_id INTEGER
);

INSERT INTO departments VALUES (1, 'Инженерия'), (2, 'Маркетинг'), (3, 'HR');
INSERT INTO employees VALUES (101, 'Артем', 1), (102, 'Вера', 1), (103, 'Денис', 2);

SELECT e.name, d.dept_name 
FROM employees e 
INNER JOIN departments d ON e.dept_id = d.id;
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Попадут ли в результат INNER JOIN строки из левой таблицы, для которых нет совпадений в правой?",
                        questionEN: "Will unmatched rows from the left table appear in an INNER JOIN result?",
                        optionsRU: ["Нет, INNER JOIN возвращает только строки с подтвержденным совпадением с обеих сторон", "Да, со значениями NULL в правой части", "Да, если это SQLite", "Да, если указан LIMIT"],
                        optionsEN: ["No, INNER JOIN returns only records having matching keys on both sides", "Yes, with NULLs for missing fields", "Yes, in SQLite", "Yes, if LIMIT is specified"],
                        correctIndex: 0,
                        explanationRU: "INNER JOIN возвращает только строгое пересечение данных, отбрасывая несовпадающие строки.",
                        explanationEN: "INNER JOIN strictly retains matching records from both relations."
                    )
                ]
            ),

            Lesson(
                id: "sql_left_outer_join",
                category: .sqlJoins,
                titleRU: "LEFT OUTER JOIN: сохранение строк и поиск пропусков",
                titleEN: "LEFT JOIN: Preserving Rows & Detecting Gaps",
                summaryRU: "Сохранение всех записей левой таблицы, заполнение NULL для правой стороны, и паттерн поиска сирот через IS NULL.",
                summaryEN: "Preserving all left records, NULL generation for missing right attributes, and anti-join gap detection using IS NULL.",
                contentMarkdownRU: ##"""
### Оператор LEFT JOIN (LEFT OUTER JOIN)

`LEFT JOIN` гарантирует, что **каждая строка из левой таблицы попадет в результат**:
- Если в правой таблице найдено соответствие по `ON`, поля заполняются данными.
- Если совпадений нет, все поля правой таблицы заполняются значением `NULL`.

```sql
SELECT 
    users.id,
    users.username,
    orders.id AS order_id
FROM users
LEFT JOIN orders ON users.id = orders.user_id;
```

### Паттерн Anti-Join: поиск неактивных сущностей
LEFT JOIN в комбинации с проверкой `WHERE right_table.id IS NULL` позволяет мгновенно найти записи, у которых нет дочерних элементов (например, пользователей без заказов):

```sql
SELECT u.username 
FROM users u 
LEFT JOIN orders o ON u.id = o.user_id 
WHERE o.id IS NULL; -- Отбираем только тех, у кого нет заказов!
```
"""##,
                contentMarkdownEN: ##"""
### LEFT OUTER JOIN and Anti-Join Pattern
`LEFT JOIN` preserves every record from the left table regardless of whether matching entries exist on the right. Missing attributes return as `NULL`.

The **Anti-Join** pattern leverages `WHERE right_table.id IS NULL` to efficiently locate parent records without associated children.
"""##,
                codeSnippet: ##"""
CREATE TABLE customers (
    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE purchases (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    item TEXT
);

INSERT INTO customers VALUES (1, 'Алексей'), (2, 'Мария'), (3, 'Олег');
INSERT INTO purchases VALUES (10, 1, 'Ноутбук'), (11, 1, 'Чехол');

-- Находим клиентов, которые еще ничего не купили (Anti-Join)
SELECT c.id, c.name 
FROM customers c 
LEFT JOIN purchases p ON c.id = p.customer_id 
WHERE p.id IS NULL;
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Каким значением заполняются столбцы правой таблицы в LEFT JOIN, если соответствие не найдено?",
                        questionEN: "What value populates right-table columns when no match exists in a LEFT JOIN?",
                        optionsRU: ["NULL", "0 (ноль)", "Пустая строка", "Значение первичного ключа"],
                        optionsEN: ["NULL", "0 (zero)", "Empty string", "Primary key value"],
                        correctIndex: 0,
                        explanationRU: "При отсутствии соответствия в правой таблице все ее атрибуты заполняются значением NULL.",
                        explanationEN: "Unmatched rows from the preserving table have right-side attributes set to NULL."
                    )
                ]
            ),

            Lesson(
                id: "sql_multi_table_joins",
                category: .sqlJoins,
                titleRU: "Каскадные JOIN: объединение 3+ таблиц",
                titleEN: "Multi-Table Joins: Chaining 3+ Tables",
                summaryRU: "Сложные реляционные запросы через цепочки JOIN, порядок связывания, производительность и предотвращение декартова взрыва.",
                summaryEN: "Complex queries chaining multiple joins, join ordering, query plan impact, and avoiding cartesian explosion.",
                contentMarkdownRU: ##"""
### Каскадное связывание нескольких таблиц

В реальных базах данных бизнес-запросы требуют объединения 3, 5 или более таблиц:
```sql
SELECT 
    c.name AS customer_name,
    o.id AS order_id,
    p.title AS product_name,
    oi.quantity,
    oi.price
FROM customers c
INNER JOIN orders o ON c.id = o.customer_id
INNER JOIN order_items oi ON o.id = oi.order_id
INNER JOIN products p ON oi.product_id = p.id
WHERE o.status = 'COMPLETED';
```

### Предотвращение декартова взрыва (Fan-out)
Если объединять таблицу с двумя независимыми дочерними таблицами один-ко-многим одновременно (например, `User` с `UserEmails` и `UserRoles`), количество результирующих строк станет произведением: $N \times M$!
Для таких агрегаций лучше использовать раздельные подзапросы или оконные функции.
"""##,
                contentMarkdownEN: ##"""
### Chaining Multiple Tables
Complex operational queries frequently span 3 or more relations. Maintain clean table aliases (`c`, `o`, `oi`, `p`) to retain clarity.

Avoid joining multiple independent 1:N relations in a single query to prevent exponential row fan-out.
"""##,
                codeSnippet: ##"""
CREATE TABLE brands (id INTEGER PRIMARY KEY, brand_name TEXT);
CREATE TABLE items (id INTEGER PRIMARY KEY, brand_id INTEGER, title TEXT);
CREATE TABLE reviews (id INTEGER PRIMARY KEY, item_id INTEGER, rating INTEGER);

INSERT INTO brands VALUES (1, 'Sony');
INSERT INTO items VALUES (10, 1, 'Наушники WH-1000');
INSERT INTO reviews VALUES (101, 10, 5), (102, 10, 4);

SELECT b.brand_name, i.title, AVG(r.rating) AS avg_stars
FROM brands b
JOIN items i ON b.id = i.brand_id
JOIN reviews r ON i.id = r.item_id
GROUP BY b.brand_name, i.title;
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что может произойти при одновременном связывании таблицы с двумя независимыми дочерними таблицами 1:N?",
                        questionEN: "What issue can occur when joining one table to two independent 1:N child tables simultaneously?",
                        optionsRU: ["Декартово умножение строк (Fan-out) и дублирование данных", "СУБД автоматически удалит дубликаты", "Запрос завершится ошибкой синтаксиса", "Память СУБД уменьшится вдвое"],
                        optionsEN: ["Cartesian fan-out multiplying rows and inflating aggregates", "The database automatically deduplicates rows", "A syntax error will be raised", "Database memory footprint halves"],
                        correctIndex: 0,
                        explanationRU: "Одновременный JOIN независимых списков приводит к перемножению строк и искажению сумм.",
                        explanationEN: "Joining independent 1:N lists multiplies records (N x M), distorting COUNT and SUM aggregates."
                    )
                ]
            ),

            Lesson(
                id: "sql_right_full_outer_join",
                category: .sqlAdvancedJoins,
                titleRU: "RIGHT JOIN и FULL OUTER JOIN: теория и эмуляция",
                titleEN: "RIGHT JOIN & FULL OUTER JOIN: Emulation & Logic",
                summaryRU: "Симметрия RIGHT JOIN, полное объединение FULL JOIN, диаграммы Венна и эмуляция FULL JOIN через UNION в SQLite.",
                summaryEN: "RIGHT JOIN symmetry, FULL OUTER JOIN semantics, Venn diagrams, and emulating FULL JOIN via UNION in SQLite.",
                contentMarkdownRU: ##"""
### RIGHT JOIN и FULL JOIN

- `RIGHT JOIN` — зеркальная копия `LEFT JOIN`: сохраняет все строки из правой таблицы, дополняя несовпадающие поля левой значениями `NULL`. В практике любой `RIGHT JOIN` легко переписывается как `LEFT JOIN` сменой порядка таблиц.
- `FULL OUTER JOIN` — объединяет результаты `LEFT JOIN` и `RIGHT JOIN`: сохраняет строки из обеих таблиц, заполняя пропуски с любой стороны значениями `NULL`.

### Поддержка в SQLite
Диалект SQLite исторически поддерживает `LEFT JOIN`, но не имеет ключевого слова `FULL OUTER JOIN`.

### Эмуляция FULL OUTER JOIN в SQLite
Для реализации полного внешнего соединения используется объединение `LEFT JOIN` с анти-джойном через `UNION ALL`:
```sql
SELECT a.id, a.val, b.val 
FROM table_a a 
LEFT JOIN table_b b ON a.id = b.id
UNION ALL
SELECT a.id, a.val, b.val 
FROM table_b b 
LEFT JOIN table_a a ON b.id = a.id 
WHERE a.id IS NULL;
```
"""##,
                contentMarkdownEN: ##"""
### RIGHT & FULL OUTER JOIN
`RIGHT JOIN` mirrors `LEFT JOIN` by preserving right-hand records.

`FULL OUTER JOIN` retains records from both relations, setting attributes to `NULL` whenever corresponding matches are absent. In SQLite, simulate FULL JOIN via `UNION ALL` combining a LEFT JOIN with an anti-join.
"""##,
                codeSnippet: ##"""
CREATE TABLE team_a (id INTEGER PRIMARY KEY, name TEXT);
CREATE TABLE team_b (id INTEGER PRIMARY KEY, name TEXT);

INSERT INTO team_a VALUES (1, 'Антон'), (2, 'Борис');
INSERT INTO team_b VALUES (2, 'Борис'), (3, 'Виктор');

-- Эмуляция FULL JOIN в SQLite
SELECT a.name AS player_a, b.name AS player_b 
FROM team_a a 
LEFT JOIN team_b b ON a.name = b.name
UNION ALL
SELECT a.name AS player_a, b.name AS player_b 
FROM team_b b 
LEFT JOIN team_a a ON b.name = a.name 
WHERE a.name IS NULL;
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Как в SQLite можно получить результат FULL OUTER JOIN при отсутствии нативного оператора?",
                        questionEN: "How can you achieve FULL OUTER JOIN in SQLite given the absence of native keyword support?",
                        optionsRU: ["Объединить LEFT JOIN и выборку отсутствующих строк через UNION ALL", "Использовать оператор INTERSECT", "FULL JOIN принципиально невозможен", "Использовать только INNER JOIN"],
                        optionsEN: ["Combine LEFT JOIN with missing right rows via UNION ALL", "Use INTERSECT operator", "FULL JOIN is impossible", "Use only INNER JOIN"],
                        correctIndex: 0,
                        explanationRU: "Эмуляция FULL JOIN в SQLite строится через UNION ALL левого соединения и отсекающего анти-соединения.",
                        explanationEN: "Emulating FULL JOIN in SQLite is achieved by combining a LEFT JOIN with an anti-join using UNION ALL."
                    )
                ]
            ),

            Lesson(
                id: "sql_cross_join_cartesian",
                category: .sqlAdvancedJoins,
                titleRU: "Декартово произведение: CROSS JOIN",
                titleEN: "Cartesian Product: CROSS JOIN",
                summaryRU: "Полное перемножение множеств, сценарии применения (матрицы дат, комбинации параметров) и случайные декартовы взрывы.",
                summaryEN: "Cartesian product evaluation, valid use cases (date grids, parameter permutations), and accidental cross joins.",
                contentMarkdownRU: ##"""
### Оператор CROSS JOIN

`CROSS JOIN` выполняет декартово произведение двух отношений: каждая строка первой таблицы соединяется с каждой строкой второй таблицы.

Если в таблице $A$ содержится $M$ строк, а в таблице $B$ содержится $N$ строк, результат `CROSS JOIN` содержит ровно:
$$M \times N \text{ строк}$$

### Когда CROSS JOIN полезен на практике?
1. **Генерация матриц вариантов**: размеры одежды (S, M, L) $\times$ цвета (красный, синий, черный).
2. **Заполнение пропусков во временных рядах**: декартово произведение списка магазинов и календаря дат для выявления дней с нулевыми продажами.
3. **Генерация тестовых данных**.
"""##,
                contentMarkdownEN: ##"""
### CROSS JOIN Semantics
`CROSS JOIN` produces the mathematical Cartesian product where each tuple in relation A merges with every tuple in relation B, yielding $M \times N$ rows.

Valuable for generating permutation matrices and zero-filling temporal data.
"""##,
                codeSnippet: ##"""
CREATE TABLE sizes (size TEXT);
CREATE TABLE colors (color TEXT);

INSERT INTO sizes VALUES ('S'), ('M'), ('L');
INSERT INTO colors VALUES ('Черный'), ('Белый');

-- Генерируем полный ассортиментный каталог (3 x 2 = 6 вариантов)
SELECT s.size, c.color, 'Футболка Basic' AS item
FROM sizes s 
CROSS JOIN colors c;
"""##,
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Сколько строк вернет запрос `SELECT * FROM a CROSS JOIN b;`, если в таблице a 10 строк, а в b — 50?",
                        questionEN: "How many rows does `SELECT * FROM a CROSS JOIN b;` yield if table a has 10 rows and b has 50?",
                        optionsRU: ["500 строк (10 * 50)", "60 строк (10 + 50)", "50 строк", "10 строк"],
                        optionsEN: ["500 rows (10 * 50)", "60 rows (10 + 50)", "50 rows", "10 rows"],
                        correctIndex: 0,
                        explanationRU: "Декартово произведение перемножает количество строк двух таблиц: 10 * 50 = 500.",
                        explanationEN: "The Cartesian product multiplies row counts ($10 \times 50 = 500$)."
                    )
                ]
            ),

            Lesson(
                id: "sql_self_join_hierarchy",
                category: .sqlAdvancedJoins,
                titleRU: "SELF JOIN: объединение таблицы с самой собой",
                titleEN: "SELF JOIN: Hierarchies & Graph Pairs",
                summaryRU: "Соединение сущности с самой собой, древовидные структуры (начальник - подчиненный), обязательность разных алиасов.",
                summaryEN: "Joining a relation against itself, organizational hierarchies (manager-employee), and alias disambiguation.",
                contentMarkdownRU: ##"""
### Оператор SELF JOIN

`SELF JOIN` — это обычное соединение таблицы с самой собой. В SQL нет отдельного ключевого слова `SELF JOIN`, используется `INNER JOIN` или `LEFT JOIN`, где таблица указывается дважды с **разными псевдонимами** (aliases):

```sql
SELECT 
    emp.name AS employee_name,
    mgr.name AS manager_name
FROM employees emp
LEFT JOIN employees mgr ON emp.manager_id = mgr.id;
```

### Сценарии применения
1. **Иерархии**: сотрудники и их руководители, категории товаров и их родительские категории.
2. **Сравнение смежных строк**: сопоставление заказов одного и того же клиента за разные даты.
3. **Поиск дубликатов**: поиск пользователей с одинаковым email, но разными ID.
"""##,
                contentMarkdownEN: ##"""
### SELF JOIN Applications
A `SELF JOIN` queries a single table against itself using distinct table aliases.

Common applications include adjacency list hierarchies (employee-to-manager), entity parent-child categories, and identifying matching duplicate values across differing rows.
"""##,
                codeSnippet: ##"""
CREATE TABLE staff_tree (
    id INTEGER PRIMARY KEY,
    name TEXT,
    manager_id INTEGER
);

INSERT INTO staff_tree VALUES 
(1, 'Генеральный директор', NULL),
(2, 'Техлид', 1),
(3, 'Разработчик', 2);

-- Отображаем сотрудника и его непосредственного руководителя
SELECT 
    e.name AS employee, 
    COALESCE(m.name, 'Верховный руководитель') AS reports_to
FROM staff_tree e 
LEFT JOIN staff_tree m ON e.manager_id = m.id;
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что является обязательным требованием при выполнении SELF JOIN в SQL?",
                        questionEN: "What is an indispensable requirement when executing a SELF JOIN in SQL?",
                        optionsRU: ["Использование разных псевдонимов (aliases) для каждой копии таблицы", "Таблица должна содержать более 1000 строк", "Обязательное использование оператора WHERE вместо ON", "Колонки должны иметь тип FLOAT"],
                        optionsEN: ["Assigning distinct table aliases to each table reference", "The table must exceed 1000 records", "Mandatory use of WHERE instead of ON", "Columns must be FLOAT types"],
                        correctIndex: 0,
                        explanationRU: "Чтобы СУБД знала, к какому экземпляру таблицы относится колонка, требуются уникальные алиасы.",
                        explanationEN: "Explicit unique aliases are mandatory to disambiguate column references across both instances."
                    )
                ]
            ),

            Lesson(
                id: "sql_scalar_subqueries",
                category: .sqlSubqueries,
                titleRU: "Скалярные подзапросы в SELECT и WHERE",
                titleEN: "Scalar Subqueries in SELECT & WHERE",
                summaryRU: "Подзапросы, возвращающие строго одно значение, вычисление отклонений от среднего и правила валидности.",
                summaryEN: "Single-value scalar subqueries, calculating deviations from global averages, and cardinality rules.",
                contentMarkdownRU: ##"""
### Скалярные подзапросы (Scalar Subqueries)

Скалярный подзапрос — это вложенный запрос `(SELECT ...)`, который возвращает **строго одно значение** (одну строку и одну колонку):

### Использование в блоке WHERE
Например, выбор всех сотрудников с зарплатой выше средней по компании:
```sql
SELECT name, salary 
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);
```

### Использование в блоке SELECT
Скалярный подзапрос можно использовать как виртуальную колонку:
```sql
SELECT 
    name,
    salary,
    (SELECT MAX(salary) FROM employees) - salary AS salary_gap
FROM employees;
```

> [!CAUTION]
> Если скалярный подзапрос возвращает более одной строки, СУБД прерывает выполнение с ошибкой: `subquery must return only one column, at most one row`.
"""##,
                contentMarkdownEN: ##"""
### Scalar Subqueries
A scalar subquery evaluates to an exact single-row, single-column value.

Commonly placed within `WHERE` comparison expressions or directly in `SELECT` lists. If a scalar subquery yields multiple rows, execution aborts with a runtime error.
"""##,
                codeSnippet: ##"""
CREATE TABLE products_catalog (
    id INTEGER PRIMARY KEY,
    title TEXT,
    price REAL
);

INSERT INTO products_catalog VALUES 
(1, 'Базовый курс', 2000.0),
(2, 'Продвинутый курс', 5000.0),
(3, 'Архитектурный буткемп', 12000.0);

-- Выбираем курсы, цена которых выше средней стоимости
SELECT title, price 
FROM products_catalog 
WHERE price > (SELECT AVG(price) FROM products_catalog);
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что произойдет, если скалярный подзапрос в блоке WHERE `WHERE price > (SELECT ...)` вернет 3 строки?",
                        questionEN: "What happens if a scalar subquery in `WHERE price > (SELECT ...)` yields 3 rows?",
                        optionsRU: ["СУБД выбросит ошибку времени выполнения", "База автоматически возьмет среднее из трех чисел", "Будет использована первая строка", "Запрос вернет все строки"],
                        optionsEN: ["The database engine aborts with a runtime error", "The engine automatically averages all 3 values", "The first value is used silently", "All rows are returned"],
                        correctIndex: 0,
                        explanationRU: "Оператор сравнения ожидает ровно одно скалярное значение; множественный возврат вызывает ошибку.",
                        explanationEN: "Scalar comparison operators strictly require single values; multi-row returns cause runtime failures."
                    )
                ]
            ),

            Lesson(
                id: "sql_correlated_subqueries",
                category: .sqlSubqueries,
                titleRU: "Коррелированные подзапросы (Correlated Subqueries)",
                titleEN: "Correlated Subqueries & Outer Scope",
                summaryRU: "Вложенные запросы с зависимостью от внешней строки, сложность O(N * M) и оптимизация через JOIN.",
                summaryEN: "Subqueries bound to outer table row contexts, O(N * M) performance costs, and rewrite optimizations via JOIN.",
                contentMarkdownRU: ##"""
### Коррелированный подзапрос

В отличие от автономного подзапроса, коррелированный подзапрос **ссылается на колонку из внешней таблицы**:
```sql
-- Выбор сотрудников с зарплатой выше средней В ИХ ОТДЕЛЕ
SELECT e.name, e.department_id, e.salary 
FROM employees e 
WHERE e.salary > (
    SELECT AVG(sub.salary) 
    FROM employees sub 
    WHERE sub.department_id = e.department_id -- ссылка на e.department_id!
);
```

### Алгоритмическая сложность
Автономный подзапрос вычисляется один раз. Коррелированный подзапрос вычисляется **для каждой строки** внешнего запроса ($O(N \times M)$). На больших таблицах это может вызывать серьезные замедления.

Для ускорения коррелированные подзапросы часто переписывают на `JOIN` с предварительно агрегированным подзапросом или оконную функцию `AVG() OVER (PARTITION BY ...)`.
"""##,
                contentMarkdownEN: ##"""
### Correlated Subquery Mechanics
Correlated subqueries depend upon values from the outer query context, re-evaluating for every candidate row ($O(N \times M)$ complexity).

Modern SQL practices often replace correlated subqueries with window functions or derived table joins to reduce latency.
"""##,
                codeSnippet: ##"""
CREATE TABLE department_staff (
    id INTEGER PRIMARY KEY,
    name TEXT,
    dept TEXT,
    salary REAL
);

INSERT INTO department_staff VALUES 
(1, 'Анна', 'IT', 120000.0),
(2, 'Борис', 'IT', 95000.0),
(3, 'Вера', 'HR', 60000.0),
(4, 'Глеб', 'HR', 75000.0);

-- Находим самого высокооплачиваемого сотрудника в каждом отделе
SELECT name, dept, salary 
FROM department_staff e 
WHERE salary = (
    SELECT MAX(salary) 
    FROM department_staff sub 
    WHERE sub.dept = e.dept
);
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Сколько раз вычисляется коррелированный подзапрос в худшем случае без оптимизации?",
                        questionEN: "How many times is an unoptimized correlated subquery evaluated in the worst case?",
                        optionsRU: ["Для каждой строки внешнего запроса", "Ровно один раз в начале запроса", "Два раза", "Зависит от количества колонок"],
                        optionsEN: ["Once for every candidate row in the outer query", "Exactly once at query startup", "Twice", "Depends on column count"],
                        correctIndex: 0,
                        explanationRU: "Коррелированный подзапрос параметризуется полями текущей внешней строки и вычисляется для каждой строки.",
                        explanationEN: "Because it references the outer row's parameters, it executes once per candidate outer tuple."
                    )
                ]
            ),

            Lesson(
                id: "sql_exists_not_exists",
                category: .sqlSubqueries,
                titleRU: "Проверка существования: EXISTS и NOT EXISTS",
                titleEN: "Existence Checks: EXISTS & NOT EXISTS",
                summaryRU: "Предикаты EXISTS, механизм раннего выхода (Short-circuit), безопасность при работе с NULL в отличие от IN.",
                summaryEN: "EXISTS predicates, short-circuit execution semantics, and NULL-safety advantages over NOT IN.",
                contentMarkdownRU: ##"""
### Операторы EXISTS и NOT EXISTS

Оператор `EXISTS` проверяет, возвращает ли подзапрос **хотя бы одну строку**:
- Если найдена хотя бы 1 строка $\rightarrow$ возвращает `TRUE`.
- Если подзапрос вернул 0 строк $\rightarrow$ возвращает `FALSE`.

```sql
SELECT c.name FROM clients c 
WHERE EXISTS (
    SELECT 1 FROM orders o 
    WHERE o.client_id = c.id AND o.amount > 50000
);
```

### Преимущество производительности: Short-Circuit
СУБД останавливает выполнение подзапроса `EXISTS` сразу же, как только найдена первая подходящая запись. Поэтому внутри `SELECT` пишут `SELECT 1` (конкретные колонки не имеют значения).

### Безопасность NOT EXISTS против NOT IN
`NOT IN` вернет пустой результат, если в подзапросе встретится хотя бы один `NULL`. `NOT EXISTS` устойчив к `NULL` и всегда работает корректно!
"""##,
                contentMarkdownEN: ##"""
### EXISTS and NOT EXISTS
`EXISTS` evaluates whether a subquery returns one or more rows, short-circuiting immediately upon locating the first match.

Always prefer `NOT EXISTS` over `NOT IN` when subqueries might contain `NULL` values, preventing three-valued logic anomalies.
"""##,
                codeSnippet: ##"""
CREATE TABLE authors_list (id INTEGER PRIMARY KEY, name TEXT);
CREATE TABLE published_books (id INTEGER PRIMARY KEY, author_id INTEGER, title TEXT);

INSERT INTO authors_list VALUES (1, 'Толстой'), (2, 'Чехов'), (3, 'Неизвестный');
INSERT INTO published_books VALUES (10, 1, 'Анна Каренина'), (20, 2, 'Вишневый сад');

-- Находим авторов, у которых ЕСТЬ опубликованные книги
SELECT name FROM authors_list a 
WHERE EXISTS (
    SELECT 1 FROM published_books b WHERE b.author_id = a.id
);
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "В чем преимущество производительности оператора EXISTS при проверке наличия данных?",
                        questionEN: "What is the performance advantage of EXISTS when checking for record presence?",
                        optionsRU: ["СУБД делает ранний выход (Short-circuit) при обнаружении первой подходящей строки", "EXISTS переносит всю таблицу в оперативную память", "EXISTS создает временные индексы", "EXISTS отключает блокировки таблиц"],
                        optionsEN: ["The engine short-circuits evaluation as soon as the first matching row is found", "Loads the whole table into RAM", "Builds temporary indexes", "Disables all table locks"],
                        correctIndex: 0,
                        explanationRU: "EXISTS прекращает сканирование сразу же при обнаружении первой совпавшей строки.",
                        explanationEN: "EXISTS halts subquery scanning immediately upon encountering the first qualifying tuple."
                    )
                ]
            ),

            Lesson(
                id: "sql_union_union_all",
                category: .sqlSetOperations,
                titleRU: "Объединение множеств: UNION и UNION ALL",
                titleEN: "Set Union: UNION vs UNION ALL",
                summaryRU: "Конкатенация выборок, затраты на дедупликацию в UNION, совместимость типов колонок и правила производительности.",
                summaryEN: "Combining query result sets, deduplication overhead in UNION, column schema matching, and performance rules.",
                contentMarkdownRU: ##"""
### Операторы UNION и UNION ALL

Операторы `UNION` и `UNION ALL` объединяют результаты двух или более независимых запросов `SELECT` в единый вертикальный набор строк:

```sql
SELECT name, email FROM active_users
UNION ALL
SELECT name, email FROM archived_users;
```

### Ключевое отличие: Дедупликация
- `UNION` — удаляет дублирующиеся строки из итоговой выборки. Для этого СУБД выполняет **тяжелую сортировку или хеширование** всего объема данных.
- `UNION ALL` — сохраняет все строки в исходном виде без проверки на дубликаты. Работает на порядки быстрее.

> [!TIP]
> Всегда используйте `UNION ALL` по умолчанию, за исключением случаев, когда удаление дубликатов является строгим бизнес-требованием.

### Требования к запросам
1. Одинаковое количество столбцов в каждом `SELECT`.
2. Совместимые типы данных соответствующих колонок.
3. Имена результирующих колонок берутся из **первого** запроса `SELECT`.
"""##,
                contentMarkdownEN: ##"""
### Combining Results: UNION vs UNION ALL
- `UNION`: Merges sets and performs explicit deduplication (incurring memory sort/hash overhead).
- `UNION ALL`: Performs simple row concatenation without deduplication, delivering optimal performance.

Projected queries must feature identical column counts and compatible data types.
"""##,
                codeSnippet: ##"""
CREATE TABLE retail_clients (id INTEGER, email TEXT);
CREATE TABLE online_clients (id INTEGER, email TEXT);

INSERT INTO retail_clients VALUES (1, 'ivan@mail.ru'), (2, 'olga@yandex.ru');
INSERT INTO online_clients VALUES (3, 'ivan@mail.ru'), (4, 'anna@gmail.com');

-- UNION удаляет дубликат ivan@mail.ru
SELECT email FROM retail_clients
UNION
SELECT email FROM online_clients;
"""##,
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Почему в промышленном SQL рекомендуется предпочитать UNION ALL вместо UNION?",
                        questionEN: "Why is UNION ALL favored over UNION in production SQL?",
                        optionsRU: ["UNION ALL не тратит ресурсы на сортировку и удаление дубликатов, работая быстрее", "UNION не поддерживается стандартом SQL", "UNION ALL позволяет соединять разные базы данных", "UNION всегда вызывает ошибку при NULL"],
                        optionsEN: ["UNION ALL avoids costly sorting and deduplication, executing significantly faster", "UNION is non-standard", "UNION ALL connects different databases", "UNION crashes on NULL values"],
                        correctIndex: 0,
                        explanationRU: "UNION требует полной сортировки или построения хеш-таблицы для дедупликации, а UNION ALL просто склеивает потоки данных.",
                        explanationEN: "UNION incurs expensive memory sorts or hash aggregation to eliminate duplicates."
                    )
                ]
            ),

            Lesson(
                id: "sql_intersect_except",
                category: .sqlSetOperations,
                titleRU: "Пересечение и разность: INTERSECT и EXCEPT",
                titleEN: "Set Theory: INTERSECT & EXCEPT",
                summaryRU: "Реализация пересечения множеств INTERSECT, разность множеств EXCEPT (MINUS) и сравнение списков данных.",
                summaryEN: "Set intersection with INTERSECT, set difference via EXCEPT (MINUS), and dataset reconciliation.",
                contentMarkdownRU: ##"""
### Операции теории множеств: INTERSECT и EXCEPT

Стандарт SQL предоставляет операторы для точного моделирования операций теории множеств над таблицами:

### INTERSECT (Пересечение)
Возвращает только те строки, которые присутствуют **и в первом, и во втором** наборе данных:
```sql
-- Клиенты, которые совершали покупки И в 2025, И в 2026 году
SELECT customer_id FROM sales_2025
INTERSECT
SELECT customer_id FROM sales_2026;
```

### EXCEPT / MINUS (Разность)
Возвращает строки из первого набора данных, которых **нет во втором**:
```sql
-- Студенты, записавшиеся на лекции, но не пришедшие на экзамен
SELECT student_id FROM enrolled_students
EXCEPT
SELECT student_id FROM exam_attendees;
```
В некоторых СУБД (например, Oracle) оператор `EXCEPT` называется `MINUS`.
"""##,
                contentMarkdownEN: ##"""
### Relational Set Operations: INTERSECT & EXCEPT
- `INTERSECT`: Yields distinct rows present in *both* query result sets.
- `EXCEPT` (or `MINUS` in Oracle): Returns records from the first result set that do not appear in the second.
"""##,
                codeSnippet: ##"""
CREATE TABLE skills_required (skill TEXT);
CREATE TABLE candidate_skills (skill TEXT);

INSERT INTO skills_required VALUES ('SQL'), ('Swift'), ('Algorithms'), ('Git');
INSERT INTO candidate_skills VALUES ('SQL'), ('Swift'), ('Python');

-- Навыки, которых кандидату не хватает для вакансии
SELECT skill FROM skills_required
EXCEPT
SELECT skill FROM candidate_skills;
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что вернет запрос с оператором EXCEPT (A EXCEPT B)?",
                        questionEN: "What does a query with EXCEPT (A EXCEPT B) return?",
                        optionsRU: ["Строки из набора A, которых нет в наборе B", "Строки, которые есть в обоих наборах", "Все строки из обоих наборов", "Строки из набора B, которых нет в A"],
                        optionsEN: ["Rows from set A that do not exist in set B", "Rows present in both sets", "All combined rows from both sets", "Rows from set B absent from A"],
                        correctIndex: 0,
                        explanationRU: "Оператор EXCEPT вычитает строки второго множества из первого.",
                        explanationEN: "EXCEPT computes set difference, filtering out any tuples of A that match items in B."
                    )
                ]
            ),

            Lesson(
                id: "sql_cte_with",
                category: .sqlCTE,
                titleRU: "Обобщенные таблицы: CTE и предложение WITH",
                titleEN: "Common Table Expressions: CTE & WITH",
                summaryRU: "Устранение лестниц вложенных подзапросов, временные именованные наборы данных и улучшение читаемости кода.",
                summaryEN: "Flattening nested subquery pyramids, named temporary result sets, and query maintainability.",
                contentMarkdownRU: ##"""
### Обобщенные табличные выражения (CTE)

CTE (Common Table Expression) — это временный именованный результирующий набор, существующий только во время выполнения одного SQL-запроса:

```sql
WITH HighEarners AS (
    SELECT id, name, department_id, salary 
    FROM employees 
    WHERE salary > 100000
)
SELECT department_id, COUNT(*) 
FROM HighEarners 
GROUP BY department_id;
```

### Преимущества CTE перед подзапросами
1. **Читаемость (Readability)**: код выполняется сверху вниз, а не «изнутри наружу».
2. **Переиспользуемость (DRY)**: к одному CTE можно обращаться несколько раз в основном запросе (например, в JOIN и WHERE).
3. **Оптимизация**: многие современные СУБД (PostgreSQL 12+, SQLite 3.35+) умеют оптимизировать и встраивать CTE инлайн (inlining).
"""##,
                contentMarkdownEN: ##"""
### Common Table Expressions (CTE)
Defined using `WITH`, CTEs provide named temporary result sets bound to a single query execution scope.

They eliminate nested subquery anti-patterns, rendering complex analytical pipelines human-readable and modular.
"""##,
                codeSnippet: ##"""
CREATE TABLE staff_salaries (
    id INTEGER PRIMARY KEY,
    name TEXT,
    salary REAL
);

INSERT INTO staff_salaries VALUES 
(1, 'Кирилл', 80000.0),
(2, 'Дарья', 150000.0),
(3, 'Роман', 60000.0);

WITH SalaryStats AS (
    SELECT AVG(salary) AS avg_sal FROM staff_salaries
)
SELECT 
    s.name, 
    s.salary, 
    ROUND(s.salary - st.avg_sal, 2) AS diff_from_mean
FROM staff_salaries s
CROSS JOIN SalaryStats st;
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Каким ключевым словом объявляется обобщенное табличное выражение (CTE)?",
                        questionEN: "Which keyword introduces a Common Table Expression (CTE)?",
                        optionsRU: ["WITH", "CTE", "AS", "TEMPORARY"],
                        optionsEN: ["WITH", "CTE", "AS", "TEMPORARY"],
                        correctIndex: 0,
                        explanationRU: "CTE объявляются в начале запроса с помощью предложения WITH.",
                        explanationEN: "Common Table Expressions are declared via the WITH clause."
                    )
                ]
            ),

            Lesson(
                id: "sql_multiple_ctes",
                category: .sqlCTE,
                titleRU: "Цепочки CTE и декомпозиция аналитики",
                titleEN: "Chaining Multiple CTEs: Analytic Pipelines",
                summaryRU: "Связывание нескольких CTE через запятую, построение поэтапных конвейеров трансформации данных.",
                summaryEN: "Chaining sequential CTEs with commas, staged data transformation pipelines, and debugging intermediate steps.",
                contentMarkdownRU: ##"""
### Построение конвейеров из нескольких CTE

Предложение `WITH` позволяет объявлять **несколько CTE подряд через запятую**. Каждое последующее CTE может ссылаться на любые ранее объявленные:

```sql
WITH 
-- Шаг 1: Очистка и фильтрация заказов
ValidOrders AS (
    SELECT user_id, amount 
    FROM orders 
    WHERE status = 'PAID' AND amount > 0
),
-- Шаг 2: Агрегация по пользователям
UserMetrics AS (
    SELECT user_id, SUM(amount) AS total_spend, COUNT(*) AS orders_count
    FROM ValidOrders 
    GROUP BY user_id
)
-- Шаг 3: Финальный отчет с обогащением
SELECT u.name, m.total_spend, m.orders_count 
FROM users u 
INNER JOIN UserMetrics m ON u.id = m.user_id 
WHERE m.total_spend >= 50000;
```

Такая структура превращает многостраничный аналитический запрос в элегантную последовательность понятных шагов.
"""##,
                contentMarkdownEN: ##"""
### Chaining Multiple CTEs
Chain multiple CTEs separated by commas under a single `WITH` keyword. Subsequent CTEs can freely query previous CTEs, mirroring Unix pipelines.
"""##,
                codeSnippet: ##"""
CREATE TABLE raw_logs (user_id INTEGER, action TEXT, ts DATE);
INSERT INTO raw_logs VALUES 
(1, 'view', '2026-03-01'), (1, 'click', '2026-03-01'), (1, 'buy', '2026-03-01'),
(2, 'view', '2026-03-01');

WITH 
Views AS (
    SELECT user_id, COUNT(*) AS views FROM raw_logs WHERE action = 'view' GROUP BY user_id
),
Buys AS (
    SELECT user_id, COUNT(*) AS purchases FROM raw_logs WHERE action = 'buy' GROUP BY user_id
)
SELECT v.user_id, v.views, COALESCE(b.purchases, 0) AS purchases
FROM Views v 
LEFT JOIN Buys b ON v.user_id = b.user_id;
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Нужно ли повторять слово WITH при объявлении второго CTE в цепочке?",
                        questionEN: "Must you repeat the WITH keyword when declaring a second CTE in a chain?",
                        optionsRU: ["Нет, CTE перечисляются через запятую под одним словом WITH", "Да, каждое CTE требует отдельного слова WITH", "Да, если второе CTE использует JOIN", "Да, в SQLite"],
                        optionsEN: ["No, multiple CTEs are separated by commas under one WITH clause", "Yes, every CTE requires its own WITH", "Yes, when using JOINs", "Yes, in SQLite"],
                        correctIndex: 0,
                        explanationRU: "Слово WITH пишется один раз, а последующие блоки разделяются запятыми.",
                        explanationEN: "A single WITH keyword precedes comma-separated CTE definitions."
                    )
                ]
            ),

            Lesson(
                id: "sql_recursive_cte",
                category: .sqlCTE,
                titleRU: "Рекурсивные CTE: иерархии, деревья и графы",
                titleEN: "Recursive CTE: Hierarchies, Trees & Sequences",
                summaryRU: "Синтаксис RECURSIVE, якорная часть (Anchor), рекурсивная часть, условие остановки и генерация рядов чисел.",
                summaryEN: "RECURSIVE syntax, anchor member, recursive term, termination conditions, and number/date generation.",
                contentMarkdownRU: ##"""
### Рекурсивные запросы (WITH RECURSIVE)

Рекурсивный CTE позволяет обходить древовидные структуры (дерево категорий, организация компании, графы маршрутов) произвольной глубины.

### Структура рекурсивного CTE
1. **Якорный запрос (Anchor member)** — базовый запрос, задающий начальное состояние (корень дерева).
2. **Оператор `UNION ALL`** — склеивает уровни рекурсии.
3. **Рекурсивный запрос (Recursive member)** — ссылается на само CTE и соединяется со следующими узлами дерева.
4. **Условие остановки** — возвращает пустой набор, когда достигнуты листья дерева.

```sql
-- Генерация последовательности чисел от 1 до 5
WITH RECURSIVE Numbers AS (
    SELECT 1 AS n              -- Якорь
    UNION ALL 
    SELECT n + 1 FROM Numbers  -- Рекурсия
    WHERE n < 5                -- Условие остановки
)
SELECT * FROM Numbers;
```
"""##,
                contentMarkdownEN: ##"""
### Recursive CTEs
Recursive CTEs traverse hierarchical graphs and generate sequences.

They consist of an **anchor member** defining starting nodes, `UNION ALL`, and a **recursive member** querying the CTE itself until an exit condition evaluates to empty.
"""##,
                codeSnippet: ##"""
-- Обход организационной иерархии сверху вниз
CREATE TABLE org_units (id INTEGER PRIMARY KEY, name TEXT, parent_id INTEGER);
INSERT INTO org_units VALUES 
(1, 'Штаб-квартира', NULL),
(2, 'Филиал Север', 1),
(3, 'Офис Архангельск', 2);

WITH RECURSIVE Tree AS (
    SELECT id, name, 0 AS depth 
    FROM org_units WHERE parent_id IS NULL
    UNION ALL
    SELECT c.id, c.name, t.depth + 1
    FROM org_units c
    JOIN Tree t ON c.parent_id = t.id
)
SELECT depth, name FROM Tree ORDER BY depth;
"""##,
                xpReward: 55,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что произойдет, если в рекурсивной части CTE забыть указать условие остановки WHERE?",
                        questionEN: "What happens if a recursive CTE omits a termination condition in its WHERE clause?",
                        optionsRU: ["Запрос уйдет в бесконечный цикл до превышения лимита глубины рекурсии", "СУБД выдаст ошибку синтаксиса при компиляции", "Запрос вернет ровно 1 строку", "Ничего, база сама догадается остановиться"],
                        optionsEN: ["Execution enters an infinite loop until the max recursion limit is exceeded", "The compiler raises a syntax error", "Returns exactly 1 row", "The engine automatically stops"],
                        correctIndex: 0,
                        explanationRU: "Без условия остановки рекурсия выполняется бесконечно, пока не сработает системный лимит глубины.",
                        explanationEN: "Missing termination predicates result in infinite recursion until hitting safety bounds."
                    )
                ]
            ),

            Lesson(
                id: "sql_window_intro_over",
                category: .sqlWindow,
                titleRU: "Оконные функции: предложение OVER и PARTITION BY",
                titleEN: "Window Functions: OVER & PARTITION BY",
                summaryRU: "Отличие оконных функций от GROUP BY: сохранение детальных строк, секционирование данных и накопительные суммы.",
                summaryEN: "Window functions vs GROUP BY: preserving individual row identity, partitioning, and cumulative aggregates.",
                contentMarkdownRU: ##"""
### Оконные функции против GROUP BY

Главное ограничение `GROUP BY` — он «схлопывает» исходные строки.
**Оконная функция вычисляет агрегат по набору строк, но СОХРАНЯЕТ каждую отдельную строку в результате!**

### Предложение OVER()
Специфицирует «окно» строк, видимое текущей строке:
```sql
SELECT 
    name, 
    department, 
    salary,
    -- Средняя зарплата по всей компании (общее окно)
    AVG(salary) OVER () AS company_avg,
    -- Средняя зарплата внутри своего отдела (секция)
    AVG(salary) OVER (PARTITION BY department) AS dept_avg
FROM employees;
```

### Секционирование (PARTITION BY)
`PARTITION BY` разделяет набор данных на независимые группы. Оконная функция вычисляется изолированно для каждой группы, не затрагивая другие.
"""##,
                contentMarkdownEN: ##"""
### Window Functions: OVER & PARTITION BY
Unlike `GROUP BY` which collapses rows into buckets, window functions calculate aggregates while preserving each individual row's identity.

`OVER (PARTITION BY col)` isolates computation across logical slices.
"""##,
                codeSnippet: ##"""
CREATE TABLE team_payroll (
    id INTEGER PRIMARY KEY,
    employee TEXT,
    team TEXT,
    salary REAL
);

INSERT INTO team_payroll VALUES 
(1, 'Максим', 'iOS', 140000.0),
(2, 'София', 'iOS', 160000.0),
(3, 'Егор', 'Android', 130000.0);

SELECT 
    employee, team, salary,
    ROUND(AVG(salary) OVER (PARTITION BY team), 2) AS team_average,
    ROUND(salary - AVG(salary) OVER (PARTITION BY team), 2) AS diff_from_team_avg
FROM team_payroll;
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "В чем главное отличие оконной функции от обычной группировки GROUP BY?",
                        questionEN: "What is the key difference between a window function and GROUP BY?",
                        optionsRU: ["Оконная функция сохраняет все исходные строки, а GROUP BY схлопывает их", "Оконные функции работают только с датами", "GROUP BY не поддерживает агрегаты SUM и AVG", "Оконные функции можно вызывать только в WHERE"],
                        optionsEN: ["Window functions preserve all base tuples, whereas GROUP BY collapses rows", "Window functions only work on dates", "GROUP BY disallows SUM and AVG", "Window functions are restricted to WHERE"],
                        correctIndex: 0,
                        explanationRU: "Оконные функции вычисляют агрегаты, возвращая для каждой строки таблицы ее индивидуальный результат.",
                        explanationEN: "Window functions calculate aggregated metrics alongside individual tuple data."
                    )
                ]
            ),

            Lesson(
                id: "sql_ranking_functions",
                category: .sqlWindow,
                titleRU: "Функции ранжирования: ROW_NUMBER, RANK, DENSE_RANK",
                titleEN: "Ranking Functions: ROW_NUMBER, RANK & DENSE_RANK",
                summaryRU: "Детальное сравнение алгоритмов нумерации, обработка коллизий (равных значений), пропуски номеров и Top-N запросы.",
                summaryEN: "Comprehensive comparison of ranking algorithms, tie-breaker handling, rank gaps, and Top-N query patterns.",
                contentMarkdownRU: ##"""
### Функции ранжирования

Когда в `OVER` указывается `ORDER BY`, СУБД упорядочивает строки внутри окна и позволяет присвоить им ранги:

1. **`ROW_NUMBER()`**:
   - Присваивает строго уникальный порядковый номер строкам (1, 2, 3, 4...).
   - Если значения равны, порядок недетерминирован (без доп. полей).

2. **`RANK()`**:
   - Присваивает одинаковый ранг одинаковым значениям, но **делает пропуски**:
   - Пример очков: `[100, 90, 90, 80]` $\rightarrow$ ранги: `1, 2, 2, 4` (номер 3 пропущен!).

3. **`DENSE_RANK()`**:
   - Присваивает одинаковый ранг одинаковым значениям **без пропусков**:
   - Пример очков: `[100, 90, 90, 80]` $\rightarrow$ ранги: `1, 2, 2, 3`.

### Паттерн Top-N в каждой категории
```sql
WITH RankedSales AS (
    SELECT 
        product, category, sales_volume,
        DENSE_RANK() OVER (PARTITION BY category ORDER BY sales_volume DESC) AS rnk
    FROM catalog
)
SELECT * FROM RankedSales WHERE rnk <= 3; -- Топ 3 товара в каждой категории!
```
"""##,
                contentMarkdownEN: ##"""
### Ranking Functions
- `ROW_NUMBER()`: Unique sequential integer per row (1, 2, 3, 4).
- `RANK()`: Identical ranks for equal values, introducing gaps (1, 2, 2, 4).
- `DENSE_RANK()`: Identical ranks without numeric gaps (1, 2, 2, 3).
"""##,
                codeSnippet: ##"""
CREATE TABLE runner_times (
    id INTEGER PRIMARY KEY,
    athlete TEXT,
    seconds REAL
);

INSERT INTO runner_times VALUES 
(1, 'Смирнов', 10.1),
(2, 'Кузнецов', 10.3),
(3, 'Попов', 10.3),
(4, 'Васильев', 10.8);

SELECT 
    athlete, seconds,
    ROW_NUMBER() OVER (ORDER BY seconds ASC) AS row_num,
    RANK() OVER (ORDER BY seconds ASC) AS rnk,
    DENSE_RANK() OVER (ORDER BY seconds ASC) AS dense_rnk
FROM runner_times;
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какие ранги присвоит функция DENSE_RANK() элементам со значениями [50, 40, 40, 30] при ORDER BY DESC?",
                        questionEN: "Which ranks does DENSE_RANK() assign to values [50, 40, 40, 30] ordered DESC?",
                        optionsRU: ["1, 2, 2, 3", "1, 2, 2, 4", "1, 2, 3, 4", "1, 1, 2, 3"],
                        optionsEN: ["1, 2, 2, 3", "1, 2, 2, 4", "1, 2, 3, 4", "1, 1, 2, 3"],
                        correctIndex: 0,
                        explanationRU: "DENSE_RANK присваивает дубликатам одинаковый номер, но не пропускает последующий номер 3.",
                        explanationEN: "DENSE_RANK assigns duplicate values identical ranks without skipping following numbers."
                    )
                ]
            ),

            Lesson(
                id: "sql_ntile_distribution",
                category: .sqlWindow,
                titleRU: "Квантили и перцентили: NTILE()",
                titleEN: "Quantiles & Buckets: NTILE()",
                summaryRU: "Разбиение выборки на N равных корзин, расчет квартилей и децилей, скоринг клиентов (RFM анализ).",
                summaryEN: "Partitioning records into N equal buckets, quartile/decile analysis, and customer RFM scoring models.",
                contentMarkdownRU: ##"""
### Функция NTILE(n)

Функция `NTILE(n)` делит упорядоченный набор строк на $n$ максимально равных по размеру групп (корзин) и возвращает номер корзины (от $1$ до $n$) для каждой строки:

- `NTILE(4)` — квартили (топ 25%, следующие 25% и т.д.).
- `NTILE(10)` — децили (топ 10%).
- `NTILE(100)` — перцентили.

### Сценарий: RFM-сегментация клиентов
```sql
SELECT 
    client_id,
    monetary_value,
    NTILE(4) OVER (ORDER BY monetary_value DESC) AS revenue_tier
FROM customer_spending;
```
Клиенты с `revenue_tier = 1` представляют топ-25% самых ценных покупателей бизнеса.
"""##,
                contentMarkdownEN: ##"""
### NTILE(n) Bucket Segmentation
`NTILE(n)` distributes ordered rows across $n$ equal-sized buckets, returning the bucket index (1 to $n$).

Essential for quartile analysis and percentile segmentation in business intelligence.
"""##,
                codeSnippet: ##"""
CREATE TABLE exam_scores (
    student_id INTEGER PRIMARY KEY,
    name TEXT,
    points INTEGER
);

INSERT INTO exam_scores VALUES 
(1, 'Алина', 98), (2, 'Борис', 85),
(3, 'Вадим', 74), (4, 'Галина', 62);

-- Разбиваем студентов на 2 группы (NTILE 2): отличники и отстающие
SELECT name, points,
       NTILE(2) OVER (ORDER BY points DESC) AS tier_group
FROM exam_scores;
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что возвращает функция NTILE(4)?",
                        questionEN: "What does NTILE(4) compute?",
                        optionsRU: ["Номер квартиля (от 1 до 4) для каждой строки выборки", "Количество строк, деленное на 4", "Остаток от деления ID на 4", "Сумму первых 4 колонок"],
                        optionsEN: ["The quartile bucket index (1 to 4) for each row", "Total rows divided by 4", "Modulo 4 of the primary key", "Sum of first 4 columns"],
                        correctIndex: 0,
                        explanationRU: "NTILE(4) делит отсортированный набор строк на 4 равные группы (квартили).",
                        explanationEN: "NTILE(4) assigns records into 4 balanced quantile buckets."
                    )
                ]
            ),

            Lesson(
                id: "sql_lag_lead_offsets",
                category: .sqlWindowValues,
                titleRU: "Оконные смещения: LAG() и LEAD()",
                titleEN: "Window Offsets: LAG() & LEAD()",
                summaryRU: "Доступ к предыдущей и следующей строке без самообъединений (Self-Join), расчет темпов роста MoM и YoY.",
                summaryEN: "Accessing preceding and succeeding rows without self-joins, period-over-period delta tracking (MoM, YoY).",
                contentMarkdownRU: ##"""
### Функции LAG() и LEAD()

Позволяют заглянуть в смежные строки относительно текущей позиции:
- `LAG(col, offset, default)` — значение из строки **выше** (предыдущая строка).
- `LEAD(col, offset, default)` — значение из строки **ниже** (следующая строка).

Параметры:
1. `col` — имя столбца или выражение.
2. `offset` (опционально, по умолчанию 1) — на сколько строк смещаться.
3. `default` (опционально, по умолчанию `NULL`) — значение-заглушка для первой/последней строки.

### Анализ динамики продаж (Month-over-Month)
```sql
SELECT 
    month,
    revenue,
    LAG(revenue, 1) OVER (ORDER BY month) AS prev_month_revenue,
    revenue - LAG(revenue, 1) OVER (ORDER BY month) AS mom_growth
FROM monthly_sales;
```
"""##,
                contentMarkdownEN: ##"""
### Temporal Deltas: LAG & LEAD
- `LAG(expr, offset, default)`: Fetches data from previous rows.
- `LEAD(expr, offset, default)`: Fetches data from future rows.

Eliminates slow self-joins when calculating period-over-period growth.
"""##,
                codeSnippet: ##"""
CREATE TABLE daily_stock (
    day_num INTEGER PRIMARY KEY,
    price REAL
);

INSERT INTO daily_stock VALUES 
(1, 100.0), (2, 105.0), (3, 103.0), (4, 112.0);

SELECT 
    day_num, price,
    LAG(price, 1, price) OVER (ORDER BY day_num) AS prev_day_price,
    ROUND(price - LAG(price, 1, price) OVER (ORDER BY day_num), 2) AS price_delta
FROM daily_stock;
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какая функция возвращает значение из предшествующей строки относительно текущей?",
                        questionEN: "Which window function accesses values from a preceding row?",
                        optionsRU: ["LAG()", "LEAD()", "FIRST_VALUE()", "PRIOR()"],
                        optionsEN: ["LAG()", "LEAD()", "FIRST_VALUE()", "PRIOR()"],
                        correctIndex: 0,
                        explanationRU: "Функция LAG() считывает значение из строки, находящейся выше на указанное смещение.",
                        explanationEN: "LAG() looks backward into previous rows within the current window."
                    )
                ]
            ),

            Lesson(
                id: "sql_first_last_value",
                category: .sqlWindowValues,
                titleRU: "Граничные значения окна: FIRST_VALUE и LAST_VALUE",
                titleEN: "Window Boundaries: FIRST_VALUE & LAST_VALUE",
                summaryRU: "Выборка первого и последнего значения в секции, ловушка дефолтного фрейма в LAST_VALUE и явные рамки.",
                summaryEN: "Boundary value extraction, the default frame trap in LAST_VALUE, and explicit window frame declarations.",
                contentMarkdownRU: ##"""
### Функции FIRST_VALUE() и LAST_VALUE()

- `FIRST_VALUE(col)` — первое значение в упорядоченном окне.
- `LAST_VALUE(col)` — последнее значение в упорядоченном окне.

### Опасная ловушка с LAST_VALUE()!
По умолчанию в SQL при наличии `ORDER BY` рамка окна не простирается до конца таблицы, а заканчивается на текущей строке (`RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`).
Из-за этого `LAST_VALUE(col)` по умолчанию возвращает значение **текущей** строки!

Для корректной работы `LAST_VALUE` необходимо явно расширить рамку до конца секции:
```sql
SELECT 
    employee, salary,
    FIRST_VALUE(salary) OVER (
        PARTITION BY dept ORDER BY salary DESC
    ) AS highest_salary,
    LAST_VALUE(salary) OVER (
        PARTITION BY dept ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS lowest_salary
FROM company_payroll;
```
"""##,
                contentMarkdownEN: ##"""
### Window Extents: FIRST_VALUE & LAST_VALUE
- `FIRST_VALUE()`: Captures initial value within frame boundaries.
- `LAST_VALUE()`: Captures terminal frame value.

Be alert to default SQL framing (`RANGE UNBOUNDED PRECEDING AND CURRENT ROW`). Always declare `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` when invoking `LAST_VALUE()`.
"""##,
                codeSnippet: ##"""
CREATE TABLE racers (
    id INTEGER PRIMARY KEY,
    racer_name TEXT,
    lap_time REAL
);

INSERT INTO racers VALUES 
(1, 'Молния', 72.4),
(2, 'Шумахер', 74.1),
(3, 'Хэмилтон', 75.8);

SELECT 
    racer_name, lap_time,
    FIRST_VALUE(lap_time) OVER (ORDER BY lap_time ASC) AS best_lap,
    ROUND(lap_time - FIRST_VALUE(lap_time) OVER (ORDER BY lap_time ASC), 2) AS gap_to_leader
FROM racers;
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какую рамку окна (frame) нужно явно указать для LAST_VALUE, чтобы получить последнее значение всей секции?",
                        questionEN: "Which window frame clause must be specified for LAST_VALUE to reach the final row of a partition?",
                        optionsRU: ["ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING", "ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING", "RANGE CURRENT ROW", "LIMIT 1"],
                        optionsEN: ["ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING", "ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING", "RANGE CURRENT ROW", "LIMIT 1"],
                        correctIndex: 0,
                        explanationRU: "По умолчанию окно ограничено текущей строкой, поэтому для конца секции нужно UNBOUNDED FOLLOWING.",
                        explanationEN: "UNBOUNDED FOLLOWING extends the evaluation window to the final partition boundary."
                    )
                ]
            ),

            Lesson(
                id: "sql_window_frames_rows",
                category: .sqlWindowValues,
                titleRU: "Рамки окон: ROWS BETWEEN и скользящие агрегаты",
                titleEN: "Window Framing: ROWS BETWEEN & Moving Averages",
                summaryRU: "Скользящее среднее (Moving Average), накопительные суммы (Running Total), ROWS vs RANGE, PRECEDING и FOLLOWING.",
                summaryEN: "Moving averages, cumulative running totals, ROWS vs RANGE semantics, PRECEDING and FOLLOWING offsets.",
                contentMarkdownRU: ##"""
### Рамки окон (Window Frames)

Предложение рамки окна уточняет, какие именно строки вокруг текущей участвуют в вычислении:

```sql
SUM(amount) OVER (
    ORDER BY date 
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
)
```

### Ключевые спецификаторы фрейма
- `UNBOUNDED PRECEDING` — от самой первой строки секции.
- `N PRECEDING` — $N$ строк назад.
- `CURRENT ROW` — текущая строка.
- `N FOLLOWING` — $N$ строк вперед.
- `UNBOUNDED FOLLOWING` — до последней строки секции.

### Скользящее 7-дневное среднее (7-day Moving Average)
Сглаживает недельные колебания метрик (выручка, посещаемость):
```sql
SELECT 
    date, daily_orders,
    AVG(daily_orders) OVER (
        ORDER BY date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS moving_avg_7d
FROM metrics;
```
"""##,
                contentMarkdownEN: ##"""
### Window Frame Clauses
Window frames restrict aggregate scope relative to current position.

Use `ROWS BETWEEN N PRECEDING AND CURRENT ROW` for moving averages and smoothed metric indicators.
"""##,
                codeSnippet: ##"""
CREATE TABLE daily_traffic (
    day_id INTEGER PRIMARY KEY,
    visitors INTEGER
);

INSERT INTO daily_traffic VALUES 
(1, 100), (2, 120), (3, 110), (4, 150), (5, 140);

-- Накопительный итог (Running Total) и скользящее среднее по 3 дням
SELECT 
    day_id, visitors,
    SUM(visitors) OVER (ORDER BY day_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total,
    ROUND(AVG(visitors) OVER (ORDER BY day_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 1) AS moving_avg_3d
FROM daily_traffic;
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какое выражение задает окно из 3 строк: предыдущая, текущая и следующая?",
                        questionEN: "Which frame definition specifies a 3-row sliding window: preceding, current, and succeeding?",
                        optionsRU: ["ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING", "ROWS BETWEEN 3 PRECEDING AND CURRENT ROW", "RANGE BETWEEN 1 AND 3", "ROWS 3"],
                        optionsEN: ["ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING", "ROWS BETWEEN 3 PRECEDING AND CURRENT ROW", "RANGE BETWEEN 1 AND 3", "ROWS 3"],
                        correctIndex: 0,
                        explanationRU: "1 PRECEDING захватывает 1 строку назад, а 1 FOLLOWING — 1 строку вперед, суммарно 3 строки.",
                        explanationEN: "1 PRECEDING AND 1 FOLLOWING spans the immediate prior, current, and next records."
                    )
                ]
            ),

            Lesson(
                id: "sql_case_when_logic",
                category: .sqlExpressionsMath,
                titleRU: "Условные выражения: CASE WHEN ... THEN ... ELSE",
                titleEN: "Conditional Logic: CASE WHEN Expressions",
                summaryRU: "Ветвление логики в SQL, простой и поисковый CASE, поворот данных (Pivot) через условные агрегаты.",
                summaryEN: "Conditional branching in queries, simple vs searched CASE, and matrix pivoting via conditional aggregates.",
                contentMarkdownRU: ##"""
### Конструкция CASE WHEN

Выражение `CASE` — аналог `if / else` или `switch` в языках программирования. Возвращает значение в зависимости от истинности условий:

```sql
SELECT 
    name,
    score,
    CASE 
        WHEN score >= 90 THEN 'Отлично'
        WHEN score >= 75 THEN 'Хорошо'
        WHEN score >= 60 THEN 'Удовлетворительно'
        ELSE 'Неудовлетворительно'
    END AS grade
FROM test_results;
```

### Поворот данных (Pivot) через условный SUM(CASE)
Мощная техника агрегации строк в столбцы без сторонних расширений:
```sql
SELECT 
    store_id,
    SUM(CASE WHEN quarter = 'Q1' THEN revenue ELSE 0 END) AS q1_rev,
    SUM(CASE WHEN quarter = 'Q2' THEN revenue ELSE 0 END) AS q2_rev
FROM retail_sales 
GROUP BY store_id;
```
"""##,
                contentMarkdownEN: ##"""
### The CASE Expression
Provides inline branching logic within queries.

Combine `SUM(CASE WHEN ...)` to pivot rows into columns natively across all standard SQL database engines.
"""##,
                codeSnippet: ##"""
CREATE TABLE orders_status (
    id INTEGER PRIMARY KEY,
    amount REAL,
    is_delivered INTEGER
);

INSERT INTO orders_status VALUES 
(1, 4500.0, 1), (2, 8900.0, 0), (3, 1200.0, 1);

SELECT 
    id, amount,
    CASE 
        WHEN is_delivered = 1 THEN 'Доставлен'
        ELSE 'В пути'
    END AS delivery_status
FROM orders_status;
"""##,
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Каким ключевым словом обязана завершаться конструкция CASE в SQL?",
                        questionEN: "Which keyword must terminate a CASE expression in SQL?",
                        optionsRU: ["END", "STOP", "FINISH", "BREAK"],
                        optionsEN: ["END", "STOP", "FINISH", "BREAK"],
                        correctIndex: 0,
                        explanationRU: "В синтаксисе SQL каждое выражение CASE завершается обязательным ключевым словом END.",
                        explanationEN: "CASE statements strictly conclude with the END keyword."
                    )
                ]
            ),

            Lesson(
                id: "sql_null_coalesce_nullif",
                category: .sqlExpressionsMath,
                titleRU: "Защита от NULL: COALESCE, IFNULL и NULLIF",
                titleEN: "NULL Protection: COALESCE, IFNULL & NULLIF",
                summaryRU: "Выбор первого непустого значения, дефолтные подстановки, предотвращение деления на ноль через NULLIF.",
                summaryEN: "First non-null selection, fallback defaults, and zero-division prevention using NULLIF.",
                contentMarkdownRU: ##"""
### Функции COALESCE и IFNULL

- `COALESCE(val1, val2, ...)` — принимает произвольное количество аргументов и возвращает **первое значение, не равное NULL**.
```sql
SELECT 
    name, 
    COALESCE(mobile_phone, work_phone, home_phone, 'Номер не указан') AS contact_phone
FROM client_profiles;
```
- `IFNULL(val1, val2)` — двухпараметрический аналог в SQLite / MySQL.

### Функция NULLIF: защита от деления на ноль
`NULLIF(a, b)` возвращает `NULL`, если $a = b$. Иначе возвращает $a$.
В SQL деление на ноль приводит к фатальной ошибке. `NULLIF` элегантно защищает вычисления:
```sql
-- Если total_clicks = 0, NULLIF вернет NULL, а результат деления станет безопасным NULL!
SELECT 
    campaign_name,
    conversions * 1.0 / NULLIF(total_clicks, 0) AS conversion_rate
FROM marketing_metrics;
```
"""##,
                contentMarkdownEN: ##"""
### COALESCE and NULLIF
- `COALESCE(a, b, ...)` returns the first non-null expression in its argument list.
- `NULLIF(a, b)` returns `NULL` when $a = b$, providing bulletproof protection against zero-division runtime errors.
"""##,
                codeSnippet: ##"""
CREATE TABLE customer_emails (
    id INTEGER PRIMARY KEY,
    username TEXT,
    primary_email TEXT,
    backup_email TEXT
);

INSERT INTO customer_emails VALUES 
(1, 'Антон', NULL, 'anton_backup@gmail.com'),
(2, 'Дарья', 'daria@corp.com', NULL),
(3, 'Игорь', NULL, NULL);

SELECT 
    username,
    COALESCE(primary_email, backup_email, 'no_email@domain.com') AS effective_email
FROM customer_emails;
"""##,
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что вернет вызов `NULLIF(100, 100)`?",
                        questionEN: "What does `NULLIF(100, 100)` return?",
                        optionsRU: ["NULL", "100", "0", "TRUE"],
                        optionsEN: ["NULL", "100", "0", "TRUE"],
                        correctIndex: 0,
                        explanationRU: "NULLIF возвращает NULL, если оба переданных аргумента равны.",
                        explanationEN: "NULLIF yields NULL whenever its two arguments are equivalent."
                    )
                ]
            ),

            Lesson(
                id: "sql_string_math_functions",
                category: .sqlExpressionsMath,
                titleRU: "Встроенные функции: строки, числа и даты",
                titleEN: "Built-in Functions: Strings, Math & Dates",
                summaryRU: "Преобразование строк (SUBSTR, TRIM, UPPER, REPLACE), математика (ROUND, ABS) и работа с датами в SQLite.",
                summaryEN: "String manipulations (SUBSTR, TRIM, UPPER, REPLACE), math primitives (ROUND, ABS), and SQLite date formatting.",
                contentMarkdownRU: ##"""
### Строковые функции
- `LENGTH(str)` — длина строки в символах.
- `UPPER(str)` / `LOWER(str)` — приведение регистра.
- `SUBSTR(str, start, len)` — извлечение подстроки (индексация с 1!).
- `TRIM(str)` — удаление пробелов по краям.
- `REPLACE(str, from, to)` — замена подстроки.
- Конкатенация: оператор `||` (например, `first_name || ' ' || last_name`).

### Математические функции
- `ROUND(val, decimals)` — округление числа до указанного знака.
- `ABS(val)` — абсолютная величина (модуль).

### Работа с датами и временем в SQLite
В SQLite нет отдельного типа данных `DATE`. Даты хранятся как строки `ISO-8601` (`YYYY-MM-DD HH:MM:SS`) или unix-метки:
```sql
SELECT 
    DATE('now') AS today,
    STRFTIME('%Y', 'now') AS current_year,
    DATE('now', '-7 days') AS one_week_ago;
```
"""##,
                contentMarkdownEN: ##"""
### Core Scalar Functions
- String concatenation: `||` operator.
- Substrings: `SUBSTR(str, start, len)` (1-indexed).
- SQLite date formatting: `DATE('now')`, `STRFTIME('%Y-%m', created_at)`.
"""##,
                codeSnippet: ##"""
CREATE TABLE user_profiles_raw (
    id INTEGER PRIMARY KEY,
    raw_name TEXT,
    balance REAL
);

INSERT INTO user_profiles_raw VALUES 
(1, '  алексей иванов  ', 1450.789);

SELECT 
    id,
    UPPER(TRIM(raw_name)) AS cleaned_name,
    ROUND(balance, 2) AS formatted_balance,
    SUBSTR(TRIM(raw_name), 1, 1) AS first_letter
FROM user_profiles_raw;
"""##,
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какой оператор в стандарте SQL и SQLite выполняет конкатенацию (склеивание) строк?",
                        questionEN: "Which operator performs string concatenation in SQL standard and SQLite?",
                        optionsRU: ["Двойная вертикальная черта `||`", "Знак плюса `+`", "Амперсанд `&`", "Точка `.`"],
                        optionsEN: ["Double pipe `||`", "Plus sign `+`", "Ampersand `&`", "Dot `.`"],
                        correctIndex: 0,
                        explanationRU: "В стандарте SQL и SQLite конкатенация строк выполняется оператором `||`.",
                        explanationEN: "String concatenation in standard SQL and SQLite uses the `||` operator."
                    )
                ]
            ),

            Lesson(
                id: "sql_ddl_create_table",
                category: .sqlDdlDml,
                titleRU: "DDL: CREATE TABLE и строгая типизация",
                titleEN: "DDL: CREATE TABLE & Data Typing",
                summaryRU: "Data Definition Language, типы хранения SQLite (INTEGER, REAL, TEXT, BLOB), strict tables и схема данных.",
                summaryEN: "Data Definition Language, SQLite affinity classes (INTEGER, REAL, TEXT, BLOB), strict mode, and table schemas.",
                contentMarkdownRU: ##"""
### Data Definition Language (DDL)

DDL — подмножество языка SQL для создания, изменения и удаления структур хранения данных (таблиц, представлений, индексов).

### Команда CREATE TABLE
```sql
CREATE TABLE IF NOT EXISTS accounts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    account_number TEXT NOT NULL UNIQUE,
    balance REAL DEFAULT 0.0,
    is_blocked INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

### Классы хранения в SQLite (Type Affinity)
В отличие от строгих СУБД (PostgreSQL), SQLite использует динамическую типизацию (Type Affinity), поддерживая 5 базовых классов:
1. `NULL` — неопределенное значение.
2. `INTEGER` — целое число со знаком (1, 2, 3, 4, 6 или 8 байт).
3. `REAL` — число с плавающей точкой двойной точности (IEEE 8-byte).
4. `TEXT` — строка текста (UTF-8, UTF-16).
5. `BLOB` — массив сырых байтов (изображения, ключи, файлы).
"""##,
                contentMarkdownEN: ##"""
### Data Definition Language: CREATE TABLE
DDL commands manage database structure schemas.

SQLite classifies storage into 5 native storage classes: `NULL`, `INTEGER`, `REAL`, `TEXT`, and `BLOB`.
"""##,
                codeSnippet: ##"""
CREATE TABLE products_inventory (
    sku TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    stock_quantity INTEGER NOT NULL DEFAULT 0,
    unit_price REAL NOT NULL
);

INSERT INTO products_inventory VALUES 
('SKU-100', 'Механическая клавиатура', 15, 7500.0);

SELECT * FROM products_inventory;
"""##,
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какой класс хранения в SQLite предназначен для хранения бинарных данных (картинок, файлов)?",
                        questionEN: "Which SQLite storage class holds binary objects like images or serialized payloads?",
                        optionsRU: ["BLOB", "BINARY", "BYTEA", "RAW"],
                        optionsEN: ["BLOB", "BINARY", "BYTEA", "RAW"],
                        correctIndex: 0,
                        explanationRU: "BLOB (Binary Large Object) хранит массив произвольных сырых байтов.",
                        explanationEN: "BLOB stores raw binary byte streams without transformation."
                    )
                ]
            ),

            Lesson(
                id: "sql_table_constraints",
                category: .sqlDdlDml,
                titleRU: "Ограничения целостности: NOT NULL, UNIQUE, CHECK",
                titleEN: "Integrity Constraints: NOT NULL, UNIQUE & CHECK",
                summaryRU: "Защита от некорректных данных на уровне схемы БД, валидация бизнес-правил через CHECK и дефолты DEFAULT.",
                summaryEN: "Schema-level data hygiene, business rule validation via CHECK, unique indices, and DEFAULT values.",
                contentMarkdownRU: ##"""
### Ограничения целостности (Constraints)

Ограничения предотвращают попадание некорректных данных в базу на уровне ядра СУБД, снимая эту ответственность с кода приложения:

1. **`NOT NULL`** — запрещает пустые значения `NULL` в столбце.
2. **`UNIQUE`** — гарантирует отсутствие дублирующихся значений во всей таблице. Автоматически создает B-Tree индекс.
3. **`DEFAULT <val>`** — подставляет значение по умолчанию, если оно не передано в INSERT.
4. **`CHECK (выражение)`** — валидирует произвольное логическое условие:
```sql
CREATE TABLE hotel_bookings (
    id INTEGER PRIMARY KEY,
    guests_count INTEGER NOT NULL CHECK (guests_count > 0 AND guests_count <= 10),
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    discount_pct REAL DEFAULT 0.0 CHECK (discount_pct BETWEEN 0.0 AND 100.0),
    CHECK (check_out > check_in) -- Ограничение на уровне всей таблицы!
);
```
"""##,
                contentMarkdownEN: ##"""
### Table Constraints
- `NOT NULL`: Prevents missing data entries.
- `UNIQUE`: Guarantees distinct values across table records.
- `CHECK (expr)`: Enforces business logic rules directly in the database engine.
"""##,
                codeSnippet: ##"""
CREATE TABLE user_cards (
    card_id INTEGER PRIMARY KEY,
    holder_name TEXT NOT NULL,
    limit_amount REAL CHECK (limit_amount >= 0.0),
    status TEXT CHECK (status IN ('ACTIVE', 'FROZEN', 'CLOSED'))
);

INSERT INTO user_cards VALUES (1, 'Иван Смирнов', 50000.0, 'ACTIVE');

SELECT * FROM user_cards;
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какое ограничение позволяет задать проверку условия (например, balance >= 0)?",
                        questionEN: "Which constraint allows specifying validation predicates like `balance >= 0`?",
                        optionsRU: ["CHECK", "VERIFY", "VALIDATE", "RULE"],
                        optionsEN: ["CHECK", "VERIFY", "VALIDATE", "RULE"],
                        correctIndex: 0,
                        explanationRU: "Ограничение CHECK проверяет истинность заданного логического выражения при любой вставке или обновлении строки.",
                        explanationEN: "CHECK constraints evaluate arbitrary boolean predicates prior to committing inserts or updates."
                    )
                ]
            ),

            Lesson(
                id: "sql_alter_drop_table",
                category: .sqlDdlDml,
                titleRU: "Модификация схемы: ALTER TABLE и DROP TABLE",
                titleEN: "Schema Evolution: ALTER TABLE & DROP TABLE",
                summaryRU: "Добавление колонок ADD COLUMN, переименование RENAME, удаление таблиц DROP и особенности миграций в SQLite.",
                summaryEN: "Adding columns with ADD COLUMN, table/column renaming, DROP TABLE, and SQLite migration constraints.",
                contentMarkdownRU: ##"""
### Модификация схемы данных

Бизнес-логика эволюционирует, требуя изменения существующей структуры таблиц:

### Команда ALTER TABLE
- Добавление новой колонки:
  ```sql
  ALTER TABLE users ADD COLUMN phone TEXT DEFAULT NULL;
  ```
- Переименование таблицы:
  ```sql
  ALTER TABLE old_orders RENAME TO orders_v2;
  ```
- Переименование колонки (SQLite 3.25+):
  ```sql
  ALTER TABLE users RENAME COLUMN email TO primary_email;
  ```

### Ограничения SQLite при изменении схемы
Исторически SQLite не поддерживает прямое удаление или модификацию типов существующих колонок через `ALTER TABLE DROP COLUMN`.
Для сложной миграции используется классический паттерн:
1. Создать новую таблицу `new_table` с нужной структурой.
2. Скопировать данные: `INSERT INTO new_table SELECT ... FROM old_table;`
3. Удалить старую таблицу: `DROP TABLE old_table;`
4. Переименовать: `ALTER TABLE new_table RENAME TO old_table;`
"""##,
                contentMarkdownEN: ##"""
### Schema Evolution: ALTER & DROP
- `ALTER TABLE t ADD COLUMN col ...`: Appends new attributes.
- `ALTER TABLE t RENAME TO new_name`: Renames relations.
- `DROP TABLE IF EXISTS t`: Safely removes entire relations.
"""##,
                codeSnippet: ##"""
CREATE TABLE temporary_metrics (id INTEGER PRIMARY KEY, val REAL);
INSERT INTO temporary_metrics VALUES (1, 42.0);

-- Добавляем новую колонку с дефолтным значением
ALTER TABLE temporary_metrics ADD COLUMN category TEXT DEFAULT 'GENERAL';

SELECT * FROM temporary_metrics;
"""##,
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какая команда используется для добавления нового столбца в существующую таблицу?",
                        questionEN: "Which command appends a new column to an existing table?",
                        optionsRU: ["ALTER TABLE table_name ADD COLUMN column_name type;", "UPDATE TABLE table_name ADD column_name;", "CREATE COLUMN column_name IN table_name;", "MODIFY TABLE table_name INSERT COLUMN;"],
                        optionsEN: ["ALTER TABLE table_name ADD COLUMN column_name type;", "UPDATE TABLE table_name ADD column_name;", "CREATE COLUMN column_name IN table_name;", "MODIFY TABLE table_name INSERT COLUMN;"],
                        correctIndex: 0,
                        explanationRU: "Для расширения структуры таблицы используется ALTER TABLE ... ADD COLUMN.",
                        explanationEN: "ALTER TABLE table_name ADD COLUMN is standard SQL for schema column extensions."
                    )
                ]
            ),

            Lesson(
                id: "sql_insert_bulk",
                category: .sqlDmlModifications,
                titleRU: "DML: Вставка строк INSERT INTO и пакетная запись",
                titleEN: "DML: INSERT INTO & Bulk Inserts",
                summaryRU: "Вставка одиночных строк, множественный Multi-row INSERT, вставка результатов запроса INSERT INTO ... SELECT.",
                summaryEN: "Single-row inserts, multi-row bulk insertions, and populating tables from queries with INSERT INTO SELECT.",
                contentMarkdownRU: ##"""
### Data Manipulation Language: INSERT INTO

Команда `INSERT INTO` добавляет новые записи в таблицу:

```sql
INSERT INTO clients (name, email, balance) 
VALUES ('Иван Петров', 'ivan@mail.ru', 10000.0);
```

### Пакетная вставка (Bulk Insert)
Вставка нескольких сотен строк отдельными вызовами `INSERT` порождает огромные накладные расходы на диск.
Множественный `INSERT` выполняет вставку одного составного пакета в единой операции:
```sql
INSERT INTO log_entries (level, message) VALUES 
('INFO', 'Сервер запущен'),
('WARN', 'Высокое потребление памяти'),
('ERROR', 'Таймаут шлюза платежей');
```

### Вставка из другого запроса (INSERT INTO ... SELECT)
```sql
INSERT INTO archived_orders (id, amount, archived_date)
SELECT id, amount, CURRENT_TIMESTAMP 
FROM orders 
WHERE status = 'CLOSED' AND created_at < '2025-01-01';
```
"""##,
                contentMarkdownEN: ##"""
### DML: Data Insertion
`INSERT INTO` inserts candidate rows into tables.

Bulk multi-row inserts group multiple value tuples into a single statement, maximizing throughput. Populate tables from existing relations using `INSERT INTO ... SELECT`.
"""##,
                codeSnippet: ##"""
CREATE TABLE tags (
    id INTEGER PRIMARY KEY,
    name TEXT UNIQUE
);

-- Пакетная вставка 3 тегов одной операцией
INSERT INTO tags (name) VALUES 
('swift'), ('ios'), ('database');

SELECT * FROM tags;
"""##,
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какая конструкция позволяет скопировать строки из одной таблицы в другую?",
                        questionEN: "Which syntax copies data directly between tables?",
                        optionsRU: ["INSERT INTO target_table SELECT ... FROM source_table", "COPY FROM source_table TO target_table", "IMPORT TABLE source_table", "MERGE INTO target_table"],
                        optionsEN: ["INSERT INTO target_table SELECT ... FROM source_table", "COPY FROM source_table TO target_table", "IMPORT TABLE source_table", "MERGE INTO target_table"],
                        correctIndex: 0,
                        explanationRU: "Конструкция INSERT INTO ... SELECT считывает строки запросом и тут же сохраняет их в целевую таблицу.",
                        explanationEN: "INSERT INTO ... SELECT transfers query results directly into destination schemas."
                    )
                ]
            ),

            Lesson(
                id: "sql_update_delete_safe",
                category: .sqlDmlModifications,
                titleRU: "Безопасное изменение UPDATE и удаление DELETE",
                titleEN: "Safe Modifications: UPDATE & DELETE Practices",
                summaryRU: "Опасность выполнения без WHERE, паттерн предварительной проверки через SELECT, мягкое удаление (Soft Delete).",
                summaryEN: "Unbounded statement hazards, SELECT verification pattern, and Soft Delete architectural design.",
                contentMarkdownRU: ##"""
### Операторы UPDATE и DELETE

- `UPDATE` модифицирует существующие значения в строках.
- `DELETE FROM` физически удаляет строки из таблицы.

### ЗОЛОТОЕ ПРАВИЛО ПРОМЫШЛЕННОГО SQL:
> [!CAUTION]
> Выполнение `UPDATE` или `DELETE` без блока `WHERE` необратимо перезапишет или удалит **абсолютно все строки** во всей таблице!

Паттерн безопасного изменения:
Перед тем как запустить тяжелый `UPDATE` или `DELETE`, всегда запустите `SELECT` с тем же самым `WHERE`, чтобы точно убедиться в выборке нужных строк:
```sql
-- Шаг 1: проверяем, что отбираются ровно 3 нужных пользователя
SELECT COUNT(*) FROM users WHERE is_inactive = 1 AND registered_at < '2020-01-01';

-- Шаг 2: выполняем безопасное удаление
DELETE FROM users WHERE is_inactive = 1 AND registered_at < '2020-01-01';
```

### Паттерн Мягкого Удаления (Soft Delete)
Вместо физического `DELETE` строки помечают флагом `is_deleted = 1` или `deleted_at = CURRENT_TIMESTAMP`, сохраняя историю и аудит.
"""##,
                contentMarkdownEN: ##"""
### Safe Modification Practices
`UPDATE` and `DELETE` without `WHERE` clauses mutate every tuple in the relation.

Always execute a preview `SELECT` with matching predicate bounds prior to modifying data. Many systems employ **Soft Delete** (`deleted_at TIMESTAMP`) to preserve historical auditability.
"""##,
                codeSnippet: ##"""
CREATE TABLE inventory_items (
    id INTEGER PRIMARY KEY,
    title TEXT,
    price REAL,
    is_archived INTEGER DEFAULT 0
);

INSERT INTO inventory_items VALUES 
(1, 'Чехол для iPhone', 1500.0, 0),
(2, 'Кабель USB-C', 800.0, 0);

-- Повышаем цену на 10% только для активных чехлов
UPDATE inventory_items 
SET price = ROUND(price * 1.10, 2) 
WHERE id = 1;

SELECT * FROM inventory_items;
"""##,
                xpReward: 40,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что произойдет при вызове команды `DELETE FROM accounts;` без указания блока WHERE?",
                        questionEN: "What happens if `DELETE FROM accounts;` is executed without a WHERE clause?",
                        optionsRU: ["Удалятся абсолютно все записи во всей таблице accounts", "СУБД выдаст предупреждение и ничего не сделает", "Удалится только первая строка", "Удалится сама таблица из базы"],
                        optionsEN: ["All rows in the accounts table will be deleted", "The engine prompts a warning and aborts", "Only the first record is removed", "The table itself is dropped"],
                        correctIndex: 0,
                        explanationRU: "Без фильтра WHERE команда DELETE уничтожит все строки в таблице.",
                        explanationEN: "Omitting WHERE clauses targets all tuples in the specified table."
                    )
                ]
            ),

            Lesson(
                id: "sql_upsert_on_conflict",
                category: .sqlDmlModifications,
                titleRU: "UPSERT: обработка конфликтов ON CONFLICT",
                titleEN: "UPSERT: Conflict Resolution (ON CONFLICT)",
                summaryRU: "Идемпотентная вставка, вставка или обновление (Insert or Update), синтаксис ON CONFLICT DO UPDATE и DO NOTHING.",
                summaryEN: "Idempotent insertions, insert-or-update semantics, ON CONFLICT DO UPDATE, and DO NOTHING clauses.",
                contentMarkdownRU: ##"""
### Механизм UPSERT (Update on Insert)

Частая задача: вставить запись, а если запись с таким ключом уже существует — обновить ее поля, не вызывая ошибку нарушения уникальности (`UNIQUE constraint failed`).

### Синтаксис ON CONFLICT
Начиная с версии 3.24, SQLite поддерживает стандартный синтаксис `UPSERT`:

1. **`DO NOTHING`** — молча пропустить вставку при конфликте:
```sql
INSERT INTO users (id, email) VALUES (101, 'alex@mail.ru')
ON CONFLICT (id) DO NOTHING;
```

2. **`DO UPDATE`** — обновить поля существующей строки. Спец-таблица `excluded` содержит переданные новые значения:
```sql
INSERT INTO page_counters (page_url, visits_count) 
VALUES ('/home', 1)
ON CONFLICT (page_url) DO UPDATE SET 
    visits_count = page_counters.visits_count + excluded.visits_count;
```
"""##,
                contentMarkdownEN: ##"""
### UPSERT: ON CONFLICT Resolution
Enables atomic insert-or-update operations without requiring race-prone read-then-write sequences.

- `ON CONFLICT (key) DO NOTHING`: Silently skips duplicate inserts.
- `ON CONFLICT (key) DO UPDATE SET ...`: Updates existing fields referencing `excluded.column`.
"""##,
                codeSnippet: ##"""
CREATE TABLE user_settings (
    user_id INTEGER PRIMARY KEY,
    theme TEXT,
    notifications_enabled INTEGER
);

INSERT INTO user_settings VALUES (1, 'Light', 1);

-- Идемпотентный UPSERT: если пользователь уже есть, обновляем его тему
INSERT INTO user_settings (user_id, theme, notifications_enabled) 
VALUES (1, 'Dark', 1)
ON CONFLICT (user_id) DO UPDATE SET 
    theme = excluded.theme;

SELECT * FROM user_settings;
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какая псевдо-таблица в выражении ON CONFLICT DO UPDATE хранит значения, которые мы пытались вставить?",
                        questionEN: "Which pseudo-table references values attempted for insertion inside ON CONFLICT DO UPDATE?",
                        optionsRU: ["excluded", "inserted", "new", "conflict"],
                        optionsEN: ["excluded", "inserted", "new", "conflict"],
                        correctIndex: 0,
                        explanationRU: "Ключевое слово excluded ссылается на значения, которые были переданы в оператор INSERT.",
                        explanationEN: "The `excluded` table alias provides access to the pending values proposed by the INSERT statement."
                    )
                ]
            ),

            Lesson(
                id: "sql_btree_indexes",
                category: .sqlIndexesPerf,
                titleRU: "Индексы B-Tree: как база находит строки за O(log N)",
                titleEN: "B-Tree Indexes: O(log N) Search Trees",
                summaryRU: "Внутреннее устройство B-Tree индексов, Full Table Scan vs Index Seek, цена поддержки индексов при записи.",
                summaryEN: "B-Tree index internals, Full Table Scan vs Index Seek, and write throughput trade-offs on indexed tables.",
                contentMarkdownRU: ##"""
### Как работают B-Tree индексы

Без индекса, чтобы найти одну запись в таблице на 10 000 000 строк, СУБД вынуждена прочитать весь файл с диска от начала до конца — это называется **Full Table Scan** ($O(N)$).

### Индекс — это сбалансированное дерево (B-Tree)
Индекс — это отдельная структура данных на диске, хранящая отсортированные значения ключа и ссылки на физические страницы таблицы:
- Время поиска сокращается с $O(N)$ до $O(\log N)$ (бинарный поиск по дереву).
- При 10 миллионах строк B-Tree находит запись всего за 3–4 дисковых чтения!

```sql
CREATE INDEX idx_users_email ON users(email);
```

### Плата за индексы
> [!WARNING]
> Индексы ускоряют операции чтения (`SELECT`), но **замедляют операции записи** (`INSERT`, `UPDATE`, `DELETE`), поскольку при каждой модификации строки СУБД обязана перестраивать и балансировать дерево индексов.
"""##,
                contentMarkdownEN: ##"""
### B-Tree Index Fundamentals
Without indexes, locating a single tuple mandates a sequential **Full Table Scan** ($O(N)$).

B-Tree indexes maintain balanced, sorted keys mapped to row locations, collapsing lookup complexity to $O(\log N)$. However, each additional index incurs disk overhead and slows down `INSERT`/`UPDATE` throughput.
"""##,
                codeSnippet: ##"""
CREATE TABLE customer_directory (
    id INTEGER PRIMARY KEY,
    passport_code TEXT,
    full_name TEXT
);

-- Создаем B-Tree индекс для ускорения мгновенного поиска по коду паспорта
CREATE INDEX idx_customers_passport ON customer_directory(passport_code);

INSERT INTO customer_directory VALUES (1, '4500-123456', 'Сергей Павлов');

SELECT full_name FROM customer_directory WHERE passport_code = '4500-123456';
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какова алгоритмическая сложность поиска строки в таблице по сбалансированному B-Tree индексу?",
                        questionEN: "What is the algorithmic search complexity of an indexed lookup using a balanced B-Tree?",
                        optionsRU: ["O(log N)", "O(N)", "O(1)", "O(N^2)"],
                        optionsEN: ["O(log N)", "O(N)", "O(1)", "O(N^2)"],
                        correctIndex: 0,
                        explanationRU: "B-Tree обеспечивает логарифмическое время поиска O(log N).",
                        explanationEN: "Balanced trees provide logarithmic O(log N) access time."
                    )
                ]
            ),

            Lesson(
                id: "sql_composite_unique_indexes",
                category: .sqlIndexesPerf,
                titleRU: "Составные индексы и порядок колонок (Leftmost Prefix)",
                titleEN: "Composite Indexes & Leftmost Prefix Rule",
                summaryRU: "Многоколоночные индексы, правило левого префикса, покрывающие индексы (Covering Index) и оптимизация.",
                summaryEN: "Multi-column composite indexes, leftmost prefix rule, covering indexes, and index selectivity.",
                contentMarkdownRU: ##"""
### Составные индексы (Composite Indexes)

Составной индекс строится по двум или более столбцам:
```sql
CREATE INDEX idx_users_country_city ON users(country, city);
```

### Главное правило: Левый префикс (Leftmost Prefix)
Индекс, созданный по `(A, B)`, физически упорядочен сначала по `A`, а затем внутри одинаковых `A` — по `B`.
- `WHERE A = 1 AND B = 2` $\rightarrow$ индекс используется полностью.
- `WHERE A = 1` $\rightarrow$ индекс используется (левый префикс совпал).
- `WHERE B = 2` $\rightarrow$ **индекс НЕ МОЖЕТ быть использован!** (потому что колонка B отсортирована только внутри групп A).

Порядок колонок при создании составного индекса имеет решающее значение!

### Покрывающий индекс (Covering Index)
Если запрос `SELECT col1, col2 FROM t WHERE col1 = 'val'` запрашивает только те колонки, которые уже содержатся в самом индексе, СУБД вообще не обращается к основной таблице, считывая всё прямо из дерева индекса (Index Only Scan).
"""##,
                contentMarkdownEN: ##"""
### Composite Indexes & Leftmost Prefix
A composite index on `(A, B)` sorts by `A`, then `B`. Queries filtering on `A` or `(A, B)` leverage the index, but queries filtering solely on `B` cannot utilize it.

A **Covering Index** contains all attributes requested by the query, bypassing the base table completely.
"""##,
                codeSnippet: ##"""
CREATE TABLE flights (
    flight_id INTEGER PRIMARY KEY,
    origin TEXT,
    destination TEXT,
    departure_time DATETIME
);

-- Составной индекс: origin (левый префикс), destination
CREATE INDEX idx_flights_route ON flights(origin, destination);

INSERT INTO flights VALUES 
(1, 'SVO', 'LED', '2026-04-01 10:00:00'),
(2, 'SVO', 'AER', '2026-04-01 12:00:00');

-- Запрос идеально попадает в индекс
SELECT flight_id FROM flights WHERE origin = 'SVO' AND destination = 'LED';
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Сможет ли оптимизатор использовать составной индекс CREATE INDEX idx ON t(A, B) для запроса `WHERE B = 10`?",
                        questionEN: "Can the query planner use an index on `(A, B)` for a query filtering only on `WHERE B = 10`?",
                        optionsRU: ["Нет, так как нарушено правило левого префикса (колонка A не указана)", "Да, в любом случае", "Да, если колонка B числовая", "Да, но только в SQLite"],
                        optionsEN: ["No, because it violates the leftmost prefix rule (attribute A is omitted)", "Yes, regardless", "Yes, if B is numeric", "Yes, in SQLite only"],
                        correctIndex: 0,
                        explanationRU: "Дерево отсортировано по первому столбцу A, поэтому прямой поиск только по B невозможен.",
                        explanationEN: "Without the leading key attribute, the index tree cannot be traversed via binary search."
                    )
                ]
            ),

            Lesson(
                id: "sql_explain_query_plan",
                category: .sqlIndexesPerf,
                titleRU: "Анализ запросов: EXPLAIN QUERY PLAN",
                titleEN: "Query Execution Plans: EXPLAIN QUERY PLAN",
                summaryRU: "Инспекция работы планировщика, обнаружение SCAN TABLE vs SEARCH TABLE USING INDEX, тюнинг производительности.",
                summaryEN: "Query planner inspection, diagnosing SCAN TABLE vs SEARCH TABLE USING INDEX, and bottleneck elimination.",
                contentMarkdownRU: ##"""
### Команда EXPLAIN QUERY PLAN

Команда `EXPLAIN QUERY PLAN` показывает, какой именно алгоритм и какие индексы СУБД планирует задействовать для выполнения запроса:

```sql
EXPLAIN QUERY PLAN 
SELECT * FROM employees WHERE email = 'dev@corp.com';
```

### Главные маркеры в плане SQLite:
1. `SCAN TABLE employees` — **тревожный сигнал!** База делает полный перебор всей таблицы (Full Table Scan).
2. `SEARCH TABLE employees USING INDEX idx_email` — **отлично!** База выполняет быстрый логарифмический поиск по B-Tree индексу.
3. `SEARCH TABLE employees USING INTEGER PRIMARY KEY (rowid=?)` — **максимальная скорость!** Прямое позиционирование по первичному ключу за $O(1)$.
4. `USE TEMP B-TREE FOR ORDER BY` — база создает временный индекс в памяти для сортировки.
"""##,
                contentMarkdownEN: ##"""
### Reading Execution Plans
Prefixing queries with `EXPLAIN QUERY PLAN` reveals planner strategy:
- `SCAN TABLE`: Sequential scan of every page ($O(N)$).
- `SEARCH TABLE USING INDEX`: Targeted logarithmic lookup via B-Tree ($O(\log N)$).
- `USE TEMP B-TREE`: In-memory sorting overhead indicating missing index on `ORDER BY` attributes.
"""##,
                codeSnippet: ##"""
CREATE TABLE audit_records (
    id INTEGER PRIMARY KEY,
    action_type TEXT,
    created_at DATE
);

CREATE INDEX idx_audit_created ON audit_records(created_at);

-- Проверяем план выполнения запроса
EXPLAIN QUERY PLAN 
SELECT * FROM audit_records WHERE created_at >= '2026-01-01';
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Что означает появление надписи 'SCAN TABLE' в выводе команды EXPLAIN QUERY PLAN?",
                        questionEN: "What does 'SCAN TABLE' signify in an EXPLAIN QUERY PLAN readout?",
                        optionsRU: ["Полное сканирование всех строк таблицы без использования индексов (Full Scan)", "Быстрый поиск по B-Tree индексу", "Синтаксическую ошибку в запросе", "Таблица заблокирована другой транзакцией"],
                        optionsEN: ["Full table scan examining every row without index assistance", "Fast B-Tree index seek", "A query syntax error", "The table is locked by another transaction"],
                        correctIndex: 0,
                        explanationRU: "SCAN TABLE означает полный перебор физических страниц таблицы, что указывает на отсутствие подходящего индекса.",
                        explanationEN: "SCAN TABLE confirms a sequential unindexed scan across the entire dataset."
                    )
                ]
            ),

            Lesson(
                id: "sql_acid_properties",
                category: .sqlTransactions,
                titleRU: "Свойства ACID и Надежность транзакций",
                titleEN: "ACID Properties & Transaction Reliability",
                summaryRU: "Атомарность (A), Согласованность (C), Изоляция (I), Долговечность (D) и предотвращение порчи данных.",
                summaryEN: "Atomicity, Consistency, Isolation, Durability, and database data corruption prevention guarantees.",
                contentMarkdownRU: ##"""
### Транзакции и гарантии ACID

Транзакция — это последовательность SQL-операций, выполняемых как единое неделимое целое.

### 4 столпа надежности (ACID):
1. **A — Atomicity (Атомарность)**:
   «Все или ничего». Если из 10 операций транзакции 9 прошли успешно, а 10-я упала, изменения всех 9 операций полностью откатываются (`ROLLBACK`). База никогда не остается в промежуточном состоянии.
2. **C — Consistency (Согласованность)**:
   Транзакция переводит базу из одного валидного состояния в другое, не нарушая ограничений целостности (`FOREIGN KEY`, `CHECK`, `NOT NULL`).
3. **I — Isolation (Изоляция)**:
   Параллельно выполняющиеся транзакции не должны влиять друг на друга.
4. **D — Durability (Долговечность)**:
   Если транзакция зафиксирована (`COMMIT`), ее данные гарантированно сохранены на диск (через WAL/журнал упреждающей записи) и не пропадут даже при внезапном отключении питания сервера.
"""##,
                contentMarkdownEN: ##"""
### ACID Transaction Guarantees
- **Atomicity**: All-or-nothing execution. Failures trigger full rollback.
- **Consistency**: Invariants and constraints remain valid before and after transactions.
- **Isolation**: Concurrent transactions cannot observe uncommitted intermediate states.
- **Durability**: Committed updates persist across system crashes via Write-Ahead Logging (WAL).
"""##,
                codeSnippet: ##"""
CREATE TABLE bank_wallets (
    account_id INTEGER PRIMARY KEY,
    owner TEXT,
    balance REAL CHECK (balance >= 0)
);

INSERT INTO bank_wallets VALUES (1, 'Алиса', 1000.0), (2, 'Боб', 500.0);

-- Атомарный перевод средств: списание и зачисление
BEGIN TRANSACTION;
UPDATE bank_wallets SET balance = balance - 200.0 WHERE account_id = 1;
UPDATE bank_wallets SET balance = balance + 200.0 WHERE account_id = 2;
COMMIT;

SELECT * FROM bank_wallets;
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какое свойство ACID гарантирует принцип 'все или ничего' (откат всех изменений при любой ошибке)?",
                        questionEN: "Which ACID property guarantees 'all-or-nothing' execution where failures rollback all changes?",
                        optionsRU: ["Атомарность (Atomicity)", "Изоляция (Isolation)", "Долговечность (Durability)", "Согласованность (Consistency)"],
                        optionsEN: ["Atomicity", "Isolation", "Durability", "Consistency"],
                        correctIndex: 0,
                        explanationRU: "Атомарность (Atomicity) гарантирует неделимость транзакции.",
                        explanationEN: "Atomicity enforces that atomic operations either complete entirely or roll back cleanly."
                    )
                ]
            ),

            Lesson(
                id: "sql_transactions_savepoints",
                category: .sqlTransactions,
                titleRU: "Транзакции: BEGIN, COMMIT, ROLLBACK и Savepoints",
                titleEN: "Transaction Control: COMMIT, ROLLBACK & Savepoints",
                summaryRU: "Управление транзакциями, аварийный откат ROLLBACK, точки сохранения SAVEPOINT для частичных откатов.",
                summaryEN: "Managing transaction state, emergency ROLLBACK, and nested partial rollbacks using SAVEPOINTs.",
                contentMarkdownRU: ##"""
### Управление транзакциями

В стандарте SQL команды управления транзакциями включают:
- `BEGIN TRANSACTION` — открытие явной транзакции.
- `COMMIT` — успешная фиксация всех изменений на диск.
- `ROLLBACK` — отмена всех изменений с момента открытия транзакции.

### Точки сохранения (SAVEPOINT)
Точки сохранения позволяют создавать контрольные метки внутри длинной транзакции и откатывать только часть операций, не сбрасывая всю транзакцию:

```sql
BEGIN TRANSACTION;

INSERT INTO orders VALUES (101, 'Клиент 1');
SAVEPOINT step1;

INSERT INTO orders VALUES (102, 'Клиент 2 (ошибочный)');
-- Откатываемся только до шага step1:
ROLLBACK TO step1;

-- Заказ 101 остался в транзакции и будет зафиксирован!
COMMIT;
```
"""##,
                contentMarkdownEN: ##"""
### Transaction Control & Savepoints
- `BEGIN TRANSACTION`: Opens transaction boundary.
- `COMMIT`: Persists state changes permanently.
- `ROLLBACK`: Discards pending mutations.
- `SAVEPOINT name`: Marks an intermediate checkpoint allowing partial rollback (`ROLLBACK TO name`).
"""##,
                codeSnippet: ##"""
CREATE TABLE game_inventory (item_id INTEGER PRIMARY KEY, item_name TEXT);

BEGIN TRANSACTION;
INSERT INTO game_inventory VALUES (1, 'Меч героя');

SAVEPOINT checkpoint_chest;
INSERT INTO game_inventory VALUES (2, 'Проклятое кольцо');

-- Отменяем только взятие проклятого кольца
ROLLBACK TO checkpoint_chest;

COMMIT;

SELECT * FROM game_inventory;
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какая команда позволяет отменить изменения только до определенной промежуточной точки транзакции?",
                        questionEN: "Which statement rolls back state changes to a specific intermediate checkpoint?",
                        optionsRU: ["ROLLBACK TO savepoint_name", "UNDO TO savepoint_name", "RESET TRANSACTION", "CANCEL CHECKPOINT"],
                        optionsEN: ["ROLLBACK TO savepoint_name", "UNDO TO savepoint_name", "RESET TRANSACTION", "CANCEL CHECKPOINT"],
                        correctIndex: 0,
                        explanationRU: "Команда ROLLBACK TO отменяет операции только до указанного SAVEPOINT.",
                        explanationEN: "ROLLBACK TO resets the transaction state specifically to the named savepoint."
                    )
                ]
            ),

            Lesson(
                id: "sql_views_virtual",
                category: .sqlViewsTriggers,
                titleRU: "Представления: CREATE VIEW и абстракции",
                titleEN: "Views: CREATE VIEW & Security Layering",
                summaryRU: "Виртуальные таблицы, сокрытие сложности длинных JOIN, разграничение прав доступа и материализованные представления.",
                summaryEN: "Virtual tables, hiding JOIN complexity, role-based column access control, and materialized views concept.",
                contentMarkdownRU: ##"""
### Представления (Views)

Представление (`VIEW`) — это виртуальная таблица, определенная сохраненным SQL-запросом.
В отличие от обычной таблицы, `VIEW` **не хранит данные физически на диске**. При каждом обращении к представлению СУБД прозрачно подставляет и выполняет лежащий в его основе запрос.

```sql
CREATE VIEW active_client_orders AS 
SELECT 
    c.name AS client_name,
    c.email,
    o.id AS order_id,
    o.amount
FROM clients c 
INNER JOIN orders o ON c.id = o.client_id 
WHERE o.status = 'PAID';
```

### Преимущества представлений
1. **Упрощение кода**: разработчики вызывают `SELECT * FROM active_client_orders;` вместо пятиэтажных `JOIN`.
2. **Безопасность (Security)**: можно предоставить пользователям доступ к `VIEW`, скрыв конфиденциальные столбцы (пароли, зарплаты).
"""##,
                contentMarkdownEN: ##"""
### SQL Views
A `VIEW` represents a stored query presenting a virtual table. Views contain no physical data on disk; queries referencing them re-evaluate the underlying query.

Views encapsulate complex joins and provide a security abstraction restricting sensitive column access.
"""##,
                codeSnippet: ##"""
CREATE TABLE employees_private (
    id INTEGER PRIMARY KEY,
    name TEXT,
    salary REAL,
    dept TEXT
);

INSERT INTO employees_private VALUES 
(1, 'Евгений', 180000.0, 'Архитектура'),
(2, 'Марина', 120000.0, 'Дизайн');

-- Публичное представление без конфиденциального поля зарплаты
CREATE VIEW public_staff_directory AS 
SELECT id, name, dept FROM employees_private;

SELECT * FROM public_staff_directory;
"""##,
                xpReward: 45,
                quiz: [
                    QuizQuestion(
                        questionRU: "Хранит ли обычное представление (VIEW) копию данных на диске?",
                        questionEN: "Does a standard SQL VIEW duplicate and store table data on disk?",
                        optionsRU: ["Нет, VIEW — это сохраненный запрос, вычисляемый динамически", "Да, данные дублируются при создании VIEW", "Да, если во VIEW есть JOIN", "Да, в SQLite"],
                        optionsEN: ["No, a VIEW is a saved query evaluated dynamically upon request", "Yes, data is cloned on creation", "Yes, when joins are involved", "Yes, in SQLite"],
                        correctIndex: 0,
                        explanationRU: "Обычное представление не хранит данные, являясь динамической виртуальной проекцией.",
                        explanationEN: "Standard views are virtual query definitions, persisting zero physical tuple data."
                    )
                ]
            ),

            Lesson(
                id: "sql_triggers_automation",
                category: .sqlViewsTriggers,
                titleRU: "Триггеры: CREATE TRIGGER и автоматизация",
                titleEN: "Triggers: CREATE TRIGGER & Audit Automations",
                summaryRU: "Реакция на события INSERT/UPDATE/DELETE, время срабатывания BEFORE/AFTER, псевдо-записи OLD и NEW, аудит изменений.",
                summaryEN: "Event handlers on INSERT/UPDATE/DELETE, BEFORE vs AFTER timings, OLD and NEW row states, and change log audits.",
                contentMarkdownRU: ##"""
### Триггеры в реляционных БД

Триггер — это процедурный блок кода, автоматически выполняемый ядром СУБД при наступлении определенного события в таблице:
- События: `INSERT`, `UPDATE`, `DELETE`.
- Время срабатывания: `BEFORE` (до изменения) или `AFTER` (после успешного изменения).
- Область: `FOR EACH ROW` — срабатывает для каждой затронутой строки.

### Псевдо-записи OLD и NEW
Внутри тела триггера доступны виртуальные строки:
- `NEW.column` — новое значение (доступно в `INSERT` и `UPDATE`).
- `OLD.column` — старое значение до изменения (доступно в `UPDATE` и `DELETE`).

### Сценарий: Неизменяемый журнал аудита (Audit Trail)
```sql
CREATE TRIGGER audit_price_changes 
AFTER UPDATE OF price ON products 
FOR EACH ROW 
WHEN OLD.price != NEW.price 
BEGIN 
    INSERT INTO price_audit_log (product_id, old_val, new_val, changed_at)
    VALUES (OLD.id, OLD.price, NEW.price, CURRENT_TIMESTAMP);
END;
```
"""##,
                contentMarkdownEN: ##"""
### Database Triggers
Triggers are automated database procedures executing in response to table modifications (`INSERT`, `UPDATE`, `DELETE`).

- `BEFORE`: Execute validations or transform values prior to mutation.
- `AFTER`: Populate audit trails or synchronize secondary tables.
- Access pre- and post-mutation attributes via `OLD` and `NEW` records.
"""##,
                codeSnippet: ##"""
CREATE TABLE products_catalog_t (
    id INTEGER PRIMARY KEY,
    name TEXT,
    price REAL
);

CREATE TABLE audit_log (
    id INTEGER PRIMARY KEY,
    msg TEXT
);

-- Триггер автоматического логирования добавления товаров
CREATE TRIGGER trg_product_added 
AFTER INSERT ON products_catalog_t 
BEGIN 
    INSERT INTO audit_log (msg) 
    VALUES ('Добавлен товар: ' || NEW.name);
END;

INSERT INTO products_catalog_t VALUES (1, 'Монитор 4K', 45000.0);

SELECT * FROM audit_log;
"""##,
                xpReward: 50,
                quiz: [
                    QuizQuestion(
                        questionRU: "Какая псевдо-запись содержит значение столбца до выполнения операции UPDATE в теле триггера?",
                        questionEN: "Which record identifier holds column values prior to an UPDATE operation inside a trigger?",
                        optionsRU: ["OLD", "NEW", "PREVIOUS", "BEFORE"],
                        optionsEN: ["OLD", "NEW", "PREVIOUS", "BEFORE"],
                        correctIndex: 0,
                        explanationRU: "Псевдо-запись OLD хранит состояние строки до модификации.",
                        explanationEN: "The OLD pseudo-record stores the original tuple values prior to modification."
                    )
                ]
            )

        ]
    }
}

