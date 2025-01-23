//
//  PlaylistDetailsViewModel.swift
//  playlisearch
//
//  Created by Oliwier Dygdałowicz on 22/01/2025.
//


import Foundation

class PlaylistDetailsViewModel: ObservableObject {
    @Published var playlist: Playlist
    @Published var isLoadingTracks = false

    init(playlist: Playlist) {
        self.playlist = playlist
    }

    func fetchTracksIfNeeded() {
        guard playlist.songs.isEmpty else {
            return // No need to fetch if songs are already loaded
        }

        isLoadingTracks = true

        SpotifyManager.shared.fetchPlaylistTracks(playlistID: playlist.id) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoadingTracks = false

                switch result {
                case .success(let songs):
                    self?.playlist = Playlist(
                        id: self?.playlist.id ?? "",
                        name: self?.playlist.name ?? "",
                        description: self?.playlist.description ?? "",
                        imageUrl: self?.playlist.imageUrl ?? "",
                        songCount: self?.playlist.songCount ?? 0,
                        tags: self?.playlist.tags ?? [],
                        songs: songs
                    )
                case .failure(let error):
                    print("Failed to fetch tracks: \(error)")
                }
            }
        }
    }
}
