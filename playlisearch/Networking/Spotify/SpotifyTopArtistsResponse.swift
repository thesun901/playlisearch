//
//  SpotifyTopArtistsResponse.swift
//  playlisearch
//
//  Created by Oliwier Dygdałowicz on 20/01/2025.
//


import Foundation

extension SpotifyManager {
    func fetchTopArtists(completion: @escaping (Result<[String], Error>) -> Void) {
        makeAuthenticatedRequest(
            endpoint: "/v1/me/top/artists",
            queryParams: [
                "time_range": "short_term",
                "limit": "20"
            ]
        ) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let response = try decoder.decode(SpotifyTopArtistsResponse.self, from: data)
                    let artistIDs = response.items.map { $0.id }
                    
                    // Cache the artist IDs
                    UserDefaults.standard.set(artistIDs, forKey: "CachedArtistIDs")
                    
                    completion(.success(artistIDs))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCachedArtistIDs() -> [String] {
        return UserDefaults.standard.stringArray(forKey: "CachedArtistIDs") ?? []
    }
}

// Models for Spotify's top artists response
struct SpotifyTopArtistsResponse: Codable {
    let items: [SpotifyArtist]
}


