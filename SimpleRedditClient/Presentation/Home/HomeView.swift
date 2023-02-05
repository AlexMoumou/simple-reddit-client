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
        NavigationView {
            ScrollView {
                PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                    vm.refreshListings()
                }
                LazyVStack {
                    ForEach (vm.postsList) { post in
                        PostView(post: post)
                    }.listStyle(.grouped)
                    
                    if(vm.after != nil) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .onAppear {
                                vm.loadListings()
                            }
                    }
                }
            }.coordinateSpace(name: "pullToRefresh")
                .navigationTitle("Best Reddit Posts")
                .toolbar {
                    NavigationLink(destination: AppDIContainer().makeSearchSubredditsView()) {
                        Image(systemName: "magnifyingglass")
                    }
                    
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        AppDIContainer().makeHomeView()
    }
}
