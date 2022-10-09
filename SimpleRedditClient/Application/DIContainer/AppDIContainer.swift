//
//  AppDIContainer.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 28/9/22.
//

import Foundation

final class AppDIContainer {
    
    // MARK: - HTTP Client
    
    lazy var client: RestClient = RestClient()
    
    // MARK: - Use Cases
    
    func makeGetHomeListingsUseCase() -> IGetHomeListingsUC {
        return GetHomeListingsUC(listingsRepo: makeListingsRepository())
    }
    
    // MARK: - Repositories
    
    func makeListingsRepository() -> ListingsRepo {
        return ListingsRepo(restClient: client)
    }
    
    // MARK: - ViewModels
    
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(getHomeListings: makeGetHomeListingsUseCase())
    }
    
    // MARK: - Views
    
    func makeHomeView() -> HomeView {
        return HomeView(vm: makeHomeViewModel())
    }
}
