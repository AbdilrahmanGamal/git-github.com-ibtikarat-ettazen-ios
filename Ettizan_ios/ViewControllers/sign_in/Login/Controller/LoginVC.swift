//
//  LoginVC.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 27/11/2023.
//

import UIKit


class LoginVC : UIViewController{
    
    @IBOutlet weak var btnForgetPassword: UIButton!
    
    @IBOutlet weak var stackTitleClose: UIStackView!
    
    @IBOutlet weak var txtPassword: CustomTextField!
    
    @IBOutlet weak var txtMobile: CustomTextField!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var lblRegisterNow: UILabel!
    
    var viewModel : loginViewModel?
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = loginViewModel(VC: self)
    }
    
    
    @IBAction func btnForgetPassword(_ sender: Any) {
        viewModel?.pushForgetPassword()
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        viewModel?.pushRegisterVC()
    }
    @IBAction func btnLogin(_ sender: Any) {
        
        if !(viewModel?.validation() ?? false) {
            return
        }

        viewModel?.login()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

