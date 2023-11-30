//
//  APIClient+Extension.swift
//  Alhabibshop
//
//  Created by abdelbaqy yassin on 12/10/20.
//  Copyright © 2020 adyas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



protocol PerformRequestsVisa {
    
    @discardableResult
    static func performRequest<T:Decodable>(route:URLRequestConvertible, completion:@escaping (T?,Error?)->Void) -> DataRequest ;
    static func performRequestOTP<T:Decodable>(route:URLRequestConvertible, completion:@escaping (T?,CustomError?)->Void) -> DataRequest ;
}

class APIClient: NSObject , PerformRequestsVisa{
    
    @discardableResult
    static func performRequestOTP<T:Decodable>(route:URLRequestConvertible, completion:@escaping (T?,CustomError?)->Void) -> DataRequest {
        return doRequestOTP(route, completion)
    }
    
    @discardableResult
    fileprivate static func doRequestOTP<T:Decodable>(_ route: URLRequestConvertible, _ completion:@escaping (T?, CustomError?) -> Void) -> DataRequest {
        
        return Alamofire.request(route).responseJSON(completionHandler: { (response) in
            print("route === \(response)")
            switch response.result{
            case .success(_):
                
                if let headerFields = response.response?.allHeaderFields as? [String: String] {
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: (response.request?.url)!)
                   
                        var cookDicList : [[String: Any]] = []
                        cookies.forEach { cookie in
                            let dic = [cookie.name : cookie.value]
                            cookDicList.append(dic)
                            if cookie.name == "OCSESSID" {
                                UserDefaults.standard.setValue(cookie.value, forKey: "OCSESSID")
                            }
                            print("=======================================================================>\(dic)")
                            
                            print("=======================================================================>\(dic)")
                        let cooc = HTTPCookie.requestHeaderFields(with: cookies)
                        UserDefaults.standard.setValue(cooc, forKey: "COOKIES")
                        //                        UserDefaults.standard.setValue(cookDicList, forKey: "COOKIES")
                        UserDefaults.standard.synchronize()
                    }
                }
                
                do{
                    let DataResponsed = try JSONDecoder().decode(T.self, from: response.data!)
                    if response.response?.statusCode == 401 {
                        completion(DataResponsed,CustomError.errorWithMessage(message: "Activation code is invalid".localized))
                    } else if response.response?.statusCode == 404 {
                        completion(nil,response.error as? CustomError)
                    }else {
                        let DataResponsed = try JSONDecoder().decode(T.self, from: response.data!)
                        completion(DataResponsed,nil)
                    }
                }
                catch{
                    print("error === \(error)")
                    completion(nil,error as? CustomError)
                }
            case .failure(let error):
                print(error)
                completion(nil,error as? CustomError)
            }
        })
    }
    
    @discardableResult
    static func performRequest<T:Decodable>(route:URLRequestConvertible, completion:@escaping (T?,Error?)->Void) -> DataRequest {
        return doRequest(route, completion)
    }
    
    @discardableResult
    fileprivate static func doRequest<T:Decodable>(_ route: URLRequestConvertible, _ completion:@escaping (T?, Error?) -> Void) -> DataRequest {
        
        return Alamofire.request(route).responseJSON(completionHandler: { (response) in
            print("route === \(response)")
            switch response.result{
            case .success(_):
                
                if let headerFields = response.response?.allHeaderFields as? [String: String] {
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: (response.request?.url)!)
                   
                        var cookDicList : [[String: Any]] = []
                        cookies.forEach { cookie in
                            let dic = [cookie.name : cookie.value]
                            cookDicList.append(dic)
                            if cookie.name == "OCSESSID" {
                                UserDefaults.standard.setValue(cookie.value, forKey: "OCSESSID")
                            }
                            print("=======================================================================>\(dic)")
                            
                            print("=======================================================================>\(dic)")
                       
                        let cooc = HTTPCookie.requestHeaderFields(with: cookies)
                        UserDefaults.standard.setValue(cooc, forKey: "COOKIES")
                        UserDefaults.standard.synchronize()
                    }
                }
                
                do{
                    let DataResponsed = try JSONDecoder().decode(T.self, from: response.data!)
                    
                    if response.response?.statusCode == 200 {
                        completion(DataResponsed,nil)
                    }else{
                        if let responseData = response.data {
                        let data = try? JSON(data: responseData)
                            if let message = data?["response_message"].string {
                                completion(nil,CustomError.errorWithMessage(message: message))
                            }else if let message = data?["error"].string {
                                completion(nil, CustomError.errorWithMessage(message: message))
                            }
                        }
                    }
                }
                catch{
                    print("error === \(error)")
                    completion(nil,error)
                }
            case .failure(let error):
                print(error)
                completion(nil,error)
            }
        })
    }
}

enum CustomError: Error {
    // Throw when an invalid password is entered
    case errorWithMessage(message: String)
    case invalidPassword
    
    // Throw when an expected resource is not found
    case notFound
    
    // Throw in all other cases
    case unexpected(code: Int)
}

extension CustomError: LocalizedError{
    public var errorDescription: String? {
        switch self {
        case .errorWithMessage(let message):
            return message
        default:
            return "error"
        }
    }
}
