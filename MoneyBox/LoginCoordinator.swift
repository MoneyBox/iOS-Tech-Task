//
//  LoginCoordinator.swift
//  MoneyBox
//
//  Created by David Gray on 02/09/2023.
//

import Networking
import UIKit

final class LoginCoordinator: Coordinator {
    
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private var networkService: DataProviderLogic
    
    var userLoggedIn: ((String) -> Void)?
 
    // MARK: - Init
    init(navigationController: UINavigationController, networkService: DataProviderLogic) {
        self.navigationController = navigationController
        self.networkService = networkService
    }
    
    func start() {
        let viewModel = LoginViewModel(networkService: networkService)
        
        viewModel.loginAction = { [weak self] user in
            self?.navigateToAccounts(user: user)
        }
        
        let viewController = LoginViewController(loginViewModel:
        viewModel)

        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func navigateToAccounts(user: String) {
        userLoggedIn?(user)
    }
    
}
