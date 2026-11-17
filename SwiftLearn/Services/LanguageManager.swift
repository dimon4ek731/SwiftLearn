import SwiftUI
import Combine

public enum AppLanguage: String, CaseIterable, Identifiable, Codable {
    case russian = "ru"
    case english = "en"
    
    public var id: String { rawValue }
    
    public var title: String {
        switch self {
        case .russian: return "Русский"
        case .english: return "English"
        }
    }
}

@MainActor
public final class LanguageManager: ObservableObject {
    public static let shared = LanguageManager()
    
    @Published public var currentLanguage: AppLanguage {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: "app_selected_language")
        }
    }
    
    public init() {
        if let saved = UserDefaults.standard.string(forKey: "app_selected_language"),
           let lang = AppLanguage(rawValue: saved) {
            self.currentLanguage = lang
        } else {
            self.currentLanguage = .russian
        }
    }
    
    public func localized(_ ru: String, _ en: String) -> String {
        currentLanguage == .russian ? ru : en
    }
}
