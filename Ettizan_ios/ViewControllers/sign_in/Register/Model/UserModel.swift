//
//  User.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 27/11/2023.
//

import Foundation

struct User : Codable {

    let activationCode : String?
    let activeSubscription : String?
    let alreadyLogin : Int?
    let country : Country?
    let createdAt : String?
    let email : String?
    let expirationAt : String?
    let id : Int?
    let mobile : String?
    let name : String?
    let passwordResetCode : String?
    let sendNotifications : Int?
    let status : Int?
    let theme : Theme?
    let token : String?
    let useFingerprint : Int?


    enum CodingKeys: String, CodingKey {
        case activationCode = "activation_code"
        case activeSubscription = "active_subscription"
        case alreadyLogin = "already_login"
        case country
        case createdAt = "created_at"
        case email = "email"
        case expirationAt = "expiration_at"
        case id = "id"
        case mobile = "mobile"
        case name = "name"
        case passwordResetCode = "password_reset_code"
        case sendNotifications = "send_notifications"
        case status = "status"
        case theme
        case token = "token"
        case useFingerprint = "use_fingerprint"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        activationCode = try values.decodeIfPresent(String.self, forKey: .activationCode)
        activeSubscription = try values.decodeIfPresent(String.self, forKey: .activeSubscription)
        alreadyLogin = try values.decodeIfPresent(Int.self, forKey: .alreadyLogin)
        country = try Country(from: decoder)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        expirationAt = try values.decodeIfPresent(String.self, forKey: .expirationAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        passwordResetCode = try values.decodeIfPresent(String.self, forKey: .passwordResetCode)
        sendNotifications = try values.decodeIfPresent(Int.self, forKey: .sendNotifications)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        theme = try Theme(from: decoder)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        useFingerprint = try values.decodeIfPresent(Int.self, forKey: .useFingerprint)
    }


}
