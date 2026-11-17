import SwiftUI

public struct OfficialDocReaderView: View {
    public let topic: OfficialDocTopic
    @ObservedObject var lang = LanguageManager.shared
    @State private var preferEnglishOriginal: Bool = false
    @State private var fontSizeMultiplier: CGFloat = 1.0
    @State private var isShowingLiveWeb: Bool = false
    
    public init(topic: OfficialDocTopic) {
        self.topic = topic
    }
    
    private var activeMarkdown: String {
        if preferEnglishOriginal || lang.currentLanguage == .english {
            return topic.contentMarkdownEN
        }
        return topic.contentMarkdownRU
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Metadata Card
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Label(topic.section.title(for: lang.currentLanguage), systemImage: topic.section.icon)
                            .font(.caption.bold())
                            .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.88))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color(red: 0.14, green: 0.38, blue: 0.88).opacity(0.12))
                            .clipShape(Capsule())
                        
                        Spacer()
                        
                        Button(action: { isShowingLiveWeb = true }) {
                            HStack(spacing: 5) {
                                Image(systemName: "safari")
                                Text(lang.localized("Swift.org", "Swift.org"))
                            }
                            .font(.caption.bold())
                            .foregroundColor(Color(red: 0.58, green: 0.22, blue: 0.88))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color(red: 0.58, green: 0.22, blue: 0.88).opacity(0.12))
                            .clipShape(Capsule())
                        }
                    }
                    
                    Text(lang.localized(topic.titleRU, topic.titleEN))
                        .font(.title2.weight(.bold))
                        .foregroundColor(.primary)
                    
                    Text(lang.localized(topic.summaryRU, topic.summaryEN))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineSpacing(3)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding(.horizontal)
                
                // Chapter Controls (Original EN toggle & Font scaling)
                HStack {
                    Button(action: {
                        preferEnglishOriginal.toggle()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "globe")
                            Text(preferEnglishOriginal ? "EN (Original)" : "RU (Перевод)")
                        }
                        .font(.caption.bold())
                        .foregroundColor(.primary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color(UIColor.tertiarySystemBackground))
                        .clipShape(Capsule())
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Button(action: {
                            if fontSizeMultiplier > 0.85 {
                                fontSizeMultiplier -= 0.1
                            }
                        }) {
                            Text("A-")
                                .font(.caption.bold())
                                .padding(.horizontal, 8)
                                .padding(.vertical, 6)
                        }
                        
                        Divider().frame(height: 14)
                        
                        Button(action: {
                            if fontSizeMultiplier < 1.4 {
                                fontSizeMultiplier += 0.1
                            }
                        }) {
                            Text("A+")
                                .font(.caption.bold())
                                .padding(.horizontal, 8)
                                .padding(.vertical, 6)
                        }
                    }
                    .background(Color(UIColor.tertiarySystemBackground))
                    .clipShape(Capsule())
                }
                .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                // Markdown Official Content
                CurriculumMarkdownView(markdown: activeMarkdown)
                    .scaleEffect(fontSizeMultiplier, anchor: .topLeading)
                    .padding(.horizontal)
            }
            .padding(.vertical)
            .padding(.bottom, 60)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { isShowingLiveWeb = true }) {
                    Image(systemName: "globe")
                }
            }
        }
        .sheet(isPresented: $isShowingLiveWeb) {
            NavigationStack {
                OfficialDocsWebView(url: topic.webURL)
                    .navigationTitle(topic.titleEN)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(lang.localized("Закрыть", "Close")) {
                                isShowingLiveWeb = false
                            }
                        }
                    }
            }
        }
    }
}
