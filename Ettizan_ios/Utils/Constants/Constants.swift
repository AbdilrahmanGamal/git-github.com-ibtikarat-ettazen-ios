//
//  Constants.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 28/11/2023.
//

import Foundation
import Alamofire


class Constants: NSObject {
    static let shared = Constants()
    
    var fontName = "Alnaseeb"
    
    var countries : [Country]?
    var defaultTheme: DefaultTheme?
    var intoSliders: [IntroScreen]?
    
    var deviceType = "IOS"
    var device_key = ""
    var userData_Key = "userData"

    func getConfiugration(completion: @escaping ((_ constantsList: [Country])-> Void)) {
        if let countr = countries {
            completion(countr)
        }else{
            getConfiugrationFromAPI { constantsList in
                completion(constantsList)
            }
        }
            
    }
    
    
    func getConfiugrationFromAPI(completion: @escaping ((_ completion: [Country])-> Void)) {
        APIClient.performRequest(route: APIRouter.configration) { (response:settingsModel?, error: Error?) in
            if error == nil && response != nil{
                if let countr = response?.countries{
                    self.countries = countr
                    self.defaultTheme = response?.defaultTheme
                    self.intoSliders = response?.introScreens
                    completion(countr)
                }
            }else{
                Alert.ShowErrorMessage(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    
}
