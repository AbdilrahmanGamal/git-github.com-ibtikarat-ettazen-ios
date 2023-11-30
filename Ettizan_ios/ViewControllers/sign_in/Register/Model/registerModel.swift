//
//  registerModel.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 27/11/2023.
//

import Foundation

struct registerModel : Codable {

    let responseMessage : String?
    let status : Bool?
    let user : User?


    enum CodingKeys: String, CodingKey {
        case responseMessage = "response_message"
        case status = "status"
        case user
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        responseMessage = try values.decodeIfPresent(String.self, forKey: .responseMessage)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        //user = try User(from: decoder)
    }


}
