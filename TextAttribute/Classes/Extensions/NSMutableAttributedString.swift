import Foundation

public extension NSMutableAttributedString {
    func addiAttribute(_ attr: TextAttribute, in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        
        return self
    }
    
    func addAttributes(_ attrs: [TextAttribute], in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        
        return self
    }

    func addAttribute(_ attr: TextAttribute, toOccurencesOfString aString: String, options opts: String.CompareOptions = [], in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        
        return self
    }
    
    func addAttributes(_ attrs: [TextAttribute], toOccurencesOfString aString: String, options opts: String.CompareOptions = [], in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        
        return self
    }

    func removeAttribute(_ attr: TextAttribute.Style, in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        
        return self
    }
    
    func removeAttributes(_ attrs: [TextAttribute.Style], in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {

        return self
    }
}

public extension NSMutableAttributedString {
    func enumerateOccrrences(of aString: String,
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
