//
//  ForgetPasswordVC.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 29/11/2023.
//

import UIKit

class ForgetPasswordVC : UIViewController{
    
    @IBOutlet weak var txtEmail: CustomTextField!
    
    var viewModel : ForgetPasswordViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ForgetPasswordViewModel(VC: self)
    }
    
    @IBAction func btnDismiss(_ sender: Any) {
        popViewController()
    }
    
    @IBAction func btnNext(_ sender: Any) {
        if !(viewModel?.validation() ?? false) {
            return
        }
        viewModel?.forgetPasswordAPI()
    }
}


