//
//  CustomTextField.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 27/11/2023.
//

import UIKit
import MaterialComponents

class CustomTextField: UIView {
    @IBOutlet weak var stackPhoneCodePlaceholder: UIStackView!
    
    @IBOutlet weak var btnPhoneCode: UIButton!
    @IBOutlet weak var viewPhoneCode: UIView!
    
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var btnShowHidePassword: UIButton!
    @IBOutlet weak var txtField: MDCOutlinedTextField!
    
    
    @IBOutlet weak var lblPlaceholder: UILabel!
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    
    var img:UIImage?// = UIImage.init()
    
    
    var ChangedBackgroud = true
    
    var selectCountry : (()->())?
    
    @IBInspectable var image:UIImage? {
        didSet {
            img = image
            txtField.leadingView = UIImageView.init(image: image)
            txtField.leadingViewMode = .always
        }
    }
    
    var isMobile = false
    
    var isWithPlaceholder = false
    
    var selectedCountry: Country? {
        didSet {
            lblCode.textColor = UIColor(resource: ._3_B_3_C_3_E)
            lblCode.text = selectedCountry?.prefix?.description
            imgFlag.setImageFromURL(urlString: selectedCountry?.imageUrl ?? "")
            txtField.maxLength = selectedCountry?.mobileDigits ?? 0
        }
    }
    
    @IBInspectable var isWhiteBackground: Bool = false {
        didSet {
            if isWhiteBackground {
                self.mainView.backgroundColor = .clear
                self.txtField.backgroundColor = .white
            }else {
                self.mainView.backgroundColor = "#F6F6F6".color_
                self.txtField.backgroundColor = "#F6F6F6".color_
            }
        }
    }
    
    @IBInspectable var isWithBorder: Bool = true {
        didSet {
            if isWithBorder {
                txtField.setOutlineColor("#22C1D3".color_, for: .editing)
                txtField.setOutlineColor("#E2E4E4".color_, for: .normal)
            }else {
                txtField.setOutlineColor(.clear, for: .editing)
                txtField.setOutlineColor(.clear, for: .normal)
            }
        }
    }
    
    @IBInspectable var isRequired: Bool = false {
        didSet {
            if isRequired {
                // create attributed string
                let myString = "  *  "
                let myAttribute = [ NSAttributedString.Key.foregroundColor: "#FF3434".color_ ]
                let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
                let myAttributeLocalized = [ NSAttributedString.Key.foregroundColor: "#818181".color_ ]
                let myAttrStringLocalized = NSAttributedString(string: txtLocalize ?? "", attributes: myAttributeLocalized)
                
                let str = NSMutableAttributedString.init()
                str.append(myAttrStringLocalized)
                str.append(myAttrString)
                // set attributed text on a UILabel
                txtField.label.attributedText = str
                //                txtField.attributedText = str
                //            txtField.label.attributedText = txtLocalize?.localize_
            }
            
        }
    }
    
    @IBInspectable var txtLocalize: String? {
        set {
            txtField.localizedTextField = newValue
            txtField.label.text = newValue?.localized
        } get {
            return txtField.localizedTextField?.localized
        }
    }
    
    @IBInspectable var placeholder: String? {
        set {
            lblPlaceholder.localizedLabel = newValue
        } get {
            return lblPlaceholder.localizedLabel?.localized
        }
    }
    
    
    @IBInspectable var isSecureText: Bool = false {
        didSet {
            txtField.isSecureTextEntry = isSecureText
            btnShowHidePassword.isHidden = !isSecureText
            btnShowHidePassword.setImage("icHidePassword".image_, for: .normal)
        }
    }
    
    var keyboardType: UIKeyboardType = .default {
        didSet {
            txtField.keyboardType = keyboardType
        }
    }
    
    var text: String? {
        set {
            txtField.text = newValue
        }
        get {
            return txtField.text
        }
    }
    var placeHolder: String? {
        return txtField.placeholder
    }
    
    
    
    var isValidateValue: Bool {
        return txtField.isValidateValue()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureXib()
    }
    
    private func configureXib() {
        Bundle.main.loadNibNamed("CustomTextField", owner: self, options: [:])
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
      //  contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.layoutIfNeeded()
        txtField.delegate = self
        setupView()
    }
    
    
    func setupView() {
        btnShowHidePassword.imageView?.imageTintColor = "#4A4A4B".color_
        txtField.setNormalLabelColor("#9AA1AA".color_, for: .normal)
        txtField.setTextColor("#9AA1AA".color_, for: .editing)
        txtField.setFloatingLabelColor("#9AA1AA".color_, for: .editing)
        txtField.setLeadingAssistiveLabelColor("#9AA1AA".color_, for: .editing)
        txtField.setTrailingAssistiveLabelColor("#9AA1AA".color_, for: .editing)
        txtField.setTextColor("#9AA1AA".color_, for: .normal)
        txtField.setFloatingLabelColor("#9AA1AA".color_, for: .normal)
        txtField.setLeadingAssistiveLabelColor("#9AA1AA".color_, for: .normal)
        txtField.setTrailingAssistiveLabelColor("#9AA1AA".color_, for: .normal)
        txtField.setPlaceHolderTextColor("#9AA1AA".color_)
        
        if isMobile {
            stackPhoneCodePlaceholder.isHidden = false

            txtField.textAlignment = .left
            txtField.setRightPaddingPoints(100)
            lblPlaceholder.textColor = "#C4C4C6".color_
            btnPhoneCode.isHidden = false
            txtField.keyboardType = .asciiCapableNumberPad
        }else {
            btnPhoneCode.isHidden = true
            txtField.textAlignment = .right
            lblPlaceholder.textColor = "#818181".color_
            
            if isWithPlaceholder {
                stackPhoneCodePlaceholder.isHidden = false
                viewPhoneCode.isHidden = true
            }else {
                stackPhoneCodePlaceholder.isHidden = true
            }
            
        }
        
    }
    @IBAction func btnPhoneCode(_ sender: Any) {
        debugPrint("btnPhoneCode ..")
        self.selectCountry?()
//        let vc = ChooseCountryViewController.storyboard_ as! ChooseCountryViewController
//        vc.selectedCountry = selectedCountry
//        vc.presentVC()
    }
    
    @IBAction func btnShowHidePassword(_ sender: Any) {
        txtField.isSecureTextEntry.toggle()
        btnShowHidePassword.setImage(txtField.isSecureTextEntry ? "icHidePassword".image_ : "icShowPasswprd".image_, for: .normal)
    }
}

extension CustomTextField : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lblPlaceholder.isHidden = true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if isMobile || isWithPlaceholder {
            lblPlaceholder.isHidden = textField.text != nil
        }
    }
}

import UIKit
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.prefix(maxLength).description
    }
}
