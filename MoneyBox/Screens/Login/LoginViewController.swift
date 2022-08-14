//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import UIKit
import Reusable

protocol LoginViewControllerProtocol {
    func goToProductsViewController(with viewModel: ProductsViewModel)
}

final class LoginViewController: UIViewController, ViewModelBased {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        prefilledTextField()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // Prefilled View Model email and password for easier demo
    private func prefilledTextField() {
        let email = emailTextField.text
        let password = passwordTextField.text
        viewModel.email = email
        viewModel.password = password
    }
    
    private func setupUI() {
        hideNavigationbar()
        
        loginButton.addShadow()
        loginButton.addCornerRadius()
    }
    
    private func login() {
        ActivityIndicator.start(for: view)
        viewModel.login { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    let viewModel: ProductsViewModel = ProductsViewModel(user: result.user)
                    self?.goToProductsViewController(with: viewModel)
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription)
                }
            }
            ActivityIndicator.stop()
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        login()
    }
    
    @IBAction func emailTextFieldDidChange(_ sender: UITextField) {
        let email = sender.text
        viewModel.email = email
    }
    
    @IBAction func passwordTextFieldDidChange(_ sender: UITextField) {
        let password = sender.text
        viewModel.password = password
    }
}

// MARK: - StoryboardSceneBased
extension LoginViewController: StoryboardSceneBased {
    public static var sceneStoryboard: UIStoryboard {
        UIStoryboard(name: "Login", bundle: nil)
    }
}

// MARK: - Navigation
extension LoginViewController: LoginViewControllerProtocol {
    func goToProductsViewController(with viewModel: ProductsViewModel) {
        let viewController = ProductsViewController.instantiate(with: viewModel)
        navigationController?.pushViewController(viewController, animated: false)
    }
}
