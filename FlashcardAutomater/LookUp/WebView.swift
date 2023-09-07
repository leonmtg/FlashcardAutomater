//
//  WebView.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/17.
//

import SwiftUI
import WebKit

struct WebView {
    @AppStorage("styleSheet") var styleSheet: StyleSheet = .raywenderlich
        
    var html: String
    
    private var formattedHtml: String {
        return """
          <html>
                  <head>
                     <link href="\(styleSheet).css" rel="stylesheet">
                  </head>
          <body>
             \(html)
          </body>
          </html>
          """
    }
    
    init(html: String) {
        self.html = html
    }
    
    func makeWebView(context: Context) -> WKWebView {
        return WKWebView()
    }
}

#if os(macOS)
extension WebView: NSViewRepresentable {
    func makeNSView(context: Context) -> WKWebView {
        makeWebView(context: context)
    }
    func updateNSView(_ nsView: WKWebView, context: Context) {
        uiView.loadHTMLString(
            formattedHtml,
            baseURL: Bundle.main.bundleURL
        )
    }
}
#else
extension WebView: UIViewRepresentable {
     func makeUIView(context: Context) -> WKWebView {
         makeWebView(context: context)
     }
    
     func updateUIView(_ uiView: WKWebView, context: Context) {
         uiView.loadHTMLString(
             formattedHtml,
             baseURL: Bundle.main.bundleURL
         )
     }
}
#endif

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(html: "<h2>hello</h2>\n<p><em><strong>noun</strong></em>\n<br />\"Hello!\" or an equivalent greeting.<br /> SYNONYMS <strong>greeting</strong><br /><em><strong>verb</strong></em>\n<br />To greet with \"hello\".<br /><em><strong>interjection</strong></em>\n<br /><strong>1</strong> A greeting (salutation) said when meeting someone or acknowledging someone’s arrival or presence.<br />• <span style=\"color: rgb(0, 85, 127);\"><em>Hello, everyone.</em></span><br /><strong>2</strong> A greeting used when answering the telephone.<br />• <span style=\"color: rgb(0, 85, 127);\"><em>Hello? How may I help you?</em></span><br /><strong>3</strong> A call for response if it is not clear if anyone is present or listening, or if a telephone conversation may have been disconnected.<br />• <span style=\"color: rgb(0, 85, 127);\"><em>Hello? Is anyone there?</em></span><br /><strong>4</strong> Used sarcastically to imply that the person addressed or referred to has done something the speaker or writer considers to be foolish.<br />• <span style=\"color: rgb(0, 85, 127);\"><em>You just tried to start your car with your cell phone. Hello?</em></span><br /><strong>5</strong> An expression of puzzlement or discovery.<br />• <span style=\"color: rgb(0, 85, 127);\"><em>Hello! What’s going on here?</em></span><br /> ANTONYMS <strong>bye</strong>, <strong>goodbye</strong></p>\n")
    }
}
