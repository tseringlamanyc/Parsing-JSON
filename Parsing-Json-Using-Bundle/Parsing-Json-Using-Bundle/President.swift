//
//  President.swift
//  Parsing-Json-Using-Bundle
//
//  Created by Tsering Lama on 11/5/20.
//

import Foundation

struct President: Decodable {
    let number: Int
    let name: String
    let birthYear: Int
    let deathYear: Int
    let tookOffice: String
    let leftOffice: String
    let party: String
    
    private enum CodingKeys: String, CodingKey {
        case number
        case name = "president"
        case birthYear = "birth_year"
        case deathYear = "death_year"
        case tookOffice = "took_office"
        case leftOffice = "left_office"
        case party
    }
}
