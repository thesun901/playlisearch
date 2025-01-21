import Foundation


extension SpotifyManager {
    func fetchUsername(completion: @escaping (Result<String, Error>) -> Void) {
        guard let token = accessToken else {
            completion(.failure(SpotifyError.missingAccessToken))
            return
        }
        
        var request = URLRequest(url: URL(string: "https://api.spotify.com/v1/me")!)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(SpotifyError.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(SpotifyUserProfile.self, from: data)
                completion(.success(response.displayName ?? "Unknown User"))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


struct SpotifyUserProfile: Codable {
    let displayName: String?
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
    }
}
