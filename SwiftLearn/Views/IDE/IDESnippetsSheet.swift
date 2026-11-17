import SwiftUI

public struct CodeSnippetItem: Identifiable {
    public let id = UUID()
    public let title: String
    public let descriptionText: String
    public let language: TargetLanguage
    public let category: String
    public let code: String
}

public struct IDESnippetsSheet: View {
    @ObservedObject var lang = LanguageManager.shared
    @Environment(\.dismiss) private var dismiss
    
    public let language: TargetLanguage
    public var onInsert: (String) -> Void
    
    @State private var searchText: String = ""
    @State private var selectedCategory: String = "All"
    
    public init(language: TargetLanguage, onInsert: @escaping (String) -> Void) {
        self.language = language
        self.onInsert = onInsert
    }
    
    private var allSnippets: [CodeSnippetItem] {
        switch language {
        case .swift:
            return [
                CodeSnippetItem(
                    title: "Async Task & MainActor",
                    descriptionText: "Фоновая асинхронная задача с возвратом на главный поток",
                    language: .swift,
                    category: "Concurrency",
                    code: """
Task {
    // Выполнение на фоне
    let result = await performBackgroundWork()
    
    await MainActor.run {
        // Обновление UI
        print("Completed with:", result)
    }
}
"""
                ),
                CodeSnippetItem(
                    title: "Codable JSON Decoding",
                    descriptionText: "Декодирование структуры из формата JSON",
                    language: .swift,
                    category: "Data",
                    code: """
struct ApiResponse: Codable {
    let id: Int
    let title: String
    let status: String
}

func parsePayload(_ data: Data) throws -> ApiResponse {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return try decoder.decode(ApiResponse.self, from: data)
}
"""
                ),
                CodeSnippetItem(
                    title: "Observable ViewModel",
                    descriptionText: "Модель представления для архитектуры SwiftUI",
                    language: .swift,
                    category: "Architecture",
                    code: """
final class FeatureViewModel: ObservableObject {
    @Published var items: [String] = []
    @Published var isLoading: Bool = false
    
    func loadData() {
        isLoading = true
        // Business logic here
        items.append("Item \\(items.count + 1)")
        isLoading = false
    }
}
"""
                ),
                CodeSnippetItem(
                    title: "Custom LocalizedError",
                    descriptionText: "Перечисление пользовательских ошибок приложения",
                    language: .swift,
                    category: "Architecture",
                    code: """
enum AppError: LocalizedError {
    case notFound
    case unauthorized
    case serverError(code: Int)
    
    var errorDescription: String? {
        switch self {
        case .notFound: return "Запрашиваемый ресурс не найден."
        case .unauthorized: return "Требуется авторизация."
        case .serverError(let code): return "Ошибка сервера: HTTP \\(code)"
        }
    }
}
"""
                ),
                CodeSnippetItem(
                    title: "Generic Stack Data Structure",
                    descriptionText: "Универсальная структура данных LIFO",
                    language: .swift,
                    category: "Algorithms",
                    code: """
struct Stack<T> {
    private var storage: [T] = []
    
    var isEmpty: Bool { storage.isEmpty }
    var count: Int { storage.count }
    
    mutating func push(_ item: T) { storage.append(item) }
    mutating func pop() -> T? { storage.popLast() }
    func peek() -> T? { storage.last }
}
"""
                )
            ]
            
        case .python:
            return [
                CodeSnippetItem(
                    title: "List & Dict Comprehensions",
                    descriptionText: "Идиоматическая генерация списков и словарей",
                    language: .python,
                    category: "Idioms",
                    code: """
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
even_squares = [x**2 for x in numbers if x % 2 == 0]
lookup_dict = {f"item_{x}": x**2 for x in numbers}

print("Squares:", even_squares)
print("Lookup:", lookup_dict)
"""
                ),
                CodeSnippetItem(
                    title: "Custom Function Decorator",
                    descriptionText: "Декоратор для замера времени выполнения функции",
                    language: .python,
                    category: "Patterns",
                    code: """
import time

def timer_decorator(func):
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        duration = time.time() - start
        print(f"[{func.__name__}] Executed in {duration:.4f}s")
        return result
    return wrapper

@timer_decorator
def heavy_computation():
    return sum(i * i for i in range(10000))
"""
                ),
                CodeSnippetItem(
                    title: "Context Manager with Statement",
                    descriptionText: "Безопасное управление ресурсами и блокировками",
                    language: .python,
                    category: "Idioms",
                    code: """
class ResourceScope:
    def __enter__(self):
        print("Resource acquired.")
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        print("Resource safely released.")
        return False

with ResourceScope():
    print("Working inside resource context...")
"""
                ),
                CodeSnippetItem(
                    title: "Binary Search Algorithm",
                    descriptionText: "Классический бинарный поиск за O(log n)",
                    language: .python,
                    category: "Algorithms",
                    code: """
def binary_search(arr, target):
    left, right = 0, len(arr) - 1
    while left <= right:
        mid = (left + right) // 2
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    return -1
"""
                )
            ]
            
        case .csharp:
            return [
                CodeSnippetItem(
                    title: "LINQ Filtering & Aggregation",
                    descriptionText: "Функциональные запросы LINQ с Where, Select и GroupBy",
                    language: .csharp,
                    category: "LINQ",
                    code: """
using System;
using System.Linq;
using System.Collections.Generic;

var numbers = new List<int> { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

var evenSquares = numbers
    .Where(n => n % 2 == 0)
    .Select(n => n * n)
    .ToList();

Console.WriteLine($"Even Squares: {string.Join(", ", evenSquares)}");
"""
                ),
                CodeSnippetItem(
                    title: "Record Struct & Immutability",
                    descriptionText: "Немутабельная модель данных с Value-семантикой",
                    language: .csharp,
                    category: "Architecture",
                    code: """
public record User(int Id, string Name, string Role);

var user1 = new User(1, "Alex", "Admin");
var user2 = user1 with { Name = "Dmitry" };

Console.WriteLine($"User1: {user1}");
Console.WriteLine($"User2: {user2}");
"""
                ),
                CodeSnippetItem(
                    title: "Async Task with Cancellation",
                    descriptionText: "Асинхронный метод с поддержкой Task и CancellationToken",
                    language: .csharp,
                    category: "Concurrency",
                    code: """
using System.Threading;
using System.Threading.Tasks;

public async Task<int> FetchDataAsync(CancellationToken ct = default)
{
    await Task.Delay(100, ct);
    return 42;
}
"""
                ),
                CodeSnippetItem(
                    title: "Pattern Matching Switch",
                    descriptionText: "Сопоставление с образцом по типам и свойствам",
                    language: .csharp,
                    category: "Idioms",
                    code: """
public static string DescribeNumber(object value) => value switch
{
    int n when n < 0 => "Negative Integer",
    int n when n == 0 => "Zero",
    int n => $"Positive Integer: {n}",
    double d => $"Floating point: {d:F2}",
    null => "Null value",
    _ => "Unknown type"
};
"""
                )
            ]
            
        case .sql:
            return [
                CodeSnippetItem(
                    title: "CREATE TABLE with Foreign Keys",
                    descriptionText: "Создание нормализованной таблицы с первичным и внешним ключом",
                    language: .sql,
                    category: "DDL",
                    code: """
CREATE TABLE departments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE employees (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    department_id INTEGER,
    salary REAL DEFAULT 0.0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);
"""
                ),
                CodeSnippetItem(
                    title: "Common Table Expression (CTE)",
                    descriptionText: "Именованное временное выражение WITH для читаемости",
                    language: .sql,
                    category: "Queries",
                    code: """
WITH HighEarners AS (
    SELECT name, department_id, salary
    FROM employees
    WHERE salary > 50000
)
SELECT d.name AS dept_name, COUNT(h.name) AS count_high_earners
FROM departments d
LEFT JOIN HighEarners h ON d.id = h.department_id
GROUP BY d.name;
"""
                ),
                CodeSnippetItem(
                    title: "Window Function (ROW_NUMBER)",
                    descriptionText: "Аналитическое ранжирование строк внутри секций",
                    language: .sql,
                    category: "Analytics",
                    code: """
SELECT 
    name, 
    department_id, 
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank_in_dept
FROM employees;
"""
                ),
                CodeSnippetItem(
                    title: "HAVING & Aggregate Filters",
                    descriptionText: "Группировка с фильтрацией агрегатных значений",
                    language: .sql,
                    category: "Queries",
                    code: """
SELECT department_id, COUNT(*) AS emp_count, AVG(salary) AS avg_sal
FROM employees
GROUP BY department_id
HAVING COUNT(*) >= 2 AND AVG(salary) > 40000;
"""
                )
            ]
        }
    }
    
