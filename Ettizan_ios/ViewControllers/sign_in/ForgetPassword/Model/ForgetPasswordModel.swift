//
//  ForgetPasswordModel.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 29/11/2023.
//

import Foundation

struct ForgetPasswordModel : Codable {

    let responseMessage : String?
    let status : Bool?


    enum CodingKeys: String, CodingKey {
        case responseMessage = "response_message"
        case status = "status"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        responseMessage = try values.decodeIfPresent(String.self, forKey: .responseMessage)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }


}
