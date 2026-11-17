import SwiftUI
import UIKit

public struct CodeBlockView: View {
    public let code: String
    public var title: String? = nil
    @State private var copied = false
    
    public init(code: String, title: String? = nil) {
        self.code = code
        self.title = title
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header bar
            HStack {
                HStack(spacing: 6) {
                    Circle().fill(Color.red.opacity(0.8)).frame(width: 10, height: 10)
                    Circle().fill(Color.yellow.opacity(0.8)).frame(width: 10, height: 10)
                    Circle().fill(Color.green.opacity(0.8)).frame(width: 10, height: 10)
                    
                    if let title = title {
                        Text(title)
                            .font(.system(.caption, design: .monospaced))
                            .foregroundColor(.gray)
                            .padding(.leading, 6)
                    } else {
                        Text("Swift")
                            .font(.system(.caption, design: .monospaced))
                            .foregroundColor(.gray)
                            .padding(.leading, 6)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    UIPasteboard.general.string = code
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    withAnimation {
                        copied = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            copied = false
                        }
                    }
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: copied ? "checkmark" : "doc.on.doc")
                        Text(copied
                             ? LanguageManager.shared.localized("Скопировано", "Copied")
                             : LanguageManager.shared.localized("Копировать", "Copy"))
                    }
                    .font(.caption2.bold())
                    .foregroundColor(copied ? .green : .white.opacity(0.8))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.white.opacity(0.12))
                    .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(red: 0.12, green: 0.13, blue: 0.15))
            
            Divider().background(Color.white.opacity(0.1))
            
            // Code lines with full Xcode Dark syntax highlighting
            ScrollView(.horizontal, showsIndicators: false) {
                Text(SwiftSyntaxHighlighter.highlight(code: code, theme: IDETheme.forPreset(.xcodeDark)))
                    .lineSpacing(5)
                    .padding(12)
            }
        }
        .background(Color(red: 0.08, green: 0.09, blue: 0.11))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.15), lineWidth: 1)
        )
    }
}
