import UIKit
import TextAttribute

class ViewController: UIViewController {
    private let label = UILabel()
    private let string = """
The quick brown fox jumped over the lazy brown dog
Jived fox nymph grabs quick waltz.
Glib jocks quiz nymph to vex dwarf.
Sphinx of black quartz, judge my vow.
How vexingly quick daft zebras jump!
The five boxing wizards jump quickly.
Pack my box with five dozen liquor jugs.
""".attributed().addingAttributes([.font(.boldSystemFont(ofSize: 22.0)), .lineSpacing(28.0), .kern(2.0), .textAlignment(.center)])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.numberOfLines = 0        
        label.attributedText = string
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: label) else { return }
        guard let idx = label.glyphIndex(at: point) else { return }
        let start = string.string.index(string.string.startIndex, offsetBy: idx)
        let end = string.string.index(string.string.startIndex, offsetBy: idx + 1)
        label.attributedText = label.attributedText?.addingAttributes([.underlineStyle(.single), .underlineColor(.red)], in: start..<end)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: label) else { return }
        guard let idx = label.glyphIndex(at: point) else { return }
        let start = string.string.index(string.string.startIndex, offsetBy: idx)
        let end = string.string.index(string.string.startIndex, offsetBy: idx + 1)
        label.attributedText = label.attributedText?.addingAttributes([.underlineStyle(.single), .underlineColor(.red)], in: start..<end)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        label.attributedText = label.attributedText?.removingAttributes([.underlineColor, .underlineStyle])
    }
}
    
public extension UILabel {
    func glyphIndex(at location: CGPoint) -> Int? {
        
        // the text container
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = lineBreakMode
        textContainer.maximumNumberOfLines = numberOfLines

        // Configure NSLayoutManager and add the text container
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)

        // Configure NSTextStorage and apply the layout manager
        let textStorage = NSTextStorage(attributedString: attributedText ?? NSAttributedString())
        textStorage.addLayoutManager(layoutManager)

        // the location offset based on the content insets and text alignments
        let insetLocation = textContainer.insetLocation(location, in: self, using: layoutManager)
        
        // figure out which character was tapped
        let characterIndex = layoutManager.glyphIndex(for: insetLocation, in: textContainer, fractionOfDistanceThroughGlyph: nil)

        // figure out how many characters are in the string up to and including the line tapped
        let lastCharacterIndex = textContainer.lastCharacterIndex(location, in: self, using: layoutManager)

        // ignore taps past the end of the current line
        return characterIndex <= lastCharacterIndex ? characterIndex : lastCharacterIndex
    }
}

private extension NSTextContainer {
    /// returns the tapped location offset based on the alignment and label insets
    func insetLocation(_ location: CGPoint, in label: UILabel, using layoutManager: NSLayoutManager) -> CGPoint {
        // account for text alignment and insets
        let textBoundingBox = layoutManager.usedRect(for: self)
        let alignmentOffset = label.textAlignment.offset

        // returns the location offset based on the content insets and text alignments
        let xOffset = ((label.bounds.size.width - textBoundingBox.size.width) * alignmentOffset) - textBoundingBox.origin.x
        let yOffset = ((label.bounds.size.height - textBoundingBox.size.height) * alignmentOffset) - textBoundingBox.origin.y
        return CGPoint(x: location.x - xOffset, y: location.y - yOffset)
    }
    
    /// returns the last character index in the tapped line
    func lastCharacterIndex(_ location: CGPoint, in label: UILabel, using layoutManager: NSLayoutManager) -> Int {
        let lineSpacing = (label.attributedText?.paragraphStyle.lineSpacing ?? 0)
        let lineTapped = Int(ceil(location.y / (label.font.lineHeight + lineSpacing))) - 1

        let rightMostPointInLine = CGPoint(x: label.bounds.size.width, y: (label.font.lineHeight + lineSpacing) * CGFloat(lineTapped))
        return layoutManager.glyphIndex(for: rightMostPointInLine, in: self, fractionOfDistanceThroughGlyph: nil)
    }
}

private extension NSTextAlignment {
    var offset: CGFloat {
        switch self {
        case .left, .natural, .justified:
            return 0.0
        case .center:
            return 0.5
        case .right:
            return 1.0
        @unknown default:
            return 0.0
        }
    }
}

private extension NSAttributedString {
    var paragraphStyle: NSParagraphStyle {
        guard let paragraphStyle = attribute(.paragraphStyle, at: 0, longestEffectiveRange: nil, in: NSRange(location: 0, length: length)) as? NSParagraphStyle else { return .default }
        return paragraphStyle
    }
}
