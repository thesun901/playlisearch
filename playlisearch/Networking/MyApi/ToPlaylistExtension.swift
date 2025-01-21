import Foundation
extension PlaylistAPI {
    func toPlaylist() -> Playlist {
        return Playlist(
            id: UUID(), // Generate a new UUID for Playlist
            name: self.name,
            description: self.description,
            imageUrl: self.imageURL,
            songCount: self.songsCount,
            tags: self.categories,
            songs: [] // Assuming the API doesn't provide songs in this request
        )
    }
}
