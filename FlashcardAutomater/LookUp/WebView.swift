//
//  WebView.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/17.
//

import SwiftUI
import WebKit

struct WebView {
    var html: String
    
    private var formattedHtml: String {
      return """
          <html>
          <body>
             \(html)
          </body>
          </html>
          """
    }
    
    init(html: String) {
        self.html = html
    }
}

extension WebView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(
            formattedHtml,
            baseURL: Bundle.main.bundleURL
        )
    }
}
