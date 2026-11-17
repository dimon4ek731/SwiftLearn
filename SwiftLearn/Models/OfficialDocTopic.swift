import Foundation

public enum DocSection: String, CaseIterable, Identifiable, Codable {
    case welcome = "Welcome to Swift"
    case languageGuide = "Language Guide"
    case languageReference = "Language Reference"
    
    public var id: String { rawValue }
    
    public func title(for language: AppLanguage) -> String {
        switch self {
        case .welcome:
            return language == .russian ? "Введение в Swift" : "Welcome to Swift"
        case .languageGuide:
            return language == .russian ? "Руководство по языку" : "Language Guide"
        case .languageReference:
            return language == .russian ? "Справочник синтаксиса" : "Language Reference"
        }
    }
    
    public var icon: String {
        switch self {
        case .welcome: return "sparkles"
        case .languageGuide: return "book.closed.fill"
        case .languageReference: return "character.book.closed.fill"
        }
    }
}

public struct OfficialDocTopic: Identifiable, Codable, Hashable {
    public let id: String
    public let language: TargetLanguage
    public let section: DocSection
    public let chapterNumber: Int
    public let titleEN: String
    public let titleRU: String
    public let summaryEN: String
    public let summaryRU: String
    public let webSlug: String
    public let contentMarkdownEN: String
    public let contentMarkdownRU: String
    
    public var webURL: URL {
        switch language {
        case .swift:
            return URL(string: "https://docs.swift.org/swift-book/documentation/the-swift-programming-language/\(webSlug)/")!
        case .python:
            return URL(string: "https://docs.python.org/3/\(webSlug)")!
        case .csharp:
            return URL(string: "https://learn.microsoft.com/en-us/dotnet/csharp/\(webSlug)")!
        }
    }
    
    public init(
        id: String,
        language: TargetLanguage = .swift,
        section: DocSection,
        chapterNumber: Int,
        titleEN: String,
        titleRU: String,
        summaryEN: String,
        summaryRU: String,
        webSlug: String,
        contentMarkdownEN: String,
        contentMarkdownRU: String
    ) {
        self.id = id
        self.language = language
        self.section = section
        self.chapterNumber = chapterNumber
        self.titleEN = titleEN
        self.titleRU = titleRU
        self.summaryEN = summaryEN
        self.summaryRU = summaryRU
        self.webSlug = webSlug
        self.contentMarkdownEN = contentMarkdownEN
        self.contentMarkdownRU = contentMarkdownRU
    }
}
