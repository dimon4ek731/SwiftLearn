import SwiftUI

public struct InterviewQAView: View {
    @ObservedObject var lang = LanguageManager.shared
    @State private var selectedLanguage: TargetLanguage = .swift
    @State private var searchText: String = ""
    @State private var expandedQuestionIDs: Set<String> = []
    
    private let questions = InterviewPrepStore.shared.interviewQuestions
    
    public init() {}
    
    private var filteredQuestions: [InterviewQuestion] {
        questions.filter { q in
            let matchesLang = q.language == selectedLanguage
            let query = searchText.trimmingCharacters(in: .whitespaces).lowercased()
            let matchesSearch = query.isEmpty ||
                q.questionRU.lowercased().contains(query) ||
                q.questionEN.lowercased().contains(query) ||
                q.quickAnswerRU.lowercased().contains(query) ||
                q.quickAnswerEN.lowercased().contains(query) ||
                q.categoryRU.lowercased().contains(query) ||
                q.categoryEN.lowercased().contains(query)
            return matchesLang && matchesSearch
        }
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                // Language Chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(TargetLanguage.allCases) { item in
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                                    selectedLanguage = item
                                }
                            }) {
                                HStack(spacing: 6) {
                                    Image(systemName: item.icon)
                                        .font(.caption2)
                                    Text(item.displayName)
                                        .font(.caption.bold())
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 7)
                                .background(selectedLanguage == item ? Color(red: 0.14, green: 0.38, blue: 0.88) : Color(UIColor.secondarySystemBackground))
                                .foregroundColor(selectedLanguage == item ? .white : .primary)
                                .clipShape(Capsule())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Search Field
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                        .font(.caption)
                    TextField(lang.localized("Поиск вопроса, концепции, термина...", "Search questions, terms..."), text: $searchText)
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
                
                // Questions List
                LazyVStack(spacing: 12) {
                    ForEach(filteredQuestions) { q in
                        questionCard(q)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
    
    private func questionCard(_ q: InterviewQuestion) -> some View {
        let isExpanded = expandedQuestionIDs.contains(q.id)
        
        return VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                    if isExpanded {
                        expandedQuestionIDs.remove(q.id)
                    } else {
                        expandedQuestionIDs.insert(q.id)
                    }
                }
            }) {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(lang.localized(q.categoryRU, q.categoryEN).uppercased())
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.88))
                        
                        Text(lang.localized(q.questionRU, q.questionEN))
                            .font(.subheadline.bold())
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up.circle.fill" : "chevron.down.circle")
                        .font(.title3)
                        .foregroundColor(isExpanded ? Color(red: 0.14, green: 0.38, blue: 0.88) : .secondary)
                }
            }
            .buttonStyle(.plain)
            
            // Quick TL;DR
            HStack(alignment: .top, spacing: 8) {
                Text("TL;DR:")
                    .font(.caption.bold())
                    .foregroundColor(Color(red: 0.16, green: 0.58, blue: 0.40))
                
                Text(lang.localized(q.quickAnswerRU, q.quickAnswerEN))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.tertiarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // Expanded Detailed Section
            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    Divider()
                    
                    Text(lang.localized("Подробный разбор", "In-Depth Explanation"))
                        .font(.caption.bold())
                        .foregroundColor(.secondary)
                    
                    Text(lang.localized(q.detailedAnswerRU, q.detailedAnswerEN))
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
                    // Code sample
                    if !q.codeSample.isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(lang.localized("Пример кода", "Code Sample"))
                                .font(.caption.bold())
                                .foregroundColor(.secondary)
                            
                            Text(q.codeSample.trimmingCharacters(in: .whitespacesAndNewlines))
                                .font(.system(size: 12, design: .monospaced))
                                .padding(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(UIColor.tertiarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    
                    // Common Pitfall Alert
                    if !q.pitfallRU.isEmpty {
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                                .font(.caption)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(lang.localized("Частая ошибка на интервью", "Common Interview Pitfall"))
                                    .font(.caption.bold())
                                    .foregroundColor(.orange)
                                
                                Text(lang.localized(q.pitfallRU, q.pitfallEN))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(10)
                        .background(Color.orange.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(12)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isExpanded ? Color(red: 0.14, green: 0.38, blue: 0.88).opacity(0.3) : Color.secondary.opacity(0.12), lineWidth: 1)
        )
    }
}
