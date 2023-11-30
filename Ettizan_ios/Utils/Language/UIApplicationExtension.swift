

import UIKit

extension UIApplication {
    
    class func initWindow(){
        (UIApplication.shared.delegate as! AppDelegate).initview()
    }
}

