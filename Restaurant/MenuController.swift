//
//  MenuController.swift
//  Restaurant
//
//  Created by Michael Hu on 07-05-18.
//  Copyright © 2018 Michael Hu. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Classes

// MenuController class definition and URL link
class MenuController {
    
    static let shared = MenuController()
    let baseURL = URL(string: "https://resto.mprog.nl/")!

    // MARK: - Functions
    
    // Function to feth categories from API
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        
        // Get 3 possible responses from API
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            
            // Decode data with JSONDecoder into categories object
            let jsonDecoder = JSONDecoder()
            if let data = data, let categories = try? jsonDecoder.decode(Categories.self, from: data) {
                completion(categories.categories)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    // Function to fetch all the menu items
    func fetchMenuItems(categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) { completion(menuItems.items)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    // Function to respond to API
    func submitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
     
        // Store list of menu Id's in JSON
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        
        // Store data in body of request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    // Function to fetch images
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) { completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
