

import UIKit
import SwiftMessages
import AudioToolbox


class Alert: NSObject {
    
    class   func show(title : String , cancelTitle : String , otherTitles : [String], completion :@escaping (_ index : Int) -> Void)  {
        
        let alertController = UIAlertController.init(title: "", message: title, preferredStyle: .alert)
        //        alertController.view.tintColor = UIColor.init(hexString: Constants.greenColorCode)
        
        
        let cancelAction = UIAlertAction.init(title: cancelTitle, style: .cancel, handler: { (action) in
            completion(0)
            
        })
        alertController.addAction(cancelAction)
        
        
        
        for string in otherTitles {
            
            let action = UIAlertAction.init(title: string, style: .default, handler: { (action) in
                
                completion(otherTitles.index(of: string)! + 1)
                
            })
            alertController.addAction(action)
            
        }
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
        
    }
    class func show(message : String)  {
        Alert.show(title: message, cancelTitle: "Ok", otherTitles: []) { (index) in
            
        }
        
    }
    
}





extension Alert{
    
    class func ShowErrorMessage(message: String) {
        self.showPopAlert(title: "Error".localized, message: message)
    }
    
    class func showPopAlert(title:String,message msg:String,okAction:(() -> Void)? = nil)  {
        
        let Errorview = MessageView.viewFromNib(layout: .cardView)
        Errorview.configureTheme(title == "Error".localized ? .error : .success)
        Errorview.button?.isHidden = true
        Errorview.titleLabel?.isHidden = true
        Errorview.titleLabel?.font =  UIFont.getFont(fontSize: 10)
        Errorview.bodyLabel?.font = UIFont.getFont(fontSize: 10)
        Errorview.configureContent(title: title == "Error".localized ? "Error".localized : "", body: msg, iconImage: "info-circle-linear".image_, iconText: nil, buttonImage: nil, buttonTitle: nil) {button in
            SwiftMessages.hideAll()
        }
        
        var config = SwiftMessages.Config.init()
        config.becomeKeyWindow = true
        SwiftMessages.show(config: config, view: Errorview)
        
        AudioServicesPlaySystemSound(1521)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            SwiftMessages.hideAll()
            okAction?()
        }
        
//        let alertController = UIAlertController(title: title.localize_, message: msg.localize_, preferredStyle: .alert)
//        let defaultAction = UIAlertAction(title:"OK".localize_, style: .default, handler: { (pAlert) in
//            //Do whatever you wants here
//            okAction?()
//        })
//        alertController.addAction(defaultAction)
//        self.present(alertController, animated: true, completion: nil)
    }
    
}


extension UIApplication {
    
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}



