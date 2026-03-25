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
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showProfile(){
        let vc = ProfileViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
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
