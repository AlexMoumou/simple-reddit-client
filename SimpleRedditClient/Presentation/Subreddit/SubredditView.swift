//
//  SubredditView.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 15/02/23.
//

import Foundation
import SwiftUI

struct SubredditView: View {
    @ObservedObject var vm: SubredditViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach (vm.postsList) { post in
                        PostView(post: post)
                    }.listStyle(.grouped)
                    
                    if(vm.after != nil) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .onAppear {
                                vm.send(action: .load)
                            }
                    }
                }
            }
        }.navigationTitle(vm.subName)
    }
}
