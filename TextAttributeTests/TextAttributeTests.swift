import XCTest
import TextAttribute

class TextAttributeTests: XCTestCase {
    func testEnumerateRanges() {
        let string = "The quick brown fox jumped over the lazy brown dog".attributed().mutable
        string.enumerateOccrrences(of: "brown") { attributedString, range in
            attributedString = NSMutableAttributedString(string: "brown and red")
        }
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
