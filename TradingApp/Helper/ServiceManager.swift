//
//  ServiceManager.swift
//  TradingApp
//
//  Created by Vinod Gupta on 23/05/24.
//

import Foundation

enum EndPoints: String {
    case holdings = "/"
}

enum APIError: String, Error {
    case noInternet = "No Internet"
    case unknownError = "Something went wrong."
}

class ServiceManager {
    
    static let shared = ServiceManager()
    
    private init() { }
    
    let baseUrl = "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io"
    
    func getRequest<T: Codable>(endpoint: EndPoints, responseModel: T.Type, completion: ((Swift.Result<T, APIError>) -> Void)?) {
        
        if let url = URL(string: baseUrl + endpoint.rawValue) {
            let urlRequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if error == nil, let data {
                    do {
                        let response = try JSONDecoder().decode(T.self, from: data)
                        completion?(.success(response))
                    } catch let error {
                        print(error.localizedDescription)
                        completion?(.failure(APIError.unknownError))
                    }
                } else {
                    completion?(.failure(APIError.noInternet))
                }
            }.resume()
        }
    }
}
