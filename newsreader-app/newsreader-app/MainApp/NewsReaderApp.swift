//
//  NewsReaderApp.swift
//

import SwiftUI

@main
struct NewsReaderApp: App {
    @StateObject private var store = NewsReaderStore()
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(store)
        }
    }
}
