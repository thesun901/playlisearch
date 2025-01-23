//
//  Playlist.swift
//  playlisearch
//
//  Created by Oliwier Dygdałowicz on 05/01/2025.
//
import Foundation

struct Playlist: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let name: String
    let description: String
    let imageUrl: String
    let songCount: Int
    let tags: [String]
    let songs: [Song]
}

