public extension NSMutableAttributedString {
    /// Adds the `TextAttribute` to the `NSMutableAttributedString` and returns self,
    /// optionally restricted to `inRange`
    @discardableResult func addAttribute(_ attr: TextAttribute,
                                         in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        return addAttributes([attr], in: inRange)
    }
    
    @discardableResult func addAttributes(_ attrs: [TextAttribute],
                                          in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        let reduced = attrs.reduce(into: [NSAttributedString.Key: Any]()) { result, attribute in
            switch attribute {
            case .textAlignment, .lineSpacing, .lineBreakMode:
                let existingStyle = (result[attribute.key] as? NSParagraphStyle) ?? NSParagraphStyle.default
                let value = attribute.value as! NSParagraphStyle
                result[attribute.key] = existingStyle + value
                return
            // switch for each other type so when new cases are added we don't forget to update this
            case .backgroundColor:
                break
            case .font:
                break
            case .foregroundColor:
                break
            case .kern:
                break
            case .shadow:
                break
            case .strikethroughColor:
                break
            case .strikethroughStyle:
                break
            case .underlineColor:
                break
            case .underlineStyle:
                break
            case .link:
                break
            }
            result[attribute.key] = attribute.value
        }
        addAttributes(reduced, range: inRange)
        return self
    }
    
    /// Adds the `TextAttribute`s to all occurrences matching `aString` in the `NSMutableAttributedString` and returns self,
    /// optionally restricted to `inRange`
    @discardableResult func addAttribute(_ attr: TextAttribute,
                                         toOccurencesOfString aString: String,
                                         options opts: String.CompareOptions = [],
                                         in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        return addAttributes([attr], toOccurencesOfString: aString, options: opts, in: inRange)
    }
    
    @discardableResult func addAttributes(_ attrs: [TextAttribute],
                                          toOccurencesOfString aString: String,
                                          options opts: String.CompareOptions = [],
                                          in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        enumerateOccurrences(of: aString, options: opts, in: inRange) { attributedString, range in
            attributedString.addAttributes(attrs)
        }
        return self
    }
    
    /// Removes the `TextAttribute.Style` from the `NSMutableAttributedString` and returns self,
    /// optionally restricted to `inRange`
    @discardableResult func removeAttribute(_ attr: TextAttribute.Style,
                                            in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        return removeAttributes([attr], in: inRange)
    }
    
    @discardableResult func removeAttributes(_ attrs: [TextAttribute.Style],
                                             in inRange: Range<String.Index>? = nil) -> NSMutableAttributedString {
        attrs.forEach { attr in
            enumerateAttribute(attr, in: inRange) { attribute, range in
                removeAttribute(attr.key, range: range)
            }
        }
        return self
    }
    
    /// Removes the `TextAttribute.Style` from all occurrences matching `aString` in the `NSMutableAttributedString` and returns self,
    /// optionally restricted to `inRange`
    @discardableResult func removeAttribute(_ attr: TextAttribute.Style,
                                            fromOccurencesOfString aString: String,
                                            options opts: String.CompareOptions = [],
                                            in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        return removeAttributes([attr], fromOccurencesOfString: aString, options: opts, in: inRange)
    }
    
    @discardableResult func removeAttributes(_ attrs: [TextAttribute.Style],
                                             fromOccurencesOfString aString: String,
                                             options opts: String.CompareOptions = [],
                                             in inRange: Range<String.Index>? = nil) -> NSAttributedString {
        enumerateOccurrences(of: aString, options: opts, in: inRange) { attributedString, range in
            attributedString.removeAttributes(attrs)
        }
        return self
    }
}
