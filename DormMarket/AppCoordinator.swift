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
    var userIsLoggedIn: Bool = true

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
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func showProfile(){
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        
        profileCoordinator.LogoutStatus = {[weak self] _ in
            self?.childDidFinish(profileCoordinator)
        }
        
        childCoordinators.append(profileCoordinator)
        profileCoordinator.start()
    }
    
    func showLoginVC(){
        let vc = LoginViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showSignUpVC(){
        let vc = SignUpViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
