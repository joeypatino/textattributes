import UIKit

public typealias NSStrikeThroughStyle = NSUnderlineStyle
public enum TextAttribute: Codable {
    case font(UIFont)
    case kern(Float)
    case foregroundColor(UIColor)
    case backgroundColor(UIColor)
    
    case shadow(NSShadow)
    case underlineStyle(NSUnderlineStyle)
    case underlineColor(UIColor)
    case strikethroughStyle(NSStrikeThroughStyle)
    case strikethroughColor(UIColor)
    
    case lineBreakMode(NSLineBreakMode)
    case lineSpacing(CGFloat)
    case textAlignment(NSTextAlignment)
    
    case link(URL)
    
    var value: Any {
        switch self {
        case .font(let font):
            return font
        case .kern(let kerning):
            return kerning
        case .foregroundColor(let color):
            return color
        case .backgroundColor(let color):
            return color
        
        case .shadow(let shadow):
            return shadow
        case .underlineStyle(let style):
            return style.rawValue
        case .underlineColor(let color):
            return color
        case .strikethroughStyle(let style):
            return style.rawValue
        case .strikethroughColor(let color):
            return color
            
        case .lineBreakMode(let lineBreakMode):
            let style = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            style.lineBreakMode = lineBreakMode
            return style
        case .lineSpacing(let lineSpacing):
            let style = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            style.lineSpacing = lineSpacing
            return style
        case .textAlignment(let alignment):
            let style = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            style.alignment = alignment
            return style
        case .link(let url):
            return url
        }
    }
    
    var key: NSAttributedString.Key { style.key }
    
    var style: Style {
        switch self {
        case .font:
            return .font
        case .kern:
            return .kern
        case .foregroundColor:
            return .foregroundColor
        case .backgroundColor:
            return .backgroundColor
        
        case .shadow:
            return .shadow
        case .underlineStyle:
            return .underlineStyle
        case .underlineColor:
            return .underlineColor
        case .strikethroughStyle:
            return .strikethroughStyle
        case .strikethroughColor:
            return .strikethroughColor
            
        case .lineBreakMode:
            return .lineBreakMode
        case .lineSpacing:
            return .lineSpacing
        case .textAlignment:
            return .textAlignment
        case .link:
            return .link
        }
    }
    
    public enum Style: String, Codable {
        case font
        case kern
        case foregroundColor
        case backgroundColor
        
        case shadow
        case underlineStyle
        case underlineColor
        case strikethroughStyle
        case strikethroughColor
        
        case lineBreakMode
        case lineSpacing
        case textAlignment
        
        case link
        
