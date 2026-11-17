import SwiftUI

public struct RosettaStoneView: View {
    @ObservedObject var lang = LanguageManager.shared
    @State private var selectedIndex: Int = 0
    @State private var activeCodeTab: TargetLanguage = .swift
    
    private let comparisons = InterviewPrepStore.shared.rosettaComparisons
    
    public init() {}
    
    private var currentItem: RosettaComparison {
        comparisons[min(selectedIndex, comparisons.count - 1)]
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Topic Selector Carousel
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(Array(comparisons.enumerated()), id: \.offset) { index, item in
                            Button(action: {
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                                    selectedIndex = index
                                }
                            }) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(lang.localized(item.categoryRU, item.categoryEN))
                                        .font(.system(size: 10, weight: .semibold))
                                        .foregroundColor(selectedIndex == index ? .white.opacity(0.8) : .secondary)
                                    
                                    Text(lang.localized(item.titleRU, item.titleEN))
                                        .font(.caption.bold())
                                        .foregroundColor(selectedIndex == index ? .white : .primary)
                                        .lineLimit(1)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    selectedIndex == index ?
                                    Color(red: 0.14, green: 0.38, blue: 0.88) :
                                    Color(UIColor.secondarySystemBackground)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Active Topic Title
                VStack(alignment: .leading, spacing: 6) {
                    Text(lang.localized(currentItem.titleRU, currentItem.titleEN))
                        .font(.title3.bold())
                    
                    Text(lang.localized(currentItem.explanationRU, currentItem.explanationEN))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                // Code Tabs for All 4 Languages
                VStack(alignment: .leading, spacing: 0) {
                    // Language Switcher Tabs
                    HStack(spacing: 0) {
                        ForEach(TargetLanguage.allCases) { target in
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    activeCodeTab = target
                                }
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: target.icon)
                                        .font(.caption2)
                                    Text(target.displayName)
                                        .font(.caption.bold())
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(activeCodeTab == target ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground))
                                .foregroundColor(activeCodeTab == target ? Color(red: 0.14, green: 0.38, blue: 0.88) : .secondary)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
                    
                    // Code Body Box
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(lang.localized("Реализация на ", "Implementation in ") + activeCodeTab.displayName)
                                .font(.caption.bold())
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Button(action: {
                                UIPasteboard.general.string = activeCodeString
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                            }) {
                                Label(lang.localized("Копировать", "Copy"), systemImage: "doc.on.doc")
                                    .font(.caption2)
                                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.88))
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 12)
                        
                        Text(activeCodeString.trimmingCharacters(in: .whitespacesAndNewlines))
                            .font(.system(size: 13, design: .monospaced))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(UIColor.tertiarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal)
                    }
                }
                
                // Comparative Takeaways
                VStack(alignment: .leading, spacing: 8) {
                    Text(lang.localized("Ключевой вывод для собеседования", "Interview Takeaway"))
                        .font(.headline)
                    
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "lightbulb.fill")
                            .foregroundColor(.orange)
                        Text(lang.localized("Понимание различий между сборкой на стеке (Swift/C# struct) и куче (Python/Reference types), а также декларативных трансформаций данных (map/LINQ/SQL) выделяет Senior-разработчиков.", "Understanding stack vs heap semantics (Swift/C# structs vs Python objects) and declarative data pipelines (map/LINQ/SQL) distinguishes Senior candidates."))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(12)
                    .background(Color.orange.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
    
    private var activeCodeString: String {
        switch activeCodeTab {
        case .swift: return currentItem.swiftCode
        case .python: return currentItem.pythonCode
        case .csharp: return currentItem.csharpCode
        case .sql: return currentItem.sqlCode
        }
    }
}
