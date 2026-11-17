import Foundation
import SwiftUI

// MARK: - Big-O Complexity Models
public enum ComplexityRating: String, Codable {
    case o1 = "O(1)"
    case oLogN = "O(log n)"
    case oN = "O(n)"
    case oNLogN = "O(n log n)"
    case oN2 = "O(n²)"
    case o2N = "O(2ⁿ)"
    case oFactN = "O(n!)"
    
    public var color: Color {
        switch self {
        case .o1: return Color(red: 0.16, green: 0.58, blue: 0.40) // Зелёный
        case .oLogN: return Color(red: 0.22, green: 0.65, blue: 0.45) // Светло-зелёный
        case .oN: return Color(red: 0.85, green: 0.65, blue: 0.15) // Жёлтый
        case .oNLogN: return Color.orange // Оранжевый
        case .oN2, .o2N, .oFactN: return Color(red: 0.85, green: 0.25, blue: 0.20) // Красный
        }
    }
}

public struct BigOItem: Identifiable, Codable {
    public var id: String
    public var nameRU: String
    public var nameEN: String
    public var isAlgorithm: Bool // false = структура данных, true = алгоритм
    public var timeAverage: ComplexityRating
    public var timeWorst: ComplexityRating
    public var spaceWorst: ComplexityRating
    public var summaryRU: String
    public var summaryEN: String
    public var bestCaseNotesRU: String
    public var bestCaseNotesEN: String
    
    public init(
        id: String,
        nameRU: String,
        nameEN: String,
        isAlgorithm: Bool,
        timeAverage: ComplexityRating,
        timeWorst: ComplexityRating,
        spaceWorst: ComplexityRating,
        summaryRU: String,
        summaryEN: String,
        bestCaseNotesRU: String,
        bestCaseNotesEN: String
    ) {
        self.id = id
        self.nameRU = nameRU
        self.nameEN = nameEN
        self.isAlgorithm = isAlgorithm
        self.timeAverage = timeAverage
        self.timeWorst = timeWorst
        self.spaceWorst = spaceWorst
        self.summaryRU = summaryRU
        self.summaryEN = summaryEN
        self.bestCaseNotesRU = bestCaseNotesRU
        self.bestCaseNotesEN = bestCaseNotesEN
    }
}

// MARK: - Cross-Language Rosetta Comparison
public struct RosettaComparison: Identifiable, Codable {
    public var id: String
    public var titleRU: String
    public var titleEN: String
    public var categoryRU: String
    public var categoryEN: String
    public var swiftCode: String
    public var pythonCode: String
    public var csharpCode: String
    public var sqlCode: String
    public var explanationRU: String
    public var explanationEN: String
    
    public init(
        id: String,
        titleRU: String,
        titleEN: String,
        categoryRU: String,
        categoryEN: String,
        swiftCode: String,
        pythonCode: String,
        csharpCode: String,
        sqlCode: String,
        explanationRU: String,
        explanationEN: String
    ) {
        self.id = id
        self.titleRU = titleRU
        self.titleEN = titleEN
        self.categoryRU = categoryRU
        self.categoryEN = categoryEN
        self.swiftCode = swiftCode
        self.pythonCode = pythonCode
        self.csharpCode = csharpCode
        self.sqlCode = sqlCode
        self.explanationRU = explanationRU
        self.explanationEN = explanationEN
    }
}

// MARK: - Interview Q&A Model
public struct InterviewQuestion: Identifiable, Codable {
    public var id: String
    public var language: TargetLanguage
    public var categoryRU: String
    public var categoryEN: String
    public var questionRU: String
    public var questionEN: String
    public var quickAnswerRU: String
    public var quickAnswerEN: String
    public var detailedAnswerRU: String
    public var detailedAnswerEN: String
    public var codeSample: String
    public var pitfallRU: String
    public var pitfallEN: String
    
    public init(
        id: String,
        language: TargetLanguage,
        categoryRU: String,
        categoryEN: String,
        questionRU: String,
        questionEN: String,
        quickAnswerRU: String,
        quickAnswerEN: String,
        detailedAnswerRU: String,
        detailedAnswerEN: String,
        codeSample: String = "",
        pitfallRU: String = "",
        pitfallEN: String = ""
    ) {
        self.id = id
        self.language = language
        self.categoryRU = categoryRU
        self.categoryEN = categoryEN
        self.questionRU = questionRU
        self.questionEN = questionEN
        self.quickAnswerRU = quickAnswerRU
        self.quickAnswerEN = quickAnswerEN
        self.detailedAnswerRU = detailedAnswerRU
        self.detailedAnswerEN = detailedAnswerEN
        self.codeSample = codeSample
        self.pitfallRU = pitfallRU
        self.pitfallEN = pitfallEN
    }
}
