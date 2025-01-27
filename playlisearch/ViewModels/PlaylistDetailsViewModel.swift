//
//  PlaylistDetailsViewModel.swift
//  playlisearch
//
//  Created by Oliwier Dygdałowicz on 22/01/2025.
//


import Foundation
import UIKit

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
    
    
    func openInSpotify() {
        guard let url = URL(string: "https://open.spotify.com/playlist/\(playlist.id)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Cannot open Spotify URL")
        }
    }

    func followOnSpotify() {
        SpotifyManager.shared.followPlaylist(playlistID: playlist.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Successfully followed playlist.")
                case .failure(let error):
                    print("Failed to follow playlist: \(error)")
                }
            }
        }
    }
}
