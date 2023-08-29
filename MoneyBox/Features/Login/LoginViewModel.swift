//
//  LoginViewModel.swift
//  MoneyBox
//
//  Created by George Woodham on 25/08/23.
//

import Combine
import Foundation
import Networking

final class LoginViewModel: ObservableObject {
    
    enum State: Equatable {
        case idle
        case loading
        case loggedIn
        case error(message: String)
    }
    
    var title = "Login"
    @Published var email = ""
    @Published var password = ""
    @Published var state: State
    
    let dataProvider: DataProviderLogic
    
    init(dataProvider: DataProviderLogic = DataProvider()) {
        self.dataProvider = dataProvider
        self.state = .idle
    }
    
    func login() {
        state = .loading
        
        let loginRequest = LoginRequest(
            email: email,
            password: password
        )
        
        dataProvider.login(request: loginRequest) { [weak self] result in
            switch result {
            case .success(let response):
                SessionManager().setUserToken(response.session.bearerToken)
                self?.state = .loggedIn
            case .failure(let error):
                self?.state = .error(message: error.localizedDescription)
            }
        }
    }
}
