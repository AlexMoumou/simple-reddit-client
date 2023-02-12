//
//  AppCoordinator.swift
//  SimpleRedditClient
//
//  Created by Alex Moumoulides on 08/02/23.
//

import UIKit

enum AppChildCoordinator {
    case Home
    case Search
    case Subreddit
}

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let diContainer: AppDIContainer
    var childCoordinators: [AppChildCoordinator: Coordinator] = [:]
    var navigationController: UINavigationController
    
    init(window: UIWindow, container: AppDIContainer) {
        self.diContainer = container
        self.window = window
        navigationController = UINavigationController()
        self.window.rootViewController = navigationController
    }
    
    func start() {
        showHome()
    }
    
    func showHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        childCoordinators[.Home] = homeCoordinator
        
        homeCoordinator.callback = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .goToSearch:
                self.showSearch()
            }
        }
        
        homeCoordinator.start()
    }
    
    func showSearch() {
        let searchCoordinator = SearchSubredditsCoordinator(navigationController: navigationController)
        childCoordinators[.Search] = searchCoordinator
        
        searchCoordinator.callback = { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .goToHome:
                self.childCoordinators[.Search] = nil
                self.navigationController.popViewController(animated: true)
            }
        }
        
        searchCoordinator.start()
    }
    
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
