import Foundation

class HomeViewModel: ObservableObject {
    @Published var username: String = "USERNAME"
    @Published var likedPlaylistsCount: Int = 4
    @Published var recommendedPlaylist: Playlist = Playlist(
        id: UUID(),
        name: "Albert Camus would love this",
        description: "he would love this",
        imageUrl: "https://via.placeholder.com/100", // Replace with actual image URL
        songCount: 62,
        tags: ["indie", "rock", "low tempo"],
        songs: [
            Song(id: UUID(), title: "Little Big Boy", artist: "Madds Buckley", duration: 210, imageUrl: "https://via.placeholder.com/100"),
            Song(id: UUID(), title: "Little Dark Age", artist: "MGMT", duration: 210, imageUrl: "https://via.placeholder.com/100"),
            Song(id: UUID(), title: "Little Talks", artist: "Of Monsters and Men", duration: 210, imageUrl: "https://via.placeholder.com/100"),
            Song(id: UUID(), title: "Little Lies", artist: "Fleetwood Mac", duration: 210, imageUrl: "https://via.placeholder.com/100"),
            Song(id: UUID(), title: "Little League", artist: "Conan Gray", duration: 210, imageUrl: "https://via.placeholder.com/100")
        ]
    )
    @Published var topSongs: [Song] = []

    init() {
        topSongs = [
            Song(id: UUID(), title: "Test Song 1", artist: "Test Artist", duration: 200000, imageUrl: ""),
            Song(id: UUID(), title: "Test Song 2", artist: "Test Artist", duration: 250000, imageUrl: "")
        ]
        fetchTopTracks()
        fetchUsername()
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

    func fetchTopTracks() {
        SpotifyManager.shared.fetchTopTracks { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let spotifyTracks):
                        self?.topSongs = spotifyTracks.map { track in
                            Song(
                                id: UUID(),
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
