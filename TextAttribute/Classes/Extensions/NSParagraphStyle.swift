internal extension NSParagraphStyle {
    static func +(lhs: NSParagraphStyle, rhs: NSParagraphStyle) -> NSParagraphStyle {
        let defaultStyle = NSParagraphStyle.default
        let updatedStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        updatedStyle.setParagraphStyle(lhs)
        
        if rhs.alignment != defaultStyle.alignment {
            updatedStyle.alignment = rhs.alignment
        }

        if rhs.allowsDefaultTighteningForTruncation != defaultStyle.allowsDefaultTighteningForTruncation {
            updatedStyle.allowsDefaultTighteningForTruncation = rhs.allowsDefaultTighteningForTruncation
        }

        if rhs.baseWritingDirection != defaultStyle.baseWritingDirection {
            updatedStyle.baseWritingDirection = rhs.baseWritingDirection
        }

        if rhs.defaultTabInterval != defaultStyle.defaultTabInterval {
            updatedStyle.defaultTabInterval = rhs.defaultTabInterval
        }

        if rhs.firstLineHeadIndent != defaultStyle.firstLineHeadIndent {
            updatedStyle.firstLineHeadIndent = rhs.firstLineHeadIndent
        }

        if rhs.headIndent != defaultStyle.headIndent {
            updatedStyle.headIndent = rhs.headIndent
        }

        if rhs.hyphenationFactor != defaultStyle.hyphenationFactor {
            updatedStyle.hyphenationFactor = rhs.hyphenationFactor
        }

        if rhs.lineBreakMode != defaultStyle.lineBreakMode {
            updatedStyle.lineBreakMode = rhs.lineBreakMode
        }

        if rhs.lineHeightMultiple != defaultStyle.lineHeightMultiple {
            updatedStyle.lineHeightMultiple = rhs.lineHeightMultiple
        }

        if rhs.lineSpacing != defaultStyle.lineSpacing {
            updatedStyle.lineSpacing = rhs.lineSpacing
        }

        if rhs.maximumLineHeight != defaultStyle.maximumLineHeight {
            updatedStyle.maximumLineHeight = rhs.maximumLineHeight
        }

        if rhs.minimumLineHeight != defaultStyle.minimumLineHeight {
            updatedStyle.minimumLineHeight = rhs.minimumLineHeight
        }

        if rhs.paragraphSpacing != defaultStyle.paragraphSpacing {
            updatedStyle.paragraphSpacing = rhs.paragraphSpacing
        }

        if rhs.paragraphSpacingBefore != defaultStyle.paragraphSpacingBefore {
            updatedStyle.paragraphSpacingBefore = rhs.paragraphSpacingBefore
        }

        if rhs.tabStops != defaultStyle.tabStops {
            updatedStyle.tabStops = rhs.tabStops
        }

        if rhs.tailIndent != defaultStyle.tailIndent {
            updatedStyle.tailIndent = rhs.tailIndent
        }
        
        return updatedStyle
    }
}
