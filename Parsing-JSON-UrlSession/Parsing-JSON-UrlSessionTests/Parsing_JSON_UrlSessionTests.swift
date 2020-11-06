//
//  Parsing_JSON_UrlSessionTests.swift
//  Parsing-JSON-UrlSessionTests
//
//  Created by Tsering Lama on 11/5/20.
//

import XCTest
@testable import Parsing_JSON_UrlSession

class Parsing_JSON_UrlSessionTests: XCTestCase {

    func testModel() {
        // arrange
        let jsonData = """
          {
              "data": {
                  "stations": [{
                          "short_name": "6926.01",
                          "legacy_id": "72",
                          "rental_methods": [
                              "KEY",
                              "CREDITCARD"
                          ],
                          "station_id": "72",
                          "eightd_station_services": [],
                          "external_id": "66db237e-0aca-11e7-82f6-3863bb44ef7c",
                          "lat": 40.76727216,
                          "lon": -73.99392888,
                          "rental_url": "http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=72",
                          "region_id": "71",
                          "capacity": 55,
                          "station_type": "classic",
                          "eightd_has_key_dispenser": false,
                          "name": "W 52 St & 11 Ave",
                          "electric_bike_surcharge_waiver": false,
                          "has_kiosk": true
                      },
                      {
                          "short_name": "5430.08",
                          "legacy_id": "79",
                          "rental_methods": [
                              "KEY",
                              "CREDITCARD"
                          ],
                          "station_id": "79",
                          "eightd_station_services": [],
                          "external_id": "66db269c-0aca-11e7-82f6-3863bb44ef7c",
                          "lat": 40.71911552,
                          "lon": -74.00666661,
                          "rental_url": "http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=79",
                          "region_id": "71",
                          "capacity": 33,
                          "station_type": "classic",
                          "eightd_has_key_dispenser": false,
                          "name": "Franklin St & W Broadway",
                          "electric_bike_surcharge_waiver": false,
                          "has_kiosk": true
                      }
                  ]
              }
          }
        """.data(using: .utf8)!
        
        let expectedCapacity = 55
        
        do {
            let results = try JSONDecoder().decode(ResultWrapper.self, from: jsonData)
            let stations = results.data.stations // [Station]
            let firstStation = stations[0]
            
            // assert
            XCTAssertEqual(expectedCapacity, firstStation.capacity)
        } catch {
            XCTFail("decoding error: \(error)")
        }
    }
    
}
