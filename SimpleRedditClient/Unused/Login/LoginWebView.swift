//
//  LoginWebView.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 24/7/22.
//

import SwiftUI

struct WebView: UIViewRepresentable {
    
    let request: URLRequest
    
    func makeUIView(context: Context) -> CustomWkWebView {
        return CustomWkWebView()
    }
    
    func updateUIView(_ uiView: CustomWkWebView, context: Context) {
        uiView.loadRequest(request)
    }
    
}

#if DEBUG
struct PostWebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(request: URLRequest(url: URL(string: "www.google.com")!))
    }
}
#endif
