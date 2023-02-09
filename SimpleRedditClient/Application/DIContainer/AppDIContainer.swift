//
//  AppDIContainer.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 28/9/22.
//

import Foundation

final class AppDIContainer {
    
    public static let shared = AppDIContainer()
    
    // MARK: - HTTP Client
    
    lazy var client: RestClient = RestClient()
    lazy var listingsRepo: ListingsRepo = ListingsRepo(restClient: client)
    
    // MARK: - Use Cases
    
    func makeGetHomeListingsUseCase() -> IGetHomeListingsUC {
        return GetHomeListingsUC(listingsRepo: listingsRepo)
    }
    
    func makeSearchSubredditsUseCase() -> ISearchSubredditsUC {
        return SeachSubredditsUC(listingsRepo: listingsRepo)
    }
    
    // MARK: - Repositories
    
//    func makeListingsRepository() -> ListingsRepo {
//        return ListingsRepo(restClient: client)
//    }
    
    // MARK: - ViewModels
    
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(getHomeListings: makeGetHomeListingsUseCase())
    }
    
    func makeSearchSubredditsViewModel() -> SearchSubredditsViewModel {
        return SearchSubredditsViewModel(getSubreddits: makeSearchSubredditsUseCase())
    }
    
    // MARK: - Views
    
    func makeHomeView() -> HomeView {
        return HomeView(vm: makeHomeViewModel())
    }
    
    func makeSearchSubredditsView() -> SearchSubredditsView {
        return SearchSubredditsView(vm: makeSearchSubredditsViewModel())
    }
}
