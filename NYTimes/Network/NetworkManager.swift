//
//  NetworkManager.swift
//  NYTimes
//
//  Created by Asif Bilal on 8/13/23.
//

import Foundation

class NetworkManager {
    
    typealias RequestCompletion<T> = (T?, Error?) -> Void
    
    enum HTTPMethod: String {
        case get = "GET",
        post = "POST",
        put = "PUT"
    }
    
    func sendRequest<T: Decodable>(endPoint: APIEndpoint, method: HTTPMethod, parameters: [String: Any] = [:], headers: [String: String]? = nil, model: T.Type) async throws -> T {
        
        let url = endPoint.URLString
        
        var request: URLRequest
        
        switch method {
        case .get:
            guard var pathURLComponents = URLComponents(string: url) else { throw ResponseError.invalidURL}
            pathURLComponents.queryItems = parameters.compactMap {
                if let value = $0.value as? String {
                    return URLQueryItem(name: $0.key, value: value)
                }
                return nil
            }
            
            guard let pathURL = pathURLComponents.url else { throw ResponseError.invalidURL}
            request = URLRequest(url: pathURL)
            
        default:
            guard let pathURL = URL(string: url) else { throw ResponseError.invalidURL}
            request = URLRequest(url: pathURL)
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let requestHeaders = headers {
            for (key, value) in requestHeaders {
                request.addValue(key, forHTTPHeaderField: value)
            }
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ResponseError.invalidResponse
        }
        
        let result = try JSONDecoder().decode(T.self, from: data)
        
        return result
    }
}

enum ResponseError: Error {
    case invalidURL
    case invalidResponse
}
