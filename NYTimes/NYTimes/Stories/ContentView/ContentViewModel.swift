//
//  ContentViewModel.swift
//  NYTimes
//
//  Created by Asif Bilal on 8/13/23.
//

import Foundation

@MainActor class ContentViewModel: ObservableObject {
    
    @Published var articles = [Article]()
    @Published var isLoadingArticles: Bool = false
    
    let manager: ContentViewAPIManagerProtocol
    
    init(manager: ContentViewAPIManagerProtocol) {
        self.manager = manager
    }
    
    // MARK: - Public Functions
    
    func fetchMostViewedArtices() {
        Task {
            do {
                self.isLoadingArticles = true
                self.articles = try await manager.fetchMostPopularArticles()
                self.isLoadingArticles = false
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
