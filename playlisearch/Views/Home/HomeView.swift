import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Powitanie użytkownika
                    Text("Welcome Back, \(viewModel.username)!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white) // Ustawiamy kolor tekstu
                        .padding(.top)
                    
                    // Liczba polubionych playlist
                    Text("Liked playlists: \(viewModel.likedPlaylistsCount)")
                        .font(.subheadline)
                        .foregroundColor(.gray) // Szary kolor
                    
                    // Sekcja rekomendowana playlisty
                    PlaylistCard(playlist: viewModel.recommendedPlaylist)
                    
                    // Najczęściej słuchane piosenki
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your top listened songs of last month")
                            .font(.title3)
                            .foregroundColor(.white)

                        // Wrap the content in a ZStack for background styling
                        ZStack {
                            Color(.tertiaryGray) // Your background color
                                .cornerRadius(10) // Rounded corners
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(viewModel.topSongs) { song in
                                    SongCard(song: song)
                                        .padding(.horizontal, 10)
                                }
                            }
                            .padding(20) // Add padding between content and background
                        }
                    }

                    
                }
                .padding()
            }
            .background(Color.black.ignoresSafeArea()) // Tło ekranu
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar) // Ciemny navbar
        }
    }
}
