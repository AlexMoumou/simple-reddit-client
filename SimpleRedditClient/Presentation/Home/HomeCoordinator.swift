//
//  HomeCoordinator.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 08/02/23.
//

import UIKit
import SwiftUI

enum HomeCoordinatorResult {
    case goToSearch
}

class HomeCoordinator: Coordinator {
    
    var childCoordinators: [AppChildCoordinator: Coordinator] = [:]
    var navigationController: UINavigationController
    var callback: (@MainActor (HomeCoordinatorResult) -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = AppDIContainer.shared.makeHomeViewModel()
        vm.callback = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .goToSearch:
                self.callback?(.goToSearch)
            }
        }
        let vc = HomeView(vm: vm)
        navigationController.pushViewController(UIHostingController(rootView: vc), animated: true)
    }
}
