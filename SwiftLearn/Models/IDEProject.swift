import Foundation

public struct IDEFile: Identifiable, Codable, Equatable, Hashable {
    public var id: UUID
    public var name: String
    public var content: String
    public var updatedAt: Date
    
    public init(id: UUID = UUID(), name: String, content: String, updatedAt: Date = Date()) {
        self.id = id
        self.name = name
        self.content = content
        self.updatedAt = updatedAt
    }
}

public struct IDEProject: Identifiable, Codable, Equatable {
    public var id: UUID
    public var name: String
    public var descriptionText: String
    public var language: TargetLanguage
    public var files: [IDEFile]
    public var activeFileId: UUID
    public var createdAt: Date
    public var updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id, name, descriptionText, language, files, activeFileId, createdAt, updatedAt
    }
    
    public init(
        id: UUID = UUID(),
        name: String,
        descriptionText: String,
        language: TargetLanguage = .swift,
        files: [IDEFile],
        activeFileId: UUID? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.descriptionText = descriptionText
        self.language = language
        self.files = files
        self.activeFileId = activeFileId ?? files.first?.id ?? UUID()
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.descriptionText = try container.decode(String.self, forKey: .descriptionText)
        self.language = (try? container.decode(TargetLanguage.self, forKey: .language)) ?? .swift
        self.files = try container.decode([IDEFile].self, forKey: .files)
        self.activeFileId = try container.decode(UUID.self, forKey: .activeFileId)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(descriptionText, forKey: .descriptionText)
        try container.encode(language, forKey: .language)
        try container.encode(files, forKey: .files)
        try container.encode(activeFileId, forKey: .activeFileId)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
    
    public var activeFile: IDEFile? {
        files.first(where: { $0.id == activeFileId }) ?? files.first
    }
    
    public mutating func updateFileContent(id: UUID, newContent: String) {
        if let idx = files.firstIndex(where: { $0.id == id }) {
            files[idx].content = newContent
            files[idx].updatedAt = Date()
            self.updatedAt = Date()
        }
    }
    
    public mutating func addFile(name: String, initialContent: String = "") -> IDEFile {
        var cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if !cleanName.contains(".") {
            cleanName += ".\(language.fileExtension)"
        }
        let newFile = IDEFile(name: cleanName, content: initialContent)
        files.append(newFile)
        activeFileId = newFile.id
        updatedAt = Date()
        return newFile
    }
    
    public mutating func removeFile(id: UUID) {
        guard files.count > 1 else { return } // Keep at least one file
        files.removeAll(where: { $0.id == id })
        if activeFileId == id {
            activeFileId = files.first?.id ?? UUID()
        }
        updatedAt = Date()
    }
    
    // Combines all project files for the offline execution engine.
    public func combinedCodeForExecution() -> String {
        switch language {
        case .swift:
            let entryFile = files.first(where: { $0.name.lowercased() == "main.swift" }) 
                ?? files.first(where: { $0.name.lowercased().contains("app") }) 
                ?? files.first
            let otherFiles = files.filter { $0.id != entryFile?.id }
            var combined = "// === Multi-File Swift Project Build ===\n"
            for file in otherFiles {
                combined += "\n// --- [File: \(file.name)] ---\n"
                combined += file.content + "\n"
            }
            if let entry = entryFile {
                combined += "\n// --- [Entrypoint: \(entry.name)] ---\n"
                combined += entry.content + "\n"
            }
            return combined

        case .python:
            let entryFile = files.first(where: { $0.name.lowercased() == "main.py" }) 
                ?? files.first(where: { $0.name.lowercased() == "app.py" }) 
                ?? files.first
            let otherFiles = files.filter { $0.id != entryFile?.id }
            var combined = "# === Multi-File Python Project Build ===\n"
            for file in otherFiles {
                combined += "\n# --- [Module: \(file.name)] ---\n"
                combined += file.content + "\n"
            }
            if let entry = entryFile {
                combined += "\n# --- [Entrypoint: \(entry.name)] ---\n"
                combined += entry.content + "\n"
            }
            return combined

        case .csharp:
            let entryFile = files.first(where: { $0.name.lowercased() == "program.cs" }) 
                ?? files.first(where: { $0.name.lowercased() == "main.cs" }) 
                ?? files.first
            let otherFiles = files.filter { $0.id != entryFile?.id }
            var combined = "// === Multi-File C# Project Build ===\n"
            for file in otherFiles {
                combined += "\n// --- [Class: \(file.name)] ---\n"
                combined += file.content + "\n"
            }
            if let entry = entryFile {
                combined += "\n// --- [Entrypoint: \(entry.name)] ---\n"
                combined += entry.content + "\n"
            }
            return combined

        case .sql:
            var combined = "-- === Multi-File SQL Project Execution ===\n"
            let sortedFiles = files.sorted { f1, f2 in
                let f1IsSchema = f1.name.lowercased().contains("schema") || f1.name.lowercased().contains("table")
                let f2IsSchema = f2.name.lowercased().contains("schema") || f2.name.lowercased().contains("table")
                if f1IsSchema && !f2IsSchema { return true }
                return false
            }
            for file in sortedFiles {
                combined += "\n-- --- [Script: \(file.name)] ---\n"
                combined += file.content + "\n"
            }
            return combined
        }
    }
    
    // MARK: - Built-in Templates
    public static var defaultTemplates: [IDEProject] {
        [
            // MARK: Swift Templates
            IDEProject(
                name: "SwiftUI Dashboard",
                descriptionText: "Архитектура современного приложения SwiftUI с моделью данных и компонентами",
                language: .swift,
                files: [
                    IDEFile(
                        name: "ContentView.swift",
                        content: """
import SwiftUI

struct MetricItem: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let change: String
    let isPositive: Bool
}

struct DashboardView: View {
    @State private var metrics: [MetricItem] = [
        MetricItem(title: "Active Users", value: "24,850", change: "+12.4%", isPositive: true),
        MetricItem(title: "Latency (ms)", value: "38ms", change: "-8.1%", isPositive: true),
        MetricItem(title: "Memory (MB)", value: "142 MB", change: "+2.0%", isPositive: false)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("System Monitor")
                .font(.title2.bold())
            
            ForEach(metrics) { metric in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(metric.title)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(metric.value)
                            .font(.headline.monospaced())
                    }
                    Spacer()
                    Text(metric.change)
                        .font(.subheadline.bold())
                        .foregroundColor(metric.isPositive ? .green : .red)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            }
        }
        .padding()
    }
}

// Запуск симуляции экрана
print("Инициализация SwiftUI Dashboard...")
print("Загружено метрик системы: 3")
print("Статус рендеринга: Ready")
"""
                    ),
                    IDEFile(
                        name: "MetricsService.swift",
                        content: """
import Foundation

struct MetricsService {
    static func calculateHealthScore(latencyMs: Double, memoryMB: Double) -> Int {
        var score = 100
        if latencyMs > 50 { score -= 15 }
        if memoryMB > 200 { score -= 25 }
        return max(0, score)
    }
}
"""
                    )
                ]
            ),
            IDEProject(
                name: "Algorithms & Stack",
                descriptionText: "Реализация универсального стека, очереди и алгоритмов поиска на Swift",
                language: .swift,
                files: [
                    IDEFile(
                        name: "Stack.swift",
                        content: """
// Generic LIFO Data Structure
struct Stack<Element> {
    private var storage: [Element] = []
    
    var isEmpty: Bool {
        storage.isEmpty
    }
    
    var count: Int {
        storage.count
    }
    
    mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    mutating func pop() -> Element? {
        storage.popLast()
    }
    
    func peek() -> Element? {
        storage.last
    }
}
"""
                    ),
                    IDEFile(
                        name: "main.swift",
                        content: """
// Тестирование структуры данных Stack
var stack = Stack<Int>()
print("Стек пуст?", stack.isEmpty)

for i in [10, 20, 30, 40] {
    stack.push(i)
    print("Push:", i, "| Всего элементов:", stack.count)
}

print("Верхний элемент (peek):", stack.peek() ?? -1)

while !stack.isEmpty {
    if let item = stack.pop() {
        print("Pop:", item)
    }
}

print("Финальный размер стека:", stack.count)
"""
                    )
                ]
            ),
            IDEProject(
                name: "Console Script",
                descriptionText: "Чистый Swift проект для тестирования логики и алгоритмов",
                language: .swift,
                files: [
                    IDEFile(
                        name: "main.swift",
                        content: """
// SwiftLearn Mobile IDE Project
import Foundation

func computeStatistics(numbers: [Double]) -> (mean: Double, max: Double, min: Double) {
    guard !numbers.isEmpty else { return (0, 0, 0) }
    let sum = numbers.reduce(0, +)
    let mean = sum / Double(numbers.count)
    let maxVal = numbers.max() ?? 0
    let minVal = numbers.min() ?? 0
    return (mean, maxVal, minVal)
}

let sampleData: [Double] = [14.2, 88.5, 34.0, 99.1, 5.4, 62.7]
let stats = computeStatistics(numbers: sampleData)

print("Размер выборки:", sampleData.count)
print("Среднее значение:", String(format: "%.2f", stats.mean))
print("Максимальный элемент:", stats.max)
print("Минимальный элемент:", stats.min)
"""
                    )
                ]
            ),

            // MARK: Python Templates
            IDEProject(
                name: "Python Data Analytics",
                descriptionText: "Модульный Python проект: статистический анализ числовых рядов и выборок",
                language: .python,
                files: [
                    IDEFile(
                        name: "stats.py",
                        content: """
# stats.py - Вспомогательный модуль аналитики
def calculate_mean(data):
    if len(data) == 0:
        return 0
    total = sum(data)
    return total / len(data)

def find_outliers(data, threshold):
    outliers = []
    for x in data:
        if x > threshold:
            outliers.append(x)
    return outliers
"""
                    ),
                    IDEFile(
                        name: "main.py",
                        content: """
# main.py - Точка входа аналитического конвейера
from stats import calculate_mean, find_outliers

sensor_readings = [21.5, 22.0, 21.8, 48.9, 22.1, 55.4, 21.9]

mean_val = calculate_mean(sensor_readings)
anomalies = find_outliers(sensor_readings, 40.0)

print("Размер выборки данных:", len(sensor_readings))
print("Среднее значение датчиков:", mean_val)
print("Обнаружено аномальных выбросов:", len(anomalies))
print("Список аномалий:", anomalies)
"""
                    )
                ]
            ),
            IDEProject(
                name: "Python OOP Banking",
                descriptionText: "Объектно-ориентированная банковская модель: аккаунты, балансы и транзакции",
                language: .python,
                files: [
                    IDEFile(
                        name: "account.py",
                        content: """
# account.py - Класс банковского счета
class BankAccount:
    def __init__(self, owner, initial_balance):
        self.owner = owner
        self.balance = initial_balance
    
    def deposit(self, amount):
        if amount > 0:
            self.balance = self.balance + amount
            print("Пополнение счета:", self.owner, "+", amount)
    
    def withdraw(self, amount):
        if amount <= self.balance:
            self.balance = self.balance - amount
            print("Списание со счета:", self.owner, "-", amount)
            return True
        else:
            print("Ошибка: Недостаточно средств для", self.owner)
            return False
"""
                    ),
                    IDEFile(
                        name: "main.py",
                        content: """
# main.py - Клиентский код банковской системы
from account import BankAccount

acc1 = BankAccount("Алексей", 10000)
acc2 = BankAccount("Мария", 5000)

print("Начальный баланс Алексея:", acc1.balance)
print("Начальный баланс Марии:", acc2.balance)

# Перевод средств
transfer_amount = 3500
if acc1.withdraw(transfer_amount):
    acc2.deposit(transfer_amount)

print("--- Итоговый отчет ---")
print("Баланс Алексея:", acc1.balance)
print("Баланс Марии:", acc2.balance)
"""
                    )
                ]
            ),
            IDEProject(
                name: "Python Quick Script",
                descriptionText: "Легкий скрипт на Python 3.12 для тестирования алгоритмов и списков",
                language: .python,
                files: [
                    IDEFile(
                        name: "main.py",
                        content: """
# Python Script Playground
print("Запуск скрипта Python 3.12...")

numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
squares = [x * x for x in numbers if x % 2 == 0]

print("Исходный список:", numbers)
print("Квадраты четных чисел:", squares)
print("Сумма квадратов:", sum(squares))
"""
                    )
                ]
            ),

            // MARK: C# Templates
            IDEProject(
                name: "C# .NET Console App",
                descriptionText: "Архитектура приложения .NET 8 / C# 12 с классами и Top-level statements",
                language: .csharp,
                files: [
                    IDEFile(
                        name: "Calculator.cs",
                        content: """
// Calculator.cs
using System;

public class Calculator
{
    public static double Add(double a, double b) => a + b;
    public static double Multiply(double a, double b) => a * b;
    
    public static double Power(double baseVal, int exp)
    {
        double result = 1.0;
        for (int i = 0; i < exp; i++)
        {
            result *= baseVal;
        }
        return result;
    }
}
"""
                    ),
                    IDEFile(
                        name: "Program.cs",
                        content: """
// Program.cs - C# 12 Top-Level Statements
using System;

Console.WriteLine(".NET 8 Runtime Initialized");

double a = 12.5;
double b = 4.0;

double sum = Calculator.Add(a, b);
double product = Calculator.Multiply(a, b);
double pow = Calculator.Power(2.0, 8);

Console.WriteLine($"Сложение ({a} + {b}) = {sum}");
Console.WriteLine($"Умножение ({a} * {b}) = {product}");
Console.WriteLine($"Возведение 2^8 = {pow}");
"""
                    )
                ]
            ),
            IDEProject(
                name: "C# OOP Inventory",
                descriptionText: "Учет товаров на C#: Records, списки List<T> и расчет стоимости склада",
                language: .csharp,
                files: [
                    IDEFile(
                        name: "Product.cs",
                        content: """
// Product.cs
public class Product
{
    public int Id { get; set; }
    public string Name { get; set; }
    public double Price { get; set; }
    public int Stock { get; set; }

    public Product(int id, string name, double price, int stock)
    {
        Id = id;
        Name = name;
        Price = price;
        Stock = stock;
    }

    public double TotalValue => Price * Stock;
}
"""
                    ),
                    IDEFile(
                        name: "Program.cs",
                        content: """
// Program.cs
using System;
using System.Collections.Generic;

Console.WriteLine("=== Складской Учет .NET ===");

var items = new List<Product>
{
    new Product(1, "Клавиатура Pro", 4500.0, 10),
    new Product(2, "Мышь Master", 2800.0, 25),
    new Product(3, "Монитор 4K", 32000.0, 4)
};

double grandTotal = 0;
foreach (var item in items)
{
    Console.WriteLine($"Товар: {item.Name} | В наличии: {item.Stock} | Стоимость: {item.TotalValue}");
    grandTotal += item.TotalValue;
}

Console.WriteLine($"Общая стоимость складских запасов: {grandTotal} руб.");
"""
                    )
                ]
            ),
            IDEProject(
                name: "C# LINQ Pipeline",
                descriptionText: "Обработка коллекций через LINQ: фильтрация Where, проекция Select и агрегаты",
                language: .csharp,
                files: [
                    IDEFile(
                        name: "Program.cs",
                        content: """
// Program.cs - C# LINQ Showcase
using System;
using System.Collections.Generic;

Console.WriteLine("Запуск LINQ конвейера...");

var scores = new List<int> { 85, 92, 45, 78, 99, 64, 88, 100 };

Console.WriteLine($"Всего участников: {scores.Count}");

int sum = 0;
int max = scores[0];
int passingCount = 0;

foreach (var s in scores)
{
    sum += s;
    if (s > max) max = s;
    if (s >= 75) passingCount++;
}

double average = (double)sum / scores.Count;

Console.WriteLine($"Средний балл: {average:F1}");
Console.WriteLine($"Максимальный результат: {max}");
Console.WriteLine($"Сдали экзамен (>= 75): {passingCount}");
"""
                    )
                ]
            ),

            // MARK: SQL Templates
            IDEProject(
                name: "SQL Store & Orders",
                descriptionText: "Реляционная база данных интернет-магазина: DDL схема, вставка и отчеты",
                language: .sql,
                files: [
                    IDEFile(
                        name: "schema.sql",
                        content: """
-- schema.sql: Создание таблиц и начальные данные
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    city TEXT NOT NULL
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    amount REAL,
    order_date DATE
);

INSERT INTO users VALUES 
(1, 'Александр', 'Москва'),
(2, 'Екатерина', 'Санкт-Петербург'),
(3, 'Дмитрий', 'Москва');

INSERT INTO orders VALUES 
(101, 1, 15000.0, '2026-03-01'),
(102, 1, 4500.0, '2026-03-05'),
(103, 2, 8900.0, '2026-03-06');
"""
                    ),
                    IDEFile(
                        name: "queries.sql",
                        content: """
-- queries.sql: Аналитические запросы
SELECT 
    u.name,
    u.city,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.amount), 0.0) AS total_spent
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name, u.city
ORDER BY total_spent DESC;
"""
                    )
                ]
            ),
            IDEProject(
                name: "SQL Analytics & Window",
                descriptionText: "Аналитические запросы: агрегации, оконные функции ROW_NUMBER и CTE",
                language: .sql,
                files: [
                    IDEFile(
                        name: "seed.sql",
                        content: """
-- seed.sql: Таблица продаж филиалов
CREATE TABLE department_sales (
    id INTEGER PRIMARY KEY,
    department TEXT,
    revenue REAL,
    sale_month TEXT
);

INSERT INTO department_sales VALUES 
(1, 'Электроника', 450000.0, '2026-01'),
(2, 'Электроника', 520000.0, '2026-02'),
(3, 'Одежда', 280000.0, '2026-01'),
(4, 'Одежда', 310000.0, '2026-02');
"""
                    ),
                    IDEFile(
                        name: "analytics.sql",
                        content: """
-- analytics.sql: Анализ динамики и средних показателей
WITH MonthlySummary AS (
    SELECT 
        department,
        sale_month,
        revenue,
        AVG(revenue) OVER (PARTITION BY department) AS dept_avg,
        ROW_NUMBER() OVER (PARTITION BY sale_month ORDER BY revenue DESC) AS month_rank
    FROM department_sales
)
SELECT 
    department,
    sale_month,
    revenue,
    ROUND(dept_avg, 2) AS dept_average,
    month_rank
FROM MonthlySummary
ORDER BY sale_month, month_rank;
"""
                    )
                ]
            )
        ]
    }
}
