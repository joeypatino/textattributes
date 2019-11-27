import UIKit

internal extension NSParagraphStyle {
    static func +(lhs: NSParagraphStyle, rhs: NSParagraphStyle) -> NSParagraphStyle {
        let defaultStyle = NSParagraphStyle.default
        let updatedStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        updatedStyle.setParagraphStyle(lhs)
        
        if updatedStyle.alignment == defaultStyle.alignment {
            updatedStyle.alignment = rhs.alignment
        }

        if updatedStyle.allowsDefaultTighteningForTruncation == defaultStyle.allowsDefaultTighteningForTruncation {
            updatedStyle.allowsDefaultTighteningForTruncation = rhs.allowsDefaultTighteningForTruncation
        }

        if updatedStyle.baseWritingDirection == defaultStyle.baseWritingDirection {
            updatedStyle.baseWritingDirection = rhs.baseWritingDirection
        }

        if updatedStyle.defaultTabInterval == defaultStyle.defaultTabInterval {
            updatedStyle.defaultTabInterval = rhs.defaultTabInterval
        }

        if updatedStyle.firstLineHeadIndent == defaultStyle.firstLineHeadIndent {
            updatedStyle.firstLineHeadIndent = rhs.firstLineHeadIndent
        }

        if updatedStyle.headIndent == defaultStyle.headIndent {
            updatedStyle.headIndent = rhs.headIndent
        }

        if updatedStyle.hyphenationFactor == defaultStyle.hyphenationFactor {
            updatedStyle.hyphenationFactor = rhs.hyphenationFactor
        }

        if updatedStyle.lineBreakMode == defaultStyle.lineBreakMode {
            updatedStyle.lineBreakMode = rhs.lineBreakMode
        }

        if updatedStyle.lineHeightMultiple == defaultStyle.lineHeightMultiple {
            updatedStyle.lineHeightMultiple = rhs.lineHeightMultiple
        }

        if updatedStyle.lineSpacing == defaultStyle.lineSpacing {
            updatedStyle.lineSpacing = rhs.lineSpacing
        }

        if updatedStyle.maximumLineHeight == defaultStyle.maximumLineHeight {
            updatedStyle.maximumLineHeight = rhs.maximumLineHeight
        }

        if updatedStyle.minimumLineHeight == defaultStyle.minimumLineHeight {
            updatedStyle.minimumLineHeight = rhs.minimumLineHeight
        }

        if updatedStyle.paragraphSpacing == defaultStyle.paragraphSpacing {
            updatedStyle.paragraphSpacing = rhs.paragraphSpacing
        }

        if updatedStyle.paragraphSpacingBefore == defaultStyle.paragraphSpacingBefore {
            updatedStyle.paragraphSpacingBefore = rhs.paragraphSpacingBefore
        }

        if updatedStyle.tabStops == defaultStyle.tabStops {
            updatedStyle.tabStops = rhs.tabStops
        }

        if updatedStyle.tailIndent == defaultStyle.tailIndent {
            updatedStyle.tailIndent = rhs.tailIndent
        }
        
        return updatedStyle
    }
}
