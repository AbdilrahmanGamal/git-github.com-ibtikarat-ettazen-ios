//
//  DefaultTheme.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 27/11/2023.
//

import Foundation


struct DefaultTheme : Codable {

    let basicColor : String?
    let id : Int?
    let imageUrl : String?
    let isDefault : Int?
    let musicUrl : String?
    let name : String?
    let secondaryColor : String?


    enum CodingKeys: String, CodingKey {
        case basicColor = "basic_color"
        case id = "id"
        case imageUrl = "image_url"
        case isDefault = "is_default"
        case musicUrl = "music_url"
        case name = "name"
        case secondaryColor = "secondary_color"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        basicColor = try values.decodeIfPresent(String.self, forKey: .basicColor)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        isDefault = try values.decodeIfPresent(Int.self, forKey: .isDefault)
        musicUrl = try values.decodeIfPresent(String.self, forKey: .musicUrl)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        secondaryColor = try values.decodeIfPresent(String.self, forKey: .secondaryColor)
    }


}
