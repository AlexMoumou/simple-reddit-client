//
//  SubredditCoordinator.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 12/02/23.
//

import UIKit
import SwiftUI

enum SubredditCoordinatorResult {
    case dismiss
}

class SubredditCoordinator: Coordinator {
    
    private let sub: Subreddit
    private var childCoordinators: [AppChildCoordinator: Coordinator] = [:]
    internal var navigationController: UINavigationController
    var callback: (@MainActor (SubredditCoordinatorResult) -> Void)?
    
    private var vm: SubredditViewModel
    
    @MainActor init(sub: Subreddit, navigationController: UINavigationController) {
        self.sub = sub
        self.navigationController = navigationController
        
        let viewModel = AppDIContainer.shared.makeSubredditViewModel(subname: sub.display_name_prefixed)
        self.vm = viewModel
        
        let view = UIHostingController(rootView: SubredditView(vm: viewModel))
        
        self.navigationController.pushViewController(view, animated: true)
    }
    
    func start() {
        Task { await setupViewModel() }
    }
    
    @MainActor private func setupViewModel() {
        vm.callback = { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .dismiss:
                self.callback?(.dismiss)
            case .openPost:
                //TODO: implement opening a post detail view with comments and the whole shebang
                print("Opening this post...eventually implemented")
            }
        }
    }
}
