//
//  ArticleMedia.swift
//  NYTimes
//
//  Created by Asif Bilal on 8/13/23.
//

import Foundation

struct ArticleMedia: Decodable {
    let type: String
    let subtype: String
    let metadata : [ArticleMediaMetadata]
    
    enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case metadatta = "media-metadata"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(String.self, forKey: .type)
        self.subtype = try container.decode(String.self, forKey: .subtype)
        self.metadata = try container.decode([ArticleMediaMetadata].self, forKey: .metadatta)
    }
}
