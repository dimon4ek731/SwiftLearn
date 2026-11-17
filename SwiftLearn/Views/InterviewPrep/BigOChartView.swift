import SwiftUI

public struct BigOChartView: View {
    @ObservedObject var lang = LanguageManager.shared
    @State private var filterMode: Int = 0 // 0 = Все, 1 = Структуры данных, 2 = Алгоритмы
    @State private var searchText: String = ""
    @State private var selectedItem: BigOItem? = nil
    
    private let items = InterviewPrepStore.shared.bigOItems
    
    public init() {}
    
    private var filteredItems: [BigOItem] {
        items.filter { item in
            let matchesCategory = filterMode == 0 || (filterMode == 1 && !item.isAlgorithm) || (filterMode == 2 && item.isAlgorithm)
            let q = searchText.trimmingCharacters(in: .whitespaces).lowercased()
            let matchesSearch = q.isEmpty ||
                item.nameRU.lowercased().contains(q) ||
                item.nameEN.lowercased().contains(q) ||
                item.summaryRU.lowercased().contains(q) ||
                item.summaryEN.lowercased().contains(q)
            return matchesCategory && matchesSearch
        }
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header Infographic Card
                legendCard
                
                // Segmented Filter
                Picker("Категория", selection: $filterMode) {
                    Text(lang.localized("Все", "All")).tag(0)
                    Text(lang.localized("Структуры данных", "Data Structures")).tag(1)
                    Text(lang.localized("Алгоритмы", "Algorithms")).tag(2)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                // Search Field
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                        .font(.caption)
                    TextField(lang.localized("Поиск структуры или алгоритма...", "Search Big-O table..."), text: $searchText)
                        .font(.subheadline)
                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                    }
                }
                .padding(10)
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
                
                // Table of Big-O Items
                LazyVStack(spacing: 12) {
                    ForEach(filteredItems) { item in
                        bigORow(item)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .sheet(item: $selectedItem) { item in
            bigODetailSheet(item)
        }
    }
    
    // MARK: - Legend Card
    private var legendCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(lang.localized("Шкала вычислительной сложности Big-O", "Big-O Complexity Scale"))
                .font(.headline)
            
            Text(lang.localized("Оценка времени исполнения T(n) и расхода оперативной памяти M(n) при росте объёма входных данных.", "Estimates time T(n) and memory M(n) scaling as input size n grows."))
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack(spacing: 6) {
                badge("O(1)", color: Color(red: 0.16, green: 0.58, blue: 0.40))
                badge("O(log n)", color: Color(red: 0.22, green: 0.65, blue: 0.45))
                badge("O(n)", color: Color(red: 0.85, green: 0.65, blue: 0.15))
                badge("O(n log n)", color: Color.orange)
                badge("O(n²)", color: Color(red: 0.85, green: 0.25, blue: 0.20))
            }
        }
        .padding(14)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal)
    }
    
    private func badge(_ text: String, color: Color) -> some View {
        Text(text)
            .font(.system(size: 11, weight: .bold, design: .monospaced))
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
            .background(color.opacity(0.18))
            .foregroundColor(color)
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
    
    // MARK: - Row View
    private func bigORow(_ item: BigOItem) -> some View {
        Button(action: {
            selectedItem = item
        }) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 6) {
                            Image(systemName: item.isAlgorithm ? "arrow.triangle.branch" : "square.stack.3d.up.fill")
                                .font(.caption.bold())
                                .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                            Text(lang.localized(item.nameRU, item.nameEN))
                                .font(.subheadline.bold())
                                .foregroundColor(.primary)
                        }
                        
                        Text(lang.localized(item.summaryRU, item.summaryEN))
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.caption2.bold())
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Complexity Badges Row
                HStack(spacing: 12) {
                    complexityMetric(
                        label: lang.localized("В среднем", "Average"),
                        rating: item.timeAverage
                    )
                    
                    complexityMetric(
                        label: lang.localized("В худшем", "Worst"),
                        rating: item.timeWorst
                    )
                    
                    complexityMetric(
                        label: lang.localized("Память", "Space"),
                        rating: item.spaceWorst
                    )
                }
            }
            .padding(12)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.secondary.opacity(0.12), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
    
    private func complexityMetric(label: String, rating: ComplexityRating) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.system(size: 9, weight: .medium))
                .foregroundColor(.secondary)
            
            Text(rating.rawValue)
                .font(.system(size: 12, weight: .bold, design: .monospaced))
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(rating.color.opacity(0.15))
                .foregroundColor(rating.color)
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
    
    // MARK: - Detail Sheet
    private func bigODetailSheet(_ item: BigOItem) -> some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(lang.localized(item.nameRU, item.nameEN))
                            .font(.title2.bold())
                        
                        Text(item.isAlgorithm ? lang.localized("Алгоритм", "Algorithm") : lang.localized("Структура данных", "Data Structure"))
                            .font(.caption.bold())
                            .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                    }
                    
                    // Complexity Metrics Card
                    HStack(spacing: 16) {
                        VStack(alignment: .center, spacing: 4) {
                            Text(lang.localized("Время (Average)", "Time (Average)"))
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text(item.timeAverage.rawValue)
                                .font(.title3.bold().monospaced())
                                .foregroundColor(item.timeAverage.color)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Divider().frame(height: 36)
                        
                        VStack(alignment: .center, spacing: 4) {
                            Text(lang.localized("Время (Worst)", "Time (Worst)"))
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text(item.timeWorst.rawValue)
                                .font(.title3.bold().monospaced())
                                .foregroundColor(item.timeWorst.color)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Divider().frame(height: 36)
                        
                        VStack(alignment: .center, spacing: 4) {
                            Text(lang.localized("Память", "Space"))
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text(item.spaceWorst.rawValue)
                                .font(.title3.bold().monospaced())
                                .foregroundColor(item.spaceWorst.color)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    // Description
                    VStack(alignment: .leading, spacing: 8) {
                        Text(lang.localized("Характеристики и принцип работы", "Key Characteristics"))
                            .font(.headline)
                        Text(lang.localized(item.summaryRU, item.summaryEN))
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    
                    // Best Use Cases
                    VStack(alignment: .leading, spacing: 8) {
                        Text(lang.localized("Когда применять на собеседовании", "When to use in Interviews"))
                            .font(.headline)
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                            Text(lang.localized(item.bestCaseNotesRU, item.bestCaseNotesEN))
                                .font(.subheadline)
                        }
                        .padding()
                        .background(Color(red: 0.16, green: 0.58, blue: 0.40).opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding()
            }
            .navigationTitle(lang.localized("Параметры сложности", "Complexity Specs"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
