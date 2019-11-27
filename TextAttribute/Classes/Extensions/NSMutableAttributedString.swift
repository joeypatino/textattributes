import Foundation

public extension NSMutableAttributedString {
    func addiAttribute(_ attr: TextAttribute, in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        
        return self
    }
    
    func addAttributes(_ attrs: [TextAttribute], in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        
        return self
    }

    func addAttribute(_ attr: TextAttribute, toOccurencesOfString aString: String, options opts: [String.CompareOptions], in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        
        return self
    }
    
    func addAttributes(_ attrs: [TextAttribute], toOccurencesOfString aString: String, options opts: [String.CompareOptions], in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        
        return self
    }

    func removeAttribute(_ attr: TextAttribute.Style, in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        
        return self
    }
    
    func removeAttributes(_ attrs: [TextAttribute.Style], in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {

        return self
    }
}

internal extension NSMutableAttributedString {
    func enumerateOccrrences(of aString: String,
                             options opts: [String.CompareOptions],
                             in inRange: Range<String.Index>? = nil,
                             using block: (inout NSMutableAttributedString, Range<String.Index>, UnsafeMutablePointer<ObjCBool>) -> Void) {
        
    }
}
