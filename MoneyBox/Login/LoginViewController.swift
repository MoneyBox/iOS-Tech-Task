//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    let viewModel: LoginViewModel = .init()

    let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 150
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let moneyboxLogo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "moneybox"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none

        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing

        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.adjustsFontForContentSizeCategory = true
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.accessibilityHint = "Enter Email Address"
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true

        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing

        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.adjustsFontForContentSizeCategory = true
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.accessibilityHint = "Enter Password Text Input"
        return textField
    }()

    let formStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)

        button.backgroundColor = UIColor(resource: .accent)
        button.layer.cornerRadius = 8

        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false

        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.accessibilityHint = "Login Button"
        return button
    }()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        emailTextField.delegate = self
        passwordTextField.delegate = self

        setupViews()

        #if DEBUG
            emailTextField.text = "test+ios@moneyboxapp.com"
            passwordTextField.text = "P455word12"
        #endif
    }

    // MARK: - Private Methods

    private func setupViews() {
        formStack.addArrangedSubview(emailTextField)
        formStack.addArrangedSubview(passwordTextField)
        formStack.addArrangedSubview(loginButton)

        mainStack.addArrangedSubview(moneyboxLogo)
        mainStack.addArrangedSubview(formStack)

        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .defaultLeadingContstraint),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: .defaultTrailingContstraint),

            emailTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            passwordTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            loginButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
        ])
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            login()
        }

        return true
    }

    @objc private func loginButtonTapped() {
        login()
    }

    private func login() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            viewModel.login(email: email, password: password) { response in
                switch response {
                case .success: self.handleSuccessfulLogin()
                case let .failure(error): self.handleFailedLogin(with: error)
                }
            }
        }
    }

    private func handleSuccessfulLogin() {
        let viewModel = AccountsViewModel(user: viewModel.user)
        let viewController = AccountsViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func handleFailedLogin(with error: LoginAttemptResponseError) {
        let alertController = UIAlertController(title: error.alertTitle, message: error.alertDescription, preferredStyle: .alert)

        alertController.addAction(
            UIAlertAction(title: "OK", style: .cancel) { _ in
                switch error {
                case .invalidEmail:
                    self.emailTextField.text = ""
                    self.emailTextField.becomeFirstResponder()
                case .invalidPassword:
                    self.passwordTextField.text = ""
                    self.passwordTextField.becomeFirstResponder()
                default: break
                }
            }
        )

        present(alertController, animated: true, completion: nil)
    }
}
