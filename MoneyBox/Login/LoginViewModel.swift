//
//  LoginViewModel.swift
//  MoneyBox
//
//  Created by David Gray on 01/09/2023.
//

import Combine
import Foundation
import Networking

enum LoginState {
    case ready
    case loading
    case success
    case error([Error])
}

final class LoginViewModel {
    
    // MARK: - Properties
    private var cancellables: Set<AnyCancellable> = []
    private let networkService: DataProviderLogic
    private let networkSession: SessionManager = SessionManager()

    // MARK: - Coordinator Closures
    var loginAction: ((String) -> Void)?
    
    // Exposed API
    public var emailFieldText: CurrentValueSubject<String, Never> = .init("")
    public var passwordFieldText: CurrentValueSubject<String, Never> = .init("")
    public var loginButtonEnabled: CurrentValueSubject<Bool, Never> = .init(false)
    public var state: CurrentValueSubject<LoginState, Never> = .init(.ready)
    
    // MARK: - Init
    init(networkService: DataProviderLogic) {
        self.networkService = networkService
        subscribe()
    }
    
    // MARK: Subscription Logic
    private func subscribe() {
        emailFieldText.combineLatest(passwordFieldText).sink { [weak self] (email, password) in
            
            guard !email.isEmpty && !password.isEmpty else {
                self?.loginButtonEnabled.send(false)
                return
            }
            
            self?.loginButtonEnabled.send(true)
        }
        .store(in: &cancellables)
    }
    
    // MARK: - Exposed Functions
    func loginTapped() {
        // Set state to loading to lock UI.
        state.value = .loading
        
        // Create request
        let loginRequest = LoginRequest(email: emailFieldText.value, password: passwordFieldText.value)
        
        networkService.login(request: loginRequest) { [weak self] result in
            switch result {
            case .success(let loginResponse):
                print("🐸 Auth succeeded", loginResponse)
                self?.networkSession.setUserToken(loginResponse.session.bearerToken)
                
                self?.networkService.fetchProducts { result in
                    switch result {
                    case .success(let account):
                        print("🐶", account)
                    case .failure(let error):
                        print("🥶", error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                print("😡 Auth failed", error.localizedDescription)
            }
        }
        
        // 1. Create network request
        // 2. Call network service with request
        // 3. Wait for response (update UI)
        // 4. Either log user in and communicate to coordinator OR present error message
    }
}
