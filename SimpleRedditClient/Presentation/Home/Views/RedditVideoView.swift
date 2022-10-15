//
//  RedditVideoView.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 13/10/22.
//

import SwiftUI
import AVKit

struct RedditVideoView: View {
    
    @State var player = AVPlayer()
    
    let url: String
    
    var body: some View {
        VideoPlayer(player: player)
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
                    .onAppear() {
                        let playerItem = AVPlayerItem(url: URL(string: url)!)
                        player = AVPlayer(playerItem: playerItem)
                    }
                    .onDisappear() {
                        player.pause()
                    }
    }
}

struct RedditVideoView_Previews: PreviewProvider {
    static var previews: some View {
        RedditVideoView(url: "")
    }
}
