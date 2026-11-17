import Foundation
import Combine

public extension Notification.Name {
    static let streakUpdated = Notification.Name("streakUpdated")
}

@MainActor
public final class StorageService: ObservableObject {
    public static let shared = StorageService()
    
    private let profileKey = "swiftlearn_user_profile_v1"
    private var saveProfileWorkItem: DispatchWorkItem?
    private let backgroundQueue = DispatchQueue(label: "com.swiftlearn.storage", qos: .utility)
    
    @Published public var profile: UserProfile {
        didSet {
            scheduleSaveProfile()
        }
    }
    
    public init() {
        if let data = UserDefaults.standard.data(forKey: profileKey),
           let decoded = try? JSONDecoder().decode(UserProfile.self, from: data) {
            self.profile = decoded
        } else {
            self.profile = UserProfile()
        }
        
        checkAndUpdateDailyStreak()
    }
    
    public func checkAndUpdateDailyStreak() {
        let calendar = Calendar.current
        let today = Date()
        
        guard let last = profile.lastActivityDate else {
            // No activity yet or reset to zero: wait for user's first task/lesson
            return
        }
        
        if calendar.isDateInToday(last) {
            // Already active today
            return
        } else if calendar.isDateInYesterday(last) {
            // Day changed to today, streak maintained from yesterday, waiting for today's activity
            return
        } else {
            // Missed at least one full day!
            if profile.streakFreezeCount > 0 {
                // Streak Freeze saves the day!
                profile.streakFreezeCount -= 1
                profile.lastActivityDate = calendar.date(byAdding: .day, value: -1, to: today) // Put last activity as yesterday
            } else {
                profile.streakDays = 1
            }
        }
    }
    
    public func recordActivity(xpGained: Int = 0) {
        let calendar = Calendar.current
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayKey = formatter.string(from: today)
        
        profile.activeDates.insert(todayKey)
        
        if xpGained > 0 {
            profile.xp += xpGained
        }
        
        if let last = profile.lastActivityDate {
            if calendar.isDateInToday(last) {
                // Already extended today
            } else if calendar.isDateInYesterday(last) {
                profile.streakDays += 1
            } else {
                // Gap
                if profile.streakFreezeCount > 0 {
                    profile.streakFreezeCount -= 1
                    profile.streakDays += 1
                } else {
                    profile.streakDays = 1
                }
            }
        } else {
            profile.streakDays = 1
        }
        
        profile.lastActivityDate = today
        if profile.streakDays > profile.longestStreakDays {
            profile.longestStreakDays = profile.streakDays
        }
        
        NotificationCenter.default.post(name: .streakUpdated, object: profile.streakDays)
    }
    
    public func addXP(_ amount: Int) {
        recordActivity(xpGained: amount)
    }
    
    public func markLessonCompleted(id: String, reward: Int) {
        guard !profile.completedLessonIDs.contains(id) else { return }
        profile.completedLessonIDs.insert(id)
        recordActivity(xpGained: reward)
    }
    
    public func markChallengeSolved(id: String, reward: Int = 30) {
        guard !profile.solvedChallengeIDs.contains(id) else { return }
        profile.solvedChallengeIDs.insert(id)
        recordActivity(xpGained: reward)
    }
    
    public func buyStreakFreeze() -> Bool {
        guard profile.xp >= 100, profile.streakFreezeCount < 3 else { return false }
        profile.xp -= 100
        profile.streakFreezeCount += 1
        return true
    }
    
    public func claimStreakMilestone(days: Int, rewardXP: Int) {
        guard !profile.claimedStreakMilestoneIDs.contains(days), profile.streakDays >= days else { return }
        profile.claimedStreakMilestoneIDs.insert(days)
        profile.xp += rewardXP
    }
    
    public func resetAllProgressToZero() {
        self.profile = UserProfile.zero
        UserDefaults.standard.removeObject(forKey: profileKey)
        NotificationCenter.default.post(name: .streakUpdated, object: 0)
    }
    
    private func scheduleSaveProfile() {
        saveProfileWorkItem?.cancel()
        let profileToSave = self.profile
        let key = self.profileKey
        
        let item = DispatchWorkItem {
            if let encoded = try? JSONEncoder().encode(profileToSave) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
        saveProfileWorkItem = item
        backgroundQueue.asyncAfter(deadline: .now() + 0.3, execute: item)
    }
}
