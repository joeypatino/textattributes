import Foundation

internal extension String {
    func attributed() -> NSAttributedString {
        return NSAttributedString(string: self)
    }
}
