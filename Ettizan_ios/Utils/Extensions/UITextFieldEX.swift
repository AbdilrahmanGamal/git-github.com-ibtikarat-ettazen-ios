//
//  UITextFieldEX.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 27/11/2023.
//

import UIKit

extension UITextField {
    
    @IBInspectable
    var localizedTextField: String? {
        get {
            return self.placeholder
        }
        set {
            self.placeholder = newValue?.localized
        }
    }
    
    @IBInspectable
    public var fontSize: CGFloat {
        get {
            return font?.pointSize ?? 0
        }
        set {
            self.font = UIFont(name: Constants.shared.fontName, size: newValue)
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    
    public func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else {
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: holder, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    func isValidateValue() -> Bool {
        if ((self.text?.count ?? 0) < 1 ) || (self.text == nil) || (self.text == "") || (self.text?.replacingOccurrences(of: " ", with: "").count == 0) || self.text?.isEmptyOrWhiteSpace() == true {
            return false
        }
        return true
    }
}
