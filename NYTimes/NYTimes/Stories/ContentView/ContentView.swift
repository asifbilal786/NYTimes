//
//  ContentView.swift
//  NYTimes
//
//  Created by Asif Bilal on 8/13/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var contentVM = ContentViewModel(manager: ContentViewAPIManager())
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.5)
                    .ignoresSafeArea()
                if contentVM.isLoadingArticles && contentVM.articles.isEmpty {
                    ProgressView {
                        Text("loading articles")
                            .foregroundColor(.gray)
                    }
                    .tint(.gray)
                } else {
                    List(contentVM.articles) { article in
                        NavigationLink {
                            ArticleDetailView(article: article)
                        } label: {
                            ArticleRow(article: article)
                        }
                        .buttonStyle(.plain)

                    }
                    .refreshable {
                        fetchMostViewedArtices()
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .navigationTitle("NY Times Most Popular")
            .onAppear {
                if contentVM.articles.isEmpty {
                    contentVM.fetchMostViewedArtices()
                }
            }
        }
    }
    
    private func fetchMostViewedArtices() {
        contentVM.fetchMostViewedArtices()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
