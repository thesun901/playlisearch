import Foundation

extension SpotifyManager {
    func fetchPlaylists(
        query: String,
        completion: @escaping (Result<[Playlist], Error>) -> Void
    ) {
        makeAuthenticatedRequest(
            endpoint: "/v1/search",
            queryParams: [
                "q": query,
                "type": "playlist",
                "limit": "20"
            ]
        ) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase

                    let response = try decoder.decode(SpotifySearchPlaylistsResponse.self, from: data)

                    let playlists = response.playlists.items.compactMap { item -> Playlist? in
                        guard
                            let item = item, // Handle null values in `items`
                            let id = item.id,
                            let name = item.name,
                            let imageUrl = item.images?.first?.url,
                            let tracks = item.tracks?.total
                        else {
                            // Skip invalid playlists
                            return nil
                        }

                        return Playlist(
                            id: id,
                            name: name,
                            description: item.description ?? "",
                            imageUrl: imageUrl,
                            songCount: tracks,
                            tags: [],
                            songs: []
                        )
                    }

                    completion(.success(playlists))
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Failed to fetch playlists: \(error)")
                completion(.failure(error))
            }
        }
    }
}

struct SpotifySearchPlaylistsResponse: Codable {
    let playlists: SpotifyPlaylistContainer
}

struct SpotifyPlaylistContainer: Codable {
    let items: [SpotifyPlaylistItem?] // Make items optional to handle null values
}

struct SpotifyPlaylistItem: Codable {
    let id: String?
    let name: String?
    let images: [SpotifyImage]?
    let description: String?
    let tracks: SpotifyPlaylistTracks?
}

struct SpotifyPlaylistTracks: Codable {
    let total: Int?
}








