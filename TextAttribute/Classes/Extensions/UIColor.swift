import UIKit

internal extension UIColor {
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        guard hex.hasPrefix("#") else { return nil }
        
        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        guard scanner.scanHexInt64(&hexNumber) else { return nil }
        
        switch hexColor.count {
        case 2:
            r = CGFloat((hexNumber & 0xff) >> 24) / 255.0
            self.init(red: r, green: r, blue: r, alpha: 1.0)
        case 8:
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255.0
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255.0
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255.0
            a = CGFloat(hexNumber & 0x000000ff) / 255.0
            self.init(red: r, green: g, blue: b, alpha: a)
        default:
            r = CGFloat((hexNumber & 0xff0000) >> 16) / 255.0
            g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255.0
            b = CGFloat((hexNumber & 0x0000ff)) / 255.0
            self.init(red: r, green: g, blue: b, alpha: 1.0)
        }
    }
}
