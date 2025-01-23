//
//  SearchViewModel.swift
//  playlisearch
//
//  Created by Oliwier Dygdałowicz on 22/01/2025.
//


import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var searchResults: [Playlist] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    func searchPlaylists() {
        guard !searchQuery.isEmpty else {
            searchResults = [] // Clear results if query is empty
            return
        }

        isLoading = true
        SpotifyManager.shared.fetchPlaylists(query: searchQuery) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let playlists):
                    self?.searchResults = playlists
                case .failure(let error):
                    self?.errorMessage = "Failed to fetch playlists: \(error.localizedDescription)"
                }
            }
        }
    }
}
