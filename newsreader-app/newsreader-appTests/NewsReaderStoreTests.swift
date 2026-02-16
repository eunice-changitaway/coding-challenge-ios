//
//  NewsReaderStoreTests.swift
//

import XCTest
@testable import newsreader_app

final class NewsReaderStoreTests: XCTestCase {
    
    private var store: NewsReaderStore!
    private var testDefaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        
        testDefaults = UserDefaults(suiteName: "NewsReaderStoreTests")
        testDefaults.removePersistentDomain(forName: "NewsReaderStoreTests")
        
        store = NewsReaderStore(userDefaults: testDefaults)
    }
    
    override func tearDown() {
        testDefaults.removePersistentDomain(forName: "NewsReaderStoreTests")
        store = nil
        testDefaults = nil
        super.tearDown()
    }
    
    // MARK: - Save Tests
    
    func testSaveArticleAddsArticle() {
        let article = makeMockArticle()
        
        store.save(article: article)
        
        XCTAssertEqual(store.savedArticles.count, 1)
        XCTAssertEqual(store.savedArticles.first?.url, article.url)
    }
    
    func testSaveArticleDoesNotDuplicate() {
        let article = makeMockArticle()
        
        store.save(article: article)
        store.save(article: article)
        
        XCTAssertEqual(store.savedArticles.count, 1)
    }
    
    // MARK: - Delete Tests
    func testDeleteRemovesArticle() {
        let article = makeMockArticle()
        
        store.save(article: article)
        store.delete(article: article)
        
        XCTAssertTrue(store.savedArticles.isEmpty)
    }
        
    // MARK: - Helpers
    private func makeMockArticle() -> NewArticles {
        return NewArticles(
            source: .init(id: "123", name: "123"),
            title: "Test Title",
            description: "Test Description",
            author: "Test Author",
            url: "https://example.com",
            urlToImage: nil,
            publishedAt: nil,
            content: nil
        )
    }
}


