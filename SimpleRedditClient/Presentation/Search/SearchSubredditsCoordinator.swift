//
//  SearchSubredditsCoordinator.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 08/02/23.
//

import UIKit
import SwiftUI

enum SearchSubredditsCoordinatorResult {
    case goToHome
}

class SearchSubredditsCoordinator: Coordinator {
    
    var childCoordinators: [AppChildCoordinator: Coordinator] = [:]
    var navigationController: UINavigationController
    var callback: (@MainActor (SearchSubredditsCoordinatorResult) -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = AppDIContainer.shared.makeSearchSubredditsView()
        navigationController.present(UINavigationController(rootViewController: UIHostingController(rootView: vc)), animated: true)
    }
}
