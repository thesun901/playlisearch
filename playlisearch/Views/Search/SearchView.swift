import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search playlists", text: $viewModel.searchQuery, onCommit: {
                    viewModel.searchPlaylists()
                })
                .padding()
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)

                // Results List
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.searchResults.isEmpty {
                    Text("No results found")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.searchResults, id: \.id) { playlist in
                                PlaylistCardView(playlist: playlist)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
        }
    }
}
