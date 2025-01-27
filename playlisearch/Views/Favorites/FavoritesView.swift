//
//  FavoritesView.swift
//  playlisearch
//
//  Created by Oliwier Dygdałowicz on 05/01/2025.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if favoritesManager.favorites.isEmpty {
                        Text("No favorite playlists yet.")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(favoritesManager.favorites) { playlist in
                            NavigationLink(destination: PlaylistDetailsView(playlist: playlist)) {
                                HStack {
                                    AsyncImage(url: URL(string: playlist.imageUrl)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(5)

                                    VStack(alignment: .leading) {
                                        Text(playlist.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text("\(playlist.songCount) songs")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(Color.black.opacity(0.8))
                                .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color.black.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationTitle("Favorites")
        }
    }
}
