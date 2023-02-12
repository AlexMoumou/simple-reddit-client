//
//  CustomWkWebView.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 25/7/22.
//

import Foundation
import WebKit

class CustomWkWebView: UIWebView {}

extension CustomWkWebView: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("")
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        return true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error)
    }
}
