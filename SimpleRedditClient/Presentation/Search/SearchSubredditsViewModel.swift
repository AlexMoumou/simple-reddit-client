//
//  SearchSubredditsViewModel.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 04/02/23.
//

import Foundation
import Combine

protocol ISearchSubredditsViewModel: ObservableObject {
    func send(action: SearchSubredditsViewModelAction)
    var subredditsList: [Subreddit] { get set }
    var term: String { get set }
}

enum SearchSubredditsViewModelAction {
    case load(String)
    case cancel
    case openSub(Subreddit)
}

enum SearchSubredditsResult {
    case goToHome
    case goToSubreddit(Subreddit)
}

class SearchSubredditsViewModel: ISearchSubredditsViewModel {
    
    private let getSubs: ISearchSubredditsUC
    private var cancelables = [AnyCancellable]()
    var callback: (@MainActor (SearchSubredditsResult) -> Void)?
    
    @Published var subredditsList: [Subreddit] = []
    @Published var after: String?
    @Published var term: String = ""
    
    init(getSubreddits: ISearchSubredditsUC) {
        self.getSubs = getSubreddits
    }
    
    func send(action: SearchSubredditsViewModelAction) {
        switch action {
            case .load(let query):
                loadListings(query: query)
            case .cancel:
                Task { await callback?(.goToHome) }
            case .openSub(let sub):
                Task { await callback?(.goToSubreddit(sub))}
        }
    }
    
    private func loadListings(query: String) {
        guard !query.isEmpty else {
            self.subredditsList = []
            self.after = nil
            self.term = ""
            return
        }
        getSubs.execute(after: self.term != query ? nil : after, term: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
                if self?.term != query {
                    self?.subredditsList = response.subreddits
                } else {
                    self?.subredditsList += response.subreddits
                }
                
                self?.after = response.info.after
                self?.term = query
            })
            .store(in: &cancelables)
    }
}
