//
//  RegisterVC.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 28/11/2023.
//

import UIKit

class RegisterVC : UIViewController{
    
    @IBOutlet weak var txtMobile: CustomTextField!
    
    @IBOutlet weak var txtEmail: CustomTextField!
    
    @IBOutlet weak var txtName: CustomTextField!
    
    @IBOutlet weak var txtPassword: CustomTextField!
    
    @IBOutlet weak var lblTermsPrivacy: UILabel!
    
    var selectedCountry = Constants.shared.countries?.first(where: {$0.id == 2}) {
        didSet {
            txtMobile.selectedCountry = selectedCountry
        }
    }
    
    var viewModel : RegisterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = RegisterViewModel(VC: self)
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        if !(viewModel?.validation() ?? false) {
            return
        }
        viewModel?.register()
    }
    
    @IBAction func btnTermsPrivacy(_ sender: Any) {
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
}


