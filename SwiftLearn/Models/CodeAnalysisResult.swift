import Foundation
import SwiftUI

public enum IssueSeverity: String, Codable {
    case error
    case warning
    case tip
    
    public var icon: String {
        switch self {
        case .error: return "xmark.circle"
        case .warning: return "exclamationmark.circle"
        case .tip: return "info.circle"
        }
    }
    
    public var color: Color {
        switch self {
        case .error: return Color(red: 0.75, green: 0.22, blue: 0.22)
        case .warning: return Color(red: 0.75, green: 0.50, blue: 0.15)
        case .tip: return Color(red: 0.14, green: 0.38, blue: 0.82)
        }
    }
}

public struct CodeIssue: Identifiable, Codable {
    public var id: UUID = UUID()
    public var line: Int?
    public var titleRU: String
    public var titleEN: String
    public var messageRU: String
    public var messageEN: String
    public var severity: IssueSeverity
    public var suggestionRU: String
    public var suggestionEN: String
    
    public init(
        id: UUID = UUID(),
        line: Int? = nil,
        titleRU: String,
        titleEN: String,
        messageRU: String,
        messageEN: String,
        severity: IssueSeverity,
        suggestionRU: String,
        suggestionEN: String
    ) {
        self.id = id
        self.line = line
        self.titleRU = titleRU
        self.titleEN = titleEN
        self.messageRU = messageRU
        self.messageEN = messageEN
        self.severity = severity
        self.suggestionRU = suggestionRU
        self.suggestionEN = suggestionEN
    }
}

public struct CodeAnalysisResult: Identifiable, Codable {
    public var id: UUID = UUID()
    public var score: Int
    public var issues: [CodeIssue]
    public var summaryRU: String
    public var summaryEN: String
    public var fixedCode: String
    public var bestPracticesRU: [String]
    public var bestPracticesEN: [String]
    
    public init(
        id: UUID = UUID(),
        score: Int,
        issues: [CodeIssue],
        summaryRU: String,
        summaryEN: String,
        fixedCode: String,
        bestPracticesRU: [String] = [],
        bestPracticesEN: [String] = []
    ) {
        self.id = id
        self.score = score
        self.issues = issues
        self.summaryRU = summaryRU
        self.summaryEN = summaryEN
        self.fixedCode = fixedCode
        self.bestPracticesRU = bestPracticesRU
        self.bestPracticesEN = bestPracticesEN
    }
}
