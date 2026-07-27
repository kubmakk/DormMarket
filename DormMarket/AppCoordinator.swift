//
//  AppCoordinator.swift
//  DormMarket
//
//  Created by kubmakk on 18/2/26.
//

import UIKit
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()

}

// Main Coordinator to be open App
class MainCoordinator: Coordinator {
    var userIsLoggedIn: Bool = UserSettings.shared.isLogin

    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if userIsLoggedIn {
        showProfile()
        } else {
        showLoginVC()
        }
    }

    func childDidFinish(_ child: Coordinator?) {
        childCoordinators = childCoordinators.filter{ $0 !== child }
    }

    func showProfile() {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        profileCoordinator.parentCoordinator = self

        profileCoordinator.logoutStatus = {[weak self] _ in
            guard let self = self else {return}

            self.childDidFinish(profileCoordinator)
            self.showLoginVC()
        }

        childCoordinators.append(profileCoordinator)
        profileCoordinator.start()
    }

    func showLoginVC() {
        let vc = LoginViewController()
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }

    func showSignUpVC() {
        let vc = SignUpViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
