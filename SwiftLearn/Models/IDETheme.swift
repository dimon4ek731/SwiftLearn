import SwiftUI

public struct CodableColor: Codable, Equatable {
    public var red: Double
    public var green: Double
    public var blue: Double
    public var opacity: Double
    
    public init(red: Double, green: Double, blue: Double, opacity: Double = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }
    
    public init(hex: String) {
        var cleanHex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cleanHex.hasPrefix("#") {
            cleanHex.remove(at: cleanHex.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cleanHex).scanHexInt64(&rgbValue)
        
        if cleanHex.count == 6 {
            self.red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
            self.green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
            self.blue = Double(rgbValue & 0x0000FF) / 255.0
            self.opacity = 1.0
        } else if cleanHex.count == 8 {
            self.red = Double((rgbValue & 0xFF000000) >> 24) / 255.0
            self.green = Double((rgbValue & 0x00FF0000) >> 16) / 255.0
            self.blue = Double((rgbValue & 0x0000FF00) >> 8) / 255.0
            self.opacity = Double(rgbValue & 0x000000FF) / 255.0
        } else {
            self.red = 0.5
            self.green = 0.5
            self.blue = 0.5
            self.opacity = 1.0
        }
    }
    
    public var color: Color {
        get {
            Color(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
        }
        set {
            if let components = newValue.cgColor?.components {
                if components.count >= 3 {
                    self.red = Double(components[0])
                    self.green = Double(components[1])
                    self.blue = Double(components[2])
                    self.opacity = components.count >= 4 ? Double(components[3]) : 1.0
                }
            } else {
                // Fallback via UIColor
                let uiColor = UIColor(newValue)
                var r: CGFloat = 0
                var g: CGFloat = 0
                var b: CGFloat = 0
                var a: CGFloat = 0
                if uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) {
                    self.red = Double(r)
                    self.green = Double(g)
                    self.blue = Double(b)
                    self.opacity = Double(a)
                }
            }
        }
    }
    
    public var hexString: String {
        let r = Int(round(red * 255))
        let g = Int(round(green * 255))
        let b = Int(round(blue * 255))
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}

public enum IDEThemePreset: String, CaseIterable, Identifiable, Codable {
    case xcodeDark = "Xcode Dark"
    case monokaiPro = "Monokai Pro"
    case dracula = "Dracula"
    case oneDark = "One Dark"
    case nord = "Nord"
    case xcodeLight = "Xcode Light"
    case custom = "Пользовательская"
    
    public var id: String { rawValue }
}

public struct IDETheme: Codable, Equatable {
    public var name: String
    public var preset: IDEThemePreset
    
    public var backgroundColor: CodableColor
    public var gutterColor: CodableColor
    public var lineNumberColor: CodableColor
    public var textColor: CodableColor
    public var keywordColor: CodableColor
    public var typeColor: CodableColor
    public var stringColor: CodableColor
    public var numberColor: CodableColor
    public var commentColor: CodableColor
    public var callColor: CodableColor
    
    public var fontSize: Double
    public var showLineNumbers: Bool
    public var wrapLines: Bool
    public var enableAutocomplete: Bool
    
    public init(
        name: String,
        preset: IDEThemePreset,
        backgroundColor: CodableColor,
        gutterColor: CodableColor,
        lineNumberColor: CodableColor,
        textColor: CodableColor,
        keywordColor: CodableColor,
        typeColor: CodableColor,
        stringColor: CodableColor,
        numberColor: CodableColor,
        commentColor: CodableColor,
        callColor: CodableColor,
        fontSize: Double = 13.0,
        showLineNumbers: Bool = true,
        wrapLines: Bool = false,
        enableAutocomplete: Bool = true
    ) {
        self.name = name
        self.preset = preset
        self.backgroundColor = backgroundColor
        self.gutterColor = gutterColor
        self.lineNumberColor = lineNumberColor
        self.textColor = textColor
        self.keywordColor = keywordColor
        self.typeColor = typeColor
        self.stringColor = stringColor
        self.numberColor = numberColor
        self.commentColor = commentColor
        self.callColor = callColor
        self.fontSize = fontSize
        self.showLineNumbers = showLineNumbers
        self.wrapLines = wrapLines
        self.enableAutocomplete = enableAutocomplete
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.preset = try container.decode(IDEThemePreset.self, forKey: .preset)
        self.backgroundColor = try container.decode(CodableColor.self, forKey: .backgroundColor)
        self.gutterColor = try container.decode(CodableColor.self, forKey: .gutterColor)
        self.lineNumberColor = try container.decode(CodableColor.self, forKey: .lineNumberColor)
        self.textColor = try container.decode(CodableColor.self, forKey: .textColor)
        self.keywordColor = try container.decode(CodableColor.self, forKey: .keywordColor)
        self.typeColor = try container.decode(CodableColor.self, forKey: .typeColor)
        self.stringColor = try container.decode(CodableColor.self, forKey: .stringColor)
        self.numberColor = try container.decode(CodableColor.self, forKey: .numberColor)
        self.commentColor = try container.decode(CodableColor.self, forKey: .commentColor)
        self.callColor = try container.decode(CodableColor.self, forKey: .callColor)
        self.fontSize = try container.decodeIfPresent(Double.self, forKey: .fontSize) ?? 13.0
        self.showLineNumbers = try container.decodeIfPresent(Bool.self, forKey: .showLineNumbers) ?? true
        self.wrapLines = try container.decodeIfPresent(Bool.self, forKey: .wrapLines) ?? false
        self.enableAutocomplete = try container.decodeIfPresent(Bool.self, forKey: .enableAutocomplete) ?? true
    }
    
    // MARK: - Presets Factory
    public static func forPreset(_ preset: IDEThemePreset) -> IDETheme {
        switch preset {
        case .xcodeDark:
            return IDETheme(
                name: "Xcode Dark",
                preset: .xcodeDark,
                backgroundColor: CodableColor(hex: "#1F2024"),
                gutterColor: CodableColor(hex: "#18191C"),
                lineNumberColor: CodableColor(hex: "#5C6168"),
                textColor: CodableColor(hex: "#DFE1E5"),
                keywordColor: CodableColor(hex: "#FC5FA3"),
                typeColor: CodableColor(hex: "#5DD8FF"),
                stringColor: CodableColor(hex: "#FC6A5D"),
                numberColor: CodableColor(hex: "#D0BF69"),
                commentColor: CodableColor(hex: "#6C7986"),
                callColor: CodableColor(hex: "#A1C8FF")
            )
        case .monokaiPro:
            return IDETheme(
                name: "Monokai Pro",
                preset: .monokaiPro,
                backgroundColor: CodableColor(hex: "#2D2A2E"),
                gutterColor: CodableColor(hex: "#221F22"),
                lineNumberColor: CodableColor(hex: "#727072"),
                textColor: CodableColor(hex: "#FCFCFA"),
                keywordColor: CodableColor(hex: "#FF6188"),
                typeColor: CodableColor(hex: "#78DCE8"),
                stringColor: CodableColor(hex: "#FFD866"),
                numberColor: CodableColor(hex: "#AB9DF2"),
                commentColor: CodableColor(hex: "#727072"),
                callColor: CodableColor(hex: "#A9DC76")
            )
        case .dracula:
            return IDETheme(
                name: "Dracula",
                preset: .dracula,
                backgroundColor: CodableColor(hex: "#282A36"),
                gutterColor: CodableColor(hex: "#21222C"),
                lineNumberColor: CodableColor(hex: "#6272A4"),
                textColor: CodableColor(hex: "#F8F8F2"),
                keywordColor: CodableColor(hex: "#FF79C6"),
                typeColor: CodableColor(hex: "#8BE9FD"),
                stringColor: CodableColor(hex: "#F1FA8C"),
                numberColor: CodableColor(hex: "#BD93F9"),
                commentColor: CodableColor(hex: "#6272A4"),
                callColor: CodableColor(hex: "#50FA7B")
            )
        case .oneDark:
            return IDETheme(
                name: "One Dark",
                preset: .oneDark,
                backgroundColor: CodableColor(hex: "#282C34"),
                gutterColor: CodableColor(hex: "#21252B"),
                lineNumberColor: CodableColor(hex: "#5C6370"),
                textColor: CodableColor(hex: "#ABB2BF"),
                keywordColor: CodableColor(hex: "#C678DD"),
                typeColor: CodableColor(hex: "#61AFEF"),
                stringColor: CodableColor(hex: "#98C379"),
                numberColor: CodableColor(hex: "#D19A66"),
                commentColor: CodableColor(hex: "#5C6370"),
                callColor: CodableColor(hex: "#56B6C2")
            )
        case .nord:
            return IDETheme(
                name: "Nord",
                preset: .nord,
                backgroundColor: CodableColor(hex: "#2E3440"),
                gutterColor: CodableColor(hex: "#242933"),
                lineNumberColor: CodableColor(hex: "#4C566A"),
                textColor: CodableColor(hex: "#D8DEE9"),
                keywordColor: CodableColor(hex: "#81A1C1"),
                typeColor: CodableColor(hex: "#88C0D0"),
                stringColor: CodableColor(hex: "#A3BE8C"),
                numberColor: CodableColor(hex: "#B48EAD"),
                commentColor: CodableColor(hex: "#4C566A"),
                callColor: CodableColor(hex: "#EBCB8B")
            )
        case .xcodeLight:
            return IDETheme(
                name: "Xcode Light",
                preset: .xcodeLight,
                backgroundColor: CodableColor(hex: "#FFFFFF"),
                gutterColor: CodableColor(hex: "#F4F5F7"),
                lineNumberColor: CodableColor(hex: "#A0A5AD"),
                textColor: CodableColor(hex: "#24272D"),
                keywordColor: CodableColor(hex: "#9B2393"),
                typeColor: CodableColor(hex: "#1C00CF"),
                stringColor: CodableColor(hex: "#C41A16"),
                numberColor: CodableColor(hex: "#1C00CF"),
                commentColor: CodableColor(hex: "#536579"),
                callColor: CodableColor(hex: "#3900A0")
            )
        case .custom:
            var custom = forPreset(.xcodeDark)
            custom.preset = .custom
            custom.name = "Custom Theme"
            return custom
        }
    }
}
