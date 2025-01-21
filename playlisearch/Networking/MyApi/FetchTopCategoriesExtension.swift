import Foundation

extension MyAPIManager {
    func fetchTopCategories(
        artistIDs: [String],
        completion: @escaping (Result<[String], Error>) -> Void
    ) {
        guard !artistIDs.isEmpty else {
            completion(.failure(NSError(domain: "Invalid Input", code: 0, userInfo: [NSLocalizedDescriptionKey: "Artist IDs list is empty."])))
            return
        }
        
        // Build the URL with artist IDs
        var urlComponents = URLComponents(string: "\(baseURL)/top-categories")
        urlComponents?.queryItems = artistIDs.map { URLQueryItem(name: "artist_ids", value: $0) }
        
        guard let url = urlComponents?.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let request = URLRequest(url: url)
        
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
                // Decode the response into the model
                let response = try JSONDecoder().decode(TopCategoriesResponse.self, from: data)
                
                // Extract the category names
                let categories = response.topCategories.map { $0.category }
                
                // Cache the categories
                UserDefaults.standard.set(categories, forKey: "CachedTopCategories")
                
                completion(.success(categories))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }


    func getCachedTopCategories() -> [String] {
        return UserDefaults.standard.stringArray(forKey: "CachedTopCategories") ?? []
    }
}

struct TopCategory: Decodable {
    let category: String
    let count: Int
}

struct TopCategoriesResponse: Decodable {
    let topCategories: [TopCategory]
    
    enum CodingKeys: String, CodingKey {
        case topCategories = "top_categories"
    }
}
