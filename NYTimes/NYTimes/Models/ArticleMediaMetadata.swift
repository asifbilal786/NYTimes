//
//  ArticleMediaMetadata.swift
//  NYTimes
//
//  Created by Asif Bilal on 8/13/23.
//

import Foundation

struct ArticleMediaMetadata: Decodable {
    
    enum MediaFormatType: String {
        case thumbnail = "Standard Thumbnail"
        case mediumThreeByTwo210
        case mediumThreeByTwo440
    }
    
    
    let url: String
    let formatType: MediaFormatType
    
    enum CodingKeys: CodingKey {
        case url
        case format
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.url = try container.decode(String.self, forKey: .url)
        let format = try container.decode(String.self, forKey: .format)
        self.formatType = MediaFormatType(rawValue: format) ?? .thumbnail
    }
}
