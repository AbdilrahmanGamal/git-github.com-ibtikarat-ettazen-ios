//
//  ResetPasswordViewModel.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 29/11/2023.
//

import Foundation
import SVPinView

class ResetPasswordViewModel {
    
    var VC : ResetPasswordVC?
    init(VC: ResetPasswordVC) {
        self.VC = VC
        setupView()
    }
    

    
    func resetPasswordAPI(){
        SharedManager.showHUD(viewController: self.VC!)
        let route = APIRouter.resetPassword(email: self.VC?.email ?? "",
                                new_password: VC?.txtNewPassword.text ?? "",
                                new_password_confirmation: VC?.txtNewPassword.text ?? "",
                                code: self.VC?.pinView.getPin() ?? "")
        
        APIClient.performRequest(route: route) { (response:ResetPasswordModel?, error: Error?) in
            SharedManager.dismissHUD(viewController: self.VC!)
            if error == nil && response != nil{
                Alert.showPopAlert(title: "Login", message: response?.responseMessage ?? "")
            }else{
                Alert.ShowErrorMessage(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func resendCodeAPI(){
        SharedManager.showHUD(viewController: self.VC!)
        APIClient.performRequest(route: APIRouter.forgetPassword(email: VC?.email ?? "")) { (response:ForgetPasswordModel?, error: Error?) in
            SharedManager.dismissHUD(viewController: self.VC!)
            if error == nil && response != nil{
                Alert.showPopAlert(title: "Login", message: response?.responseMessage ?? "")
            }else{
                Alert.ShowErrorMessage(message: error?.localizedDescription ?? "")
            }
        }
    }
}


extension ResetPasswordViewModel {
    func setupView(){
        VC?.lblEmail.text = VC?.email
        
        if let pinView = VC?.pinView {
            pinView.becomeFirstResponderAtIndex = 0
            pinView.pinLength = 4
            pinView.interSpace = 20
            pinView.textColor = "#161B30".color_
            pinView.shouldSecureText = false
            pinView.style = .box
            
            pinView.contentMode = .left
            
            pinView.fieldCornerRadius = 6
            pinView.activeFieldCornerRadius = 6
            pinView.borderLineThickness = 0
            pinView.activeBorderLineThickness = 0
            pinView.tintColor = "#22C1D3".color_
            pinView.fieldBackgroundColor = .white
            pinView.activeFieldBackgroundColor = .white
            pinView.font = UIFont.getFont(fontSize: 20)
            pinView.keyboardType = .asciiCapableNumberPad
            pinView.keyboardAppearance = .default
            pinView.placeholder = "    "
            //pinView.placeholder = "-"
            pinView.isContentTypeOneTimeCode = true
            //        self.pinView.didFinishCallback = { pin in
            //            self.btnVerfiy(self)
            //        }
        }
    }
    
    
    
    func validation() -> Bool {
        if VC?.pinView.getPin().isValidateValue == false {
            Alert.ShowErrorMessage(message: "TextFeildValidation".localized(with: "Code".localized))
            return false
        }
        if VC?.txtNewPassword.isValidateValue == false {
            Alert.ShowErrorMessage(message: "TextFeildValidation".localized(with: VC?.txtNewPassword.txtLocalize ?? ""))
            return false
        }
        if VC?.txtNewPassword.text?.count ?? 7 < 6  {
            Alert.ShowErrorMessage(message: "PasswordValidation".localized)
            return false
        }
        if VC?.txtConfirmPassword.isValidateValue == false {
            Alert.ShowErrorMessage(message: "TextFeildValidation".localized(with: VC?.txtConfirmPassword.txtLocalize ?? ""))
            return false
        }
        if VC?.txtNewPassword.text != VC?.txtConfirmPassword.text {
            Alert.ShowErrorMessage(message: "InvalidPassword".localized)
            return false
        }
        return true
    }
}
