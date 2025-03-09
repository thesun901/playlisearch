# Playlisearch 🎵🔍  
**Discover and categorize Spotify playlists effortlessly!**  

Playlisearch is a mobile application that helps users explore and categorize Spotify playlists. Since Spotify lacks built-in playlist categorization, this app fills the gap by analyzing playlist content and assigning relevant categories.

## 📌 Features  
- 🏠 **Home View**: Browse recommended playlists and see your liked playlists count.  
- 🎶 **Playlist Details**: View song information, including title, artist, and optional album art. You can add playlist directly to your Spotify from this view  
- 🔍 **Smart Categorization**: Automatically assigns the 6 most relevant categories to a playlist based on its artists. (backend responsibility see: playlisearch-backend for more details on this topic) 
- 🔄 **Spotify Integration**: Fetch playlists and songs directly from the Spotify API.  
- 🌐 **Custom Backend**: Uses FastAPI to store and manage categorized playlists.  

## 🛠️ Tech Stack  
- **Frontend**: Swift (iOS)  
- **Backend**: FastAPI (Python)  
- **Database**: PostgreSQL
- **Authentication**: Spotify OAuth  
- **Hosting**: Currentlu local, but planning on cloud deployment

## 🚀 Getting Started  

### Clone the repository  
```bash
git clone https://github.com/thesun901/playlisearch.git
cd playlisearch
```

### Backend Setup (FastAPI)  
For backend setup please see [playlisearch-backend repository](https://github.com/thesun901/playlisearch-backend)

### iOS App Setup  
1. Open the `Playlisearch.xcodeproj` in Xcode.  
2. Ensure you have an active **Spotify Developer App** with proper API keys.  
3. Run the app on a simulator or connected iPhone.

### Spotify API Configuration  
You'll need a **Spotify Developer Account** to get API credentials.  

1. Go to [Spotify Developer Dashboard](https://developer.spotify.com/dashboard).  
2. Create an app and note your **Client ID** and **Client Secret**.  
3. Set up the **Redirect URI** (e.g., `playlisearch://callback`).  

## 🗺️ Roadmap  
✅ Fetch playlists from Spotify API  
✅ Categorize playlists based on artists  
✅ Categorize user based on favourite artists  
🔲 Improve UI/UX for playlist browsing  
🔲 Add filters aside of user favourite categories for discovering new music
🔲 Implement user authentication  

## 🤝 Contributing  
Contributions are welcome!
