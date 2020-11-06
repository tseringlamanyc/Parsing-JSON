//
//  Bundle+Parsing JSON.swift
//  Parsing-Json-Using-Bundle
//
//  Created by Tsering Lama on 11/5/20.
//

import Foundation

enum BundleError: Error {
    case invalidResource(String)
    case noContent(String)
    case decodingError(Error)
}

extension Bundle {
    
    // 1) Get path of the file to be read using the Bundle class -> String?
    // 2) Using the path read its data contents -> Data?
    
    // 3) Bundle.main is a singleton
    
    // this will be a throwing function - use try? or do catch or try!
    func parseJSON(name: String) throws -> [President] {
        
        guard let path = Bundle.main.path(forResource: name, ofType: ".json") else {
            throw BundleError.invalidResource(name)
        }
        
        // singleton
        guard let data = FileManager.default.contents(atPath: path) else {
            throw BundleError.noContent(path)
        }
        
        var presidents: [President]
        
        do {
            presidents = try JSONDecoder().decode([President].self, from: data)
        } catch {
            throw BundleError.decodingError(error)
        }
        
        return presidents
        
    }
}
