import Foundation


extension SpotifyManager {
    func fetchTopTracks(completion: @escaping (Result<[SpotifyTrack], Error>) -> Void) {
        makeAuthenticatedRequest(
            endpoint: "/v1/me/top/tracks",
            queryParams: [
                "time_range" : "short_term",
                "limit" : "5"
                ]
        ) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let response = try decoder.decode(SpotifyTopTracksResponse.self, from: data)
                    completion(.success(response.items))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// Models for Spotify's top tracks response
struct SpotifyTopTracksResponse: Codable {
    let items: [SpotifyTrack]
}

struct SpotifyTrack: Codable {
    let id: String
    let name: String
    let durationMs: Int
    let artists: [SpotifyArtist]
    let album: SpotifyAlbum
}

struct SpotifyArtist: Codable {
    let id: String
    let name: String
}
struct SpotifyAlbum: Codable {
    let images: [SpotifyImage]
}

struct SpotifyImage: Codable {
    let url: String
}
