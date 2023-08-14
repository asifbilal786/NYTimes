//
//  MostPopularArticlesResponse.swift
//  NYTimes
//
//  Created by Asif Bilal on 8/13/23.
//

import Foundation

struct MostPopularArticlesResponse: Decodable {
    let status: String
    let numberOfResults: Int
    let articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status
        case numberOfResults = "num_results"
        case articles = "results"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.status = try container.decode(String.self, forKey: .status)
        self.numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        self.articles = try container.decode([Article].self, forKey: .articles)
    }
}
