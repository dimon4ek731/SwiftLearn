import SwiftUI

public struct SwiftSyntaxHighlighter {
    
    private static let keywords: Set<String> = [
        "associatedtype", "class", "deinit", "enum", "extension", "fileprivate",
        "func", "import", "init", "inout", "internal", "let", "open", "operator",
        "private", "protocol", "public", "rethrows", "static", "struct", "subscript",
        "typealias", "var", "break", "case", "continue", "default", "defer", "do",
        "else", "fallthrough", "for", "guard", "if", "in", "repeat", "return",
        "switch", "where", "while", "as", "catch", "false", "is", "nil", "super",
        "self", "Self", "throw", "throws", "true", "try", "async", "await", "actor",
        "some", "any", "mutating", "nonmutating", "override", "weak", "unowned",
        "@State", "@Binding", "@Observable", "@MainActor", "@Environment",
        "@Published", "@ObservedObject", "@StateObject", "@AppStorage"
    ]
    
    private static let builtInTypes: Set<String> = [
        "Int", "Int8", "Int16", "Int32", "Int64", "UInt", "UInt8", "UInt16", "UInt32", "UInt64",
        "Double", "Float", "CGFloat", "Bool", "String", "Character", "Substring",
        "Array", "Dictionary", "Set", "Optional", "Result", "Task", "Date", "UUID", "Data", "URL",
        "View", "Text", "VStack", "HStack", "ZStack", "List", "ScrollView", "Button",
        "Image", "Color", "Spacer", "Divider", "NavigationStack", "NavigationLink",
        "GeometryReader", "LazyVStack", "LazyHStack", "ForEach", "Toggle", "TextField"
    ]
    
    /// Parses Swift source code and produces an AttributedString styled according to the IDETheme.
    public static func highlight(code: String, theme: IDETheme) -> AttributedString {
        var result = AttributedString(code)
        // Default base styling
        result.foregroundColor = theme.textColor.color
        result.font = .system(size: CGFloat(theme.fontSize), weight: .regular, design: .monospaced)
        
        let nsString = code as NSString
        let fullRange = NSRange(location: 0, length: nsString.length)
        guard fullRange.length > 0 else { return result }
        
        // 1. Comments: // ... or /* ... */
        applyRegex(
            pattern: "(//.*$)|(/\\*[\\s\\S]*?\\*/)",
            options: [.anchorsMatchLines],
            in: nsString,
            fullRange: fullRange
        ) { range in
            if let attributedRange = Range(range, in: result) {
                result[attributedRange].foregroundColor = theme.commentColor.color
                result[attributedRange].font = .system(size: CGFloat(theme.fontSize), weight: .regular, design: .monospaced).italic()
            }
        }
        
        // 2. Strings: "..." or """..."""
        applyRegex(
            pattern: "\"(\\\\.|[^\"])*\"|\"\"\"[\\s\\S]*?\"\"\"",
            options: [],
            in: nsString,
            fullRange: fullRange
        ) { range in
            if let attributedRange = Range(range, in: result) {
                result[attributedRange].foregroundColor = theme.stringColor.color
            }
        }
        
        // 3. Numbers: integers, floats, hex
        applyRegex(
            pattern: "\\b(0x[0-9a-fA-F]+|\\d+\\.\\d+|\\d+)\\b",
            options: [],
            in: nsString,
            fullRange: fullRange
        ) { range in
            if let attributedRange = Range(range, in: result) {
                result[attributedRange].foregroundColor = theme.numberColor.color
            }
        }
        
        // 4. Identifiers and Keywords
        applyRegex(
            pattern: "@?[a-zA-Z_][a-zA-Z0-9_]*",
            options: [],
            in: nsString,
            fullRange: fullRange
        ) { range in
            let word = nsString.substring(with: range)
            if let attributedRange = Range(range, in: result) {
                if keywords.contains(word) {
                    result[attributedRange].foregroundColor = theme.keywordColor.color
                    result[attributedRange].font = .system(size: CGFloat(theme.fontSize), weight: .semibold, design: .monospaced)
                } else if builtInTypes.contains(word) || (word.first?.isUppercase == true && !word.contains("_")) {
                    result[attributedRange].foregroundColor = theme.typeColor.color
                }
            }
        }
        
        // 5. Function Call identifiers: foo(...)
        applyRegex(
            pattern: "\\b([a-zA-Z_][a-zA-Z0-9_]*)(?=\\s*\\()",
            options: [],
            in: nsString,
            fullRange: fullRange
        ) { range in
            let word = nsString.substring(with: range)
            if !keywords.contains(word) && !builtInTypes.contains(word) && word.first?.isUppercase != true {
                if let attributedRange = Range(range, in: result) {
                    result[attributedRange].foregroundColor = theme.callColor.color
                }
            }
        }
        
        return result
    }
    
    private static func applyRegex(
        pattern: String,
        options: NSRegularExpression.Options,
        in nsString: NSString,
        fullRange: NSRange,
        handler: (NSRange) -> Void
    ) {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else { return }
        let matches = regex.matches(in: nsString as String, options: [], range: fullRange)
        for match in matches {
            handler(match.range)
        }
    }
}
