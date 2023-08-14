//
//  APIEndpoint.swift
//  NYTimes
//
//  Created by Asif Bilal on 8/13/23.
//

import Foundation

enum APIEndpoint {
    
    case fetchMostPopularArticles(period: Int)
    
    
    var URLString: String {
        
        let endpoint: String
        
        switch self {
        case .fetchMostPopularArticles(let period):
            endpoint = "mostpopular/v2/mostviewed/all-sections/\(period).json"
        }
        
        return baseURL + "/svc/" + endpoint
    }
}
