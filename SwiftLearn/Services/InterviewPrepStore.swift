import Foundation

public final class InterviewPrepStore {
    public static let shared = InterviewPrepStore()
    
    public let bigOItems: [BigOItem]
    public let rosettaComparisons: [RosettaComparison]
    public let interviewQuestions: [InterviewQuestion]
    
    private init() {
        // MARK: - 1. Big-O Complexity Data
        self.bigOItems = [
            // Data Structures
            BigOItem(
                id: "ds_array",
                nameRU: "Массив (Array / List)",
                nameEN: "Array / Dynamic List",
                isAlgorithm: false,
                timeAverage: .o1,
                timeWorst: .oN,
                spaceWorst: .oN,
                summaryRU: "Доступ по индексу O(1). Вставка/удаление в начало/середину требует сдвига O(n). Добавление в конец амортизированное O(1).",
                summaryEN: "Index access O(1). Insert/delete in middle takes O(n). Append to end is amortized O(1).",
                bestCaseNotesRU: "Идеально для фиксированного набора данных и частого произвольного чтения по индексу.",
                bestCaseNotesEN: "Ideal for fixed collections and frequent random index reads."
            ),
            BigOItem(
                id: "ds_linked_list",
                nameRU: "Связный список (Linked List)",
                nameEN: "Linked List (Singly / Doubly)",
                isAlgorithm: false,
                timeAverage: .oN,
                timeWorst: .oN,
                spaceWorst: .oN,
                summaryRU: "Вставка/удаление в известную позицию O(1). Доступ и поиск элемента требуют прохода O(n).",
                summaryEN: "Insertion/deletion at known node is O(1). Access and search require O(n) traversal.",
                bestCaseNotesRU: "Эффективен для очередей и частых вставок/удалений без индексации.",
                bestCaseNotesEN: "Efficient for queues and frequent unindexed insertions/removals."
            ),
            BigOItem(
                id: "ds_stack_queue",
                nameRU: "Стек и Очередь (Stack & Queue)",
                nameEN: "Stack & Queue (LIFO / FIFO)",
                isAlgorithm: false,
                timeAverage: .o1,
                timeWorst: .o1,
                spaceWorst: .oN,
                summaryRU: "Push/Pop в стеке и Enqueue/Dequeue в очереди выполняются за строгое O(1).",
                summaryEN: "Push/Pop in Stack and Enqueue/Dequeue in Queue operate in strict O(1).",
                bestCaseNotesRU: "Незаменимы для обхода графов (DFS/BFS), валидации скобок и истории вызовов.",
                bestCaseNotesEN: "Essential for graph traversals (DFS/BFS), parenthesis checks, and call stacks."
            ),
            BigOItem(
                id: "ds_hash_table",
                nameRU: "Хеш-таблица (Dictionary / HashMap)",
                nameEN: "Hash Table / Dictionary",
                isAlgorithm: false,
                timeAverage: .o1,
                timeWorst: .oN,
                spaceWorst: .oN,
                summaryRU: "Вставка, поиск и удаление по ключу в среднем O(1). При коллизиях в худшем случае деградирует до O(n).",
                summaryEN: "Key insertion, lookup, and deletion average O(1). Degrades to O(n) in worst-case collisions.",
                bestCaseNotesRU: "Основная структура данных для быстрого поиска и мемоизации кэша.",
                bestCaseNotesEN: "Core data structure for fast lookups and memoization caching."
            ),
            BigOItem(
                id: "ds_bst",
                nameRU: "Бинарное дерево поиска (BST)",
                nameEN: "Binary Search Tree (BST)",
                isAlgorithm: false,
                timeAverage: .oLogN,
                timeWorst: .oN,
                spaceWorst: .oN,
                summaryRU: "Поиск, вставка и удаление в сбалансированном дереве O(log n). При вырождении в список - O(n).",
                summaryEN: "Search, insert, and delete take O(log n) when balanced. Degrades to O(n) if unbalanced.",
                bestCaseNotesRU: "Хранит элементы в упорядоченном виде с поддержкой диапазонных запросов.",
                bestCaseNotesEN: "Maintains elements in sorted order with range query support."
            ),
            BigOItem(
                id: "ds_avl_rb_tree",
                nameRU: "Красно-чёрное / AVL-дерево",
                nameEN: "Red-Black / AVL Balanced Tree",
                isAlgorithm: false,
                timeAverage: .oLogN,
                timeWorst: .oLogN,
                spaceWorst: .oN,
                summaryRU: "Самобалансирующееся дерево. Гарантирует O(log n) для всех операций поиска и модификации даже в худшем случае.",
                summaryEN: "Self-balancing tree. Guarantees O(log n) for search and modifications even in worst case.",
                bestCaseNotesRU: "Лежит в основе std::map, C# SortedDictionary и файловых систем.",
                bestCaseNotesEN: "Underlies std::map, C# SortedDictionary, and database engines."
            ),
            BigOItem(
                id: "ds_heap",
                nameRU: "Куча / Приоритетная очередь (Heap)",
                nameEN: "Binary Heap / Priority Queue",
                isAlgorithm: false,
                timeAverage: .oLogN,
                timeWorst: .oLogN,
                spaceWorst: .oN,
                summaryRU: "Получение минимума/максимума за O(1). Вставка и извлечение корня за O(log n).",
                summaryEN: "Peak min/max in O(1). Insert and extract root in O(log n).",
                bestCaseNotesRU: "Идеально для алгоритма Дейкстры, поиска K-наибольших элементов и планировщиков задач.",
                bestCaseNotesEN: "Ideal for Dijkstra algorithm, Kth largest element, and job schedulers."
            ),
            BigOItem(
                id: "ds_trie",
                nameRU: "Префиксное дерево (Trie)",
                nameEN: "Prefix Tree (Trie)",
                isAlgorithm: false,
                timeAverage: .o1,
                timeWorst: .o1,
                spaceWorst: .oN,
                summaryRU: "Поиск и вставка слова зависят только от его длины K: O(K), не завися от размера словаря N.",
                summaryEN: "Lookup and insert depend only on word length K: O(K), independent of dictionary size N.",
                bestCaseNotesRU: "Используется для автодополнения (autocomplete), проверки орфографии и IP-маршрутизации.",
                bestCaseNotesEN: "Used for autocomplete, spell checkers, and IP routing tables."
            ),

            // Algorithms
            BigOItem(
                id: "algo_binary_search",
                nameRU: "Бинарный поиск (Binary Search)",
                nameEN: "Binary Search",
                isAlgorithm: true,
                timeAverage: .oLogN,
                timeWorst: .oLogN,
                spaceWorst: .o1,
                summaryRU: "Деление отсортированного пространства поиска пополам на каждом шаге. Требует упорядоченный массив.",
                summaryEN: "Halves the search space each step. Requires a sorted array.",
                bestCaseNotesRU: "Лучший случай O(1), если элемент находится ровно по центру.",
                bestCaseNotesEN: "Best case O(1) if target is at exact middle."
            ),
            BigOItem(
                id: "algo_quick_sort",
                nameRU: "Быстрая сортировка (Quick Sort)",
                nameEN: "Quick Sort",
                isAlgorithm: true,
                timeAverage: .oNLogN,
                timeWorst: .oN2,
                spaceWorst: .oLogN,
                summaryRU: "Разделяй и властвуй вокруг опорного элемента (pivot). Худший случай O(n²) при неудачном выборе pivot.",
                summaryEN: "Divide-and-conquer partitioning around pivot. Worst case O(n²) on poor pivot choice.",
                bestCaseNotesRU: "Практически самая быстрая сортировка на месте благодаря отличной локальности кэша.",
                bestCaseNotesEN: "Fastest in-place sort in practice due to superior cache locality."
            ),
            BigOItem(
                id: "algo_merge_sort",
                nameRU: "Сортировка слиянием (Merge Sort)",
                nameEN: "Merge Sort",
                isAlgorithm: true,
                timeAverage: .oNLogN,
                timeWorst: .oNLogN,
                spaceWorst: .oN,
                summaryRU: "Стабильная сортировка с гарантированным временем O(n log n) в любых условиях. Требует дополнительную память O(n).",
                summaryEN: "Stable sort guaranteeing O(n log n) in all cases. Requires auxiliary O(n) memory.",
                bestCaseNotesRU: "Идеальна для сортировки связных списков и внешней сортировки больших файлов на диске.",
                bestCaseNotesEN: "Ideal for linked lists and external disk sorting of massive datasets."
            ),
            BigOItem(
                id: "algo_heap_sort",
                nameRU: "Пирамидальная сортировка (Heap Sort)",
                nameEN: "Heap Sort",
                isAlgorithm: true,
                timeAverage: .oNLogN,
                timeWorst: .oNLogN,
                spaceWorst: .o1,
                summaryRU: "Построение двоичной кучи и последовательное извлечение максимума. Сортировка на месте без доп. памяти O(1).",
                summaryEN: "Build max-heap and repeatedly extract root. In-place sorting with O(1) extra space.",
                bestCaseNotesRU: "Гарантирует O(n log n) без риска деградации, как у QuickSort.",
                bestCaseNotesEN: "Guarantees O(n log n) without worst-case degradation risk."
            ),
            BigOItem(
                id: "algo_timsort",
                nameRU: "TimSort (Python & Swift sort)",
                nameEN: "TimSort (Hybrid Merge + Insertion)",
                isAlgorithm: true,
                timeAverage: .oNLogN,
                timeWorst: .oNLogN,
                spaceWorst: .oN,
                summaryRU: "Гибридный алгоритм, используемый по умолчанию в Python (sort) и Java. Находит уже отсортированные отрезки (runs).",
                summaryEN: "Hybrid adaptive sort used in Python and Java. Exploits pre-existing ordered runs.",
                bestCaseNotesRU: "На почти отсортированных данных работает за линейное время O(n)!",
                bestCaseNotesEN: "Runs in linear O(n) time on nearly sorted real-world data!"
            ),
            BigOItem(
                id: "algo_bubble_sort",
                nameRU: "Пузырьковая сортировка (Bubble Sort)",
                nameEN: "Bubble Sort",
                isAlgorithm: true,
                timeAverage: .oN2,
                timeWorst: .oN2,
                spaceWorst: .o1,
                summaryRU: "Попарное сравнение соседних элементов. Учебный алгоритм, непригодный для больших объёмов данных.",
                summaryEN: "Pairwise adjacent swapping. Educational algorithm, impractical for large datasets.",
                bestCaseNotesRU: "O(n), если массив уже отсортирован и используется флаг перестановок.",
                bestCaseNotesEN: "O(n) if already sorted with swap flag."
            )
        ]
        
        // MARK: - 2. Cross-Language Rosetta Comparisons
        self.rosettaComparisons = [
            RosettaComparison(
                id: "rosetta_vars",
                titleRU: "Объявление переменных и констант",
                titleEN: "Variables and Constants Declaration",
                categoryRU: "Основы синтаксиса",
                categoryEN: "Syntax Fundamentals",
                swiftCode: """
// Неизменяемая константа
let maxAttempts = 3
// Изменяемая переменная со строгой типизацией
var score: Int = 100
score += 10
""",
                pythonCode: """
# Константы по соглашению PEP 8 (UPPERCASE)
MAX_ATTEMPTS = 3
# Динамическая типизация (с опциональными type hints)
score: int = 100
score += 10
""",
                csharpCode: """
// Константа времени компиляции
const int MaxAttempts = 3;
// Неизменяемое поле только для чтения
readonly int timeout = 5000;
// Вывод типа с помощью var
var score = 100;
score += 10;
""",
                sqlCode: """
-- Временные переменные (в T-SQL / PL-pgSQL)
DECLARE @Score INT = 100;
SET @Score = @Score + 10;
-- Либо константы в SELECT:
SELECT 3 AS MaxAttempts, 110 AS Score;
""",
                explanationRU: "В Swift и C# строгая статическая типизация с выводом типов (type inference). Python использует динамическую типизацию с поддержкой type hints (PEP 484). В SQL переменные объявляются через DECLARE в процедурном коде.",
                explanationEN: "Swift and C# enforce strict static typing with type inference. Python employs dynamic typing with PEP 484 type hints. SQL variables are declared via DECLARE in procedural blocks."
            ),
            RosettaComparison(
                id: "rosetta_null_safety",
                titleRU: "Опционалы и обработка отсутствующих значений",
                titleEN: "Null Safety & Missing Values",
                categoryRU: "Типизация и Безопасность",
                categoryEN: "Type System & Safety",
                swiftCode: """
var username: String? = nil
// Nil-coalescing оператор
let display = username ?? "Гость"
// Опциональная привязка
if let name = username {
    print("Привет, \\(name)")
}
""",
                pythonCode: """
from typing import Optional

username: Optional[str] = None
# Логический оператор or или ternary
display = username if username is not None else "Гость"
if username is not None:
    print(f"Привет, {username}")
""",
                csharpCode: """
string? username = null;
// Null-coalescing оператор
string display = username ?? "Гость";
// Null-conditional и pattern matching
if (username is { } name) {
    Console.WriteLine($"Привет, {name}");
}
""",
                sqlCode: """
-- Значение NULL и проверка через COALESCE / IS NULL
SELECT 
    COALESCE(username, 'Гость') AS display_name
FROM users
WHERE username IS NOT NULL;
""",
                explanationRU: "Swift использует тип-обёртку Optional enum. C# с версии 8 поддерживает Nullable Reference Types (`string?`). В Python отсутствие значения представляется синглтоном `None`. В SQL используется тризначная логика `NULL` и функция `COALESCE`.",
                explanationEN: "Swift wraps optionals in an enum. C# 8+ uses Nullable Reference Types. Python relies on the None singleton. SQL employs three-valued logic and COALESCE."
            ),
            RosettaComparison(
                id: "rosetta_collections_transform",
                titleRU: "Функциональная обработка коллекций",
                titleEN: "Functional Collection Transformations",
                categoryRU: "Коллекции и LINQ",
                categoryEN: "Collections & Data Pipelines",
                swiftCode: """
let numbers = [1, 2, 3, 4, 5, 6]
// map, filter, reduce
let result = numbers
    .filter { $0 % 2 == 0 }
    .map { $0 * 10 }
    .reduce(0, +)
// result == 120
""",
                pythonCode: """
numbers = [1, 2, 3, 4, 5, 6]
# List comprehension (идиоматичный Python)
evens_times_10 = [x * 10 for x in numbers if x % 2 == 0]
result = sum(evens_times_10)
# result == 120
""",
                csharpCode: """
var numbers = new[] { 1, 2, 3, 4, 5, 6 };
// LINQ методы расширения
var result = numbers
    .Where(x => x % 2 == 0)
    .Select(x => x * 10)
    .Sum();
// result == 120
""",
                sqlCode: """
-- Фильтрация, трансформация и агрегация в реляционной модели
SELECT SUM(number * 10) AS result
FROM numbers_table
WHERE number % 2 = 0;
-- результат = 120
""",
                explanationRU: "Во всех четырех языках декларативные цепочки обработки аналогичны: filter -> map -> reduce в Swift, list comprehension в Python, Where -> Select -> Sum в C# LINQ, и WHERE -> expression -> SUM() в SQL.",
                explanationEN: "Declarative transformations share identical logic: filter/map/reduce in Swift, list comprehensions in Python, LINQ Where/Select/Sum in C#, and WHERE/expression/SUM() in SQL."
            ),
            RosettaComparison(
                id: "rosetta_concurrency",
                titleRU: "Асинхронность и многопоточность",
                titleEN: "Asynchronous Programming (async/await)",
                categoryRU: "Многопоточность",
                categoryEN: "Concurrency",
                swiftCode: """
func fetchUser(id: Int) async throws -> User {
    let url = URL(string: "https://api.dev/users/\\(id)")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(User.self, from: data)
}
""",
                pythonCode: """
import asyncio
import httpx

async def fetch_user(user_id: int) -> dict:
    async with httpx.AsyncClient() as client:
        response = await client.get(f"https://api.dev/users/{user_id}")
        return response.json()
""",
                csharpCode: """
public async Task<User> FetchUserAsync(int id) {
    using var client = new HttpClient();
    var response = await client.GetStringAsync($"https://api.dev/users/{id}");
    return JsonSerializer.Deserialize<User>(response)!;
}
""",
                sqlCode: """
-- Асинхронные пакетные задания / фоновые агенты (pg_cron / SQL Agent)
-- Запросы на чтение выполняются параллельно транзакциям с блокировками
SELECT * FROM users WHERE id = 42;
""",
                explanationRU: "Современные Swift, Python и C# используют синтаксис `async/await`. В Swift 6 потокобезопасность гарантируется на этапе компиляции акторами (Actors). В C# асинхронные методы компилируются в машину состояний (state machine).",
                explanationEN: "Swift, Python, and C# share async/await semantics. Swift 6 enforces compile-time safety via Actors. C# compiles async methods into state machines."
            ),
            RosettaComparison(
                id: "rosetta_classes_structs",
                titleRU: "Классы vs Структуры (Value vs Reference)",
                titleEN: "Classes vs Structs (Value vs Reference)",
                categoryRU: "ООП и Архитектура",
                categoryEN: "OOP & Memory Architecture",
                swiftCode: """
// Value Type (копирование при передаче)
struct Point {
    var x: Int
    var y: Int
}
// Reference Type (ссылочный тип, счетчик ARC)
class UserSession {
    var token: String
    init(token: String) { self.token = token }
}
""",
                pythonCode: """
# В Python все объекты являются ссылочными (Reference Types)
from dataclasses import dataclass

@dataclass
class Point:
    x: int
    y: int

class UserSession:
    def __init__(self, token: str):
        self.token = token
""",
                csharpCode: """
// Value Type на стеке
public struct Point {
    public int X { get; set; }
    public int Y { get; set; }
}
// Reference Type в управляемой куче
public class UserSession {
    public string Token { get; set; }
    public UserSession(string token) => Token = token;
}
""",
                sqlCode: """
-- В SQL реляционная модель:
-- Таблица как сущность (Class/Table)
CREATE TABLE user_sessions (
    user_id INT PRIMARY KEY,
    token TEXT NOT NULL
);
""",
                explanationRU: "В Swift и C# есть фундаментальное деление на Value Types (`struct`, живут на стеке) и Reference Types (`class`, куча). В Python все переменные являются ссылками на объекты в куче. В SQL моделируются нормализованные кортежи (строки).",
                explanationEN: "Swift and C# distinguish between Value Types (stack) and Reference Types (heap). In Python, every variable is a reference to a heap object."
            )
        ]
        
        // MARK: - 3. Top 50 Interview Questions & Answers
        self.interviewQuestions = [
            // --- SWIFT QUESTIONS ---
            InterviewQuestion(
                id: "swift_arc_retain_cycle",
                language: .swift,
                categoryRU: "Управление памятью",
                categoryEN: "Memory Management",
                questionRU: "Что такое ARC, Retain Cycle и как избежать утечек памяти?",
                questionEN: "What is ARC, Retain Cycles, and how to avoid memory leaks?",
                quickAnswerRU: "ARC (Automatic Reference Counting) автоматически освобождает память при счетчике ссылок 0. Retain Cycle возникает при циклической сильной связи двух объектов. Решается через `weak` или `unowned` ссылки.",
                quickAnswerEN: "ARC automatically deallocates memory when retain count hits 0. Retain cycles occur when objects hold strong references to each other. Fixed via weak or unowned.",
                detailedAnswerRU: """
### Механизм работы ARC
В Swift память под ссылочные типы (`class`) управляется подсчётом сильных ссылок. Когда создаётся сильная ссылка (`strong`), счётчик инкрементируется, при обнулении вызывается `deinit`.

### Как возникает Retain Cycle
Если Объект А держит сильную ссылку на Объект Б, а Объект Б держит ссылку на Объект А (или внутри замыкания `self` захвачен сильно), объекты никогда не освободятся.

### Решение
1. `weak` — ссылка всегда `Optional`, не увеличивает счётчик ссылок, автоматически зануляется (`nil`) при удалении объекта.
2. `unowned` — ссылка не является Optional, используется когда гарантировано, что объект живёт дольше или столько же.
3. В замыканиях: `[weak self] in guard let self else { return }`.
""",
                detailedAnswerEN: "ARC tracks strong references. Break cycles using `[weak self]` in closures or weak delegates.",
                codeSample: """
class Parent {
    var child: Child?
    deinit { print("Parent deallocated") }
}

class Child {
    weak var parent: Parent? // Предотвращает Retain Cycle
    deinit { print("Child deallocated") }
}
""",
                pitfallRU: "Использование unowned вместо weak, когда время жизни объекта может закончиться раньше — приводит к мгновенному крашу fatal error: Attempted to read dangling pointer.",
                pitfallEN: "Using unowned when the referenced object can be deallocated earlier crashes with a dangling pointer error."
            ),
            InterviewQuestion(
                id: "swift_value_vs_reference",
                language: .swift,
                categoryRU: "Архитектура типов",
                categoryEN: "Type Architecture",
                questionRU: "В чём разница между Value Types (struct, enum) и Reference Types (class)?",
                questionEN: "What is the difference between Value Types and Reference Types in Swift?",
                quickAnswerRU: "Value Types копируются при передаче (Copy semantics), размещаются на стеке и потокобезопасны. Reference Types передаются по ссылке, размещаются в куче (heap) и разделяют состояние.",
                quickAnswerEN: "Value types copy on write/pass, live on stack, thread-safe. Reference types share reference on heap.",
                detailedAnswerRU: """
### Value Types (struct, enum, Int, String, Array):
- Копируются при присваивании или передаче в функцию.
- Размещаются на быстром стеке (за исключением полей внутри классов).
- Встроенный механизм **Copy-on-Write (CoW)** для коллекций: реальное копирование происходит только в момент модификации данных.
- Не требуют блокировок для многопоточности, так как у каждого потока своя независимая копия.

### Reference Types (class, actor):
- Передаётся указатель на область памяти в куче (heap).
- Изменение поля через одну ссылку меняет данные для всех обладателей ссылки.
- Поддерживают наследование, полиморфизм и деинициализатор `deinit`.
""",
                detailedAnswerEN: "Value types offer immutability and stack speed. Reference types provide shared mutable identity.",
                codeSample: """
struct Point { var x: Int }
var p1 = Point(x: 10)
var p2 = p1 // Создаётся полная копия
p2.x = 20
print(p1.x) // 10 (не изменилось!)
""",
                pitfallRU: "Заблуждение, что классы всегда быстрее структур из-за отсутствия копирования. На самом деле накладные расходы на выделение памяти в heap и подсчёт ссылок ARC в разы медленнее работы стека.",
                pitfallEN: "Assuming classes are always faster than structs. Heap allocation and ARC atomic retain/release overhead is much slower than stack allocation."
            ),
            InterviewQuestion(
                id: "swift_actors_concurrency",
                language: .swift,
                categoryRU: "Многопоточность",
                categoryEN: "Concurrency",
                questionRU: "Что такое Actor в Swift Concurrency и как он защищает от Data Races?",
                questionEN: "What is an Actor in Swift Concurrency and how does it prevent Data Races?",
                quickAnswerRU: "Actor — это ссылочный тип, который автоматически изолирует своё внутреннее состояние. Доступ к его свойствам и методам извне возможен только асинхронно через `await`, что исключает гонки данных.",
                quickAnswerEN: "An Actor is a reference type with automatic state isolation. External calls require await, preventing data races.",
                detailedAnswerRU: """
### Проблема Data Race
Гонка данных происходит, когда два потока одновременно обращаются к одной ячейке памяти, и хотя бы один поток производит запись.

### Решение через Actor
Actor гарантирует **взаимное исключение (mutual exclusion)**: в любой момент времени только одна задача может выполнять код внутри актора.
- Внутри актора доступ синхронный.
- Извне актора доступ обязательно через ключевое слово `await` (точка потенциальной приостановки).
""",
                detailedAnswerEN: "Actors guarantee mutual exclusion for state access without explicit manual locks.",
                codeSample: """
actor BankAccount {
    private var balance: Int = 1000
    
    func withdraw(amount: Int) -> Bool {
        guard balance >= amount else { return false }
        balance -= amount
        return true
    }
}

// Вызов извне:
// let ok = await account.withdraw(amount: 500)
""",
                pitfallRU: "Забывать о возможности Reentrancy в акторах: между вызовами await состояние актора может измениться другой задачей.",
                pitfallEN: "Overlooking actor reentrancy: actor state may mutate between await suspension points."
            ),

            // --- PYTHON QUESTIONS ---
            InterviewQuestion(
                id: "py_gil_multithreading",
                language: .python,
                categoryRU: "Ядро языка",
                categoryEN: "Core Python",
                questionRU: "Что такое GIL (Global Interpreter Lock) и как обойти его ограничения?",
                questionEN: "What is GIL and how to bypass its concurrency limitations?",
                quickAnswerRU: "GIL — мьютекс в CPython, позволяющий только одному нативному потоку выполнять байткод Python в любой момент времени. Для CPU-bound задач используют multiprocessing, для I/O-bound — asyncio или потоки.",
                quickAnswerEN: "GIL is a CPython mutex allowing only one thread to execute Python bytecode at once. Use multiprocessing for CPU tasks and asyncio for I/O.",
                detailedAnswerRU: """
### Зачем нужен GIL
GIL упростил реализацию CPython, сделав управление памятью на основе счётчиков ссылок (reference counting) потокобезопасным без гранулярных блокировок на каждом объекте.

### Последствия
- В многопоточных CPU-bound программах (математические расчеты, сжатие видео) многопоточность не даёт ускорения на многоядерных процессорах.
- Для I/O-bound задач (сетевые запросы, чтение файлов) GIL автоматически освобождается во время ожидания системного вызова, поэтому `threading` и `asyncio` эффективны.

### Как обойти
1. Модуль `multiprocessing` (отдельные процессы со своими копиями памяти).
2. Вынос вычислений в C-расширения или библиотеки (NumPy, Cython), которые отпускают GIL.
3. Python 3.13+ экспериментальный режим без GIL (PEP 703).
""",
                detailedAnswerEN: "GIL synchronizes CPython memory management. Use multiprocessing or C extensions like NumPy for true parallelism.",
                codeSample: """
# Для параллельных CPU-вычислений:
from multiprocessing import Pool

def square(x):
    return x * x

if __name__ == '__main__':
    with Pool(4) as p:
        print(p.map(square, [1, 2, 3, 4]))
""",
                pitfallRU: "Пытаться ускорить тяжелые математические расчеты с помощью модуля threading в стандартном Python.",
                pitfallEN: "Using threading to speed up CPU-heavy mathematical computations in vanilla CPython."
            ),
            InterviewQuestion(
                id: "py_mutable_default_args",
                language: .python,
                categoryRU: "Идиомы Python",
                categoryEN: "Python Idioms",
                questionRU: "В чём опасность использования изменяемых (mutable) аргументов по умолчанию?",
                questionEN: "Why is using mutable default arguments dangerous in Python?",
                quickAnswerRU: "Значения аргументов по умолчанию вычисляются один раз в момент определения функции (def), а не при каждом её вызове. Изменяемый объект (список, словарь) будет общим для всех вызовов.",
                quickAnswerEN: "Default arguments are evaluated once at function definition time. A mutable object is shared across all invocations.",
                detailedAnswerRU: """
### Механика
Когда Python компилирует инструкцию `def`, он создаёт объект функции и сохраняет значения по умолчанию в кортеж `__defaults__`. Если аргумент — список `[]`, все вызовы будут модифицировать один и тот же список в памяти.

### Правильный паттерн
Использовать `None` в качестве значения по умолчанию и инициализировать новый список внутри функции.
""",
                detailedAnswerEN: "Use default value None and initialize the list inside the function body.",
                codeSample: """
# ОШИБКА:
def bad_append(item, lst=[]):
    lst.append(item)
    return lst

# ПРАВИЛЬНО:
def good_append(item, lst=None):
    if lst is None:
        lst = []
    lst.append(item)
    return lst
""",
                pitfallRU: "Использование `def register(user, tags=[]):` приводит к тому, что теги первого пользователя появятся у всех последующих.",
                pitfallEN: "Using `def register(user, tags=[]):` causes all subsequent users to inherit tags of the first user."
            ),

            // --- C# QUESTIONS ---
            InterviewQuestion(
                id: "cs_gc_generations",
                language: .csharp,
                categoryRU: "Управление памятью .NET",
                categoryEN: ".NET Memory & GC",
                questionRU: "Как устроен Сборщик Мусора (GC) в .NET и что такое поколения 0, 1, 2?",
                questionEN: "How does .NET Garbage Collector work and what are Generations 0, 1, and 2?",
                quickAnswerRU: "GC в .NET основан на гипотезе поколений: новые объекты умирают быстрее. Поколение 0 — короткоживущие объекты, Поколение 1 — буфер выживших, Поколение 2 — долгожители. Сборка Gen 0 проходит за миллисекунды.",
                quickAnswerEN: "GC relies on the generational hypothesis: newer objects die faster. Gen 0 is short-lived, Gen 1 is buffer, Gen 2 is long-lived.",
                detailedAnswerRU: """
### Поколения GC:
- **Поколение 0 (Gen 0)**: Сюда попадают все вновь создаваемые объекты (кроме больших). Сборка происходит чаще всего и занимает доли миллисекунд.
- **Поколение 1 (Gen 1)**: Буферная зона между новыми и старыми объектами. Выжившие при сборке Gen 0 объекты переходят в Gen 1.
- **Поколение 2 (Gen 2)**: Долгоживущие объекты (статические поля, синглтоны, кэши) и куча больших объектов (**LOH** — Large Object Heap для объектов >= 85 000 байт). Сборка Gen 2 называется Full GC и наиболее затратна.
""",
                detailedAnswerEN: "Gen 0 catches ephemeral allocations, Gen 1 acts as a buffer, Gen 2 holds durable state and Large Object Heap.",
                codeSample: """
// Проверка поколения объекта
var obj = new object();
Console.WriteLine(GC.GetGeneration(obj)); // 0

GC.Collect(0); // Сборка только нулевого поколения
Console.WriteLine(GC.GetGeneration(obj)); // 1
""",
                pitfallRU: "Чрезмерное ручное вызывание `GC.Collect()`. Сборщик мусора .NET самонастраивающийся, принудительный сбор сбивает эвристики и блокирует потоки.",
                pitfallEN: "Calling GC.Collect() manually in high-throughput loops disrupts the self-tuning GC heuristics."
            ),
            InterviewQuestion(
                id: "cs_linq_deferred_execution",
                language: .csharp,
                categoryRU: "LINQ",
                categoryEN: "LINQ & Collections",
                questionRU: "Что такое отложенное выполнение (Deferred Execution) в LINQ?",
                questionEN: "What is Deferred Execution in LINQ?",
                quickAnswerRU: "Запрос LINQ не выполняется в момент объявления. Вычисление происходит только тогда, когда коллекция итерируется через `foreach` или вызываются жадные операторы (`ToList()`, `ToArray()`, `Count()`).",
                quickAnswerEN: "LINQ queries evaluate lazily when iterated via foreach or materialized with ToList(), ToArray(), or Count().",
                detailedAnswerRU: """
### Механизм
Операторы `Where`, `Select`, `Take` возвращают объект `IEnumerable<T>`, который хранит логику конвейера (делегаты), но не выполняет фильтрацию сразу.

### Преимущества
1. Экономия ресурсов: если взять `.Take(5)`, вычислятся только первые 5 элементов.
2. Актуальность данных: запрос обращается к исходной коллекции в момент итерации, а не в момент создания запроса.

### Немедленные (Eager) операторы
`ToList()`, `ToArray()`, `ToDictionary()`, `First()`, `Count()`, `Sum()`.
""",
                detailedAnswerEN: "IEnumerable pipeline executes on demand. Use ToList() to prevent repeated multiple enumerations.",
                codeSample: """
var numbers = new List<int> { 1, 2, 3 };
var query = numbers.Where(n => n > 1); // Запрос объявлен, но не выполнен

numbers.Add(4);

// Итерация происходит сейчас: 4 включена в результат!
foreach (var n in query) {
    Console.WriteLine(n); // 2, 3, 4
}
""",
                pitfallRU: "Многократное перечисление (Multiple Enumeration): выполнение тяжелого LINQ-запроса повторно при каждом обращении к `query.Count()` и `foreach (var x in query)`. Решение — один раз вызвать `.ToList()`.",
                pitfallEN: "Multiple enumeration trap: iterating an unmemoized LINQ query repeatedly executes database queries or allocations multiple times."
            ),

            // --- SQL QUESTIONS ---
            InterviewQuestion(
                id: "sql_acid_transactions",
                language: .sql,
                categoryRU: "Транзакции и Базы данных",
                categoryEN: "Database Transactions",
                questionRU: "Что означает аббревиатура ACID в реляционных базах данных?",
                questionEN: "What does ACID stand for in relational databases?",
                quickAnswerRU: "ACID — гарантии надежности транзакций: Atomicity (Атомарность — всё или ничего), Consistency (Согласованность — соблюдение правил), Isolation (Изолированность — параллельные транзакции не мешают), Durability (Надежность — фиксация на диске).",
                quickAnswerEN: "Atomicity (all or nothing), Consistency (schema rules valid), Isolation (transactions isolated), Durability (persisted on disk).",
                detailedAnswerRU: """
### 4 столпа ACID:
1. **Atomicity (Атомарность)**: Транзакция неделима. Если хотя бы один запрос падает, выполняется полный откат (`ROLLBACK`).
2. **Consistency (Согласованность)**: База переходит из одного валидного состояния в другое, соблюдая все внешние ключи, уникальные индексы и ограничения `CHECK`.
3. **Isolation (Изолированность)**: Параллельные транзакции выполняются так, будто они идут последовательно. Уровни: Read Uncommitted, Read Committed, Repeatable Read, Serializable.
4. **Durability (Надежность/Стойкость)**: После `COMMIT` изменения гарантированно сохранены в журнале предзаписи (WAL) и не пропадут даже при внезапном сбое питания.
""",
                detailedAnswerEN: "ACID guarantees data integrity across transaction crashes and concurrent client queries.",
                codeSample: """
BEGIN TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
-- Если обе операции успешны:
COMMIT;
-- В случае ошибки:
-- ROLLBACK;
""",
                pitfallRU: "Путать Атомарность и Согласованность. Атомарность отвечает за откат незавершенных шагов, а Согласованность — за соблюдение бизнес-правил и целостности схемы.",
                pitfallEN: "Confusing Atomicity with Consistency. Atomicity handles rollback; Consistency ensures constraint adherence."
            ),
            InterviewQuestion(
                id: "sql_where_vs_having",
                language: .sql,
                categoryRU: "Запросы и Оптимизация",
                categoryEN: "Query Optimization",
                questionRU: "В чём принципиальное различие между WHERE и HAVING?",
                questionEN: "What is the key difference between WHERE and HAVING in SQL?",
                quickAnswerRU: "WHERE фильтрует отдельные строки ДО группировки (не может содержать агрегатные функции). HAVING фильтрует группы ПОСЛЕ выполнения GROUP BY и работает с агрегатами (COUNT, SUM, AVG).",
                quickAnswerEN: "WHERE filters rows before aggregation. HAVING filters grouped rows after GROUP BY and evaluates aggregate expressions.",
                detailedAnswerRU: """
### Порядок выполнения SQL запроса:
1. `FROM` & `JOIN` (соединение таблиц)
2. `WHERE` (фильтрация исходных строк — используются индексы!)
3. `GROUP BY` (группировка строк по ключам)
4. `HAVING` (фильтрация уже сгруппированных наборов)
5. `SELECT` (проекция колонок)
6. `ORDER BY` (сортировка)
7. `LIMIT` / `OFFSET` (пагинация)
""",
                detailedAnswerEN: "WHERE executes before GROUP BY; HAVING executes after GROUP BY on aggregated buckets.",
                codeSample: """
SELECT department_id, COUNT(*) AS emp_count
FROM employees
WHERE salary > 30000          -- Фильтрация строк ДО агрегации
GROUP BY department_id
HAVING COUNT(*) >= 5          -- Фильтрация групп ПОСЛЕ агрегации
ORDER BY emp_count DESC;
""",
                pitfallRU: "Помещение простых фильтров колонок в `HAVING` вместо `WHERE` — это лишает СУБД возможности использовать индексы и сильно замедляет запрос.",
                pitfallEN: "Placing plain row filters into HAVING instead of WHERE prevents index scans and causes full table scans."
            )
        ]
    }
}
