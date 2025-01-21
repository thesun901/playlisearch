//
//  SpotifyConstants.swift
//  playlisearch
//
//  Created by Oliwier Dygdałowicz on 18/01/2025.
//
import Foundation


let env = ProcessInfo.processInfo.environment
    
enum SpotifyConstants {
    static let spotifyHost = "api.spotify.com"
    static let authHost = "accounts.spotify.com"
    static let clientId = env["CLIENT_ID"] ?? ""
    static let clientSecret = env["CLIENT_SECRET"] ?? ""
    static let redirectUri = "myapp://spotify-callback"
    static let responseType = "token"
    static let scopes = "user-top-read"
    
    static var authParams = [
        "response_type": responseType,
        "client_id": clientId,
        "redirect_uri" : redirectUri,
        "scope": scopes
    ]
}
