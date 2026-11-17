import SwiftUI

@main
struct SwiftLearnApp: App {
    @StateObject private var lang = LanguageManager.shared
    @StateObject private var storage = StorageService.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(lang)
                .environmentObject(storage)
                .onAppear {
                    if let argIdx = ProcessInfo.processInfo.arguments.firstIndex(of: "-openLesson"),
                       argIdx + 1 < ProcessInfo.processInfo.arguments.count {
                        let lessonId = ProcessInfo.processInfo.arguments[argIdx + 1]
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            AppNavigationState.shared.openLesson(id: lessonId)
                        }
                    } else if let tabIdx = ProcessInfo.processInfo.arguments.firstIndex(of: "-openTab"),
                              tabIdx + 1 < ProcessInfo.processInfo.arguments.count,
                              let tab = Int(ProcessInfo.processInfo.arguments[tabIdx + 1]) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            AppNavigationState.shared.selectedTab = tab
                        }
                    }
                }
                .onOpenURL { url in
                    if url.host == "lesson" {
                        let lessonId = url.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
                        AppNavigationState.shared.openLesson(id: lessonId)
                    }
                }
        }
    }
}
