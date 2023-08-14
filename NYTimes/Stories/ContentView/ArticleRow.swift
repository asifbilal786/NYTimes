//
//  ArticleRow.swift
//  NYTimes
//
//  Created by Asif Bilal on 8/13/23.
//

import SwiftUI

struct ArticleRow: View {
    let article: Article
    
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: article.mediaThumbnailURL), content: { image in
                image
                    .resizable()
                    .scaledToFill()
            }, placeholder: {
                Image(systemName: "photo.circle")
                    .resizable()
            })
            .frame(width: 30, height: 30)
            .clipShape(Circle())
            VStack(spacing: 0) {
                Group {
                    Text(article.title)
                        .lineLimit(2)
                        .font(.headline)
                        .frame(height: 50)
                    Spacer()
                        .frame(width: 10)
                    Text(article.byline)
                        .lineLimit(1)
                        .font(.body)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                    .frame(width: 5)
                Group {
                    Text(Image(systemName: "calendar"))
                    + Text(" \(article.publishedAt)")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.vertical, 20)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .padding(.horizontal, 20)
        .frame(height: 120)
    }
}

struct ArticleRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRow(article: .init())
            .previewLayout(.sizeThatFits)
    }
}

extension Article {
    init() {
        self.id = 0
        self.title = "Good news about world and it's related things"
        self.byline = "By Thompson"
        self.abstract = "As the chief songwriter and guitarist for the Band, he offered a rustic vision of his adopted country that helped inspire the genre that came to be known as Americana"
        self.publishedAt = "2023-08-07"
        self.media = []
    }
}
