import Foundation

extension SpotifyManager {
    func fetchPlaylistTracks(
        playlistID: String,
        completion: @escaping (Result<[Song], Error>) -> Void
    ) {
        makeAuthenticatedRequest(
            endpoint: "/v1/playlists/\(playlistID)/tracks",
            queryParams: ["limit": "50"]
        ) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase

                    let response = try decoder.decode(SpotifyPlaylistTracksResponse.self, from: data)

                    let songs = response.items.compactMap { item -> Song? in
                        guard
                            let track = item.track,
                            let id = track.id,
                            let name = track.name,
                            let artist = track.artists.first?.name,
                            let duration = track.durationMs,
                            let imageUrl = track.album.images.first?.url
                        else {
                            return nil
                        }

                        return Song(
                            id: id, // Use the track's Spotify ID
                            title: name,
                            artist: artist,
                            duration: duration,
                            imageUrl: imageUrl
                        )
                    }

                    completion(.success(songs))
                } catch {
                    // Print the raw response in case of an error
                    if let rawResponse = String(data: data, encoding: .utf8) {
                        print("Raw Spotify API Response (Error Context): \(rawResponse)")
                    } else {
                        print("Failed to convert response data to string.")
                    }
                    print("Decoding error: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Failed to fetch playlist tracks: \(error)")
                completion(.failure(error))
            }
        }
    }
}


struct SpotifyPlaylistTracksResponse: Codable {
    let href: String
    let items: [SpotifyPlaylistTrackItem]
}

struct SpotifyPlaylistTrackItem: Codable {
    let track: SpotifyPlaylistTrack?
}

struct SpotifyPlaylistTrack: Codable {
    let id: String?
    let name: String?
    let artists: [SpotifyArtist]
    let album: SpotifyAlbum
    let durationMs: Int?
}
