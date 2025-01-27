import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Black background for the entire screen
                Color.black.ignoresSafeArea()

                VStack {
                    // Search Bar
                    TextField("Search playlists", text: $viewModel.searchQuery, onCommit: {
                        viewModel.searchPlaylists()
                    })
                    .padding()
                    .background(Color.gray.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.horizontal)

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
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
