//
//  HeadlinesViewModel.swift
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class HeadlinesViewModel: ObservableObject {
    @Published var articles: [NewArticles] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiService = NewsReaderAPIServiceRequest()
    
    func fetchArticlesUsingMock() async {
        isLoading = true
        defer { isLoading = false }
        
        // MARK: Assign view with mock data
        articles = HeadlinesViewModel.mockData
    }
}

extension HeadlinesViewModel {
    
    static let mockData: [NewArticles] = [
        NewArticles(source: .init(id: "123", name: "123"), title: "News article title 01", description: "subtitle news 1", author: "James Bond", url: "https://www.winknews.com/news/collier/57-cases-of-measles-confirmed-at-ave-maria-university-7-currently-contagious/article_298f2922-a5b2-4b67-a0cd-24009dc56801.html", urlToImage: "https://bloximages.chicago2.vip.townnews.com/winknews.com/content/tncms/assets/v3/editorial/4/da/4da9fdb9-f204-5ff4-b472-556f52d6a016/67f66bdfe1fd0.image.png?crop=1920%2C1008%2C0%2C35&resize=1200%2C630&order=crop%2Cresize", publishedAt: nil, content: nil ),
        NewArticles(source: .init(id: "456", name: "456"), title: "News article title 02", description: "subtitle news 2", author: "Benjamin Franklin", url: "https://www.wsj.com/politics/national-security/pentagon-prepares-second-aircraft-carrier-to-deploy-to-the-middle-east-e7140a64", urlToImage: "https://images.wsj.net/im-10580856/social", publishedAt: nil, content: nil ),
        NewArticles(source: .init(id: "786", name: "786"), title: "News article title 03", description: "subtitle news 3", author: "Theodore Roosevelt", url: "https://www.bloomberg.com/news/articles/2026-02-11/apple-s-ios-26-4-siri-update-runs-into-snags-in-internal-testing-ios-26-5-27", urlToImage: "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iin.P72WhU78/v0/1200x800.jpg", publishedAt: nil, content: nil ),
        NewArticles(source: .init(id: "455", name: "455"), title: "News article title 04", description: "subtitle news 4", author: "Michael Lim", url: "https://www.yahoo.com/news/articles/south-carolina-sees-dip-daily-182615103.html", urlToImage: "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iin.P72WhU78/v0/1200x800.jpg", publishedAt: nil, content: nil ),
        NewArticles(source: .init(id: "222", name: "222"), title: "News article title 05", description: "subtitle news 5", author: "James Bond", url: "https://www.washingtonpost.com/business/2026/02/11/immigrants-irs-dhs-tax-data/", urlToImage: "https://s.yimg.com/os/en/reuters.com/67957e9e6cc9ba7a5afe516c2489c656", publishedAt: nil, content: nil ),
        NewArticles(source: .init(id: "457", name: "457"), title: "News article title 06", description: "subtitle news 6", author: "Grace Amberosia", url:  "https://www.cnbc.com/2026/02/11/mcdonalds-mcd-q4-2025-earnings.html", urlToImage:  "https://gizmodo.com/app/uploads/2026/02/Starliner--1200x675.jpg", publishedAt: nil, content: nil ),
        NewArticles(source: .init(id: "775", name: "775"), title: "News article title 07", description: "subtitle news 7", author: "Joseph Loo", url:  "https://www.cnbc.com/2026/02/11/mcdonalds-mcd-q4-2025-earnings.html", urlToImage:  "https://gizmodo.com/app/uploads/2026/02/Starliner--1200x675.jpg", publishedAt: nil, content: nil )
    ]
}







