//
//  profileCoordinator.swift
//  DormMarket
//
//  Created by kubmakk on 25.03.2026.
//
import UIKit

class ProfileCoordinator: Coordinator {

    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: MainCoordinator?

    var logoutStatus: ((Bool) -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showMainFlow()
    }

    func showMainFlow() {
        let vc = ProfileViewController()
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: true)
    }

    func onLogout() {
        self.logoutStatus?(true)
    }
}
