//
//  HomeViewModel.swift
//  playlisearch
//
//  Created by Oliwier Dygdałowicz on 05/01/2025.
//
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
    @Published var topSongs: [Song] = [
        Song(id: UUID(), title: "Little Big Boy", artist: "Madds Buckley", duration: 210, imageUrl: "https://via.placeholder.com/100"),
        Song(id: UUID(), title: "Little Dark Age", artist: "MGMT", duration: 210, imageUrl: "https://via.placeholder.com/100"),
        Song(id: UUID(), title: "Little Talks", artist: "Of Monsters and Men", duration: 210, imageUrl: "https://via.placeholder.com/100"),
        Song(id: UUID(), title: "Little Lies", artist: "Fleetwood Mac", duration: 210, imageUrl: "https://via.placeholder.com/100"),
        Song(id: UUID(), title: "Little League", artist: "Conan Gray", duration: 210, imageUrl: "https://via.placeholder.com/100")
    ]
}


