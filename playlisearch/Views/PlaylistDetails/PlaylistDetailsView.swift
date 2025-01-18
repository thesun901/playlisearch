import SwiftUI

struct PlaylistDetailsView: View {
    let playlist: Playlist
    
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Playlist Header
                HStack(alignment: .center) {
                    Spacer()
                    
                    AsyncImage(url: URL(string: self.playlist.imageUrl)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 150, height: 150)
                        .cornerRadius(5)
                    
                    Spacer()

                    // Icons Section
                    VStack(spacing: 15) {
                        Button(action: {
                            if favoritesManager.isFavorite(playlist) {
                                favoritesManager.removeFromFavorites(playlist)
                            } else {
                                favoritesManager.addToFavorites(playlist)
                            }
                        }) {
                            Image(systemName: favoritesManager.isFavorite(playlist) ? "heart.fill" : "heart")
                                .font(.title)
                                .foregroundColor(favoritesManager.isFavorite(playlist) ? .red : .gray)
                        }
                        
                        Spacer()

                        Button(action: {
                            print("add playlist tapped")
                        }) {
                            Image(systemName: "plus.circle")
                                .font(.title)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            print("show playlist tapped")
                        }) {
                            
                            Image(systemName: "eye")
                                .font(.title)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(playlist.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    HStack {
                        ForEach(playlist.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .padding(5)
                                .background(Color.orange)
                                .cornerRadius(5)
                                .foregroundColor(.white)
                        }
                    }

                    Text("\(playlist.songCount) songs")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                // Songs List
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(playlist.songs) { song in
                        SongCard(song: song)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color.black.ignoresSafeArea())
    }
}
