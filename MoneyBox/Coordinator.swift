//
//  Coordinator.swift
//  MoneyBox
//
//  Created by David Gray on 02/09/2023.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
