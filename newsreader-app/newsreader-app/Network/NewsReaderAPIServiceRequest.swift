//
//  NewsReaderAPIServiceRequest.swift
//

import Foundation

enum NewsAPIError: Error {
    case invalidURL
    case requestFailed(statusCode: Int)
}

final class NewsReaderAPIServiceRequest {
    private let apiKey = "6328308dbece476db477f50b97c7765f"
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    
    // MARK: Fetch news from API - currently isn't working for Headlines tab
    func fetchNews(forSources sourceIDs: [String]) async throws -> [NewArticles] {
        guard !sourceIDs.isEmpty else { return [] } // Nothing selected

        let sourcesQuery = sourceIDs.joined(separator: ",")
        let urlString = "\(baseURL)?sources=\(sourcesQuery)&apiKey=\(apiKey)"

        guard let url = URL(string: urlString) else { throw NewsAPIError.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NewsAPIError.requestFailed(statusCode: httpResponse.statusCode)
        }

        let decoded = try JSONDecoder().decode(NewsResponse.self, from: data)
        return decoded.articles
    }
}


