//
//  NewsReaderStore.swift
//

import Foundation
import Combine
import SwiftUI

final class NewsReaderStore: ObservableObject {
    @Published var savedArticles: [NewArticles] = []
    
    private let userDefaults: UserDefaults
    private let key = "savedArticles"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        loadSavedArticles()
    }
    
    func save(article: NewArticles) {
        if !savedArticles.contains(where: { $0.url == article.url }) {
            savedArticles.append(article)
            persist()
        }
    }
    
    func delete(article: NewArticles) {
        savedArticles.removeAll { $0.id == article.id }
        persist()
    }
    
    private func persist() {
        if let encoded = try? JSONEncoder().encode(savedArticles) {
            userDefaults.set(encoded, forKey: key)
        }
    }
    
    private func loadSavedArticles() {
        if let data = userDefaults.data(forKey: key),
           let decoded = try? JSONDecoder().decode([NewArticles].self, from: data) {
            self.savedArticles = decoded
        }
    }
}




