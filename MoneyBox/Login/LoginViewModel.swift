//
//  LoginViewModel.swift
//  MoneyBox
//
//  Created by Daniel Murphy on 01/04/2024.
//

import Foundation
import Networking

enum LoginAttemptResponseError {
    case invalidEmail
    case invalidPassword
    case apiError(_ error: Error)

    var alertTitle: String {
        switch self {
        case .invalidEmail, .invalidPassword: "Invalid Input"
        case .apiError: "An Error Occurred"
        }
    }

    var alertDescription: String {
        switch self {
        case .invalidEmail:
            "Email is not in the correct format, please check again"
        case .invalidPassword:
            "Password did not match the length constraint"
        case let .apiError(error):
            error.localizedDescription
        }
    }
}

enum LoginAttemptResponse {
    case success
    case failure(_ error: LoginAttemptResponseError)
}

final class LoginViewModel {
    private let sessionManager: SessionManager
    private let dataProvider: DataProvider

    var user: LoginResponse.User?

    init(
        sessionManager: SessionManager = SessionManager(),
        dataProvider: DataProvider = DataProvider()
    ) {
        self.sessionManager = sessionManager
        self.dataProvider = dataProvider
    }

    func login(email: String, password: String, completionHandler: @escaping (LoginAttemptResponse) -> Void) {
        if !isValidEmail(email) {
            completionHandler(.failure(.invalidEmail))
            return
        }

        if !isValidPassword(password) {
            completionHandler(.failure(.invalidPassword))
            return
        }

        let request = LoginRequest(email: email, password: password)
        dataProvider.login(request: request) { result in
            let response = switch result {
            case let .success(success): self.handleSuccessfulLogin(for: success)
            case let .failure(failure): self.handleFailedLogin(with: failure)
            }

            completionHandler(response)
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        NSPredicate.emailRegEx.evaluate(with: email)
    }

    private func isValidPassword(_ password: String) -> Bool {
        password.count >= 4 // arbitrary password rule to show example case
    }

    private func handleSuccessfulLogin(for response: LoginResponse) -> LoginAttemptResponse {
        user = response.user
        sessionManager.setUserToken(response.session.bearerToken)

        return .success
    }

    private func handleFailedLogin(with error: Error) -> LoginAttemptResponse {
        .failure(.apiError(error))
    }
}
