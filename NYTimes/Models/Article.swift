//
//  Article.swift
//  NYTimes
//
//  Created by Asif Bilal on 8/13/23.
//

import Foundation

struct Article: Identifiable, Decodable {
    let id: Int
    let title: String
    let byline: String
    let abstract: String
    let publishedAt: String
    let media: [ArticleMedia]
    
    var mediaThumbnailURL: String {
        media.first?.metadata.first(where: { $0.formatType == .thumbnail})?.url ?? ""
    }
    
    var mediaLargeURL: String {
        media.first?.metadata.first(where: { $0.formatType == .mediumThreeByTwo440})?.url ?? ""
    }

    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case byline
        case abstract
        case publishedAt = "published_date"
        case media
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.byline = try container.decode(String.self, forKey: .byline)
        self.abstract = try container.decode(String.self, forKey: .abstract)
        self.publishedAt = try container.decode(String.self, forKey: .publishedAt)
        self.media = try container.decode([ArticleMedia].self, forKey: .media)
    }
}
