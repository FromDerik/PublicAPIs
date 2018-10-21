//
//  Entry.swift
//  PublicAPIs
//
//  Created by Derik Malcolm on 10/21/18.
//  Copyright © 2018 Derik Malcolm. All rights reserved.
//

import Foundation

struct APIResponse: Codable {
    let count: Int
    let entries: [Entry]
}

struct Entry: Codable {
    let api: String
    let description: String
    let auth: String
    let https: Bool
    let cors: String
    let link: String
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case api = "API"
        case description = "Description"
        case auth = "Auth"
        case https = "HTTPS"
        case cors = "Cors"
        case link = "Link"
        case category = "Category"
    }
}
