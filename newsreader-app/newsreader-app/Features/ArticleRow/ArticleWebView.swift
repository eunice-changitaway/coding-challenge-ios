//
//  ArticleWebView.swift
//

import SwiftUI
import WebKit

struct ArticleWebView: UIViewRepresentable {
    let url: URL
    var onSave: (() -> Void)? = nil
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onSave: onSave)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var onSave: (() -> Void)?
        init(onSave: (() -> Void)?) { self.onSave = onSave }
    }
}


