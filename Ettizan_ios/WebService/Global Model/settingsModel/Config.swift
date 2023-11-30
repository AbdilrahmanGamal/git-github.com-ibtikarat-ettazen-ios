//
//  Config.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 27/11/2023.
//

import Foundation

struct Config : Codable {

    let enableRating : String?
    let facebook : String?
    let instagram : String?
    let moyasarPublicKey : String?
    let moyasarSecretKey : String?
    let tiktok : String?
    let twitter : String?
    let whatsapp : String?
    let youtube : String?


    enum CodingKeys: String, CodingKey {
        case enableRating = "enable_rating"
        case facebook = "facebook"
        case instagram = "instagram"
        case moyasarPublicKey = "moyasar_public_key"
        case moyasarSecretKey = "moyasar_secret_key"
        case tiktok = "tiktok"
        case twitter = "twitter"
        case whatsapp = "whatsapp"
        case youtube = "youtube"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        enableRating = try values.decodeIfPresent(String.self, forKey: .enableRating)
        facebook = try values.decodeIfPresent(String.self, forKey: .facebook)
        instagram = try values.decodeIfPresent(String.self, forKey: .instagram)
        moyasarPublicKey = try values.decodeIfPresent(String.self, forKey: .moyasarPublicKey)
        moyasarSecretKey = try values.decodeIfPresent(String.self, forKey: .moyasarSecretKey)
        tiktok = try values.decodeIfPresent(String.self, forKey: .tiktok)
        twitter = try values.decodeIfPresent(String.self, forKey: .twitter)
        whatsapp = try values.decodeIfPresent(String.self, forKey: .whatsapp)
        youtube = try values.decodeIfPresent(String.self, forKey: .youtube)
    }


}
