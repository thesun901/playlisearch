import SwiftUI

struct PlaylistDetailsView: View {
    @StateObject private var viewModel: PlaylistDetailsViewModel
    @EnvironmentObject var favoritesManager: FavoritesManager
    @State private var showSuccess = false

    init(playlist: Playlist) {
        _viewModel = StateObject(wrappedValue: PlaylistDetailsViewModel(playlist: playlist))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .center) {
                    Spacer()

                    AsyncImage(url: URL(string: viewModel.playlist.imageUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 150, height: 150)
                    .cornerRadius(5)

                    Spacer()

                    VStack(spacing: 15) {
                        Button(action: {
                            if favoritesManager.isFavorite(viewModel.playlist) {
                                favoritesManager.removeFromFavorites(viewModel.playlist)
                            } else {
                                favoritesManager.addToFavorites(viewModel.playlist)
                            }
                        }) {
                            Image(systemName: favoritesManager.isFavorite(viewModel.playlist) ? "heart.fill" : "heart")
                                .font(.title)
                                .foregroundColor(favoritesManager.isFavorite(viewModel.playlist) ? .red : .gray)
                        }

                        Spacer()

                            Button(action: {
                                SpotifyManager.shared.followPlaylist(playlistID: viewModel.playlist.id) { result in
                                    switch result {
                                    case .success:
                                        showSuccess = true
                                    case .failure(let error):
                                        print("Failed to follow playlist: \(error)")
                                    }
                                }
                            }) {
                                Image(systemName: showSuccess ? "checkmark.circle.fill" : "plus.circle")
                                    .font(.title)
                                    .foregroundColor(showSuccess ? .green : .gray)
                            }
                            .animation(.easeInOut, value: showSuccess)



                        Spacer()

                        Button(action: {
                            viewModel.openInSpotify()
                        }) {
                            Image(systemName: "eye")
                                .font(.title)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal)

                VStack(alignment: .leading) {
                    Text(viewModel.playlist.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)


                    HStack {
                        ForEach(viewModel.playlist.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .padding(5)
                                .background(Color.orange)
                                .cornerRadius(5)
                                .foregroundColor(.white)
                        }
                    }

                    Text("\(viewModel.playlist.songCount) songs")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                // Songs List
                if viewModel.isLoadingTracks {
                    VStack {
                        ProgressView("Loading tracks...")
                            .foregroundColor(.gray)
                            .padding(.top)
                    }
                } else {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.playlist.songs) { song in
                            SongCard(song: song)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            viewModel.fetchTracksIfNeeded()
        }
    }
}
