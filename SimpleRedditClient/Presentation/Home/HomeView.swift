//
//  HomeView.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 2/8/22.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var vm: HomeViewModel
    
    var body: some View {
        ScrollView {
            PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                vm.send(action: .refresh)
            }
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
        }.coordinateSpace(name: "pullToRefresh")
            .navigationTitle("Best Reddit Posts")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    vm.send(action: .tapSearch)
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        AppDIContainer().makeHomeView()
    }
}
