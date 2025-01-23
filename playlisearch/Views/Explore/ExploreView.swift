import SwiftUI

struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(Array(viewModel.playlists.enumerated()), id: \.offset) { index, playlist in
                        PlaylistCardView(playlist: playlist) // Ensure uniqueness at runtime
                            .padding(.horizontal)
                            .onAppear {
                                if index >= viewModel.playlists.count - 5 {
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
                if viewModel.playlists.isEmpty {
                    viewModel.initializeExploreView()
                }
                

            }
        }
    }
}
