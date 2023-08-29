//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import Combine
import CombineCocoa
import MoneyBoxUI
import UIKit

class LoginViewController: UIViewController {

    private let viewModel: LoginViewModel
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel 
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = UIColor(named: "GreyColor")
        
        createLayout()
        setupBindings()
    }
    
    private lazy var emailTextField = EmailsTextField()
    
    private lazy var passwordTextField = PasswordTextField()
    
    private lazy var loginButton: MBButton = {
        let button = MBButton(style: .primary)
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    private lazy var autoFillButton: MBButton = {
        let button = MBButton(style: .secondary)
        button.setTitle("Auto fill", for: .normal)
        return button
    }()
    
    private func createLayout() {
        
        let vstack = UIStackView()
        vstack.axis = .vertical
        vstack.alignment = .fill
        vstack.distribution = .fill
        vstack.spacing = Theme.Constants.padding
        vstack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vstack)
        
        NSLayoutConstraint.activate([
            vstack.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Theme.Constants.padding
            ),
            vstack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Theme.Constants.padding
            ),
            vstack.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            )
        ])
        
        [emailTextField,
         passwordTextField,
         loginButton,
         autoFillButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            vstack.addArrangedSubview($0)
        }
    }
    
    private func setupBindings() {

        // Binding View to ViewModel
        emailTextField.textPublisher
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .removeDuplicates()
            .assign(to: \.email, on: viewModel)
            .store(in: &bindings)
        
        passwordTextField.textPublisher
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .removeDuplicates()
            .assign(to: \.password, on: viewModel)
            .store(in: &bindings)
        
        loginButton.tapPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.viewModel.login()
            }
            .store(in: &bindings)
        
        autoFillButton.tapPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.autoFillLogin()
            }
            .store(in: &bindings)
        
        viewModel.$state
            .sink { [weak self] state in
                switch state {
                case .idle, .loading:
                    break
                case .error(let message):
                    self?.presentError(message)
                case .loggedIn:
                    self?.navigateToProductList()
                }
            }
            .store(in: &bindings)
        
    }
    
    private func presentError(_ message: String) {
        let alert = UIAlertController(
            title: "Uh oh!",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    private func navigateToProductList() {
        let destination = ProductListViewController(viewModel: .init())
        navigationController?.pushViewController(destination, animated: true)
    }

}

/*
 Auto-fill login for project simplicity
 */
extension LoginViewController {
    
    @objc
    func autoFillLogin() {
        emailTextField.text = "test+ios2@moneyboxapp.com"
        passwordTextField.text = "P455word12"
        emailTextField.sendActions(for: .valueChanged)
        passwordTextField.sendActions(for: .valueChanged)
    }
    
}
