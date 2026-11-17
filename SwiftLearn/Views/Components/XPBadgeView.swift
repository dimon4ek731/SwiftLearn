import SwiftUI

public struct XPBadgeView: View {
    @ObservedObject var storage = StorageService.shared
    @ObservedObject var lang = LanguageManager.shared
    @ObservedObject var nav = AppNavigationState.shared
    
    @State private var showingStreakSheet: Bool = false
    
    public init() {}
    
    public var body: some View {
        HStack(spacing: 6) {
            // Interactive Streak Flame Button
            Button(action: {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                showingStreakSheet = true
            }) {
                HStack(spacing: 4) {
                    Image(systemName: storage.profile.hasPracticedToday ? "flame.fill" : "flame")
                        .foregroundColor(storage.profile.hasPracticedToday ? .orange : .orange.opacity(0.8))
                        .font(.system(size: 11, weight: .bold))
                    Text("\(storage.profile.streakDays)")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundColor(storage.profile.hasPracticedToday ? .orange : .primary)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    storage.profile.hasPracticedToday
                        ? Color.orange.opacity(0.18)
                        : Color(UIColor.secondarySystemFill)
                )
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(
                            storage.profile.hasPracticedToday ? Color.orange.opacity(0.4) : Color.clear,
                            lineWidth: 1
                        )
                )
            }
            .buttonStyle(.plain)
            
            // Level Pill
            Button(action: {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                nav.navigateToProfile()
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.82))
                        .font(.system(size: 10, weight: .semibold))
                    Text("LV \(storage.profile.level)")
                        .font(.system(size: 11, weight: .semibold, design: .monospaced))
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color(UIColor.secondarySystemFill))
                .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
        .fixedSize()
        .sheet(isPresented: $showingStreakSheet) {
            StreakDetailSheet()
        }
    }
}
