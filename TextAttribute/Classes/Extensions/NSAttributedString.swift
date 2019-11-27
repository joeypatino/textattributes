import Foundation

internal extension NSAttributedString {
    /// returns a mutable copy of the `NSAttributedString` instance
    var mutable: NSMutableAttributedString {
        return mutableCopy() as! NSMutableAttributedString
    }
}

internal extension NSMutableAttributedString {
    /// wrapper function using `Range<String.Index>` types
    func attributedSubstring(from range: Range<String.Index>) -> NSAttributedString {
        let nsRange = NSRange(location: string.distance(from: string.startIndex, to: range.lowerBound), length: string.distance(from: range.lowerBound, to: range.upperBound))
        return attributedSubstring(from: nsRange)
    }
    
    /// wrapper function using `Range<String.Index>` types
    func replaceCharacters(in range: Range<String.Index>, with attrString: NSAttributedString) {
        let nsRange = NSRange(location: string.distance(from: string.startIndex, to: range.lowerBound), length: string.distance(from: range.lowerBound, to: range.upperBound))
        replaceCharacters(in: nsRange, with: attrString)
    }
    
    /// wrapper function using `Range<String.Index>` types
    func addAttribute(_ attr: NSAttributedString.Key, value: Any, range: Range<String.Index>? = nil) {
        let nsRange = range.map { NSRange(location: string.distance(from: string.startIndex, to: $0.lowerBound), length: string.distance(from: $0.lowerBound, to: $0.upperBound)) } ?? NSRange(location: 0, length: length)
        addAttribute(attr, value: value, range: nsRange)
    }
    
    /// wrapper function using `Range<String.Index>` types
    func addAttributes(_ attrs: [NSAttributedString.Key: Any], range: Range<String.Index>? = nil) {
        let nsRange = range.map { NSRange(location: string.distance(from: string.startIndex, to: $0.lowerBound), length: string.distance(from: $0.lowerBound, to: $0.upperBound)) } ?? NSRange(location: 0, length: length)
        addAttributes(attrs, range: nsRange)
    }
    
    /// wrapper function using `Range<String.Index>` types
    func removeAttribute(_ name: NSAttributedString.Key, range: Range<String.Index>? = nil) {
        let nsRange = range.map { NSRange(location: string.distance(from: string.startIndex, to: $0.lowerBound), length: string.distance(from: $0.lowerBound, to: $0.upperBound)) } ?? NSRange(location: 0, length: length)
        removeAttribute(name, range: nsRange)
    }
}

internal extension NSMutableAttributedString {
    /// Enumerates the each subrange of `attr` in the `NSMutableAttributedString` and calls the closure with the
    /// attributes value and the range of the found attributes
    func enumerateAttribute(_ attr: TextAttribute.Style,
                            options opts: NSAttributedString.EnumerationOptions = [],
                            in inRange: Range<String.Index>? = nil,
                            using block: (Any?, Range<String.Index>) -> Void) {
        let nsRange = inRange.map { NSRange(location: string.distance(from: string.startIndex, to: $0.lowerBound), length: string.distance(from: $0.lowerBound, to: $0.upperBound)) } ?? NSRange(location: 0, length: length)
        enumerateAttribute(attr.key, in: nsRange, options: opts) { attribute, range, stop in
            let start = string.index(string.startIndex, offsetBy: range.location)
            let end = string.index(string.startIndex, offsetBy: range.location + range.length)
            block(attribute, start..<end)
        }
    }
    
    /// Enumerates each occurrence of `aString` in the `NSMutableAttributedString` and calls the closure with an
    /// `NSMutableAttributedString` substring instance and the range of the found string. Modifying the `NSMutableAttributedString`
    /// substring is allowed and will be reflected in `self` at the completion of the enumeration.
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

public extension NSAttributedString {
    /// Returns a new `NSAttributedString` instance by adding the `TextAttribute` to the `NSAttributedString`,
    /// optionally restricted to `inRange`
    func addingAttribute(_ attr: TextAttribute,
                         in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        return addingAttributes([attr], in: inRange)
    }
    
    func addingAttributes(_ attrs: [TextAttribute],
                          in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        let string = mutable
        string.addAttributes(attrs, in: inRange)
        return NSAttributedString(attributedString: string)
    }
    
    /// Returns a new `NSAttributedString` instance by adding the `TextAttribute`s to all occurrences matching `aString` in the `NSAttributedString`,
    /// optionally restricted to `inRange`
    func addingAttribute(_ attr: TextAttribute,
                         toOccurencesOfString aString: String,
                         options opts: String.CompareOptions = [],
                         in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        return addingAttributes([attr], toOccurencesOfString: aString, options: opts, in: inRange)
    }
    
    func addingAttributes(_ attrs: [TextAttribute],
                          toOccurencesOfString aString: String,
                          options opts: String.CompareOptions = [],
                          in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        let string = mutable
        string.addAttributes(attrs, toOccurencesOfString: aString, options: opts, in: inRange)
        return NSAttributedString(attributedString: string)
    }
    
    /// Returns a new `NSAttributedString` instance by removing the `TextAttribute.Style` from the `NSAttributedString`,
    /// optionally restricted to `inRange`
    func removingAttribute(_ attr: TextAttribute.Style,
                           in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        removingAttributes([attr], in: inRange)
    }
    
    func removingAttributes(_ attrs: [TextAttribute.Style],
                            in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        let string = mutable
        string.removeAttributes(attrs, in: inRange)
        return NSAttributedString(attributedString: string)
    }
    
    /// Returns a new `NSAttributedString` instance by removing the `TextAttribute.Style` from all occurrences matching `aString` in the `NSAttributedString`,
    /// optionally restricted to `inRange`
    func removingAttribute(_ attr: TextAttribute.Style,
                           fromOccurencesOfString aString: String,
                           options opts: String.CompareOptions = [],
                           in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        return removingAttributes([attr], fromOccurencesOfString: aString, options: opts, in: inRange)
    }
    
    func removingAttributes(_ attrs: [TextAttribute.Style],
                            fromOccurencesOfString aString: String,
                            options opts: String.CompareOptions = [],
                            in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        let string = mutable
        string.removeAttributes(attrs, fromOccurencesOfString: aString, options: opts, in: inRange)
        return NSAttributedString(attributedString: string)
    }
}
