//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import Combine
import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: LoginViewModel
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: UI Properties
    lazy var emailTextField: UITextField = {
        let textField = PaddedTextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.placeholder = "Email Address"
        textField.textContentType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = PaddedTextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.placeholder = "Password"
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.delegate = self
        return textField
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOGIN", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.12, green: 0.82, blue: 0.63, alpha: 1.0)
        button.layer.cornerCurve = .continuous
        button.layer.cornerRadius = 9
        button.setTitleColor(.gray, for: .selected)
        return button
    }()
    
    // MARK: - Init
    init(loginViewModel: LoginViewModel) {
        self.viewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(named: "background_color")
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        
        subscribe()
        
        layoutViews()
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            // MARK: Email Field Constraints
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // MARK: Password Field Constraints
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // MARK: Login Button Constraints
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: Subscription Logic
    private func subscribe() {
        viewModel.loginButtonEnabled
            .receive(on: DispatchQueue.main)
            .sink { enabled in
                self.loginButton.isEnabled = enabled
                self.loginButton.backgroundColor = enabled ? UIColor(red: 0.12, green: 0.82, blue: 0.63, alpha: 1.0) : .systemGray
            }
            .store(in: &cancellables)
        
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    // Having to use delegate instead of publisher updates
    // as publisher will not return per character change.
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField === emailTextField {
            viewModel.emailFieldText.send(textField.text ?? "")
        } else if textField === passwordTextField {
            viewModel.passwordFieldText.send(textField.text ?? "")
        } else {
            print("⚠️ Unknown text field change...")
        }
        
    }
}
