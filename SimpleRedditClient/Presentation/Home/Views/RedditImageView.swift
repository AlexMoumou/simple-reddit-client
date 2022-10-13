//
//  RedditImageView.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 13/10/22.
//

import SwiftUI

struct RedditImageView: View {
    let url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url),
                   content: { image in
                       image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                   },
                   placeholder: {
            Color.gray.padding().frame(width: 300, height: 300, alignment: .center)
                   })
    }
}

struct RedditImageView_Previews: PreviewProvider {
    static var previews: some View {
        RedditImageView(url: "")
    }
}
