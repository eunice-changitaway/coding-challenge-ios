//
//  SavedView.swift
//

import SwiftUI

struct SavedView: View {
    @EnvironmentObject var store: NewsReaderStore
    @State private var selectedArticle: NewArticles?

    
    var body: some View {
        NavigationStack {
            Group {
                if store.savedArticles.isEmpty {
                    Text("You haven't saved any articles yet. Please check back later.")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    List(store.savedArticles) { article in
                        Button {
                            selectedArticle = article
                        } label: {
                            ArticleRowView(article: article)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .navigationTitle("Saved")
            .navigationSubtitle("Let's display and use mock data for now")
            .sheet(item: $selectedArticle) { article in
                if let url = URL(string: article.url) {
                    NavigationView {
                        ArticleWebView(url: url)
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button("Done") {
                                        selectedArticle = nil
                                    }
                                }
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button("Delete") {
                                        store.delete(article: article)
                                        selectedArticle = nil
                                    }
                                }
                            }
                    }
                } else {
                    VStack(spacing: 16) {
                        Text("We have detected an article URL error for this article. The article was not received properly. Please come back and try again later.")
                            .font(.headline)
                            .foregroundColor(.red)
                        Button("Close") {
                            selectedArticle = nil
                        }
                    }
                    .padding()
                }
            }

        }
    }
}

