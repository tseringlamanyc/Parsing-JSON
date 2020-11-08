//
//  APIClinet .swift
//  Parsing-JSON-UrlSession
//
//  Created by Tsering Lama on 11/5/20.
//

import Foundation
import Combine

enum ApiError: Error {
    case badURL(String)
    case networkError(Error)
    case decodingError(Error)
}

class APIClient {
    
    // fetchData() - does asynchronous network call // returns BEFORE the request is complete
    
    // when dealing with asynchronous call - deal with closure
    // closure (reference) - capture the value of our network call
    
    public func fetchData(completionHandler: @escaping (Result<[Station], ApiError>) -> ()) {
        let endpointURL = "https://gbfs.citibikenyc.com/gbfs/en/station_information.json"
        
        // 1)
        // need URL - to create network request
        guard let url = URL(string: endpointURL) else {
            completionHandler(.failure(.badURL(endpointURL)))
            return
        }
        
        // 2)
        // make , crete GET request (POST, DELETE, PATCH, PUT)
        let request = URLRequest(url: url)
        
        // 3)
        // use URLSession to make the Network Request
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(.networkError(error)))
                return
            }
            
            if let data = data {
                
                // 4)
                // decode json to swift model
                do {
                    let results = try JSONDecoder().decode(ResultWrapper.self, from: data)
                    completionHandler(.success(results.data.stations))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
        dataTask.resume() // suspended state until resumed 
    }
    
    
    // MARK:- Combine
    
    // Combine works with publishers and subscribers
    // Publishers - are values emiited over time
    // Subscribers - receives values and can perform operations on those values (eg map, filter, sort etc..)
    
    func fetchData() throws -> AnyPublisher<[Station], Error> {
        let endpoint = "https://gbfs.citibikenyc.com/gbfs/en/station_information.json"
        guard let url = URL(string: endpoint) else {
            throw ApiError.badURL(endpoint)
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ResultWrapper.self, decoder: JSONDecoder())
            .map { $0.data.stations }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
