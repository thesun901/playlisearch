import Foundation

struct SongAPI: Codable {
    let id: String
    let name: String
    let imageURL: String
    let artistName: String
    let artistID: String
    let duration: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
        case artistName = "artist_name"
        case artistID = "artist_id"
        case duration
    }
}

struct PlaylistAPI: Codable {
    let id: String
    let name: String
    let imageURL: String
    let description: String
    let songsCount: Int
    let followersCount: Int
    let categories: [String]
    let songs: [SongAPI]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
        case description
        case songsCount = "songs_count"
        case followersCount = "followers_count"
        case categories
        case songs
    }
}

struct PlaylistsAPIResponse: Codable {
    let playlists: [PlaylistAPI]
}

class MyAPIManager {
    let baseURL = "http://127.0.0.1:8000"
    
    func fetchPlaylistsAPI(categories: [String], amount: Int, completion: @escaping (Result<[PlaylistAPI], Error>) -> Void) {
        // Build the URL with multiple `categories` query parameters
        var urlComponents = URLComponents(string: "\(baseURL)/playlists")
        var queryItems = categories.map { URLQueryItem(name: "categories", value: $0) }
        queryItems.append(URLQueryItem(name: "amount", value: String(amount)))
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let playlistsResponse = try JSONDecoder().decode(PlaylistsAPIResponse.self, from: data)
                completion(.success(playlistsResponse.playlists))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
