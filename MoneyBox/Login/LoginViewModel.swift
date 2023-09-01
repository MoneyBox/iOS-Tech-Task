//
//  LoginViewModel.swift
//  MoneyBox
//
//  Created by David Gray on 01/09/2023.
//

import Combine
import Foundation

final class LoginViewModel {
    
    // MARK: - Properties
    private var cancellables: Set<AnyCancellable> = []
    
    // Exposed API
    public var emailFieldText: CurrentValueSubject<String, Never> = .init("")
    public var passwordFieldText: CurrentValueSubject<String, Never> = .init("")
    public var loginButtonEnabled: CurrentValueSubject<Bool, Never> = .init(false)
    
    // MARK: - Init
    init() {
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
}
