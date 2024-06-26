import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let gifURL: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.isUserInteractionEnabled = false
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let html =
                """
                <html>
                <body style="margin: 0; padding: 0;">
                <img src="\(gifURL)" style="width: 100%; height: auto;"/>
                </body>
                </html>
                """
        webView.loadHTMLString(html, baseURL: nil)
    }
}
