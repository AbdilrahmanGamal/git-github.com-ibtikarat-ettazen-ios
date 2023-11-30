//
//  ResetPasswordVC.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 29/11/2023.
//

import UIKit
import SVPinView


class ResetPasswordVC : UIViewController{
    
    @IBOutlet weak var pinView: SVPinView!
    
    @IBOutlet weak var txtConfirmPassword: CustomTextField!
    
    @IBOutlet weak var txtNewPassword: CustomTextField!
    
    @IBOutlet weak var lblEmail: UILabel!
    
    var email: String?
    
    var viewModel : ResetPasswordViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ResetPasswordViewModel(VC: self)
    }
    
    
    @IBAction func btnDismiss(_ sender: Any) {
        self.popViewController()
    }
    
    @IBAction func btnReset(_ sender: Any) {
        if !(viewModel?.validation() ?? false) {
            return
        }
        viewModel?.resetPasswordAPI()
    }
    
    @IBAction func btnResend(_ sender: Any) {
        viewModel?.resendCodeAPI()        
    }
    
}
