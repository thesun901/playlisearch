import SwiftUI
@preconcurrency import WebKit

struct SpotifyAuthView: UIViewRepresentable {
    var onTokenReceived: (String) -> Void
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        if let request = SpotifyManager.shared.getAccessTokenRequest() {
            webView.load(request)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onTokenReceived: onTokenReceived)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var onTokenReceived: (String) -> Void
        
        init(onTokenReceived: @escaping (String) -> Void) {
            self.onTokenReceived = onTokenReceived
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url, url.absoluteString.starts(with: SpotifyConstants.redirectUri) {
                if SpotifyManager.shared.handleRedirectURL(url) {
                    if let token = SpotifyManager.shared.accessToken {
                        onTokenReceived(token)
                    }
                }
                decisionHandler(.cancel) // Prevent further navigation
                return
            }
            decisionHandler(.allow)
        }
    }

}
