//
//  AppCoordinator.swift
//  DormMarket
//
//  Created by kubmakk on 18/2/26.
//

import UIKit

protocol Coordinator{
    var navigationController: UINavigationController { get set }
    func start()
}

// Main Coordinator to be open App
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showProfile(){
        let vc = ProfileViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
