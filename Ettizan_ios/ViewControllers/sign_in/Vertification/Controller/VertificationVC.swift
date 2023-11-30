//
//  VertificationVC.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 29/11/2023.
//

import UIKit
import SVPinView


class VertificationVC : UIViewController{
    
    @IBOutlet weak var pinView: SVPinView!
    
    @IBOutlet weak var lblMobile: UILabel!
    
    @IBOutlet weak var lblTimer: UILabel!
    
    @IBOutlet weak var btnTimer: UIButton!
    
    var mobile : String?
    var country: Country?
    
    var viewModel : VertificationViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = VertificationViewModel(VC: self)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
        self.popViewController()
    }
    
    @IBAction func btnVerify(_ sender: Any) {
        viewModel?.vertificationAPI()
    }
    
    @IBAction func btnResend(_ sender: Any) {
        viewModel?.btnResend()
    }
}

