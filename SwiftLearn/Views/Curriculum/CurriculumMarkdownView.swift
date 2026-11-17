import SwiftUI

// MARK: - Markdown Block Model
public enum MarkdownBlock: Identifiable {
    public var id: String {
        switch self {
        case .heading(let level, _, let id):
            return "h_\(level)_\(id)"
        case .code(let lang, _, let id):
            return "code_\(lang)_\(id)"
        case .callout(let type, _, _, let id):
            return "callout_\(type.rawValue)_\(id)"
        case .bulletList(_, let id):
            return "bullet_\(id)"
        case .numberedList(_, let id):
            return "num_\(id)"
        case .paragraph(_, let id):
            return "p_\(id)"
        }
    }
    
    case heading(level: Int, text: String, id: Int)
    case code(language: String, code: String, id: Int)
    case callout(type: MarkdownCalloutType, title: String?, content: String, id: Int)
    case bulletList(items: [String], id: Int)
    case numberedList(items: [(number: Int, text: String)], id: Int)
    case paragraph(text: String, id: Int)
}

public enum MarkdownCalloutType: String {
    case note
    case tip
    case important
    case warning
    
    public var icon: String {
        switch self {
        case .note: return "info.circle.fill"
        case .tip: return "lightbulb.fill"
        case .important: return "exclamationmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        }
    }
    
    public var accentColor: Color {
        switch self {
        case .note: return Color(red: 0.14, green: 0.48, blue: 0.95) // System Blue
        case .tip: return Color(red: 0.18, green: 0.68, blue: 0.45) // Emerald Green
        case .important: return Color(red: 0.95, green: 0.55, blue: 0.15) // Amber
        case .warning: return Color(red: 0.92, green: 0.28, blue: 0.25) // Ruby
        }
    }
    
    public var defaultTitleRU: String {
        switch self {
        case .note: return "Примечание"
        case .tip: return "Совет эксперта"
        case .important: return "Важно знать"
        case .warning: return "Внимание"
        }
    }
    
    public var defaultTitleEN: String {
        switch self {
        case .note: return "Note"
        case .tip: return "Pro Tip"
        case .important: return "Important"
        case .warning: return "Warning"
        }
    }
}

// MARK: - Curriculum Markdown View
public struct CurriculumMarkdownView: View {
    public let markdown: String
    @ObservedObject var lang = LanguageManager.shared
    
    private var blocks: [MarkdownBlock] {
        CurriculumMarkdownParser.parse(markdown)
    }
    
    public init(markdown: String) {
        self.markdown = markdown
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            ForEach(blocks) { block in
                switch block {
                case .heading(let level, let text, _):
                    headingView(level: level, text: text)
                    
                case .code(let lang, let code, _):
                    CodeBlockView(code: code, title: lang.isEmpty ? "Swift" : lang.uppercased())
                        .padding(.vertical, 4)
                    
                case .callout(let type, let title, let content, _):
                    calloutView(type: type, title: title, content: content)
                    
                case .bulletList(let items, _):
                    bulletListView(items: items)
                    
                case .numberedList(let items, _):
                    numberedListView(items: items)
                    
                case .paragraph(let text, _):
                    paragraphView(text: text)
                }
            }
        }
    }
    
    // MARK: - Subviews
    @ViewBuilder
    private func headingView(level: Int, text: String) -> some View {
        HStack(alignment: .center, spacing: 8) {
            Capsule()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.14, green: 0.38, blue: 0.88),
                            Color(red: 0.35, green: 0.58, blue: 0.98)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 4, height: level == 1 ? 24 : (level == 2 ? 20 : 16))
            
