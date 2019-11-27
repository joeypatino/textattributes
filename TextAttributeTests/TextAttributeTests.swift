import XCTest
import TextAttribute

class TextAttributeTests: XCTestCase {
    private let string = "The quick brown fox jumped over the lazy brown dog".attributed().mutable
        
    func test_AddAttribute_occurences() {
        string.addAttribute(.foregroundColor(.red), toOccurencesOfString: "brown")
        print("Updated: '\(string)'")
    }
    
    func test_AddAttributes_occurences() {
        string.addAttributes([.foregroundColor(.red), .underlineStyle(.single)], toOccurencesOfString: "brown")
        print("Updated: '\(string)'")
    }
    
    func test_RemoveAttributes() {
        string.addAttributes([.foregroundColor(.red), .underlineStyle(.single)], toOccurencesOfString: "brown")
        string.removeAttributes([.foregroundColor, .underlineStyle])
        print("Updated: '\(string)'")
    }
}

internal extension NSAttributedString {
    var mutable: NSMutableAttributedString {
        return mutableCopy() as! NSMutableAttributedString
    }
}

internal extension String {
    func attributed() -> NSAttributedString {
        return NSAttributedString(string: self)
    }
}
