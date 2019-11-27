import Foundation

internal extension NSAttributedString {
    var mutable: NSMutableAttributedString {
        return mutableCopy() as! NSMutableAttributedString
    }
}

internal extension NSAttributedString {
    func addAttribute(_ attr: NSAttributedString.Key, value: Any, range: Range<String.Index>? = nil) {

    }
    
    func addAttributes(_ attrs: [NSAttributedString.Key: Any], range: Range<String.Index>? = nil) {
        
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

    func addingAttribute(_ attr: TextAttribute, toOccurencesOfString aString: String, options opts: [String.CompareOptions], in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        let string = mutable

        return NSAttributedString(attributedString: string)
    }
    
    func addingAttributes(_ attrs: [TextAttribute], toOccurencesOfString aString: String, options opts: [String.CompareOptions], in inRange: Range<String.Index>? = nil) -> NSAttributedString {
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
