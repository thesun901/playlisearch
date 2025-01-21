import SwiftUI

@main
struct playlisearchApp: App {
    @State private var isAuthorized = false

    var body: some Scene {
        WindowGroup {
            if isAuthorized {
                ContentView() // Main view of the app
            } else {
                SpotifyAuthView { token in
                    SpotifyManager.shared.accessToken = token
                    isAuthorized = true
                }
            }
        }
    }
}
