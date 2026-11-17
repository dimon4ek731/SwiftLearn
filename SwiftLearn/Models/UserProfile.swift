import Foundation

public struct UserProfile: Codable {
    public var xp: Int
    public var streakDays: Int
    public var longestStreakDays: Int
    public var streakFreezeCount: Int
    public var activeDates: Set<String>
    public var claimedStreakMilestoneIDs: Set<Int>
    public var lastActivityDate: Date?
    public var completedLessonIDs: Set<String>
    public var solvedChallengeIDs: Set<String>
    
    public init(
        xp: Int = 120,
        streakDays: Int = 4,
        longestStreakDays: Int = 5,
        streakFreezeCount: Int = 2,
        activeDates: Set<String> = [],
        claimedStreakMilestoneIDs: Set<Int> = [3],
        lastActivityDate: Date? = Date(),
        completedLessonIDs: Set<String> = [],
        solvedChallengeIDs: Set<String> = []
    ) {
        self.xp = xp
        self.streakDays = streakDays
        self.longestStreakDays = max(streakDays, longestStreakDays)
        self.streakFreezeCount = streakFreezeCount
        
        var dates = activeDates
        if dates.isEmpty && streakDays > 0 {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let today = Date()
            dates.insert(formatter.string(from: today))
            // Generate previous streak days in activeDates
            for i in 1..<streakDays {
                if let prevDate = Calendar.current.date(byAdding: .day, value: -i, to: today) {
                    dates.insert(formatter.string(from: prevDate))
                }
            }
        }
        self.activeDates = dates
        self.claimedStreakMilestoneIDs = claimedStreakMilestoneIDs
        self.lastActivityDate = lastActivityDate
        self.completedLessonIDs = completedLessonIDs
        self.solvedChallengeIDs = solvedChallengeIDs
    }
    
    public static var zero: UserProfile {
        UserProfile(
            xp: 0,
            streakDays: 0,
            longestStreakDays: 0,
            streakFreezeCount: 1,
            activeDates: [],
            claimedStreakMilestoneIDs: [],
            lastActivityDate: nil,
            completedLessonIDs: [],
            solvedChallengeIDs: []
        )
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.xp = try container.decode(Int.self, forKey: .xp)
        self.streakDays = try container.decode(Int.self, forKey: .streakDays)
        self.longestStreakDays = try container.decodeIfPresent(Int.self, forKey: .longestStreakDays) ?? max(self.streakDays, 5)
        self.streakFreezeCount = try container.decodeIfPresent(Int.self, forKey: .streakFreezeCount) ?? 2
        self.activeDates = try container.decodeIfPresent(Set<String>.self, forKey: .activeDates) ?? []
        self.claimedStreakMilestoneIDs = try container.decodeIfPresent(Set<Int>.self, forKey: .claimedStreakMilestoneIDs) ?? [3]
        self.lastActivityDate = try container.decodeIfPresent(Date.self, forKey: .lastActivityDate)
        self.completedLessonIDs = try container.decode(Set<String>.self, forKey: .completedLessonIDs)
        self.solvedChallengeIDs = try container.decode(Set<String>.self, forKey: .solvedChallengeIDs)
        
        // Ensure active dates has today if lastActivityDate is today
        if let last = self.lastActivityDate, Calendar.current.isDateInToday(last) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.activeDates.insert(formatter.string(from: last))
        }
    }
    
    public var hasPracticedToday: Bool {
        guard let last = lastActivityDate else { return false }
        return Calendar.current.isDateInToday(last)
    }
    
    public var level: Int {
        max(1, (xp / 100) + 1)
    }
    
    public var levelTitle: (ru: String, en: String) {
        switch level {
        case 1...2:
            return ("Junior iOS Developer", "Junior iOS Developer")
        case 3...5:
            return ("Middle iOS Engineer", "Middle iOS Engineer")
        case 6...9:
            return ("Senior iOS Engineer", "Senior iOS Engineer")
        default:
            return ("Lead iOS Architect", "Lead iOS Architect")
        }
    }
}
