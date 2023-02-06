//
//  SubredditTile.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 06/02/23.
//

import Foundation
import SwiftUI

struct SubredditTile: View {
    
    let subreddit: Subreddit
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: subreddit.header_img)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Image("Subreddit_placeholder").resizable().scaledToFit()
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 1))
            .padding(.leading)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(subreddit.display_name_prefixed)
                Text(subreddit.public_description)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .allowsTightening(true)
            }
            .padding(.horizontal)
        }
    }
    
}

struct SubredditTile_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SubredditTile(subreddit: Subreddit.example())
        }
    }
}
