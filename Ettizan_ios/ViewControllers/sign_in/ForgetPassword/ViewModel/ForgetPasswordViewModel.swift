//
//  ForgetPasswordViewModel.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 29/11/2023.
//

import Foundation


class ForgetPasswordViewModel {
    
    var VC : ForgetPasswordVC?
    
    init(VC: ForgetPasswordVC) {
        self.VC = VC
        setupView()
    }
    
    
    
    func setupView(){
        VC?.txtEmail.keyboardType = .emailAddress
        VC?.txtEmail.isWithPlaceholder = true
        VC?.txtEmail.setupView()
    }

    func validation() -> Bool {
        if VC?.txtEmail.isValidateValue == false {
            Alert.ShowErrorMessage(message: "TextFeildValidation".localized(with: VC?.txtEmail.txtLocalize ?? ""))
            return false
        }
        if !((VC?.txtEmail.text?.removeWhiteSpaceAndArabicNumbers.isValidEmail() ?? false)) {
            Alert.ShowErrorMessage(message: "InvalidEmail".localized)
            return false
        }
        return true
    }
    
    func forgetPasswordAPI(){
        SharedManager.showHUD(viewController: self.VC!)
        APIClient.performRequest(route: APIRouter.forgetPassword(email: VC?.txtEmail.text ?? "")) { (response:ForgetPasswordModel?, error: Error?) in
            SharedManager.dismissHUD(viewController: self.VC!)
            if error == nil && response != nil{
               // Alert.showPopAlert(title: "Login", message: response?.responseMessage ?? "")
                self.pushView()
            }else{
                Alert.ShowErrorMessage(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func pushView(){
        let vc = VC?.viewController(storyboard: .resetPassword, Identifier: .resetPassword) as! ResetPasswordVC
        vc.email = VC?.txtEmail.text ?? ""
        self.VC?.navigationController?.pushViewController(vc, animated: true)
    }
}
