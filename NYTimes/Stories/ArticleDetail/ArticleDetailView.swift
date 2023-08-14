//
//  ArticleDetailView.swift
//  NYTimes
//
//  Created by Asif Bilal on 8/14/23.
//

import SwiftUI

struct ArticleDetailView: View {
    
    let article: Article
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.5)
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 10) {
                    AsyncImage(url: URL(string: article.mediaLargeURL)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                        } else if phase.error != nil {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    Group {
                        Text(article.title)
                            .font(.headline)
                        Text(article.abstract)
                            .font(.body)
                        Text(article.byline)
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.horizontal, 10)
        }
        .navigationTitle(article.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: .init())
    }
}
