import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                   
                    Text("Welcome Back, \(viewModel.username)!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white) // Ustawiamy kolor tekstu
                        .padding(.top)
                    
                    
                    Text("Liked playlists: \(viewModel.likedPlaylistsCount)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    
                    PlaylistCardView(playlist: viewModel.recommendedPlaylist)
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your top listened songs of last month")
                            .font(.title3)
                            .foregroundColor(.white)

                        
                        ZStack {
                            Color(.tertiaryGray)
                                .cornerRadius(10)
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(viewModel.topSongs) { song in
                                    SongCard(song: song)
                                        .padding(.horizontal, 10)
                                }
                            }
                            .padding(20)
                        }
                    }

                    
                }
                .padding()
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}
