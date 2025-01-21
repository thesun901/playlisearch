import SwiftUI

struct PlaylistCardView: View {
    let playlist: Playlist
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: playlist.imageUrl)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()
                    .frame(height: 200)
            }
            
            Text(playlist.name)
                .font(.headline)
                .foregroundColor(.white)
            
            Text(playlist.description)
                .font(.subheadline)
                .lineLimit(2)
                .foregroundColor(.white)
            
            Text("\(playlist.songCount) songs")
                .font(.subheadline)
                .foregroundColor(.gray)
        
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), spacing: 8)], spacing: 8) {
                            ForEach(playlist.tags, id: \.self) { tag in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.orange)
                                        .frame(height: 20) 
                                    
                                    Text(tag)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .padding(.horizontal, 8)
                        }
                    }
                }
            }
            .padding()
            .background(Color.secondaryGrey.opacity(0.8))
            .cornerRadius(10)
    }
}
