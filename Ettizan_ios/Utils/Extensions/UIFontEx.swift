//
//  UIFontEx.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 29/11/2023.
//

import Foundation
import UIKit


extension UIFont{
    
    class func getFont(fontSize : CGFloat) -> UIFont{
        return UIFont(name: Constants.shared.fontName, size: fontSize)!
    }
    
}
