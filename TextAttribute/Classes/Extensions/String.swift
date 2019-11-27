import Foundation

public extension String {
    func attributed() -> NSAttributedString {
        return NSAttributedString(string: self)
    }
}
