import SwiftUI

public struct ContentView: View {
    @ObservedObject var lang = LanguageManager.shared
    @ObservedObject var nav = AppNavigationState.shared
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $nav.selectedTab) {
            CurriculumView()
                .tabItem {
                    Label(
                        lang.localized("Модули", "Modules"),
                        systemImage: "book.pages"
                    )
                }
                .tag(0)
            
            OfficialDocumentationView()
                .tabItem {
                    Label(
                        lang.localized("Доки", "Docs"),
                        systemImage: "books.vertical.fill"
                    )
                }
                .tag(1)
            
            ChallengesView()
                .tabItem {
                    Label(
                        lang.localized("Задачи", "Practice"),
                        systemImage: "checklist"
                    )
                }
                .tag(2)
            
            SwiftUISandboxView()
                .tabItem {
                    Label(
                        lang.localized("IDE", "IDE"),
                        systemImage: "macwindow.on.rectangle"
                    )
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Label(
                        lang.localized("Профиль", "Profile"),
                        systemImage: "person"
                    )
                }
                .tag(4)
        }
        .tint(Color(red: 0.14, green: 0.38, blue: 0.82))
    }
}
