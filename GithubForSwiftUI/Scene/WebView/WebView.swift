//
//  WebView.swift
//  GithubForSwiftUI
//
//  Created by Isami Odagiri on 2023/05/07.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let loadUrl: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let loadUrl else {
            return
        }
        
        let request = URLRequest(url: loadUrl)
        uiView.load(request)
    }
}

#if DEBUG
struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(loadUrl: URL(string: "https://google.com"))
    }
}
#endif
