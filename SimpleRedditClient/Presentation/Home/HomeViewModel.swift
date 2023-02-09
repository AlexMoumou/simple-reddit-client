//
//  HomeViewModel.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 2/8/22.
//

import Foundation
import Combine

enum HomeViewModelResult {
    case goToSearch
}

enum HomeViewModelAction {
    case load
    case refresh
    case tapSearch
}

class HomeViewModel: ObservableObject {
    
    private let getHomeListings: IGetHomeListingsUC
    @Published var postsList: [Post] = []
    @Published var after: String?
    
    private var cancelables = [AnyCancellable]()
    var callback: (@MainActor (HomeViewModelResult) -> Void)?
    
    init(getHomeListings: IGetHomeListingsUC) {
        self.getHomeListings = getHomeListings
        loadListings()
    }
    
    func send(action: HomeViewModelAction) {
        switch action {
        case .load:
            loadListings()
        case .refresh:
            refreshListings()
        case .tapSearch:
            Task { await callback?(.goToSearch) }
        }
    }
    
    private func loadListings() {
        getHomeListings.execute(after: after)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
                self?.postsList += response.posts
                self?.after = response.info.after
            })
            .store(in: &cancelables)
    }
    
    private func refreshListings() {
        getHomeListings.execute(after: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
                self?.postsList = response.posts
                self?.after = response.info.after
            })
            .store(in: &cancelables)
    }
}
