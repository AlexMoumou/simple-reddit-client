//
//  HomeViewModel.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 2/8/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    private let getHomeListings: IGetHomeListingsUC
    
    @Published var postsList: [Post] = []
    
    private var cancelables = [AnyCancellable]()
    @Published var after: String?
    
    init(getHomeListings: IGetHomeListingsUC) {
        self.getHomeListings = getHomeListings
        loadListings()
    }
    
    
    func loadListings() {
        getHomeListings.execute(after: after)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
                self?.postsList = response.posts
                self?.after = response.info.after
            })
            .store(in: &cancelables)
    }
}
