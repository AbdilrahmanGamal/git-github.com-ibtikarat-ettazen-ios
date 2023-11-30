//
//  Cache.swift
//  Piano Cafe
//
//  Created by MAHMOUD ABDULKAWY on 4/12/18.
//  Copyright © 2018 DSFH. All rights reserved.
//

import UIKit


class Cache: NSObject {
    static let shared = Cache()

    
    var isFirstTime: Bool? {
        get {
            return Cache.object(key: "isFirstTime") as? Bool
        }
        set {
            Cache.set(object: newValue, forKey: "isFirstTime")
        }
    }
    
    
    var currentUserData: loginModel? {
        get {
            return Cache.object(key: Constants.shared.userData_Key) as? loginModel
        }
    }

    var currentUserID: Int? {
        get {
            if let id = currentUserData?.user?.id {
                return id
            }else{
                return nil
            }
        }
    }
    
    var currentUserToken: String? {
        get {
            if let token = currentUserData?.user?.token {
                return token
            }else{
                return nil
            }        }

    }
    

    
    private static func archiveUserInfo(info : Any) -> NSData {
        return NSKeyedArchiver.archivedData(withRootObject: info) as NSData
    }
    
    
    class func object(key:String) -> Any? {
        if let unarchivedObject = UserDefaults.standard.object(forKey: key) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data)
        }
        return nil
    }
    
    
    class func set(object : Any? ,forKey key:String) {
        let archivedObject = archiveUserInfo(info: object!)
        UserDefaults.standard.set(archivedObject, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    
    
    class func removeObject(key:String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    
    
}
