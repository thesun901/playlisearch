import SwiftUI

struct MainTabView: View {
    init() {
        // Customize the tab bar appearance
        UITabBar.appearance().barTintColor = UIColor.black // Tab bar background
        UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray // Unselected icon color
        UITabBar.appearance().tintColor = UIColor.orange // Selected icon color
    }
    
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "music.note.list")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
        .accentColor(.orange)
    }
}