        var key: NSAttributedString.Key {
            switch self {
            case .font:
                return .font
            case .foregroundColor:
                return .foregroundColor
            case .backgroundColor:
                return .backgroundColor
            case .kern:
                return .kern
            
            case .shadow:
                return .shadow
            case .underlineStyle:
                return .underlineStyle
            case .underlineColor:
                return .underlineColor
            case .strikethroughStyle:
                return .strikethroughStyle
            case .strikethroughColor:
                return .strikethroughColor
                
            case .lineBreakMode:
                return .paragraphStyle
            case .lineSpacing:
                return .paragraphStyle
            case .textAlignment:
                return .paragraphStyle
            
            case .link:
                return .link
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case style
        case value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(TextAttribute.Style.self, forKey: .style)
        
        switch type {
        case .font:
            self = .font(try container.decode(Font.self, forKey: .value).uiFont)
        case .kern:
            self = .kern(try container.decode(Float.self, forKey: .value))
        case .foregroundColor:
            self = .foregroundColor(try container.decode(Color.self, forKey: .value).uiColor)
        case .backgroundColor:
            self = .backgroundColor(try container.decode(Color.self, forKey: .value).uiColor)
        
        case .shadow:
            self = .shadow(try container.decode(Shadow.self, forKey: .value).nsShadow)
        case .underlineStyle:
            let rawValue = try container.decode(Int.self, forKey: .value)
            self = .underlineStyle(NSUnderlineStyle(rawValue: rawValue))
        case .underlineColor:
            self = .underlineColor(try container.decode(Color.self, forKey: .value).uiColor)
        case .strikethroughStyle:
            let rawValue = try container.decode(Int.self, forKey: .value)
            self = .strikethroughStyle(NSStrikeThroughStyle(rawValue: rawValue))
        case .strikethroughColor:
            self = .strikethroughColor(try container.decode(Color.self, forKey: .value).uiColor)
            
        case .lineBreakMode:
            let rawValue = try container.decode(Int.self, forKey: .value)
            self = .lineBreakMode(NSLineBreakMode(rawValue: rawValue) ?? NSLineBreakMode.byWordWrapping)
        case .lineSpacing:
            self = .lineSpacing(try container.decode(CGFloat.self, forKey: .value))
        case .textAlignment:
            let rawValue = try container.decode(Int.self, forKey: .value)
            self = .textAlignment(NSTextAlignment(rawValue: rawValue) ?? .justified)
        
        case .link:
            self = .link(try container.decode(URL.self, forKey: .value))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(style, forKey: .style)
        
        switch self {
        case .font(let font):
            try container.encode(Font(font: font), forKey: .value)
        case .kern(let kern):
            try container.encode(kern, forKey: .value)
        case .foregroundColor(let color):
            try container.encode(Color(color: color), forKey: .value)
        case .backgroundColor(let color):
            try container.encode(Color(color: color), forKey: .value)
        
        case .shadow(let shadow):
            try container.encode(Shadow(shadow: shadow), forKey: .value)
        case .underlineStyle(let style):
            try container.encode(style.rawValue, forKey: .value)
        case .underlineColor(let color):
            try container.encode(Color(color: color), forKey: .value)
        case .strikethroughStyle(let style):
            try container.encode(style.rawValue, forKey: .value)
        case .strikethroughColor(let color):
            try container.encode(Color(color: color), forKey: .value)
        
        case .lineBreakMode(let lineBreakMode):
            try container.encode(lineBreakMode.rawValue, forKey: .value)
        case .lineSpacing(let spacing):
            try container.encode(spacing, forKey: .value)
        case .textAlignment(let style):
            try container.encode(style.rawValue, forKey: .value)
            
        case .link(let url):
            try container.encode(url, forKey: .value)
        }
    }
}

internal struct Color: Codable {
    private var red: CGFloat = 0.0
    private var green: CGFloat = 0.0
    private var blue: CGFloat = 0.0
    private var alpha: CGFloat = 0.0
    
    public var uiColor: UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public var cgColor: CGColor {
        return uiColor.cgColor
    }
    
    public init(color: UIColor) {
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
    
    public init(hex: String) {
        self.init(color: UIColor(hex: hex)!)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = Color(hex: try container.decode(String.self))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        func toI(_ f: CGFloat) -> Int {
            return min(256 - 1, Int(CGFloat(256) * f))
        }
        let hexValue = String(format:"#%02X%02X%02X%02X", toI(red), toI(green), toI(blue), toI(alpha))
        try container.encode(hexValue)
    }
}

internal struct Font: Codable {
    public let uiFont: UIFont
    
    static func systemFont(ofSize size: CGFloat) -> Font {
        self.init(font: .systemFont(ofSize: size))
    }
    
    public init(font: UIFont) {
        self.uiFont = font
    }
    
    public init(name: String, size: CGFloat) {
        self.uiFont = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    private enum CodingKeys: String, CodingKey {
        case size
        case name
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let size = try container.decode(CGFloat.self, forKey: .size)
        uiFont = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uiFont.fontName, forKey: .name)
        try container.encode(uiFont.pointSize, forKey: .size)
    }
}

internal struct Shadow: Codable {
    public let nsShadow: NSShadow
        
    public init(shadow: NSShadow) {
        self.nsShadow = shadow
    }
    
    private enum CodingKeys: String, CodingKey {
        case blur
        case offset
        case color
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let blur = try container.decode(CGFloat.self, forKey: .blur)
        let offset = try container.decode(CGSize.self, forKey: .blur)
        let color = try container.decodeIfPresent(Color.self, forKey: .color)?.uiColor
        nsShadow = NSShadow()
        nsShadow.shadowBlurRadius = blur
        nsShadow.shadowOffset = offset
        nsShadow.shadowColor = color?.cgColor
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nsShadow.shadowBlurRadius, forKey: .blur)
        try container.encode(nsShadow.shadowOffset, forKey: .offset)
        
        if let shadowColor = nsShadow.shadowColor as? UIColor {
            try container.encode(Color(color: shadowColor), forKey: .color)
        }
    }
}
