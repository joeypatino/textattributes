import Foundation

internal extension NSAttributedString {
    var mutable: NSMutableAttributedString {
        return mutableCopy() as! NSMutableAttributedString
    }
}

internal extension NSMutableAttributedString {
    func attributedSubstring(from range: Range<String.Index>) -> NSAttributedString {
        let nsRange = NSRange(location: string.distance(from: string.startIndex, to: range.lowerBound), length: string.distance(from: range.lowerBound, to: range.upperBound))
        return attributedSubstring(from: nsRange)
    }
    
    func replaceCharacters(in range: Range<String.Index>, with attrString: NSAttributedString) {
        let nsRange = NSRange(location: string.distance(from: string.startIndex, to: range.lowerBound), length: string.distance(from: range.lowerBound, to: range.upperBound))
        return replaceCharacters(in: nsRange, with: attrString)
    }

    func addAttribute(_ attr: NSAttributedString.Key, value: Any, range: Range<String.Index>? = nil) {
        let nsRange = range.map { NSRange(location: string.distance(from: string.startIndex, to: $0.lowerBound), length: string.distance(from: $0.lowerBound, to: $0.upperBound)) } ?? NSRange(location: 0, length: length)
        addAttribute(attr, value: value, range: nsRange)
    }
    
    func addingAttributes(_ attrs: [NSAttributedString.Key: Any], range: Range<String.Index>? = nil) {
        let nsRange = range.map { NSRange(location: string.distance(from: string.startIndex, to: $0.lowerBound), length: string.distance(from: $0.lowerBound, to: $0.upperBound)) } ?? NSRange(location: 0, length: length)
        addAttributes(attrs, range: nsRange)
    }
}

public extension NSAttributedString {
    func addingAttribute(_ attr: TextAttribute, in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        let string = mutable

        return NSAttributedString(attributedString: string)
    }
    
    func addingAttributes(_ attrs: [TextAttribute], in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        let string = mutable
        
        return NSAttributedString(attributedString: string)
    }

    func addingAttribute(_ attr: TextAttribute, toOccurencesOfString aString: String, options opts: String.CompareOptions = [], in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        let string = mutable

        return NSAttributedString(attributedString: string)
    }
    
    func addingAttributes(_ attrs: [TextAttribute], toOccurencesOfString aString: String, options opts: String.CompareOptions = [], in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        let string = mutable

        return NSAttributedString(attributedString: string)
    }

    func removingAttribute(_ attr: TextAttribute.Style, in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        let string = mutable
        
        return NSAttributedString(attributedString: string)
    }
    
    func removingAttributes(_ attrs: [TextAttribute.Style], in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        let string = mutable
        
        return NSAttributedString(attributedString: string)
    }
}
