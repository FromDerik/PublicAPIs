//
//  DataManager.swift
//  PublicAPIs
//
//  Created by Derik Malcolm on 10/21/18.
//  Copyright © 2018 Derik Malcolm. All rights reserved.
//

import Foundation

class DataManager {
    
    static let baseURL = "https://api.publicapis.org/"
    
    static func fetchCategories(completionHandler: @escaping ([String]) -> Void) {
        guard let url = URL(string: baseURL + "/categories") else { return }
        
        let session = URLSession.shared.dataTask(with: url) { (data, res, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                var categories = try JSONDecoder().decode([String].self, from: data)
                categories.insert("All", at: 0)
                
                completionHandler(categories)
            } catch let error {
                print(error)
            }
            
        }
        
        session.resume()
    }
    
    static func fetchEntries(title: String? = nil, description: String? = nil, category: String? = nil, authType: String? = nil, https: Bool? = nil, cors: String? = nil, completionHandler: @escaping ([Entry]) -> Void) {
        
        guard let url = URL(string: baseURL + "/entries") else { return }
        var request = URLRequest(url: url)
        
        if let title = title { request.addValue(title, forHTTPHeaderField: "title") }
        if let category = category { request.addValue(category, forHTTPHeaderField: "category") }
        if let auth = authType { request.addValue(auth, forHTTPHeaderField: "auth") }
        if let https = https { request.addValue(https.description, forHTTPHeaderField: "https") }
        if let cors = cors { request.addValue(cors, forHTTPHeaderField: "cors") }
        
        if let description = description {
            if description != "All" {
                request.addValue(description, forHTTPHeaderField: "description")
            }
        }
        
        let session = URLSession.shared.dataTask(with: request) { (data, res, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let res = try JSONDecoder().decode(APIResponse.self, from: data)
                let entries = res.entries
                
                completionHandler(entries)
            } catch let error {
                print(error)
            }
            
        }
        
        session.resume()
    }
}
