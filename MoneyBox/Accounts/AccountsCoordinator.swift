//
//  AccountsCoordinator.swift
//  MoneyBox
//
//  Created by David Gray on 03/09/2023.
//

import Networking
import UIKit

final class AccountsCoordinator: Coordinator {
    
    // MARK: - Properties
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let dataProvider: DataProviderLogic
    private let user: Networking.LoginResponse.User
    
    
    // MARK: - Init
    init(navigationController: UINavigationController, dataProvider: DataProviderLogic, user: Networking.LoginResponse.User) {
        self.navigationController = navigationController
        self.dataProvider = dataProvider
        self.user = user
    }
    
    func start() {
        let accountsViewModel = AccountsViewModel(dataProvider: dataProvider)
        let viewController = AccountsViewController(accountsViewModel: accountsViewModel)
        
        DispatchQueue.main.async {
            self.navigationController.setViewControllers([viewController], animated: false)
        }
    }
    
}
