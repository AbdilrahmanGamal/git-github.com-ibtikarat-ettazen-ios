//
//  VertificationViewModel.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 29/11/2023.
//

import Foundation
import UIKit


class VertificationViewModel {
    
    var count: Int = 30
    var timer: Timer?
    
    
    var VC : VertificationVC?
    init(VC: VertificationVC) {
        self.VC = VC
        setupView()
    }
    
    
    
    func btnResend() {
        if (count == 0) {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countDownDate), userInfo: nil, repeats: true)
            self.VC?.btnTimer.setTitle("TimerCount".localized, for: .normal)
            self.count = 30
            self.resendAPI()
        }
    }
    
    
    func resendAPI(){
        SharedManager.showHUD(viewController: self.VC!)
        let route = APIRouter.resendMobileCode(mobile: self.VC?.mobile ?? "")
        
        APIClient.performRequest(route: route) { (response:resendModel?, error: Error?) in
            SharedManager.dismissHUD(viewController: self.VC!)
            if error == nil && response != nil{
                Alert.showPopAlert(title: "Login", message: response?.responseMessage ?? "")
            }else{
                Alert.ShowErrorMessage(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func vertificationAPI(){
        SharedManager.showHUD(viewController: self.VC!)
        let route = APIRouter.validateMobile(mobile: self.VC?.mobile ?? "",
                                             country_id: "\(self.VC?.country?.id ?? 0)",
                                             code: self.VC?.pinView.getPin() ?? "",
                                             device_key: "")
        
        APIClient.performRequest(route: route) { (response:VertificationModel?, error: Error?) in
            SharedManager.dismissHUD(viewController: self.VC!)
            if error == nil && response != nil{
                Alert.showPopAlert(title: "Login", message: response?.responseMessage ?? "")
            }else{
                Alert.ShowErrorMessage(message: error?.localizedDescription ?? "")
            }
        }
    }
    
}

extension VertificationViewModel {
    func validation() -> Bool {
        if self.VC?.pinView.getPin().isValidateValue == false {
            Alert.ShowErrorMessage(message: "TextFeildValidation".localized(with: "Code".localized))
            return false
        }
        return true
    }
}

extension VertificationViewModel {
    func setupView(){
        self.VC?.lblMobile.text = self.VC?.mobile
        if let pinView = VC?.pinView {
            pinView.becomeFirstResponderAtIndex = 0
            pinView.pinLength = 4
            pinView.interSpace = 20
            pinView.textColor = "#161B30".color_
            pinView.shouldSecureText = false
            pinView.style = .box
            pinView.fieldCornerRadius = 6
            pinView.activeFieldCornerRadius = 6
            pinView.borderLineThickness = 0
            pinView.activeBorderLineThickness = 0
            pinView.tintColor = "#22C1D3".color_
            //        pinView.borderLineColor = "#D0D5DC".color_
            //        pinView.activeBorderLineColor = "#6C727F".color_
            pinView.fieldBackgroundColor = .white
            pinView.activeFieldBackgroundColor = .white
            pinView.font = UIFont.getFont(fontSize: 20)
            pinView.keyboardType = .asciiCapableNumberPad
            pinView.keyboardAppearance = .default
            pinView.placeholder = "    "
            pinView.isContentTypeOneTimeCode = true
            self.VC?.pinView.didFinishCallback = { pin in
                self.vertificationAPI()
            }
        }
        self.VC?.btnTimer.setTitle("TimerCount".localized, for: .normal)
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countDownDate), userInfo: nil, repeats: true)
        
    }
}


extension VertificationViewModel {
    @objc func countDownDate() {
        if (count >= 0){
            let minutes = String(format: "%02d", count / 60)
            let seconds = String(format: "%02d", count % 60)
            self.VC?.lblTimer.localizedLabel = minutes + ":" + seconds
            if count > 0 {
                count -= 1
            }else {
                self.timer?.invalidate()
                self.VC?.lblTimer.text = nil
                self.VC?.btnTimer.setTitle("Resend Again".localized, for: .normal)
            }
        } else {
            self.timer?.invalidate()
            self.VC?.lblTimer.text = nil
            self.VC?.btnTimer.setTitle("Resend Again".localized, for: .normal)
        }
    }
    
}
