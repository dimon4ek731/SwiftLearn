import SwiftUI

public enum InterviewSubTab: Int, CaseIterable, Identifiable {
    case bigO = 0
    case rosetta = 1
    case questions = 2
    
    public var id: Int { rawValue }
}

public struct InterviewPrepView: View {
    @ObservedObject var lang = LanguageManager.shared
    @State private var activeTab: InterviewSubTab = .bigO
    
    public init(initialTab: InterviewSubTab = .bigO) {
        _activeTab = State(initialValue: initialTab)
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Sub-Segmented Control
            Picker("Раздел", selection: $activeTab) {
                Label(lang.localized("Big-O Шпаргалка", "Big-O Sheet"), systemImage: "chart.bar.xaxis")
                    .tag(InterviewSubTab.bigO)
                
                Label(lang.localized("Розеттский камень", "Language Matrix"), systemImage: "arrow.triangle.swap")
                    .tag(InterviewSubTab.rosetta)
                
                Label(lang.localized("Вопросы с собеседований", "Q&A Interview"), systemImage: "questionmark.bubble.fill")
                    .tag(InterviewSubTab.questions)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(UIColor.systemBackground))
            
            Divider()
            
            // Sub-views
            switch activeTab {
            case .bigO:
                BigOChartView()
            case .rosetta:
                RosettaStoneView()
            case .questions:
                InterviewQAView()
            }
        }
        .onAppear {
            if ProcessInfo.processInfo.arguments.contains("-rosetta") {
                activeTab = .rosetta
            } else if ProcessInfo.processInfo.arguments.contains("-qa") {
                activeTab = .questions
            }
        }
    }
}
