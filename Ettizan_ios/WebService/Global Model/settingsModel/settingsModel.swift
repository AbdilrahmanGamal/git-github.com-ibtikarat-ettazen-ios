//
//  settingsModel.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 27/11/2023.
//

import Foundation

struct settingsModel : Codable {

    let config : Config?
    let countries : [Country]?
    let defaultTheme : DefaultTheme?
    let introScreens : [IntroScreen]?
    let responseMessage : String?
    let status : Bool?
    let topSearchTexts : [String]?
    let user : String?


    enum CodingKeys: String, CodingKey {
        case config
        case countries = "countries"
        case defaultTheme
        case introScreens = "intro_screens"
        case responseMessage = "response_message"
        case status = "status"
        case topSearchTexts = "top_search_texts"
        case user = "user"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        config = try Config(from: decoder)
        countries = try values.decodeIfPresent([Country].self, forKey: .countries)
        defaultTheme = try DefaultTheme(from: decoder)
        introScreens = try values.decodeIfPresent([IntroScreen].self, forKey: .introScreens)
        responseMessage = try values.decodeIfPresent(String.self, forKey: .responseMessage)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        topSearchTexts = try values.decodeIfPresent([String].self, forKey: .topSearchTexts)
        user = try values.decodeIfPresent(String.self, forKey: .user)
    }


}
