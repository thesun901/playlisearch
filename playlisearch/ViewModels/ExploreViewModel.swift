import Foundation

class ExploreViewModel: ObservableObject {
    @Published var playlists: [Playlist] = []
    @Published var isLoading = false
    private var categories: [String] = []
    private let limit = 15

    func initializeExploreView() {
        SpotifyManager.shared.fetchTopArtists { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let artistIDs):
                    self?.fetchCategoriesFromAPI(artistIDs: artistIDs)
                case .failure(let error):
                    print("Failed to fetch top artists: \(error)")
                }
            }
        }
    }

    private func fetchCategoriesFromAPI(artistIDs: [String]) {
        MyAPIManager().fetchTopCategories(artistIDs: artistIDs) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedCategories):
                    self?.categories = fetchedCategories
                    self?.fetchMorePlaylists()
                case .failure(let error):
                    print("Failed to fetch categories: \(error)")
                }
            }
        }
    }

    func fetchMorePlaylists() {
        guard !isLoading, !categories.isEmpty else { return }
        isLoading = true

        MyAPIManager().fetchPlaylistsAPI(categories: categories, amount: limit) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlistsAPI):
                    let playlists = playlistsAPI.map { apiPlaylist in
                        Playlist(
                            id: apiPlaylist.id,
                            name: apiPlaylist.name,
                            description: apiPlaylist.description,
                            imageUrl: apiPlaylist.imageURL,
                            songCount: apiPlaylist.songsCount,
                            tags: apiPlaylist.categories,
                            songs: apiPlaylist.songs.map { apiSong in
                                Song(
                                    id: apiSong.id,
                                    title: apiSong.name,
                                    artist: apiSong.artistName,
                                    duration: apiSong.duration,
                                    imageUrl: apiSong.imageURL
                                )
                            }
                        )
                    }
                    self?.playlists.append(contentsOf: playlists)
                case .failure(let error):
                    print("Failed to fetch playlists: \(error)")
                }
                self?.isLoading = false
            }
        }
    }
}
