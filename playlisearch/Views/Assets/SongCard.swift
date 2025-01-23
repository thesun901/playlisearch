//
//  SongCard.swift
//  playlisearch
//
//  Created by Oliwier Dygdałowicz on 07/01/2025.
//

import SwiftUI
struct SongCard: View {
    let song: Song
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: song.imageUrl ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 50, height: 50)
            .cornerRadius(5)
            .padding(.leading, 5)
            
            VStack(alignment: .leading) {
                
                Text(song.title)
                    .font(.headline)
                    .foregroundColor(.orange)
                    .padding(.top, 3)
                
                
                Spacer()
                
                Text(song.artist)
                    .font(.subheadline)
                    .foregroundColor(.textWhite)
                    .padding(.bottom, 3)
                
                
            }
            
            Spacer()
        }
        .padding(.vertical, 5)
        .background(Color("SecondaryGrey"))
        .cornerRadius(5)
    }
}
