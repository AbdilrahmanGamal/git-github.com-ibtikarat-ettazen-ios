//
//  APIRouter.swift
//  Alhabibshop
//
//  Created by abdelbaqy yassin on 12/10/20.
//  Copyright © 2020 adyas. All rights reserved.
//

import Foundation
import Alamofire

var ApiToken = ""
var CustomerId = ""
var udid = ""



class API: NSObject {

    class  var baseUrl: String {
        if let env = UserDefaults.standard.string(forKey: "Environment") {
            if env == "Production" {
                return "https://ettazenn.com/api/"
            } else {
                return "https://ettazenn.com/api/"
            }
        } else {
            return "https://ettazenn.com/api/"
        }
    }
}

enum APIRouter: URLRequestConvertible{
    
    case configration
    case login(mobile: String , password : String , countryId : String)
    case register(name : String ,email : String,mobile: String , password : String , countryId : String)
    case forgetPassword(email : String)
    case resetPassword(email : String,new_password : String ,new_password_confirmation: String , code : String)
    case validateMobile(mobile : String,country_id : String ,code: String , device_key : String)
    case resendMobileCode(mobile : String)

  

    //MARK:- HTTPMETHOD
    private var method : HTTPMethod{
        
        switch self {
        case .login,
            .register,
            .forgetPassword,
            .resetPassword,
            .validateMobile,
            .resendMobileCode:
            return .post
        default:
            return .get
        }
    }
    
    private var contentType : CONTENT_TYPE{
        switch self {
        
            
        case .login(_, _, _) ,
                .register(_, _, _, _, _) ,
                .forgetPassword(_) ,
                .resetPassword(_,_,_,_),
                .validateMobile(_,_,_,_),
                .resendMobileCode(_):
            return .FORM_DATA
        default:
            return .JSON
        }
        
    }
    //MARK:- PATH
    private var path:String{
        switch self {
            
        case .configration:
            return "app/settings"
        case .login(mobile: _, password: _, countryId: _):
            return "app/login"
        case .register(name: _, email: _,mobile: _, password: _, countryId: _):
            return "app/register"
        case .forgetPassword(email: _):
            return "app/send-password-code"
        case .resetPassword(email: _, new_password: _, new_password_confirmation: _, code: _):
            return "app/reset-password"
        case .validateMobile(mobile: _, country_id: _, code: _, device_key: _):
            return "app/validate-mobile"
        case .resendMobileCode(mobile: _):
            return "app/resend-mobile-code"
        }
    }
    
    //MARK:- ENCODING
    internal var encoding : ParameterEncoding{
        switch method {
        case .get:
            return URLEncoding.default
        default:
            switch contentType {
            case .JSON:
                return JSONEncoding.default
            default:
                return URLEncoding.default
            }
        }
    }
    
