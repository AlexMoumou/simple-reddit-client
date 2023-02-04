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
                Text(post.title)
                    .bold()
                    .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 0, trailing: 0))
                if post.selftext != "" && post.selftext != nil {
                    Text(post.selftext!)
                        .italic()
                        .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 0, trailing: 0))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            VStack{
                if post.url.hasSuffix(".jpg") || post.url.hasSuffix(".png") {
                    RedditImageView(url: post.url)
                } else {
                    let link = "[\(post.url)](\(post.url))"
                    HStack {
                        Text(.init(link))
                            .truncationMode(.tail)
                            .lineLimit(2)
                            .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 5, trailing: 10))
                            .frame(alignment: .leading)
                        Spacer()
                    }
                }
                
                if post.isVideo {
                    RedditVideoView(url: post.videoURL)
                }
                
            }.frame(maxWidth: .infinity)
            
            Spacer()
        }.frame(maxWidth: .infinity)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostView(post: Post.example())
        }
    }
}
