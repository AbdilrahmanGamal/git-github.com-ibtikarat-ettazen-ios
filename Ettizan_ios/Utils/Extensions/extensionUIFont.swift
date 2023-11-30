//
//  extensionUIFont.swift
//  Alhabibshop
//
//  Created by Abdilrahman on 12/6/20.
//  Copyright © 2020 adyas. All rights reserved.
//

import UIKit

//struct AppFontName {
//    static let regular = Constants.shared.fontName
//    static let bold    = "Alnaseeb-Bold"
////    static let italic  = "Alnaseeb-Italic"
//}

extension UIFont {
        
    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }
    
    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
}

