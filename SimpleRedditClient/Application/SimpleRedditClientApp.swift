//
//  SimpleRedditClientApp.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 24/7/22.
//

import SwiftUI

@main
struct SimpleRedditClientApp: App {
    
    let DI = AppDIContainer()
    
    var body: some Scene {
        WindowGroup {
            DI.makeHomeView()
        }
    }
}
