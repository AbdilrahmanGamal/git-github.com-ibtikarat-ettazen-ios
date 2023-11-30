//
//  loginViewModel.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 28/11/2023.
//

import Foundation


class loginViewModel {
    
    var countries : [Country] = []
    
    var selectedCountry = Constants.shared.countries?.first(where: {$0.id == 2}) {
        didSet {
            VC?.txtMobile.selectedCountry = selectedCountry
        }
    }
    
    var VC : LoginVC?
    
    init(VC: LoginVC) {
        self.VC = VC
        //setupView()
        
        Constants.shared.getConfiugration { constantsList in
            self.countries = constantsList
            self.selectedCountry = Constants.shared.countries?.first(where: {$0.id == 2})
            //self.VC?.txtMobile.selectedCountry = self.selectedCountry
            self.setupView()
        }
    }
    
    
    
    func login() {
        let mobile = VC?.txtMobile.text ?? ""
        let password = VC?.txtPassword.text ?? ""
        let countryId = "\(selectedCountry?.id ?? 0)"
        SharedManager.showHUD(viewController: self.VC!)
        APIClient.performRequest(route: APIRouter.login(mobile: mobile, password: password, countryId: countryId)) { (response:loginModel?, error: Error?) in
            SharedManager.dismissHUD(viewController: self.VC!)
            if error == nil && response != nil{
                //Cache.set(object: response, forKey: Constants.shared.userData_Key)
                if response?.user?.status == 0 && self.selectedCountry?.id == 2 {
                    self.pushVertification()
                }else{
                    
                }
                Alert.showPopAlert(title: "Login", message: response?.responseMessage ?? "")
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
    
    func pushForgetPassword(){
        let vc = self.VC?.viewController(storyboard: .forgetPassword, Identifier: .forgetPassword) as! ForgetPasswordVC
        self.VC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushRegisterVC(){
        let vc = self.VC?.viewController(storyboard: .register, Identifier: .register) as! RegisterVC
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




extension loginViewModel {
    func setupView(){
        VC?.btnForgetPassword.underline()
        VC?.lblRegisterNow.underline()
        //VC?.txtMobile.selectedCountry = selectedCountry
        VC?.txtMobile.isMobile = true
        VC?.txtMobile.setupView()
        
        VC?.txtMobile.selectCountry = {
            self.pushChooseCountry()
        }
    }
    
    func validation() -> Bool {
        if VC?.txtMobile.isValidateValue == false {
            Alert.ShowErrorMessage(message: "TextFeildValidation".localized(with: VC?.txtMobile.txtLocalize ?? ""))
            return false
        }
        
        if VC?.txtMobile.text?.count != selectedCountry?.mobileDigits {
            Alert.ShowErrorMessage(message: "MobileDigits".localized(with: selectedCountry?.mobileDigits?.description ?? ""))
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
