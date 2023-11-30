//
//  UIViewControllerEx.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 29/11/2023.
//

import UIKit

enum storyboardName : String {
    case register = "Register"
    case forgetPassword = "ForgetPassword"
    case resetPassword = "ResetPassword"
    case Vertification = "Vertification"
}

enum storyboardIdentifier : String {
    case register = "RegisterVC"
    case forgetPassword = "ForgetPasswordVC"
    case resetPassword = "ResetPasswordVC"
    case Vertification = "VertificationVC"
}

extension UIViewController {
    
    func viewController(storyboard : storyboardName , Identifier : storyboardIdentifier) -> UIViewController{
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: Identifier.rawValue)
        return VC
    }
    
    func popViewController(){
        self.navigationController?.popViewController(animated: true)
    }
}
