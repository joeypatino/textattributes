import UIKit

public extension NSMutableAttributedString {
    @discardableResult
    func addAttribute(_ attr: TextAttribute, in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        return addAttributes([attr], in: inRange)
    }
    
    @discardableResult
    func addAttributes(_ attrs: [TextAttribute], in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        let reduced = attrs.reduce(into: [NSAttributedString.Key: Any]()) { result, attribute in
            switch attribute {
            case .textAlignment, .lineSpacing, .lineBreakMode:
                let existingStyle = (result[attribute.key] as? NSParagraphStyle) ?? NSParagraphStyle.default
                let value = attribute.value as! NSParagraphStyle
                result[attribute.key] = existingStyle + value
            // switch for each other type so when new cases are added we don't forget to update this
            case .backgroundColor:
                break
            case .font:
                break
            case .foregroundColor:
                break
            case .kern:
                break
            case .shadow:
                break
            case .strikethroughColor:
                break
            case .strikethroughStyle:
                break
            case .underlineColor:
                break
            case .underlineStyle:
                break
            case .link:
                break
            }
            result[attribute.key] = attribute.value
        }
        addAttributes(reduced, range: inRange)
        return self
    }
    
    @discardableResult
    func addAttribute(_ attr: TextAttribute, toOccurencesOfString aString: String, options opts: String.CompareOptions = [], in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        return addAttributes([attr], toOccurencesOfString: aString, options: opts, in: inRange)
    }
    
    @discardableResult
    func addAttributes(_ attrs: [TextAttribute], toOccurencesOfString aString: String, options opts: String.CompareOptions = [], in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        enumerateOccurrences(of: aString, options: opts, in: inRange) { attributedString, range in
            attributedString.addAttributes(attrs)
        }
        return self
    }
    
    @discardableResult
    func removeAttribute(_ attr: TextAttribute.Style, in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        return removeAttributes([attr], in: inRange)
    }
    
    @discardableResult
    func removeAttributes(_ attrs: [TextAttribute.Style], in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        attrs.forEach { attr in
            enumerateAttribute(attr, in: inRange) { attribute, range in
                removeAttribute(attr.key, range: range)
            }
        }
        return self
    }
}

internal extension NSMutableAttributedString {
    func enumerateAttribute(_ attr: TextAttribute.Style,
                            options opts: NSAttributedString.EnumerationOptions = [],
                            in inRange: Range<String.Index>? = nil, using block: (Any?, Range<String.Index>) -> Void) {
        let nsRange = inRange.map { NSRange(location: string.distance(from: string.startIndex, to: $0.lowerBound), length: string.distance(from: $0.lowerBound, to: $0.upperBound)) } ?? NSRange(location: 0, length: length)
        enumerateAttribute(attr.key, in: nsRange, options: opts) { attribute, range, stop in
            let start = string.index(string.startIndex, offsetBy: range.location)
            let end = string.index(string.startIndex, offsetBy: range.location + range.length)
            block(attribute, start..<end)
        }
    }
    
    func enumerateOccurrences(of aString: String,
                              options opts: String.CompareOptions = [],
                              in inRange: Range<String.Index>? = nil,
                              using block: (inout NSMutableAttributedString, Range<String.Index>) -> Void) {
        let range = inRange ?? string.startIndex..<string.index(string.startIndex, offsetBy: length)
        var start = range.lowerBound
        let end = range.upperBound
        let slice = string[range]
        var substringRanges:[Range<String.Index>] = []
        while let subrange = slice.range(of: aString, options: opts, range: start..<end) {
            substringRanges.append(subrange)
            start = subrange.upperBound
            if start == end { break }
        }
        
        var offset = 0
        substringRanges.forEach { range in
            
            let substringStart = string.index(range.lowerBound, offsetBy: offset)
            let substringEnd = string.index(range.upperBound, offsetBy: offset)
            var substring = attributedSubstring(from: substringStart..<substringEnd).mutable
            let len = substring.length
            block(&substring, range)
            
            let replacementStart = string.index(range.lowerBound, offsetBy: offset)
            let replacementEnd = string.index(range.upperBound, offsetBy: offset)
            replaceCharacters(in: replacementStart..<replacementEnd, with: substring)
            offset = offset + (substring.length - len)
        }
    }
}
