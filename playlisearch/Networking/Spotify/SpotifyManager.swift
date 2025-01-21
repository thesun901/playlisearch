import Foundation



enum SpotifyError: Error {
    case unauthorized
    case invalidEndpoint
    case invalidResponse
    case noData
    case missingAccessToken
}



class SpotifyManager {
    static let shared = SpotifyManager()
    
    var accessToken: String? {
        didSet {
            if let token = accessToken {
                UserDefaults.standard.set(token, forKey: "SpotifyAccessToken")
            }
        }
    }
    
    init() {
        accessToken = UserDefaults.standard.string(forKey: "SpotifyAccessToken")
    }
    
    // Public method to update the access token
    func updateAccessToken(_ token: String) {
        self.accessToken = token
    }
    
    func getAccessTokenRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = SpotifyConstants.authHost
        components.path = "/authorize"
        components.queryItems = SpotifyConstants.authParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
    
    func handleRedirectURL(_ url: URL) -> Bool {
        guard let fragment = url.fragment else { return false }
        
        let params = fragment
            .split(separator: "&")
            .reduce(into: [String: String]()) { dict, param in
                let parts = param.split(separator: "=", maxSplits: 1)
                if let key = parts.first, let value = parts.last {
                    dict[String(key)] = String(value)
                }
            }
        
        if let token = params["access_token"] {
            updateAccessToken(token) // Use the new public method
            return true
        }
        return false
    }
    
    
    
    func makeAuthenticatedRequest(
        endpoint: String,
        method: String = "GET",
        queryParams: [String: String]? = nil,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let token = accessToken else {
            completion(.failure(SpotifyError.unauthorized))
            return
        }
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = SpotifyConstants.spotifyHost
        components.path = endpoint
        if let queryParams = queryParams {
            components.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else {
            completion(.failure(SpotifyError.invalidEndpoint))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                completion(.failure(SpotifyError.invalidResponse))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