    //MARK:- ENCODING
    internal  var parameters:[String:Any]?{
        switch self {
            
            // case of request without params

            
        case .register(name: let name,email: let email,mobile: let mobile, password: let password, countryId: let countryId):
            return [APIParametersKey.name:name,
                    APIParametersKey.email:email,
                    APIParametersKey.mobile:mobile,
                    APIParametersKey.password:password,
                    APIParametersKey.country_id:countryId,
                    APIParametersKey.device_key:"asdsadsdsadsadsadsadsd",
                    APIParametersKey.device_type:Constants.shared.deviceType
            ]
            
        case .login(mobile: let mobile, password: let password, countryId: let countryId):
            return [APIParametersKey.mobile:mobile,
                    APIParametersKey.password:password,
                    APIParametersKey.country_id:countryId,
                    APIParametersKey.device_key:"asdsadsdsadsadsadsadsd",
                    APIParametersKey.device_type:Constants.shared.deviceType
            ]
        case .forgetPassword(email: let email):
            return [APIParametersKey.email:email]
        case .resetPassword(email: let email, new_password: let new_password, new_password_confirmation: let new_password_confirmation, code: let code):
            return [APIParametersKey.email:email,
                    APIParametersKey.new_password:new_password,
                    APIParametersKey.new_password_confirmation:new_password_confirmation,
                    APIParametersKey.code:code]
        case .validateMobile(mobile: let mobile, country_id: let country_id, code: let code, device_key: let device_key):
            return [APIParametersKey.mobile:mobile,
                    APIParametersKey.country_id:country_id,
                    APIParametersKey.device_key:device_key,
                    APIParametersKey.code:code]
        case .resendMobileCode(mobile: let mobile):
            return [APIParametersKey.mobile:mobile]
        default:
            return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try "\(API.baseUrl + path)".asURL()
        print("URL : \(url.absoluteString )")
        var urlRequest = URLRequest(url: try url.asURL())
        //HTTP METHOD
        urlRequest.httpMethod = method.rawValue
        
        //HEADER
        let lang = Language.isRTL ? "ar" : "en"
        var code = ""

        
        urlRequest.setValue(lang, forHTTPHeaderField: APIParametersKey.LanguageHeader)
        
        let systemVersion = UIDevice.current.systemVersion

        if let sess = UserDefaults.standard.value(forKey: "OCSESSID") as? String{
            urlRequest.setValue(sess , forHTTPHeaderField: "USER-SESSION-ID")
        }
        var versionNumber = ""
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            versionNumber = version
        }

        print("Param : " + "\( parameters.debugDescription)")
        print("Headers \(String(describing: urlRequest.allHTTPHeaderFields))")
        print("Request URL \(String(describing: urlRequest.url))")
        print("Parameters \(String(describing: urlRequest.httpBody))")
        print("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC")
        return try! encoding.encode(urlRequest, with: parameters)
        //        return urlRequest
        
    }
}



struct URLRequestNotFoundBaseUrl:Error {}

public enum CONTENT_TYPE: String {
    case JSON = "json"
    case FORM_DATA     = "formData"
    case XFORMWWWApplication = "application/x-www-form-urlencoded"
    case TEXT_PLAIN = "text/plain"
    
}

struct APIParametersKey {
    static let LanguageHeader = "language"
    
    static let name = "name"
    static let email = "email"
    static let mobile = "mobile"
    static let password = "password"
    static let device_type = "device_type"
    static let country_id = "country_id"
    static let finger_print = "finger_print"
    static let device_key = "device_key"

    static let new_password = "new_password"
    static let new_password_confirmation = "new_password_confirmation"
    static let code = "code"

    
//    static let CurrencyHeader = "Accept-Currency"
//    static let Language = "lang"
//    static let VisaTypeId = "visa_type_id"
//    static let CityId = "city_id"
//    static let PromoCode = "promo_code"
//    static let CountryId = "country_id"
//    static let UserId = "user_id"
//    static let ParentPaymentId = "parent_payment_id"
//    static let TrackNo = "track_no"
//    static let name = "name"
//    static let email = "user_email"
//    static let message = "message"
//    static let type = "type"
//    static let password = "password"
//    static let phone = "phone"
//    static let catId = "cat_id"
//    static let orderID = "order_id"
//    static let attachedImage = "attach_file"
//    static let msgType = "msg_type"
//    static let city_id = "city_id"
//    static let district_id = "district_id"
//    static let lat = "lat"
//    static let lng = "lng"
//    static let addition_info = "addition_info"
//    static let old_password = "old_password"
//    static let locale = "locale"
//    static let _locale = "_locale"
//    static let currency = "currency"
//    static let path = "path"
//    static let search = "search"
//    static let Address_id = "address_id"
//    static let order_id = "order_id"
//    static let note_id = "note_id"
//    static let ind_note_id = "ind_note_id"
//    static let key = "key"
//    
//    static let product_id = "product_id"
//    static let quantuty = "quantuty"
//    static let offer_id = "offers[]"
//    static let quantity = "quantity"
//    static let api_token = "api_token"
//    static let coupon = "coupon"
//
//    static let payment_method = "payment_method"
//    static let firstname = "firstname"
//    static let lastname = "lastname"
//    static let Email = "email"
//    static let telephone = "telephone"
//    static let address_1 = "address_1"
//    static let country_id = "country_id"
//    static let zone_id = "zone_id"
//    static let api_version = "api_version"
//    static let customer_id = "customer_id"
//    static let fullname = "full_name"
//
//    static let tamara_id = "tamara_order_id"
//    static let tabby_id = "tabby_order_id"
}



