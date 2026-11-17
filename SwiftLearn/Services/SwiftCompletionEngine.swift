import Foundation

public enum CompletionKind: String {
    case function = "func"
    case keyword = "key"
    case type = "type"
    case snippet = "snip"
    case modifier = "mod"
}

public struct CompletionItem: Equatable, Hashable {
    public let trigger: String        // Prefix to match against (lowercased)
    public let insertText: String     // Full text to insert: e.g. "print()"
    public let displayText: String    // Menu display text: e.g. "print(...)"
    public let cursorOffsetFromEnd: Int // e.g. -1 puts cursor inside print(|)
    public let kind: CompletionKind
    
    public init(
        trigger: String,
        insertText: String,
        displayText: String? = nil,
        cursorOffsetFromEnd: Int = 0,
        kind: CompletionKind = .function
    ) {
        self.trigger = trigger.lowercased()
        self.insertText = insertText
        self.displayText = displayText ?? insertText
        self.cursorOffsetFromEnd = cursorOffsetFromEnd
        self.kind = kind
    }
}

public struct SwiftCompletionEngine {
    
    public static let shared = SwiftCompletionEngine()
    
    public let database: [CompletionItem] = [
        // MARK: - Functions & Common Calls
        CompletionItem(trigger: "pri", insertText: "print()", displayText: "print(...)", cursorOffsetFromEnd: -1, kind: .function),
        CompletionItem(trigger: "prin", insertText: "print()", displayText: "print(...)", cursorOffsetFromEnd: -1, kind: .function),
        CompletionItem(trigger: "print", insertText: "print()", displayText: "print(...)", cursorOffsetFromEnd: -1, kind: .function),
        CompletionItem(trigger: "fatal", insertText: "fatalError(\"\")", displayText: "fatalError(\"...\")", cursorOffsetFromEnd: -2, kind: .function),
        CompletionItem(trigger: "precond", insertText: "precondition()", displayText: "precondition(...)", cursorOffsetFromEnd: -1, kind: .function),
        CompletionItem(trigger: "asser", insertText: "assert()", displayText: "assert(...)", cursorOffsetFromEnd: -1, kind: .function),
        CompletionItem(trigger: "max", insertText: "max()", displayText: "max(a, b)", cursorOffsetFromEnd: -1, kind: .function),
        CompletionItem(trigger: "min", insertText: "min()", displayText: "min(a, b)", cursorOffsetFromEnd: -1, kind: .function),
        CompletionItem(trigger: "zip", insertText: "zip()", displayText: "zip(a, b)", cursorOffsetFromEnd: -1, kind: .function),
        
        // MARK: - Keywords & Declarations
        CompletionItem(trigger: "fun", insertText: "func () {\n    \n}", displayText: "func name() { ... }", cursorOffsetFromEnd: -10, kind: .keyword),
        CompletionItem(trigger: "func", insertText: "func () {\n    \n}", displayText: "func name() { ... }", cursorOffsetFromEnd: -10, kind: .keyword),
        CompletionItem(trigger: "stru", insertText: "struct  {\n    \n}", displayText: "struct Name { ... }", cursorOffsetFromEnd: -8, kind: .keyword),
        CompletionItem(trigger: "struct", insertText: "struct  {\n    \n}", displayText: "struct Name { ... }", cursorOffsetFromEnd: -8, kind: .keyword),
        CompletionItem(trigger: "cla", insertText: "class  {\n    \n}", displayText: "class Name { ... }", cursorOffsetFromEnd: -8, kind: .keyword),
        CompletionItem(trigger: "class", insertText: "class  {\n    \n}", displayText: "class Name { ... }", cursorOffsetFromEnd: -8, kind: .keyword),
        CompletionItem(trigger: "enu", insertText: "enum  {\n    case \n}", displayText: "enum Name { ... }", cursorOffsetFromEnd: -13, kind: .keyword),
        CompletionItem(trigger: "enum", insertText: "enum  {\n    case \n}", displayText: "enum Name { ... }", cursorOffsetFromEnd: -13, kind: .keyword),
        CompletionItem(trigger: "pro", insertText: "protocol  {\n    \n}", displayText: "protocol Name { ... }", cursorOffsetFromEnd: -8, kind: .keyword),
        CompletionItem(trigger: "proto", insertText: "protocol  {\n    \n}", displayText: "protocol Name { ... }", cursorOffsetFromEnd: -8, kind: .keyword),
        CompletionItem(trigger: "ext", insertText: "extension  {\n    \n}", displayText: "extension Type { ... }", cursorOffsetFromEnd: -8, kind: .keyword),
        CompletionItem(trigger: "exten", insertText: "extension  {\n    \n}", displayText: "extension Type { ... }", cursorOffsetFromEnd: -8, kind: .keyword),
        CompletionItem(trigger: "imp", insertText: "import ", displayText: "import Module", cursorOffsetFromEnd: 0, kind: .keyword),
        CompletionItem(trigger: "impo", insertText: "import ", displayText: "import Module", cursorOffsetFromEnd: 0, kind: .keyword),
        CompletionItem(trigger: "import", insertText: "import ", displayText: "import Module", cursorOffsetFromEnd: 0, kind: .keyword),
        CompletionItem(trigger: "ret", insertText: "return ", displayText: "return value", cursorOffsetFromEnd: 0, kind: .keyword),
        CompletionItem(trigger: "retu", insertText: "return ", displayText: "return value", cursorOffsetFromEnd: 0, kind: .keyword),
        CompletionItem(trigger: "guard", insertText: "guard  else { return }", displayText: "guard condition else { return }", cursorOffsetFromEnd: -16, kind: .keyword),
        CompletionItem(trigger: "gua", insertText: "guard  else { return }", displayText: "guard condition else { return }", cursorOffsetFromEnd: -16, kind: .keyword),
        CompletionItem(trigger: "swi", insertText: "switch  {\ncase :\n    break\ndefault:\n    break\n}", displayText: "switch value { case ... }", cursorOffsetFromEnd: -38, kind: .keyword),
        CompletionItem(trigger: "switch", insertText: "switch  {\ncase :\n    break\ndefault:\n    break\n}", displayText: "switch value { case ... }", cursorOffsetFromEnd: -38, kind: .keyword),
        CompletionItem(trigger: "priv", insertText: "private ", displayText: "private var/func", cursorOffsetFromEnd: 0, kind: .keyword),
        CompletionItem(trigger: "pub", insertText: "public ", displayText: "public var/func", cursorOffsetFromEnd: 0, kind: .keyword),
        CompletionItem(trigger: "mut", insertText: "mutating ", displayText: "mutating func", cursorOffsetFromEnd: 0, kind: .keyword),
        CompletionItem(trigger: "stat", insertText: "static ", displayText: "static var/func", cursorOffsetFromEnd: 0, kind: .keyword),
        
        // MARK: - SwiftUI Views
        CompletionItem(trigger: "vst", insertText: "VStack(spacing: 8) {\n    \n}", displayText: "VStack(spacing: 8) { ... }", cursorOffsetFromEnd: -3, kind: .snippet),
        CompletionItem(trigger: "vstack", insertText: "VStack(spacing: 8) {\n    \n}", displayText: "VStack(spacing: 8) { ... }", cursorOffsetFromEnd: -3, kind: .snippet),
        CompletionItem(trigger: "hst", insertText: "HStack(spacing: 8) {\n    \n}", displayText: "HStack(spacing: 8) { ... }", cursorOffsetFromEnd: -3, kind: .snippet),
        CompletionItem(trigger: "hstack", insertText: "HStack(spacing: 8) {\n    \n}", displayText: "HStack(spacing: 8) { ... }", cursorOffsetFromEnd: -3, kind: .snippet),
        CompletionItem(trigger: "zst", insertText: "ZStack {\n    \n}", displayText: "ZStack { ... }", cursorOffsetFromEnd: -3, kind: .snippet),
        CompletionItem(trigger: "zstack", insertText: "ZStack {\n    \n}", displayText: "ZStack { ... }", cursorOffsetFromEnd: -3, kind: .snippet),
        CompletionItem(trigger: "tex", insertText: "Text(\"\")", displayText: "Text(\"...\")", cursorOffsetFromEnd: -2, kind: .snippet),
        CompletionItem(trigger: "text", insertText: "Text(\"\")", displayText: "Text(\"...\")", cursorOffsetFromEnd: -2, kind: .snippet),
        CompletionItem(trigger: "but", insertText: "Button(action: {\n    \n}) {\n    Text(\"\")\n}", displayText: "Button(action: ...) { ... }", cursorOffsetFromEnd: -16, kind: .snippet),
        CompletionItem(trigger: "button", insertText: "Button(action: {\n    \n}) {\n    Text(\"\")\n}", displayText: "Button(action: ...) { ... }", cursorOffsetFromEnd: -16, kind: .snippet),
        CompletionItem(trigger: "ima", insertText: "Image(systemName: \"\")", displayText: "Image(systemName: \"...\")", cursorOffsetFromEnd: -2, kind: .snippet),
        CompletionItem(trigger: "image", insertText: "Image(systemName: \"\")", displayText: "Image(systemName: \"...\")", cursorOffsetFromEnd: -2, kind: .snippet),
        CompletionItem(trigger: "spa", insertText: "Spacer()", displayText: "Spacer()", cursorOffsetFromEnd: 0, kind: .snippet),
        CompletionItem(trigger: "spacer", insertText: "Spacer()", displayText: "Spacer()", cursorOffsetFromEnd: 0, kind: .snippet),
        CompletionItem(trigger: "div", insertText: "Divider()", displayText: "Divider()", cursorOffsetFromEnd: 0, kind: .snippet),
        CompletionItem(trigger: "divider", insertText: "Divider()", displayText: "Divider()", cursorOffsetFromEnd: 0, kind: .snippet),
        CompletionItem(trigger: "for", insertText: "ForEach(items) { item in\n    \n}", displayText: "ForEach(items) { ... }", cursorOffsetFromEnd: -3, kind: .snippet),
        CompletionItem(trigger: "fore", insertText: "ForEach(items) { item in\n    \n}", displayText: "ForEach(items) { ... }", cursorOffsetFromEnd: -3, kind: .snippet),
        
        // MARK: - SwiftUI Attributes & State
        CompletionItem(trigger: "@st", insertText: "@State private var : ", displayText: "@State private var name: Type", cursorOffsetFromEnd: -2, kind: .keyword),
        CompletionItem(trigger: "@state", insertText: "@State private var : ", displayText: "@State private var name: Type", cursorOffsetFromEnd: -2, kind: .keyword),
        CompletionItem(trigger: "@bi", insertText: "@Binding var : ", displayText: "@Binding var name: Type", cursorOffsetFromEnd: -2, kind: .keyword),
        CompletionItem(trigger: "@bind", insertText: "@Binding var : ", displayText: "@Binding var name: Type", cursorOffsetFromEnd: -2, kind: .keyword),
        CompletionItem(trigger: "@obs", insertText: "@Observable", displayText: "@Observable", cursorOffsetFromEnd: 0, kind: .keyword),
        CompletionItem(trigger: "@main", insertText: "@MainActor", displayText: "@MainActor", cursorOffsetFromEnd: 0, kind: .keyword),
        
        // MARK: - Common Modifiers
        CompletionItem(trigger: ".pad", insertText: ".padding()", displayText: ".padding()", cursorOffsetFromEnd: 0, kind: .modifier),
        CompletionItem(trigger: ".padding", insertText: ".padding()", displayText: ".padding()", cursorOffsetFromEnd: 0, kind: .modifier),
        CompletionItem(trigger: ".fra", insertText: ".frame(width: , height: )", displayText: ".frame(width: , height: )", cursorOffsetFromEnd: -12, kind: .modifier),
        CompletionItem(trigger: ".frame", insertText: ".frame(width: , height: )", displayText: ".frame(width: , height: )", cursorOffsetFromEnd: -12, kind: .modifier),
        CompletionItem(trigger: ".bac", insertText: ".background(Color.)", displayText: ".background(Color.)", cursorOffsetFromEnd: -1, kind: .modifier),
        CompletionItem(trigger: ".back", insertText: ".background(Color.)", displayText: ".background(Color.)", cursorOffsetFromEnd: -1, kind: .modifier),
        CompletionItem(trigger: ".for", insertText: ".foregroundColor(Color.)", displayText: ".foregroundColor(Color.)", cursorOffsetFromEnd: -1, kind: .modifier),
        CompletionItem(trigger: ".cor", insertText: ".cornerRadius(12)", displayText: ".cornerRadius(12)", cursorOffsetFromEnd: 0, kind: .modifier),
        CompletionItem(trigger: ".tas", insertText: ".task {\n    \n}", displayText: ".task { ... }", cursorOffsetFromEnd: -3, kind: .modifier),
        CompletionItem(trigger: ".task", insertText: ".task {\n    \n}", displayText: ".task { ... }", cursorOffsetFromEnd: -3, kind: .modifier),
        CompletionItem(trigger: ".ona", insertText: ".onAppear {\n    \n}", displayText: ".onAppear { ... }", cursorOffsetFromEnd: -3, kind: .modifier),
        CompletionItem(trigger: ".onappear", insertText: ".onAppear {\n    \n}", displayText: ".onAppear { ... }", cursorOffsetFromEnd: -3, kind: .modifier),
        
        // MARK: - Types
        CompletionItem(trigger: "str", insertText: "String", displayText: "String", cursorOffsetFromEnd: 0, kind: .type),
        CompletionItem(trigger: "string", insertText: "String", displayText: "String", cursorOffsetFromEnd: 0, kind: .type),
        CompletionItem(trigger: "dou", insertText: "Double", displayText: "Double", cursorOffsetFromEnd: 0, kind: .type),
        CompletionItem(trigger: "double", insertText: "Double", displayText: "Double", cursorOffsetFromEnd: 0, kind: .type),
        CompletionItem(trigger: "boo", insertText: "Bool", displayText: "Bool", cursorOffsetFromEnd: 0, kind: .type),
        CompletionItem(trigger: "bool", insertText: "Bool", displayText: "Bool", cursorOffsetFromEnd: 0, kind: .type),
        CompletionItem(trigger: "uui", insertText: "UUID()", displayText: "UUID()", cursorOffsetFromEnd: 0, kind: .type),
        CompletionItem(trigger: "uuid", insertText: "UUID()", displayText: "UUID()", cursorOffsetFromEnd: 0, kind: .type),
        CompletionItem(trigger: "view", insertText: "View", displayText: "View", cursorOffsetFromEnd: 0, kind: .type),
        CompletionItem(trigger: "iden", insertText: "Identifiable", displayText: "Identifiable", cursorOffsetFromEnd: 0, kind: .type)
    ]
    
    /// Finds the best completion item for the given prefix.
    public func findMatch(for prefix: String) -> (item: CompletionItem, suffix: String)? {
        let cleanPrefix = prefix.trimmingCharacters(in: .whitespacesAndNewlines)
        guard cleanPrefix.count >= 2 else { return nil }
        
        let lower = cleanPrefix.lowercased()
        
        // Exact trigger match first
        if let exact = database.first(where: { $0.trigger == lower }) {
            let suffix = makeSuffix(prefix: cleanPrefix, insertText: exact.insertText)
            return (exact, suffix)
        }
        
        // Starts with trigger
        if let match = database.first(where: { $0.insertText.lowercased().hasPrefix(lower) && $0.insertText.count > cleanPrefix.count }) {
            let suffix = makeSuffix(prefix: cleanPrefix, insertText: match.insertText)
            return (match, suffix)
        }
        
        return nil
    }
    
    private func makeSuffix(prefix: String, insertText: String) -> String {
        if insertText.lowercased().hasPrefix(prefix.lowercased()) {
            let dropCount = prefix.count
            return String(insertText.dropFirst(dropCount))
        }
        return insertText
    }
}
