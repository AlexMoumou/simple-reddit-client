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
            Text(vm.subName)
        }
    }
}