            Text(CurriculumMarkdownParser.renderInlineMarkdown(text))
                .font(level == 1 ? .title2.weight(.bold) : (level == 2 ? .title3.weight(.bold) : .headline.weight(.bold)))
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.top, level == 1 ? 16 : 10)
    }
    
    @ViewBuilder
    private func calloutView(type: MarkdownCalloutType, title: String?, content: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: type.icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(type.accentColor)
                .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title ?? (lang.currentLanguage == .russian ? type.defaultTitleRU : type.defaultTitleEN))
                    .font(.subheadline.bold())
                    .foregroundColor(type.accentColor)
                
                Text(CurriculumMarkdownParser.renderInlineMarkdown(content))
                    .font(.subheadline)
                    .lineSpacing(4)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer(minLength: 0)
        }
        .padding(14)
        .background(type.accentColor.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(type.accentColor.opacity(0.24), lineWidth: 1)
        )
        .padding(.vertical, 4)
    }
    
    @ViewBuilder
    private func bulletListView(items: [String]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                HStack(alignment: .top, spacing: 10) {
                    Circle()
                        .fill(Color(red: 0.14, green: 0.38, blue: 0.88))
                        .frame(width: 6, height: 6)
                        .padding(.top, 8)
                    
                    Text(CurriculumMarkdownParser.renderInlineMarkdown(item))
                        .font(.body)
                        .lineSpacing(5)
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .padding(.vertical, 2)
    }
    
    @ViewBuilder
    private func numberedListView(items: [(number: Int, text: String)]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(items, id: \.number) { num, item in
                HStack(alignment: .top, spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.14, green: 0.38, blue: 0.88).opacity(0.14))
                            .frame(width: 22, height: 22)
                        
                        Text("\(num)")
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.14, green: 0.38, blue: 0.88))
                    }
                    .padding(.top, 2)
                    
                    Text(CurriculumMarkdownParser.renderInlineMarkdown(item))
                        .font(.body)
                        .lineSpacing(5)
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .padding(.vertical, 2)
    }
    
    @ViewBuilder
    private func paragraphView(text: String) -> some View {
        Text(CurriculumMarkdownParser.renderInlineMarkdown(text))
            .font(.body)
            .lineSpacing(5)
            .foregroundColor(.primary)
            .fixedSize(horizontal: false, vertical: true)
    }
}

// MARK: - Markdown Parser & AttributedString Engine
public struct CurriculumMarkdownParser {
    
    public static func parse(_ raw: String) -> [MarkdownBlock] {
        let lines = raw.components(separatedBy: .newlines)
        var blocks: [MarkdownBlock] = []
        var i = 0
        var blockId = 0
        
        while i < lines.count {
            let line = lines[i]
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            
            // 1. Skip empty lines
            if trimmed.isEmpty {
                i += 1
                continue
            }
            
            // 2. Fenced code block: ```
            if trimmed.hasPrefix("```") {
                let lang = trimmed.replacingOccurrences(of: "```", with: "").trimmingCharacters(in: .whitespaces)
                var codeLines: [String] = []
                i += 1
                while i < lines.count && !lines[i].trimmingCharacters(in: .whitespaces).hasPrefix("```") {
                    codeLines.append(lines[i])
                    i += 1
                }
                if i < lines.count && lines[i].trimmingCharacters(in: .whitespaces).hasPrefix("```") {
                    i += 1
                }
                blocks.append(.code(language: lang, code: codeLines.joined(separator: "\n"), id: blockId))
                blockId += 1
                continue
            }
            
            // 3. Headings: ###, ##, #
            if trimmed.hasPrefix("### ") {
                let text = String(trimmed.dropFirst(4)).trimmingCharacters(in: .whitespaces)
                blocks.append(.heading(level: 3, text: text, id: blockId))
                blockId += 1
                i += 1
                continue
            } else if trimmed.hasPrefix("## ") {
                let text = String(trimmed.dropFirst(3)).trimmingCharacters(in: .whitespaces)
                blocks.append(.heading(level: 2, text: text, id: blockId))
                blockId += 1
                i += 1
                continue
            } else if trimmed.hasPrefix("# ") {
                let text = String(trimmed.dropFirst(2)).trimmingCharacters(in: .whitespaces)
                blocks.append(.heading(level: 1, text: text, id: blockId))
                blockId += 1
                i += 1
                continue
            }
            
            // 4. Blockquote / Callout: >
            if trimmed.hasPrefix(">") {
                var calloutLines: [String] = []
                var calloutType: MarkdownCalloutType = .note
                let customTitle: String? = nil
                
                while i < lines.count && lines[i].trimmingCharacters(in: .whitespaces).hasPrefix(">") {
                    var cLine = lines[i].trimmingCharacters(in: .whitespaces)
                    cLine.removeFirst()
                    if cLine.hasPrefix(" ") { cLine.removeFirst() }
                    
                    if calloutLines.isEmpty {
                        let upper = cLine.uppercased()
                        if upper.contains("[!NOTE]") || upper.contains("NOTE:") || upper.contains("ПРИМЕЧАНИЕ:") {
                            calloutType = .note
                            cLine = cLine.replacingOccurrences(of: "\\[!NOTE\\]", with: "", options: .regularExpression).trimmingCharacters(in: .whitespaces)
                        } else if upper.contains("[!TIP]") || upper.contains("TIP:") || upper.contains("СОВЕТ:") {
                            calloutType = .tip
                            cLine = cLine.replacingOccurrences(of: "\\[!TIP\\]", with: "", options: .regularExpression).trimmingCharacters(in: .whitespaces)
                        } else if upper.contains("[!IMPORTANT]") || upper.contains("IMPORTANT:") || upper.contains("ВАЖНО:") {
                            calloutType = .important
                            cLine = cLine.replacingOccurrences(of: "\\[!IMPORTANT\\]", with: "", options: .regularExpression).trimmingCharacters(in: .whitespaces)
                        } else if upper.contains("[!WARNING]") || upper.contains("WARNING:") || upper.contains("ВНИМАНИЕ:") {
                            calloutType = .warning
                            cLine = cLine.replacingOccurrences(of: "\\[!WARNING\\]", with: "", options: .regularExpression).trimmingCharacters(in: .whitespaces)
                        }
                    }
                    
                    if !cLine.isEmpty {
                        calloutLines.append(cLine)
                    }
                    i += 1
                }
                
                blocks.append(.callout(type: calloutType, title: customTitle, content: calloutLines.joined(separator: "\n"), id: blockId))
                blockId += 1
                continue
            }
            
            // 5. Bullet list: - or *
            if trimmed.hasPrefix("- ") || trimmed.hasPrefix("* ") {
                var items: [String] = []
                while i < lines.count {
                    let cur = lines[i].trimmingCharacters(in: .whitespaces)
                    if cur.hasPrefix("- ") {
                        items.append(String(cur.dropFirst(2)).trimmingCharacters(in: .whitespaces))
                        i += 1
                    } else if cur.hasPrefix("* ") {
                        items.append(String(cur.dropFirst(2)).trimmingCharacters(in: .whitespaces))
                        i += 1
                    } else {
                        break
                    }
                }
                blocks.append(.bulletList(items: items, id: blockId))
                blockId += 1
                continue
            }
            
            // 6. Numbered list: 1. or 2.
            if let firstMatch = parseNumberedListItem(trimmed) {
                var items: [(number: Int, text: String)] = [firstMatch]
                i += 1
                while i < lines.count {
                    let cur = lines[i].trimmingCharacters(in: .whitespaces)
                    if let match = parseNumberedListItem(cur) {
                        items.append(match)
                        i += 1
                    } else {
                        break
                    }
                }
                blocks.append(.numberedList(items: items, id: blockId))
                blockId += 1
                continue
            }
            
            // 7. Regular paragraph
            var paragraphLines: [String] = []
            while i < lines.count {
                let cur = lines[i].trimmingCharacters(in: .whitespaces)
                if cur.isEmpty ||
                    cur.hasPrefix("```") ||
                    cur.hasPrefix("#") ||
                    cur.hasPrefix(">") ||
                    cur.hasPrefix("- ") ||
                    cur.hasPrefix("* ") ||
                    parseNumberedListItem(cur) != nil {
                    break
                }
                paragraphLines.append(lines[i])
                i += 1
            }
            if !paragraphLines.isEmpty {
                blocks.append(.paragraph(text: paragraphLines.joined(separator: "\n"), id: blockId))
                blockId += 1
            }
        }
        
        return blocks
    }
    
