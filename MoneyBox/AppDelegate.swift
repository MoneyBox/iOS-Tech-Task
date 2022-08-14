//
//  AppDelegate.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 15.01.2022.
//

import UIKit
import IQKeyboardManagerSwift
import Reusable

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureLoginViewController()
        
        // Setup KeyboardManager
        configureKeyboardManager()
    
        return true
    }
    
    func configureLoginViewController() {
        let viewModel = LoginViewModel()
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = LoginViewController.instantiate(with: viewModel)
        navigationController.viewControllers = [rootViewController]
        self.window?.rootViewController = navigationController
    }
    
    func configureKeyboardManager() {
        let keyboardManager = IQKeyboardManager.shared
        keyboardManager.enable = true
        keyboardManager.shouldResignOnTouchOutside = true
    }
    
}
