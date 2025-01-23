import Foundation

class HomeViewModel: ObservableObject {
    @Published var username: String = "USERNAME"
    @Published var likedPlaylistsCount: Int = 4
    @Published var categories: [String] = []
    @Published var recommendedPlaylist: Playlist = Playlist(
        id: "UUID()",
        name: "Albert Camus would love this",
        description: "he would love this",
        imageUrl: "https://via.placeholder.com/100",
        songCount: 62,
        tags: ["indie", "rock", "low tempo"],
        songs: [
        ]
    )
    @Published var topSongs: [Song] = []
    
    private let cache = CacheManager<UUID, Playlist>()

    init() {
        fetchTopTracks()
        fetchUsername()
        fetchCategoriesAndRecommendedPlaylist()
    }

    private func fetchCategoriesAndRecommendedPlaylist() {
        SpotifyManager.shared.fetchTopArtists { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let artistIDs):
                    self?.fetchCategoriesFromAPI(artistIDs: artistIDs) { fetchedCategories in
                        self?.categories = fetchedCategories
                        self?.fetchRecommendedPlaylist()
                    }
                case .failure(let error):
                    print("Failed to fetch top artists: \(error)")
                }
            }
        }
    }

    private func fetchCategoriesFromAPI(artistIDs: [String], completion: @escaping ([String]) -> Void) {
        MyAPIManager().fetchTopCategories(artistIDs: artistIDs) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedCategories):
                    print("Fetched categories: \(fetchedCategories)")
                    completion(fetchedCategories)
                case .failure(let error):
                    print("Failed to fetch categories: \(error)")
                    completion([]) // Return an empty array if the fetch fails
                }
            }
        }
    }
    
    func fetchUsername() {
        SpotifyManager.shared.fetchUsername { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let username):
                    self?.username = username
                case .failure(let error):
                    print("Failed to fetch username: \(error)")
                }
            }
        }
    }
    
    func fetchRecommendedPlaylist() {
        guard !categories.isEmpty else {
            print("No categories available to fetch recommended playlists.")
            return
        }

        MyAPIManager().fetchPlaylistsAPI(categories: categories, amount: 1) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    if let firstPlaylist = playlists.first {
                        self?.recommendedPlaylist = Playlist(
                            id: firstPlaylist.id,
                            name: firstPlaylist.name,
                            description: firstPlaylist.description,
                            imageUrl: firstPlaylist.imageURL,
                            songCount: firstPlaylist.songsCount,
                            tags: firstPlaylist.categories,
                            songs: firstPlaylist.songs.map { apiSong in
                                Song(
                                    id: apiSong.id,
                                    title: apiSong.name,
                                    artist: apiSong.artistName,
                                    duration: apiSong.duration,
                                    imageUrl: apiSong.imageURL
                                )
                            }
                        )
                    } else {
                        print("No playlists found for the given categories.")
                    }
                case .failure(let error):
                    print("Failed to fetch recommended playlist: \(error)")
                }
            }
        }
    }


    func fetchTopTracks() {
        SpotifyManager.shared.fetchTopTracks { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let spotifyTracks):
                    self?.topSongs = spotifyTracks.map { track in
                        Song(
                            id: track.id,
                            title: track.name,
                            artist: track.artists.first?.name ?? "Unknown Artist",
                            duration: track.durationMs,
                            imageUrl: track.album.images.first?.url ?? ""
                        )
                    }
                case .failure(let error):
                    print("Failed to load top songs: \(error)")
                }
            }
        }
    }
}
