import SwiftUI
import Combine

@MainActor
public final class AppNavigationState: ObservableObject {
    public static let shared = AppNavigationState()
    
    @Published public var selectedTab: Int = 0
    @Published public var presentedLesson: Lesson? = nil
    
    public init() {}
    
    public func navigateToCurriculum() {
        selectedTab = 0
    }
    
    public func openLesson(id: String) {
        if let found = CurriculumStore.shared.lessons.first(where: { $0.id == id }) {
            selectedTab = 0
            presentedLesson = found
        }
    }
    
    public func navigateToDocs() {
        selectedTab = 1
    }
    
    public func navigateToChallenges() {
        selectedTab = 2
    }
    
    public func navigateToIDE() {
        selectedTab = 3
        NotificationCenter.default.post(
            name: .selectIDE,
            object: nil
        )
    }
    
    public func navigateToPlayground(withCode code: String) {
        selectedTab = 3
        NotificationCenter.default.post(
            name: .loadPlaygroundCode,
            object: code
        )
    }
    
    public func navigateToProfile() {
        selectedTab = 4
    }
}

public extension Notification.Name {
    static let selectIDE = Notification.Name("selectIDE")
    static let loadPlaygroundCode = Notification.Name("loadPlaygroundCode")
}
