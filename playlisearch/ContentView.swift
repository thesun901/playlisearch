//
//  ContentView.swift
//  playlisearch
//
//  Created by Oliwier Dygdałowicz on 05/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainTabView()
            .environmentObject(FavoritesManager())
      }
}

#Preview {
    ContentView()
}

