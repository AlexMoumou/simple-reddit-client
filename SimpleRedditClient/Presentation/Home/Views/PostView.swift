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
            VStack (alignment: .leading, spacing: 5){
                Text(post.subredditNamePrefixed)
                Text(post.author)
            }.frame(maxWidth: .infinity,
                    alignment: .leading)
            .padding()
            Text(post.title).bold().padding(EdgeInsets.init(top: 0, leading: 5, bottom: 10, trailing: 5))
            VStack{
                AsyncImage(url: URL(string: post.url),
                           content: { image in
                               image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                           },
                           placeholder: {
                    Color.gray.padding().frame(width: 300, height: 300, alignment: .center)
                           })
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
