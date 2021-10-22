//
//  ContentView.swift
//  TestWSS
//
//  Created by Yury Korolev on 21.10.2021.
//

import SwiftUI
import UIKit
import WebKit

class WebView: UIView {
 
  let _webview: WKWebView
  
  override init(frame: CGRect) {
    
    let cfg = WKWebViewConfiguration()
    cfg.limitsNavigationsToAppBoundDomains = false
    
    
    _webview = WKWebView(frame: .zero, configuration: cfg)
    
    
    super.init(frame: frame)
    
    _webview.configuration.userContentController.add(self, name: "blink")
    _webview.navigationDelegate = self
    
    
    addSubview(_webview)
    _webview.load(URLRequest(url: URL(string: "https://michaeltreat.github.io/Web-Worker-Demo/html/web-worker.html")!))
  
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    _webview.frame = self.bounds
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension WebView: WKScriptMessageHandler {
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    
  }
  
  
}

extension WebView: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    print("finish")
  }
  
  func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
    completionHandler(.useCredential, cred)
//    let serverTrust = challenge.protectionSpace.serverTrust!;
//    let exceptions = SecTrustCopyExceptions(serverTrust);
//    SecTrustSetExceptions(serverTrust, exceptions);
//    completionHandler(.useCredential, URLCredential(trust: serverTrust))
    
  }
}



struct WebSView: UIViewRepresentable {
  func updateUIView(_ uiView: WebView, context: Context) {
  }
  
  func makeUIView(context: Context) -> WebView {
    WebView()
  }
}

struct ContentView: View {
    var body: some View {
        WebSView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WebSView()
    }
}
