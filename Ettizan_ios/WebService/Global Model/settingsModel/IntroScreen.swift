//
//  IntroScreen.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 27/11/2023.
//

import Foundation

struct IntroScreen : Codable {

    let imageUrl : String?
    let title : String?


    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case title = "title"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }


}
