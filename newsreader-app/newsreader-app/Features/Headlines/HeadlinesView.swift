//
//  HeadlinesView.swift
//

import SwiftUI

struct HeadlinesView: View {
    @StateObject private var viewModel = HeadlinesViewModel()
    @EnvironmentObject var store: NewsReaderStore
    @State private var selectedArticle: NewArticles?
    
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading your articles…")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if viewModel.articles.isEmpty {
                    Text("No articles available at the moment from our online sources. Please try again and come back later.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    List(viewModel.articles) { article in
                        Button {
                            selectedArticle = article
                        } label: {
                            ArticleRowView(article: article)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .navigationTitle("Headlines")
            .navigationSubtitle("Let's display and use mock data for now")
            .onAppear {
                Task {
                    await viewModel.fetchArticlesUsingMock()
                }
            }
            .sheet(item: $selectedArticle) { article in
                if let url = URL(string: article.url) {
                    NavigationView {
                        ArticleWebView(url: url) {
                            store.save(article: article)
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Save") {
                                    store.save(article: article)
                                    selectedArticle = nil
                                }
                            }
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Done") {
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