    private static func parseNumberedListItem(_ line: String) -> (number: Int, text: String)? {
        let pattern = "^(\\d+)\\.\\s+(.+)$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        let nsLine = line as NSString
        let range = NSRange(location: 0, length: nsLine.length)
        if let match = regex.firstMatch(in: line, range: range), match.numberOfRanges >= 3 {
            let numStr = nsLine.substring(with: match.range(at: 1))
            let text = nsLine.substring(with: match.range(at: 2))
            if let num = Int(numStr) {
                return (num, text)
            }
        }
        return nil
    }
    
    /// Parses inline Markdown (e.g., `code`, **bold**, *italic*) and applies Apple developer documentation color accents
    public static func renderInlineMarkdown(_ text: String) -> AttributedString {
        guard var attr = try? AttributedString(
            markdown: text,
            options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        ) else {
            return AttributedString(text)
        }
        
        for run in attr.runs {
            if run.inlinePresentationIntent?.contains(.code) == true {
                let range = run.range
                attr[range].font = .system(.subheadline, design: .monospaced).weight(.semibold)
                // Distinct Cupertino code token amber/coral tint
                attr[range].foregroundColor = Color(red: 0.88, green: 0.38, blue: 0.16)
                attr[range].backgroundColor = Color(red: 0.88, green: 0.38, blue: 0.16).opacity(0.12)
            } else if run.inlinePresentationIntent?.contains(.stronglyEmphasized) == true {
                let range = run.range
                attr[range].font = .body.weight(.bold)
                attr[range].foregroundColor = .primary
            }
        }
        
        return attr
    }
}
