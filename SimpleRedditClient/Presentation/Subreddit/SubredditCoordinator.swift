//
//  SubredditCoordinator.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 12/02/23.
//

import UIKit

enum SubredditCoordinatorResult {
    case dismiss
    //TODO: open post view
    case openPost
}

class SubredditCoordinator: Coordinator {
    
    var childCoordinators: [AppChildCoordinator: Coordinator] = [:]
    var navigationController: UINavigationController
    var callback: (@MainActor (SubredditCoordinatorResult) -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
}
