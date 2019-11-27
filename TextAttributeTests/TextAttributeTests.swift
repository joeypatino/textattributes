import XCTest
import TextAttribute

class TextAttributeTests: XCTestCase {
    private let string = "The quick brown fox jumped over the lazy brown dog".attributed().mutable
        
    func test_AddAttribute_occurences() {
        let result = string.addAttribute(.foregroundColor(.red), toOccurencesOfString: "brown")
        print("Updated: '\(result)'")
    }
    
    func test_AddAttributes_ccurences() {
        let result = string.addAttributes([.foregroundColor(.red), .underlineStyle(.single)], toOccurencesOfString: "brown")
        print("Updated: '\(result)'")
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
