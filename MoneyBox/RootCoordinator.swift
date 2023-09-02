//
//  RootCoordinator.swift
//  MoneyBox
//
//  Created by David Gray on 02/09/2023.
//

import Networking
import UIKit

final class RootCoordinator: Coordinator {
    
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var networkService: DataProviderLogic
    
    private var isLoggedIn = false // This would perform some auth checks in a full app
    
    // MARK: - Init
    init(navigationController: UINavigationController, networkService: DataProviderLogic) {
        self.navigationController = navigationController
        self.networkService = networkService
    }
    
    func start() {
        if isLoggedIn {
            // Go to Accounts page OR Show quick pin page
        } else {
            // Go to Login page
            let loginCoordinator = LoginCoordinator(navigationController: navigationController, networkService: networkService)
            
            loginCoordinator.start()
            
            
            
            
//            let viewController = LoginViewController(loginViewModel: LoginViewModel(networkService: networkService))
//            navigationController.pushViewController(viewController, animated: false)
        }
    }
    
}
