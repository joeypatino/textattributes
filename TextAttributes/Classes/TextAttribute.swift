/// A structure representing an NSAttributedString attribute
public enum TextAttribute {
    case font(UIFont)
    case kern(Float)
    case foregroundColor(UIColor)
    case backgroundColor(UIColor)
    
    case shadow(NSShadow)
    case underlineStyle(NSUnderlineStyle)
    case underlineColor(UIColor)
    case strikethroughStyle(NSStrikeThroughStyle)
    case strikethroughColor(UIColor)
    
    case paragraphSpacingBefore(CGFloat)
    case lineBreakMode(NSLineBreakMode)
    case lineSpacing(CGFloat)
    case lineHeightMultiple(CGFloat)
    case textAlignment(NSTextAlignment)
    case baselineOffset(CGFloat)
    
    case link(URL)
    case textAttachment(NSTextAttachment)
    case textAttachmentImage(UIImage)
    
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
            
        case .paragraphSpacingBefore(let spacingBefore):
            let style = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            style.paragraphSpacingBefore = spacingBefore
            return style
        case .lineBreakMode(let lineBreakMode):
            let style = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            style.lineBreakMode = lineBreakMode
            return style
        case .lineSpacing(let lineSpacing):
            let style = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            style.lineSpacing = lineSpacing
            return style
        case .lineHeightMultiple(let lineHeightMultiple):
            let style = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            style.lineHeightMultiple = lineHeightMultiple
            return style
        case .textAlignment(let alignment):
            let style = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            style.alignment = alignment
            return style
            
        case .link(let url):
            return url
        case .textAttachment(let attachment):
            return attachment
        case .textAttachmentImage(let image):
            let attachment = TextAttachment()
            attachment.image = image
            return attachment

        case .baselineOffset(let offset):
            return offset
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
            
        case .paragraphSpacingBefore:
            return .paragraphSpacingBefore
        case .lineBreakMode:
            return .lineBreakMode
        case .lineSpacing:
            return .lineSpacing
        case .lineHeightMultiple:
            return .lineHeightMultiple
        case .textAlignment:
            return .textAlignment

        case .link:
            return .link
        case .textAttachment:
            return .textAttachment
        case .textAttachmentImage:
            return .textAttachementImage
            
        case .baselineOffset:
            return .baselineOffset
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
        
        case paragraphSpacingBefore
        case lineBreakMode
        case lineSpacing
        case lineHeightMultiple
        case textAlignment
        
        case link
        case textAttachment
        case textAttachementImage
        case baselineOffset
        
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
                
            case .paragraphSpacingBefore:
                return .paragraphStyle
            case .lineBreakMode:
                return .paragraphStyle
            case .lineSpacing:
                return .paragraphStyle
            case .lineHeightMultiple:
                return .paragraphStyle
            case .textAlignment:
                return .paragraphStyle
            
            case .link:
                return .link
            case .textAttachment:
                return .attachment
            case .textAttachementImage:
                return .attachment
                
            case .baselineOffset:
                return .baselineOffset
            }
        }
    }
}

public typealias NSStrikeThroughStyle = NSUnderlineStyle

extension TextAttribute: Codable {
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

        case .paragraphSpacingBefore:
            self = .paragraphSpacingBefore(try container.decode(CGFloat.self, forKey: .value))
        case .lineBreakMode:
            let rawValue = try container.decode(Int.self, forKey: .value)
            self = .lineBreakMode(NSLineBreakMode(rawValue: rawValue) ?? NSLineBreakMode.byWordWrapping)
        case .lineSpacing:
            self = .lineSpacing(try container.decode(CGFloat.self, forKey: .value))
        case .lineHeightMultiple:
            self = .lineHeightMultiple(try container.decode(CGFloat.self, forKey: .value))
        case .textAlignment:
            let rawValue = try container.decode(Int.self, forKey: .value)
            self = .textAlignment(NSTextAlignment(rawValue: rawValue) ?? .justified)
        
        case .link:
            self = .link(try container.decode(URL.self, forKey: .value))
        
        case .textAttachment:
            let data = try container.decodeIfPresent(Data.self, forKey: .value) ?? Data()
            let image = UIImage(data: data) ?? UIImage()
            self = .textAttachment(NSTextAttachment(image: image))
            
        case .textAttachementImage:
            let data = try container.decodeIfPresent(Data.self, forKey: .value) ?? Data()
            let image = UIImage(data: data) ?? UIImage()
            self = .textAttachmentImage(image)

        case .baselineOffset:
            self = .baselineOffset(try container.decode(CGFloat.self, forKey: .value))
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
        
        case .paragraphSpacingBefore(let spacingBefore):
            try container.encode(spacingBefore, forKey: .value)
        case .lineBreakMode(let lineBreakMode):
            try container.encode(lineBreakMode.rawValue, forKey: .value)
        case .lineSpacing(let spacing):
            try container.encode(spacing, forKey: .value)
        case .lineHeightMultiple(let lineHeightMultiple):
            try container.encode(lineHeightMultiple, forKey: .value)
        case .textAlignment(let style):
            try container.encode(style.rawValue, forKey: .value)
            
        case .link(let url):
            try container.encode(url, forKey: .value)
        
        case .textAttachment(let attachment):
            let image = attachment.image ?? UIImage()
            try container.encodeIfPresent(image.pngData(), forKey: .value)

        case .textAttachmentImage(let image):
            try container.encodeIfPresent(image.pngData(), forKey: .value)

        case .baselineOffset(let offset):
            try container.encode(offset, forKey: .value)
        }
    }
}

/// Internal Codable Color structure
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
        self.init(color: UIColor(hex: hex))
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

/// Internal Codable Font structure
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

/// Internal Codable Shadow structure
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

internal class TextAttachment: NSTextAttachment {
    override func image(forBounds imageBounds: CGRect, textContainer: NSTextContainer?, characterIndex charIndex: Int) -> UIImage? {
        super.image(forBounds: imageBounds, textContainer: textContainer, characterIndex: charIndex)
    }

    override func attachmentBounds(for textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {
        super.attachmentBounds(for: textContainer, proposedLineFragment: lineFrag, glyphPosition: position, characterIndex: charIndex)
    }
}
