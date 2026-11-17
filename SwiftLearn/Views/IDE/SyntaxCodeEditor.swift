import SwiftUI
import UIKit

public struct SyntaxCodeEditor: UIViewRepresentable {
    @Binding var text: String
    var theme: IDETheme
    var onTextChange: ((String) -> Void)?
    var onSuggestionChange: ((String?) -> Void)?
    
    public init(
        text: Binding<String>,
        theme: IDETheme,
        onTextChange: ((String) -> Void)? = nil,
        onSuggestionChange: ((String?) -> Void)? = nil
    ) {
        self._text = text
        self.theme = theme
        self.onTextChange = onTextChange
        self.onSuggestionChange = onSuggestionChange
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public func sizeThatFits(_ proposal: ProposedViewSize, uiView: CodeEditorContainerView, context: Context) -> CGSize? {
        return proposal.replacingUnspecifiedDimensions()
    }
    
    public func makeUIView(context: Context) -> CodeEditorContainerView {
        let container = CodeEditorContainerView(theme: theme)
        container.textView.delegate = context.coordinator
        container.onSuggestionChange = onSuggestionChange
        context.coordinator.container = container
        container.updateContent(text: text, theme: theme)
        return container
    }
    
    public func updateUIView(_ uiView: CodeEditorContainerView, context: Context) {
        context.coordinator.parent = self
        uiView.onSuggestionChange = onSuggestionChange
        if uiView.textView.text != text {
            uiView.updateContent(text: text, theme: theme)
        } else if uiView.currentTheme != theme {
            uiView.applyTheme(theme)
        }
    }
    
    public class Coordinator: NSObject, UITextViewDelegate {
        var parent: SyntaxCodeEditor
        weak var container: CodeEditorContainerView?
        private var isHighlighting = false
        
        init(_ parent: SyntaxCodeEditor) {
            self.parent = parent
        }
        
        public func textViewDidChange(_ textView: UITextView) {
            guard !isHighlighting else { return }
            isHighlighting = true
            
            let newText = textView.text ?? ""
            parent.text = newText
            parent.onTextChange?(newText)
            
            // Re-apply syntax highlighting while preserving cursor position
            let selectedRange = textView.selectedRange
            container?.applySyntaxHighlighting(newText)
            textView.selectedRange = selectedRange
            
            container?.gutterView.setNeedsDisplay()
            container?.updateGhostText()
            isHighlighting = false
        }
        
        public func textViewDidChangeSelection(_ textView: UITextView) {
            container?.updateGhostText()
        }
        
        public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            // When Enter or Tab is pressed and ghost autocomplete is active -> Accept Completion!
            if text == "\n" || text == "\t" {
                if let container = container, container.activeCompletion != nil {
                    container.acceptActiveCompletion()
                    return false
                }
            }
            return true
        }
        
        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            container?.gutterView.setNeedsDisplay()
            container?.updateGhostTextPosition()
        }
    }
}

public extension Notification.Name {
    static let acceptCodeCompletion = Notification.Name("acceptCodeCompletion")
}

// MARK: - CodeEditorContainerView (Gutter + UITextView + Ghost Text)
public final class CodeEditorContainerView: UIView {
    public let textView: UITextView
    public let gutterView: GutterView
    public let ghostLabel: UILabel
    public private(set) var currentTheme: IDETheme
    
    public var onSuggestionChange: ((String?) -> Void)?
    
    public struct ActiveCompletion {
        public let item: CompletionItem
        public let wordRange: NSRange
        public let suffix: String
    }
    
    public private(set) var activeCompletion: ActiveCompletion?
    private let gutterWidth: CGFloat = 38
    
    public init(theme: IDETheme) {
        self.currentTheme = theme
        
        // TextKit 1 layout manager setup
        let textStorage = NSTextStorage()
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: .zero)
        textContainer.widthTracksTextView = true
        layoutManager.addTextContainer(textContainer)
        
        self.textView = UITextView(frame: .zero, textContainer: textContainer)
        self.gutterView = GutterView(textView: textView, theme: theme, gutterWidth: gutterWidth)
        self.ghostLabel = UILabel()
        