    private var categories: [String] {
        var set = Set<String>()
        for s in allSnippets { set.insert(s.category) }
        return ["All"] + set.sorted()
    }
    
    private var filteredSnippets: [CodeSnippetItem] {
        allSnippets.filter { item in
            let matchCat = selectedCategory == "All" || item.category == selectedCategory
            let matchSearch = searchText.isEmpty ||
                item.title.localizedCaseInsensitiveContains(searchText) ||
                item.descriptionText.localizedCaseInsensitiveContains(searchText)
            return matchCat && matchSearch
        }
    }
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Category Picker
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(categories, id: \.self) { cat in
                            Button {
                                selectedCategory = cat
                            } label: {
                                Text(cat == "All" ? lang.localized("Все", "All") : cat)
                                    .font(.caption.bold())
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(selectedCategory == cat ? Color(red: 0.14, green: 0.38, blue: 0.82) : Color(UIColor.tertiarySystemBackground))
                                    .foregroundColor(selectedCategory == cat ? .white : .primary)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .background(Color(UIColor.secondarySystemBackground))
                
                Divider()
                
                // Snippets List
                List {
                    ForEach(filteredSnippets) { snippet in
                        snippetCard(snippet)
                    }
                }
                .searchable(text: $searchText, prompt: lang.localized("Поиск сниппетов...", "Search snippets..."))
            }
            .navigationTitle(lang.localized("Сниппеты (\(language.displayName))", "Snippets (\(language.displayName))"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(lang.localized("Закрыть", "Close")) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func snippetCard(_ snippet: CodeSnippetItem) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(snippet.title)
                        .font(.headline)
                    Text(snippet.descriptionText)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Text(snippet.category)
                    .font(.system(size: 9, weight: .bold))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.secondary.opacity(0.12))
                    .clipShape(Capsule())
            }
            
            // Code block preview
            Text(snippet.code)
                .font(.system(size: 11, design: .monospaced))
                .foregroundColor(.primary)
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.tertiarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 6))
            
            // Actions
            HStack(spacing: 12) {
                Button {
                    UIPasteboard.general.string = snippet.code
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                } label: {
                    Label(lang.localized("Скопировать", "Copy"), systemImage: "doc.on.doc")
                        .font(.caption.bold())
                }
                
                Spacer()
                
                Button {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    onInsert(snippet.code)
                    dismiss()
                } label: {
                    Label(lang.localized("Вставить в файл", "Insert into File"), systemImage: "arrow.down.doc")
                        .font(.caption.bold())
                        .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                }
            }
            .padding(.top, 4)
        }
        .padding(.vertical, 6)
    }
}
