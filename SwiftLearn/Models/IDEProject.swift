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
    public var files: [IDEFile]
    public var activeFileId: UUID
    public var createdAt: Date
    public var updatedAt: Date
    
    public init(
        id: UUID = UUID(),
        name: String,
        descriptionText: String,
        files: [IDEFile],
        activeFileId: UUID? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.descriptionText = descriptionText
        self.files = files
        self.activeFileId = activeFileId ?? files.first?.id ?? UUID()
        self.createdAt = createdAt
        self.updatedAt = updatedAt
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
            cleanName += ".swift"
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
    // Declarations from auxiliary files are prepended before main.swift.
    public func combinedCodeForExecution() -> String {
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
    }
    
    // MARK: - Built-in Templates
    public static var defaultTemplates: [IDEProject] {
        [
            IDEProject(
                name: "SwiftUI Dashboard",
                descriptionText: "Архитектура современного приложения SwiftUI с моделью данных и компонентами",
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
                name: "Algorithms & Data Structures",
                descriptionText: "Реализация универсального стека, очереди и алгоритмов поиска",
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
            )
        ]
    }
}
