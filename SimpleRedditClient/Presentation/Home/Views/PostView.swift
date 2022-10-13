//
//  PostView.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 9/10/22.
//

import SwiftUI

struct PostView: View {
    
    let post: Post
    
    var body: some View {
        VStack {
            Divider()
            VStack (alignment: .leading, spacing: 5){
                Text(post.subredditNamePrefixed)
                Text(post.author)
                Text(post.title).bold().padding(EdgeInsets.init(top: 10, leading: 0, bottom: 0, trailing: 0))
            }.frame(maxWidth: .infinity,
                    alignment: .leading)
            .padding()
            
            VStack{
                post.isVideo ?
                AnyView(RedditVideoView(url: post.videoURL)):
                AnyView(RedditImageView(url: post.url))
            }.frame(maxWidth: .infinity)
            Spacer()
        }.frame(maxWidth: .infinity)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: Post.example())
    }
}
