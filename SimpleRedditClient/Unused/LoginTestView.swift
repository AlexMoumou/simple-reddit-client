//
//  ContentView.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 24/7/22.
//

import SwiftUI

struct LoginTestView: View {
    
    @State var showWebViewSheet: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Press here to login to reddit")
                    .padding()
                Button(action: {showWebViewSheet = true}) {
                    Text("TAP HERE")
                }
            }
        }.sheet(isPresented: $showWebViewSheet) {
            WebView(request: URLRequest(url: RedditApiEndpoint.login.url))
        }.onOpenURL { url in
            print(url)
//            UserDefaults.standard.set("access token", forKey: (Bundle.main.bundleIdentifier ?? "") + "-accessToken")
            showWebViewSheet = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginTestView(showWebViewSheet: false)
    }
}
