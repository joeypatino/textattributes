import XCTest
import TextAttribute

class TextAttributeTests: XCTestCase {
    private let string = "The quick brown fox jumped over the lazy brown dog".attributed().mutable
        
    func test_encodeAttributes() {
        let shadow = NSShadow()
        shadow.shadowBlurRadius = 1.0
        shadow.shadowOffset = CGSize(width: 1, height: -1)
        shadow.shadowColor = UIColor.red
        let attributes: [TextAttribute] = [.shadow(shadow), .foregroundColor(.red), .underlineStyle(.single), .lineSpacing(6.0), .textAlignment(.center)]
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(attributes)
        let output = String(data: data, encoding: .utf8)!
        print(output)
    }
    
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
