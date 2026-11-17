import SwiftUI

public enum DocDisplayMode: Int, CaseIterable, Identifiable {
    case chapters = 0
    case interviewPrep = 1
    case liveWeb = 2
    
    public var id: Int { rawValue }
}

public struct OfficialDocumentationView: View {
    @ObservedObject var lang = LanguageManager.shared
    @State private var selectedLanguage: TargetLanguage = .swift
    @State private var displayMode: DocDisplayMode = .chapters
    @State private var searchText: String = ""
    @State private var selectedSection: DocSection? = nil
    
    private let store = OfficialDocsStore.shared
    
    public init() {}
    
    private var filteredTopics: [OfficialDocTopic] {
        var list = store.topics.filter { $0.language == selectedLanguage }
        if let s = selectedSection {
            list = list.filter { $0.section == s }
        }
        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            let q = searchText.lowercased()
            list = list.filter {
                $0.titleRU.lowercased().contains(q) ||
                $0.titleEN.lowercased().contains(q) ||
                $0.summaryRU.lowercased().contains(q) ||
                $0.summaryEN.lowercased().contains(q)
            }
        }
        return list
    }
    
    private var liveWebURL: URL {
        switch selectedLanguage {
        case .swift:
            return URL(string: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/")!
        case .python:
            return URL(string: "https://docs.python.org/3/tutorial/")!
        case .csharp:
            return URL(string: "https://learn.microsoft.com/en-us/dotnet/csharp/tour-of-csharp/")!
        case .sql:
            return URL(string: "https://www.sqlite.org/lang.html")!
        }
    }
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Top Language Switcher (only for chapters & liveWeb)
                if displayMode != .interviewPrep {
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
                                            .font(.system(size: 12, weight: .semibold))
                                        Text(item.displayName)
                                            .font(.caption.weight(.bold))
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
                        .padding(.vertical, 8)
                    }
                    .background(Color(UIColor.systemBackground))
                }
                
                // Top Segmented Mode Picker
                Picker("Режим", selection: $displayMode) {
                    Label(lang.localized("Главы книги", "Language Guide"), systemImage: "book.pages")
                        .tag(DocDisplayMode.chapters)
                    
                    Label(lang.localized("Собеседование & Big-O", "Interview & Big-O"), systemImage: "graduationcap.fill")
                        .tag(DocDisplayMode.interviewPrep)
                    
                    Label(lang.localized("Официальный Web", "Live Web Docs"), systemImage: "globe")
                        .tag(DocDisplayMode.liveWeb)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.bottom, 8)
                .background(Color(UIColor.systemBackground))
                
                Divider()
                
                // Content Switcher
                switch displayMode {
                case .chapters:
                    chaptersListView
                case .interviewPrep:
                    InterviewPrepView()
                case .liveWeb:
                    OfficialDocsWebView(url: liveWebURL)
                }
            }
            .navigationTitle(displayMode == .interviewPrep ? lang.localized("Собеседования и Big-O", "Interview Prep & Big-O") : "\(selectedLanguage.displayName) Docs")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if ProcessInfo.processInfo.arguments.contains("-interview") {
                    displayMode = .interviewPrep
                }
            }
        }
    }
    
    // MARK: - Offline Chapters View
    private var chaptersListView: some View {
        VStack(spacing: 0) {
            // Section Filter Chips
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    FilterChip(
                        title: lang.localized("Все главы", "All Chapters"),
                        isSelected: selectedSection == nil
                    ) {
                        selectedSection = nil
                    }
                    
                    ForEach(DocSection.allCases) { sec in
                        FilterChip(
                            title: sec.title(for: lang.currentLanguage),
                            isSelected: selectedSection == sec
                        ) {
                            selectedSection = sec
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            .background(Color(UIColor.secondarySystemBackground).opacity(0.4))
            
            // Search Results or Grouped Chapters
            ScrollView {
                LazyVStack(spacing: 12) {
                    // Header Banner
                    HStack(spacing: 12) {
                        Image(systemName: "apple.terminal.fill")
                            .font(.title2)
                            .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.88))
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("The Swift Programming Language")
                                .font(.headline.weight(.bold))
                            Text(lang.localized("Официальная документация Apple и Swift.org для версии Swift 6.", "Official Apple and Swift.org reference manual for Swift 6."))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // Chapters List
                    ForEach(filteredTopics) { topic in
                        NavigationLink(destination: OfficialDocReaderView(topic: topic)) {
                            HStack(alignment: .top, spacing: 14) {
                                // Chapter Number Badge
                                Text("\(topic.chapterNumber)")
                                    .font(.headline.bold())
                                    .foregroundColor(.white)
                                    .frame(width: 32, height: 32)
                                    .background(
                                        topic.section == .welcome ? Color(red: 0.14, green: 0.38, blue: 0.88) :
                                        topic.section == .languageGuide ? Color(red: 0.58, green: 0.22, blue: 0.88) :
                                        Color(red: 0.95, green: 0.60, blue: 0.15)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text(lang.localized(topic.titleRU, topic.titleEN))
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                            .multilineTextAlignment(.leading)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.caption.bold())
                                            .foregroundColor(.secondary.opacity(0.6))
                                    }
                                    
                                    Text(lang.localized(topic.summaryRU, topic.summaryEN))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)
                                    
                                    HStack(spacing: 6) {
                                        Image(systemName: "link")
                                            .font(.system(size: 10))
                                        Text("docs.swift.org/\(topic.webSlug)")
                                            .font(.system(size: 11, design: .monospaced))
                                    }
                                    .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.88))
                                    .padding(.top, 2)
                                }
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 80)
            }
            .searchable(text: $searchText, prompt: lang.localized("Поиск по документации...", "Search official documentation..."))
        }
    }
}

private struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption.bold())
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color(red: 0.14, green: 0.38, blue: 0.88) : Color(UIColor.secondarySystemBackground))
                .foregroundColor(isSelected ? .white : .primary)
                .clipShape(Capsule())
        }
    }
}
