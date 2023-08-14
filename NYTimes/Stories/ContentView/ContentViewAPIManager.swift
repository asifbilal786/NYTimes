//
//  ContentViewAPIManager.swift
//  NYTimes
//
//  Created by Asif Bilal on 8/13/23.
//

import Foundation

protocol ContentViewAPIManagerProtocol {
    func fetchMostPopularArticles() async throws -> [Article]
}

class ContentViewAPIManager: ContentViewAPIManagerProtocol {
    
    private let manager = NetworkManager()
    
    func fetchMostPopularArticles() async throws -> [Article] {
        let response = try await manager.sendRequest(endPoint: .fetchMostPopularArticles(period: 7), method: .get, parameters: ["api-key": apiKey], model: MostPopularArticlesResponse.self)
        return response.articles
    }
}
