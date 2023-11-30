//
//  RegisterViewModel.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 28/11/2023.
//

import Foundation
import UIKit


class RegisterViewModel {
    
    var countries : [Country] = []
    
    var selectedCountry = Constants.shared.countries?.first(where: {$0.id == 2}) {
        didSet {
            VC?.txtMobile.selectedCountry = selectedCountry
        }
    }
    
    var VC : RegisterVC?
    init(VC: RegisterVC) {
        self.VC = VC
        //setupView()
        
        Constants.shared.getConfiugration { constantsList in
            self.countries = constantsList
            self.selectedCountry = Constants.shared.countries?.first(where: {$0.id == 2})
            self.setupView()
        }
        
    }
    
    func setupView(){
        VC?.lblTermsPrivacy.underline()
        VC?.txtMobile.isMobile = true
        //VC?.txtMobile.selectedCountry = selectedCountry
        VC?.txtEmail.isWithPlaceholder = true
        VC?.txtEmail.keyboardType = .emailAddress
        VC?.txtMobile.setupView()
        VC?.txtEmail.setupView()
        
        VC?.txtMobile.selectCountry = {
            self.pushChooseCountry()
        }
    }
    
    
    func register() {
        let name = VC?.txtName.text ?? ""
        let email = VC?.txtEmail.text ?? ""
        let mobile = VC?.txtMobile.text ?? ""
        let password = VC?.txtPassword.text ?? ""
        let countryId = "\(selectedCountry?.id ?? 0)"
        
        SharedManager.showHUD(viewController: self.VC ?? UIViewController())
        APIClient.performRequest(route: APIRouter.register(name: name, email: email,mobile: mobile, password: password, countryId: countryId)) { (response:registerModel?, error: Error?) in
            SharedManager.dismissHUD(viewController: self.VC ?? UIViewController())
            if error == nil && response != nil{
                //Cache.set(object: response, forKey: Constants.shared.userData_Key)
                if self.VC?.selectedCountry?.id == 2{
                    self.pushVertification()
                }else{
                    
                }
                Alert.showPopAlert(title: "Register", message: response?.responseMessage ?? "")
            }else{
                Alert.ShowErrorMessage(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func pushVertification(){
        let vc = self.VC?.viewController(storyboard: .Vertification, Identifier: .Vertification) as! VertificationVC
        vc.country = selectedCountry
        vc.mobile = VC?.txtMobile.text ?? ""
        self.VC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushChooseCountry(){
        if let chooseCountryVC = ChooseCountryVC.viewController{
            chooseCountryVC.selectedCountry = { country in
                self.selectedCountry = country
                self.VC?.txtMobile.selectedCountry = country

            }
            self.VC?.present(chooseCountryVC, animated: true)
        }
    }
    
}

extension RegisterViewModel {
    
    func validation() -> Bool {
        if VC?.txtName.isValidateValue == false {
            Alert.ShowErrorMessage(message: "TextFeildValidation".localized(with: VC?.txtName.txtLocalize ?? ""))
            return false
        }
        
        if let fullName = VC?.txtName.text, !fullName.isEmpty {
            let names = fullName.split(separator: " ")
            if names.count != 2 && names.count != 3 {
                Alert.ShowErrorMessage(message: "you_must_enter_valid_name".localized)
                return false
            }
        }
        if VC?.txtEmail.isValidateValue == false {
            Alert.ShowErrorMessage(message: "TextFeildValidation".localized(with: VC?.txtEmail.txtLocalize ?? ""))
            return false
        }
        if !((VC?.txtEmail.text?.removeWhiteSpaceAndArabicNumbers.isValidEmail() ?? false)) {
            Alert.ShowErrorMessage(message: "InvalidEmail".localized)
            return false
        }
        
        if VC?.txtMobile.isValidateValue == false {
            Alert.ShowErrorMessage(message: "TextFeildValidation".localized(with: VC?.txtMobile.txtLocalize ?? ""))
            return false
        }
        if VC?.txtMobile.text?.count != selectedCountry?.mobileDigits {
            Alert.ShowErrorMessage(message: "MobileDigits".localized(with: VC?.selectedCountry?.mobileDigits?.description ?? ""))
            return false
        }
        if VC?.txtMobile.text?.hasPrefix("5") == false {
            Alert.ShowErrorMessage(message: "MobileMustStartAt05".localized)
            return false
        }
        if VC?.txtPassword.isValidateValue == false {
            Alert.ShowErrorMessage(message: "TextFeildValidation".localized(with: VC?.txtPassword.txtLocalize ?? ""))
            return false
        }
        if VC?.txtPassword.text?.count ?? 7 < 6  {
            Alert.ShowErrorMessage(message: "PasswordValidation".localized)
            return false
        }
        return true
    }
}
