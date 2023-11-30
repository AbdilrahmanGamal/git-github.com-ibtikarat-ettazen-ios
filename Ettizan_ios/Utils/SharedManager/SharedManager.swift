//
//  SharedManager.swift
//  IraqiMart
//
//  Created by Adyas on 29/11/16.
//  Copyright © 2016 IraqiMart. All rights reserved.
//

import UIKit
//import SwiftGifOrigin
//import NVActivityIndicatorView

class SharedManager: NSObject {
    
    static var activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    static var viewLoader = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    
    class func showHUD(viewController: UIViewController)
    {
        viewLoader.backgroundColor = .black.withAlphaComponent(0.6)
        
        let width : CGFloat = 170
        
        var containerView = UIView(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - width/2, y: (UIScreen.main.bounds.height / 2) - width/2, width: width, height: 180))
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 20, width: width, height: 100))
        imageView.image = UIImage(named: "icLoadingLogo")
        imageView.contentMode = .scaleAspectFit
        containerView.addSubview(imageView)
        
        // إنشاء النص
        let label = UILabel(frame: CGRect(x: 0, y: 120, width: width, height: 50))
        label.text = "جاري التحميل ..."
        label.textColor = UIColor(resource: ._3_B_3_C_3_E)
        label.font = UIFont(name: Constants.shared.fontName, size: 18)
        label.textAlignment = .center
        containerView.addSubview(label)
        
        viewLoader.isHidden = false
        viewLoader.addSubview(containerView)

        viewController.view.addSubview(viewLoader)
        
    }
    class func dismissHUD(viewController: UIViewController)
    {
        viewLoader.isHidden = true
    }
    
    
    class func showAlertWithMessage(title: String, alertMessage: String, viewController: UIViewController)
    {
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
    class  func show_AlertWith_Array(title : String , cancelTitle : String , otherTitles : [String], viewController : UIViewController ,completion :@escaping (_ index : Int) -> Void)  {
        
        let alertController = UIAlertController.init(title: "", message: title, preferredStyle: .actionSheet)
        
        
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
        
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    }
}


