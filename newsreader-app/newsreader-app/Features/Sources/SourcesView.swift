//
//  SourcesView.swift
//

import SwiftUI

struct SourcesView: View {
    @StateObject private var viewModel = SourcesViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.sources) { source in
                Button(action: {
                    viewModel.toggleSelection(for: source)
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(source.name)
                                .font(.headline)
                            if let desc = source.description {
                                Text(desc)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                        if viewModel.selectedSourceIDs.contains(source.id) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Sources")
            .listStyle(.insetGrouped)
        }
    }
}

