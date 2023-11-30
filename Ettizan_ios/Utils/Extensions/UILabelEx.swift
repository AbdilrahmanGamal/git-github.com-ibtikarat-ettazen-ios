//
//  UILabelEx.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 27/11/2023.
//

import UIKit

@IBDesignable
extension UILabel {
    
    @IBInspectable
    var localizedLabel: String? {
        get {
            return self.text
        }
        set {
            self.text = newValue?.localized
        }
    }
    
    @IBInspectable
    public var fontSize: CGFloat {
        get {
            return font.pointSize
        }
        set {
            self.font = UIFont(name: Constants.shared.fontName, size: newValue)
        }
    }
    
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
    
    
}
