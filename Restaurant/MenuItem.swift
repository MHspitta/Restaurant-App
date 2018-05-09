//
//  MenuItem.swift
//  Restaurant
//
//  Created by Michael Hu on 07-05-18.
//  Copyright © 2018 Michael Hu. All rights reserved.
//

import Foundation

// MARK: - Structs

// Struct for menu item
struct MenuItem: Codable {
    var id: Int
    var name: String
    var description: String
    var price: Double
    var category: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case category
        case imageURL = "image_url"
    }
}

struct MenuItems: Codable {
    let items: [MenuItem]
}

