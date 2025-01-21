import SwiftUI

struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.playlists, id: \.id) { playlist in
                        PlaylistCardView(playlist: playlist)
                            .padding(.horizontal)
                            .onAppear {
                                if playlist == viewModel.playlists.last {
                                    viewModel.fetchMorePlaylists()
                                }
                            }
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                }
            }
            .background(Color.black.ignoresSafeArea()) // Tło ekranu
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationTitle("Explore")
            .onAppear {
                viewModel.initializeExploreView()
            }
        }
    }
}
