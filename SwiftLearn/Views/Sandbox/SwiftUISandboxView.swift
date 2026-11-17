import SwiftUI

public struct SwiftUISandboxView: View {
    @ObservedObject var lang = LanguageManager.shared
    @ObservedObject var storage = StorageService.shared
    
    enum SandboxMode: Int, CaseIterable, Identifiable {
        case ide = 0
        case playground = 1
        
        var id: Int { rawValue }
    }
    
    @State private var sandboxMode: SandboxMode = .ide
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                switch sandboxMode {
                case .ide:
                    IDEMainView()
                case .playground:
                    PlaygroundView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Режим среды", selection: $sandboxMode) {
                        Text("IDE").tag(SandboxMode.ide)
                        Text(lang.localized("Скрипт", "Script")).tag(SandboxMode.playground)
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: 200)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    XPBadgeView()
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .selectIDE)) { _ in
                sandboxMode = .ide
            }
            .onReceive(NotificationCenter.default.publisher(for: .loadPlaygroundCode)) { _ in
                sandboxMode = .playground
            }
        }
    }
}
