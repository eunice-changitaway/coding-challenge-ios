//
//  SourcesViewModel.swift
//

import Foundation
import Combine

@MainActor
final class SourcesViewModel: ObservableObject {
    @Published var sources: [NewsSource] = []
    @Published var selectedSourceIDs: Set<String> = []
    
    private let apiKey = "6328308dbece476db477f50b97c7765f"
    
    init() {
        loadSelectedSources()
        Task { await fetchSources() }
    }
    
    func fetchSources() async {
        guard let url = URL(string: "https://newsapi.org/v2/sources?language=en&apiKey=\(apiKey)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(NewsSourcesResponse.self, from: data)
            DispatchQueue.main.async {
                self.sources = response.sources
            }
        } catch {
            print("Failed to fetch sources:", error)
        }
    }

    func toggleSelection(for source: NewsSource) {
        if selectedSourceIDs.contains(source.id) {
            selectedSourceIDs.remove(source.id)
        } else {
            selectedSourceIDs.insert(source.id)
        }
        saveSelectedSources()
    }
    
    private func loadSelectedSources() {
        if let saved = UserDefaults.standard.array(forKey: "SelectedSources") as? [String] {
            selectedSourceIDs = Set(saved)
        }
    }
    
    private func saveSelectedSources() {
        UserDefaults.standard.set(Array(selectedSourceIDs), forKey: "SelectedSources")
    }
}
