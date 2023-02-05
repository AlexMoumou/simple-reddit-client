//
//  SearchSubredditsViewModel.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 04/02/23.
//

import Foundation
import Combine

protocol ISearchSubredditsViewModel: ObservableObject {
    func loadListings(query: String)
    var subredditsList: [Subreddit] { get set }
    var term: String { get set }
}

class SearchSubredditsViewModel: ISearchSubredditsViewModel {
    
    private let getSubs: ISearchSubredditsUC
    
    @Published var subredditsList: [Subreddit] = []
    @Published var after: String?
    @Published var term: String = ""
    
    private var cancelables = [AnyCancellable]()
    
    init(getSubreddits: ISearchSubredditsUC) {
        self.getSubs = getSubreddits
    }
    
    
    func loadListings(query: String) {
        guard !query.isEmpty else {
            self.subredditsList = []
            self.after = nil
            self.term = ""
            return
        }
        getSubs.execute(after:self.term != query ? nil : after, term: query)
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
