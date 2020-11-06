//
//  Station.swift
//  Parsing-JSON-UrlSession
//
//  Created by Tsering Lama on 11/5/20.
//

import Foundation

struct ResultWrapper: Decodable {
    let data: StationsWrapper
}

struct StationsWrapper: Decodable {
    let stations: [Station]
}

struct Station: Decodable, Hashable {
    let stationType: String
    let lat: Double
    let lon: Double
    let capacity: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case stationType = "station_type"
        case name
        case lat
        case lon
        case capacity 
    }
}
