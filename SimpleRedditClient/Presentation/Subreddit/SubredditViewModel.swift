//
//  SubredditViewModel.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 12/02/23.
//

import Foundation
import Combine

protocol ISubredditViewModel: ObservableObject {
    func send(action: SubredditViewModelAction)
    var postsList: [Post] { get set }
    var after: String? { get set }
    var callback: (@MainActor (SubredditViewModelResult) -> Void)? { get set }
}

enum SubredditViewModelResult {
    case dismiss
    case openPost
}

enum SubredditViewModelAction {
    case load
    case refresh
    case openPost
}

class SubredditViewModel: ISubredditViewModel {
    private let getListings: IGetSubredditListingsUC
    private let subName: String
    @Published var postsList: [Post] = []
    @Published var after: String?
    
    private var cancelables = [AnyCancellable]()
    var callback: (@MainActor (SubredditViewModelResult) -> Void)?
    
    init(subName: String, getListings: IGetSubredditListingsUC) {
        self.subName = subName
        self.getListings = getListings
    }
    
    func send(action: SubredditViewModelAction) {
        switch action {
        case .load:
            loadListings()
        case .refresh:
            refreshListings()
        case .openPost:
            Task { await callback?(.openPost) }
        }
    }
    
    private func loadListings() {
        getListings.execute(subName: subName, after: after)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
                self?.postsList += response.posts
                self?.after = response.info.after
            })
            .store(in: &cancelables)
    }
    
    private func refreshListings() {
        getListings.execute(subName: subName, after: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
                self?.postsList = response.posts
                self?.after = response.info.after
            })
            .store(in: &cancelables)
    }
}
