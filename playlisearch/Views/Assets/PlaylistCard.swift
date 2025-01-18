//
//  RecommendedPlaylistView.swift
//  playlisearch
//
//  Created by Oliwier Dygdałowicz on 05/01/2025.
//
import SwiftUI


struct PlaylistCard: View {
    let playlist: Playlist
    
    var body: some View {
        NavigationLink(destination: PlaylistDetailsView(playlist: self.playlist)) {
            VStack(alignment: .leading) {
                Text("Today's recommended playlist:")
                    .font(.headline)
                    .foregroundColor(.white)
                
                HStack {
                    AsyncImage(url: URL(string: self.playlist.imageUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(self.playlist.name)
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        HStack {
                            ForEach(self.playlist.tags, id: \.self) { tag in
                                Text(tag)
                                    .font(.caption)
                                    .padding(5)
                                    .background(Color.orange)
                                    .cornerRadius(5)
                                    .foregroundColor(.white) // Tekst w tagach
                            }
                        }
                        
                        Text("\(self.playlist.songCount) songs")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.8)) // Czarny z lekką przezroczystością
                .cornerRadius(10)
            }
        }
    }
}