        super.init(frame: .zero)
        setupViews()
        applyTheme(theme)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return size
    }
    
    private func setupViews() {
        clipsToBounds = true
        
        gutterView.clipsToBounds = true
        textView.clipsToBounds = true
        
        addSubview(gutterView)
        addSubview(textView)
        
        // Ghost text label lives inside textView so it scrolls naturally with text
        ghostLabel.isHidden = true
        ghostLabel.numberOfLines = 1
        ghostLabel.backgroundColor = .clear
        textView.addSubview(ghostLabel)
        
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.smartQuotesType = .no
        textView.smartDashesType = .no
        textView.smartInsertDeleteType = .no
        textView.keyboardType = .asciiCapable
        textView.isScrollEnabled = true
        textView.alwaysBounceVertical = true
        textView.showsVerticalScrollIndicator = true
        textView.showsHorizontalScrollIndicator = false
        textView.contentInset = UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 8)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleAcceptNotification),
            name: .acceptCodeCompletion,
            object: nil
        )
    }
    
    @objc private func handleAcceptNotification() {
        acceptActiveCompletion()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let showGutter = currentTheme.showLineNumbers
        let effectiveGutterWidth = showGutter ? dynamicGutterWidth : 0
        
        gutterView.isHidden = !showGutter
        gutterView.frame = CGRect(x: 0, y: 0, width: effectiveGutterWidth, height: bounds.height)
        textView.frame = CGRect(x: effectiveGutterWidth, y: 0, width: bounds.width - effectiveGutterWidth, height: bounds.height)
        
        gutterView.setNeedsDisplay()
        updateGhostTextPosition()
    }
    
    private var dynamicGutterWidth: CGFloat {
        let text = textView.text ?? ""
        let lineCount = max(1, text.components(separatedBy: "\n").count)
        let digits = max(2, String(lineCount).count)
        let font = UIFont.monospacedDigitSystemFont(ofSize: CGFloat(max(9, currentTheme.fontSize - 2)), weight: .regular)
        let sample = String(repeating: "8", count: digits) as NSString
        let width = sample.size(withAttributes: [.font: font]).width
        return max(36, ceil(width + 16))
    }
    
    public func updateContent(text: String, theme: IDETheme) {
        self.currentTheme = theme
        textView.text = text
        applyTheme(theme)
        applySyntaxHighlighting(text)
        gutterView.setNeedsDisplay()
        clearCompletion()
    }
    
    public func applyTheme(_ theme: IDETheme) {
        self.currentTheme = theme
        backgroundColor = UIColor(theme.backgroundColor.color)
        textView.backgroundColor = UIColor(theme.backgroundColor.color)
        textView.tintColor = UIColor(Color(red: 0.14, green: 0.38, blue: 0.82))
        gutterView.updateTheme(theme)
        applySyntaxHighlighting(textView.text)
        setNeedsLayout()
    }
    
    // MARK: - Auto-Completion & Ghost Text
    public func updateGhostText() {
        guard currentTheme.enableAutocomplete else {
            clearCompletion()
            return
        }
        guard let selectedRange = textView.selectedTextRange, selectedRange.isEmpty else {
            clearCompletion()
            return
        }
        
        let nsText = (textView.text ?? "") as NSString
        let cursorOffset = textView.offset(from: textView.beginningOfDocument, to: selectedRange.start)
        guard cursorOffset >= 0, cursorOffset <= nsText.length else {
            clearCompletion()
            return
        }
        
        // Scan backwards to find the word prefix currently being typed
        var start = cursorOffset
        while start > 0 {
            let prevChar = nsText.substring(with: NSRange(location: start - 1, length: 1))
            if prevChar.rangeOfCharacter(from: CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "@."))) != nil {
                start -= 1
            } else {
                break
            }
        }
        
        let wordLength = cursorOffset - start
        guard wordLength >= 2 else {
            clearCompletion()
            return
        }
        
        let wordRange = NSRange(location: start, length: wordLength)
        let currentWord = nsText.substring(with: wordRange)
        
        if let match = SwiftCompletionEngine.shared.findMatch(for: currentWord) {
            self.activeCompletion = ActiveCompletion(
                item: match.item,
                wordRange: wordRange,
                suffix: match.suffix
            )
            
            ghostLabel.text = match.suffix
            ghostLabel.font = UIFont.monospacedSystemFont(ofSize: CGFloat(currentTheme.fontSize), weight: .regular)
            ghostLabel.textColor = UIColor.placeholderText.withAlphaComponent(0.65)
            ghostLabel.sizeToFit()
            
            updateGhostTextPosition()
            ghostLabel.isHidden = false
            onSuggestionChange?(match.item.displayText)
        } else {
            clearCompletion()
        }
    }
    
    public func updateGhostTextPosition() {
        guard activeCompletion != nil, let selectedRange = textView.selectedTextRange else {
            ghostLabel.isHidden = true
            return
        }
        let caretRect = textView.caretRect(for: selectedRange.start)
        ghostLabel.frame = CGRect(
            x: caretRect.maxX + 1,
            y: caretRect.minY + (caretRect.height - ghostLabel.bounds.height) / 2,
            width: ghostLabel.bounds.width + 4,
            height: ghostLabel.bounds.height
        )
    }
    
    public func clearCompletion() {
        activeCompletion = nil
        ghostLabel.isHidden = true
        ghostLabel.text = ""
        onSuggestionChange?(nil)
    }
    
    public func acceptActiveCompletion() {
        guard let comp = activeCompletion else { return }
        let insertText = comp.item.insertText
        let currentText = (textView.text ?? "") as NSString
        
        guard comp.wordRange.location + comp.wordRange.length <= currentText.length else {
            clearCompletion()
            return
        }
        
        let updatedText = currentText.replacingCharacters(in: comp.wordRange, with: insertText)
        let newCursorOffset = comp.wordRange.location + insertText.count + comp.item.cursorOffsetFromEnd
        
        textView.text = updatedText
        applySyntaxHighlighting(updatedText)
        
        if let newPos = textView.position(from: textView.beginningOfDocument, offset: newCursorOffset) {
            textView.selectedTextRange = textView.textRange(from: newPos, to: newPos)
        }
        
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        clearCompletion()
        gutterView.setNeedsDisplay()
        
        // Notify SwiftUI
        textView.delegate?.textViewDidChange?(textView)
    }
    
    // MARK: - Syntax Highlighting
    public func applySyntaxHighlighting(_ text: String) {
        let textStorage = textView.textStorage
        let fontSize = CGFloat(currentTheme.fontSize)
        let font = UIFont.monospacedSystemFont(ofSize: fontSize, weight: .regular)
        let boldFont = UIFont.monospacedSystemFont(ofSize: fontSize, weight: .semibold)
        let italicFont = UIFont.italicSystemFont(ofSize: fontSize)
        
        let defaultAttrs: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor(currentTheme.textColor.color)
        ]
        
        textStorage.beginEditing()
        textStorage.setAttributes(defaultAttrs, range: NSRange(location: 0, length: textStorage.length))
        
        let nsString = textStorage.string as NSString
        let fullRange = NSRange(location: 0, length: nsString.length)
        guard fullRange.length > 0 else {
            textStorage.endEditing()
            return
        }
        
        // 1. Comments
        applyRegex(
            pattern: "(//.*$)|(/\\*[\\s\\S]*?\\*/)",
            options: [.anchorsMatchLines],
            in: nsString,
            fullRange: fullRange
        ) { range in
            textStorage.addAttributes([
                .foregroundColor: UIColor(self.currentTheme.commentColor.color),
                .font: italicFont
            ], range: range)
        }
        
        // 2. Strings
        applyRegex(
            pattern: "\"(\\\\.|[^\"])*\"|\"\"\"[\\s\\S]*?\"\"\"",
            options: [],
            in: nsString,
            fullRange: fullRange
        ) { range in
            textStorage.addAttributes([
                .foregroundColor: UIColor(self.currentTheme.stringColor.color)
            ], range: range)
        }
        
        // 3. Numbers
        applyRegex(
            pattern: "\\b(0x[0-9a-fA-F]+|\\d+\\.\\d+|\\d+)\\b",
            options: [],
            in: nsString,
            fullRange: fullRange
        ) { range in
            textStorage.addAttributes([
                .foregroundColor: UIColor(self.currentTheme.numberColor.color)
            ], range: range)
        }
        
        // 4. Keywords
        applyRegex(
            pattern: "@?[a-zA-Z_][a-zA-Z0-9_]*",
            options: [],
            in: nsString,
            fullRange: fullRange
        ) { range in
            let word = nsString.substring(with: range)
            if SyntaxRules.keywords.contains(word) {
                textStorage.addAttributes([
                    .foregroundColor: UIColor(self.currentTheme.keywordColor.color),
                    .font: boldFont
                ], range: range)
            } else if SyntaxRules.builtInTypes.contains(word) || (word.first?.isUppercase == true && !word.contains("_")) {
                textStorage.addAttributes([
                    .foregroundColor: UIColor(self.currentTheme.typeColor.color)
                ], range: range)
            }
        }
        
        // 5. Function calls
        applyRegex(
            pattern: "\\b([a-zA-Z_][a-zA-Z0-9_]*)(?=\\s*\\()",
            options: [],
            in: nsString,
            fullRange: fullRange
        ) { range in
            let word = nsString.substring(with: range)
            if !SyntaxRules.keywords.contains(word) && !SyntaxRules.builtInTypes.contains(word) && word.first?.isUppercase != true {
                textStorage.addAttributes([
                    .foregroundColor: UIColor(self.currentTheme.callColor.color)
                ], range: range)
            }
        }
        
        textStorage.endEditing()
    }
    
    private func applyRegex(
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

// MARK: - GutterView (Pixel-perfect Line Numbers)
public final class GutterView: UIView {
    private weak var textView: UITextView?
    private var theme: IDETheme
    private let gutterWidth: CGFloat
    
    public init(textView: UITextView, theme: IDETheme, gutterWidth: CGFloat) {
        self.textView = textView
        self.theme = theme
        self.gutterWidth = gutterWidth
        super.init(frame: .zero)
        backgroundColor = UIColor(theme.gutterColor.color)
        isOpaque = true
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateTheme(_ theme: IDETheme) {
        self.theme = theme
        backgroundColor = UIColor(theme.gutterColor.color)
        setNeedsDisplay()
    }
    
    public override func draw(_ rect: CGRect) {
        guard let textView = textView else { return }
        let layoutManager = textView.layoutManager
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.clip(to: bounds)
        
        // 1. Draw Gutter Background
        context.setFillColor(UIColor(theme.gutterColor.color).cgColor)
        context.fill(bounds)
        
        // 2. Draw subtle right divider line
        context.setStrokeColor(UIColor.separator.withAlphaComponent(0.2).cgColor)
        context.setLineWidth(1.0)
        context.move(to: CGPoint(x: bounds.width - 0.5, y: 0))
        context.addLine(to: CGPoint(x: bounds.width - 0.5, y: bounds.height))
        context.strokePath()
        
        // 3. Draw line numbers matching visible glyphs
        let font = UIFont.monospacedDigitSystemFont(ofSize: CGFloat(max(9, theme.fontSize - 2)), weight: .regular)
        let numberAttrs: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor(theme.lineNumberColor.color)
        ]
        
        let text = textView.text ?? ""
        let nsText = text as NSString
        let totalLen = nsText.length
        
        // Ensure TextKit layout and glyphs are computed
        layoutManager.ensureLayout(forCharacterRange: NSRange(location: 0, length: totalLen))
        
        let contentOffsetY = textView.contentOffset.y
        let topInset = textView.contentInset.top
        
        var charIndex = 0
        var lineNumber = 1
        
        while charIndex < totalLen {
            let lineRange = nsText.lineRange(for: NSRange(location: charIndex, length: 0))
            let glyphIndex = layoutManager.glyphIndexForCharacter(at: lineRange.location)
            let lineRect = layoutManager.lineFragmentRect(forGlyphAt: glyphIndex, effectiveRange: nil)
            
            let screenY = lineRect.origin.y - contentOffsetY + topInset
            
            if screenY + lineRect.height >= 0 && screenY <= bounds.height {
                let numberString = "\(lineNumber)" as NSString
                let stringSize = numberString.size(withAttributes: numberAttrs)
                let drawX = bounds.width - 6 - stringSize.width
                let drawY = screenY + (lineRect.height - stringSize.height) / 2
                
                numberString.draw(at: CGPoint(x: drawX, y: drawY), withAttributes: numberAttrs)
            }
            
            charIndex = NSMaxRange(lineRange)
            lineNumber += 1
        }
        
        // Handle trailing newline extra line fragment (when text ends in \n or is empty)
        if layoutManager.extraLineFragmentRect.height > 0 {
            let extraRect = layoutManager.extraLineFragmentRect
            let screenY = extraRect.origin.y - contentOffsetY + topInset
            
            if screenY + extraRect.height >= 0 && screenY <= bounds.height {
                let numberString = "\(lineNumber)" as NSString
                let stringSize = numberString.size(withAttributes: numberAttrs)
                let drawX = bounds.width - 6 - stringSize.width
                let drawY = screenY + (extraRect.height - stringSize.height) / 2
                
                numberString.draw(at: CGPoint(x: drawX, y: drawY), withAttributes: numberAttrs)
            }
        }
    }
}

// MARK: - Syntax Rules Constants
private enum SyntaxRules {
    static let keywords: Set<String> = [
        // Swift Keywords
        "associatedtype", "class", "deinit", "enum", "extension", "fileprivate",
        "func", "import", "init", "inout", "internal", "let", "open", "operator",
        "private", "protocol", "public", "rethrows", "static", "struct", "subscript",
        "typealias", "var", "break", "case", "continue", "default", "defer", "do",
        "else", "fallthrough", "for", "guard", "if", "in", "repeat", "return",
        "switch", "where", "while", "as", "catch", "false", "is", "nil", "super",
        "self", "Self", "throw", "throws", "true", "try", "async", "await", "actor",
        "some", "any", "mutating", "nonmutating", "override", "weak", "unowned",
        "@State", "@Binding", "@Observable", "@MainActor", "@Environment",
        "@Published", "@ObservedObject", "@StateObject", "@AppStorage",
        
        // Python Keywords
        "def", "lambda", "None", "True", "False", "elif", "pass", "raise", "from",
        "with", "yield", "finally", "except", "global", "nonlocal", "assert",
        "not", "and", "or",
        
        // C# Keywords
        "using", "namespace", "protected", "void", "string", "int", "double", "float",
        "bool", "char", "object", "record", "interface", "new", "null", "this", "base",
        "foreach", "typeof", "sizeof", "stackalloc", "checked", "unchecked",
        "lock", "yield", "partial", "ref", "out", "params", "sealed", "virtual",
        "abstract", "extern", "event", "delegate", "fixed", "stackalloc",
        
        // SQL Keywords
        "SELECT", "select", "FROM", "from", "WHERE", "where", "JOIN", "join", "INNER", "inner",
        "LEFT", "left", "RIGHT", "right", "FULL", "full", "ON", "on", "GROUP", "group",
        "BY", "by", "HAVING", "having", "ORDER", "order", "ASC", "asc", "DESC", "desc",
        "LIMIT", "limit", "OFFSET", "offset", "CREATE", "create", "TABLE", "table",
        "INSERT", "insert", "INTO", "into", "VALUES", "values", "UPDATE", "update",
        "SET", "set", "DELETE", "delete", "PRIMARY", "primary", "KEY", "key",
        "FOREIGN", "foreign", "REFERENCES", "references", "DISTINCT", "distinct",
        "UNION", "union", "ALL", "all", "LIKE", "like", "BETWEEN", "between",
        "OVER", "over", "PARTITION", "partition"
    ]
    
    static let builtInTypes: Set<String> = [
        // Swift Types
        "Int", "Int8", "Int16", "Int32", "Int64", "UInt", "UInt8", "UInt16", "UInt32", "UInt64",
        "Double", "Float", "CGFloat", "Bool", "String", "Character", "Substring",
        "Array", "Dictionary", "Set", "Optional", "Result", "Task", "Date", "UUID", "Data", "URL",
        "View", "Text", "VStack", "HStack", "ZStack", "List", "ScrollView", "Button",
        "Image", "Color", "Spacer", "Divider", "NavigationStack", "NavigationLink",
        "GeometryReader", "LazyVStack", "LazyHStack", "ForEach", "Toggle", "TextField",
        
        // Python Types & Builtins
        "int", "float", "str", "list", "dict", "tuple", "set", "bool", "bytes", "bytearray",
        "range", "len", "print", "type", "isinstance", "enumerate", "zip", "filter", "map",
        
        // C# Types & .NET
        "Console", "List", "Dictionary", "HashSet", "IEnumerable", "ICollection", "IList",
        "Task", "Action", "Func", "Math", "DateTime", "Guid", "HttpClient", "StringBuilder",
        
        // SQL Types & Aggregations
        "INTEGER", "TEXT", "REAL", "BLOB", "VARCHAR", "BOOLEAN", "TIMESTAMP", "DATE",
        "COUNT", "SUM", "AVG", "MIN", "MAX", "ROW_NUMBER", "RANK", "DENSE_RANK", "COALESCE"
    ]
}
