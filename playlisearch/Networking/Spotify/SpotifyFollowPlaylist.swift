extension SpotifyManager {
    func followPlaylist(playlistID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        makeAuthenticatedRequest(
            endpoint: "/v1/playlists/\(playlistID)/followers",
            method: "PUT"
        ) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
