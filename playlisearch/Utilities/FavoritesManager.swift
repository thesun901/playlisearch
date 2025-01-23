import Foundation

class FavoritesManager: ObservableObject {
    @Published var favorites: [Playlist] = [] {
        didSet {
            saveFavorites()
        }
    }

    private let favoritesKey = "favorites"

    init() {
        loadFavorites()
    }

    func addToFavorites(_ playlist: Playlist) {
        if !favorites.contains(where: { $0.id == playlist.id }) {
            favorites.append(playlist)
        }
    }

    func removeFromFavorites(_ playlist: Playlist) {
        favorites.removeAll { $0.id == playlist.id }
    }

    func isFavorite(_ playlist: Playlist) -> Bool {
        favorites.contains(where: { $0.id == playlist.id })
    }

    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }

    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey) {
            do {
                let decoded = try JSONDecoder().decode([Playlist].self, from: data)
                favorites = decoded
            } catch {
                print("Failed to decode favorites, clearing old data: \(error)")
                UserDefaults.standard.removeObject(forKey: favoritesKey)
                favorites = []
            }
        }
    }
}
