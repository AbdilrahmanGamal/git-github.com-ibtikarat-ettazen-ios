//
//  Country.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 27/11/2023.
//

import Foundation


struct Country : Codable {

    let id : Int?
    let imageUrl : String?
    let mobileDigits : Int?
    let name : String?
    let prefix : Int?


    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imageUrl = "image_url"
        case mobileDigits = "mobile_digits"
        case name = "name"
        case prefix = "prefix"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        mobileDigits = try values.decodeIfPresent(Int.self, forKey: .mobileDigits)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        prefix = try values.decodeIfPresent(Int.self, forKey: .prefix)
    }


}
