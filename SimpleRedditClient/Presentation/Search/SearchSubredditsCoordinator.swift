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
        let vm = AppDIContainer.shared.makeSearchSubredditsViewModel()
        vm.callback = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .goToHome:
                self.callback?(.goToHome)
            }
        }
        let vc = SearchSubredditsView(vm: vm)
        let host = UIHostingController(rootView: vc)
        host.navigationItem.hidesBackButton = true
        navigationController.pushViewController(host, animated: true)
    }
}
