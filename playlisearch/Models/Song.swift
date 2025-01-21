//
//  Song.swift
//  playlisearch
//
//  Created by Oliwier Dygdałowicz on 05/01/2025.
//
import Foundation

struct Song: Identifiable, Codable, Equatable{
    let id: UUID
    let title: String
    let artist: String
    let duration: Int
    let imageUrl: String
}

