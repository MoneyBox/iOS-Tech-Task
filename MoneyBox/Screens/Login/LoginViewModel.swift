//
//  LoginViewModel.swift
//  MoneyBox
//
//  Created by Marc Jardine Esperas on 8/16/22.
//

import Foundation
import Networking

protocol LoginViewModelProtocol {
    func login(completion: @escaping (Result<LoginResponse, Error>) -> Void)
}

class LoginViewModel: LoginViewModelProtocol {
    private let dataProvider: DataProviderLogic
    var email: String? = ""
    var password: String? = ""
    
    init(dataProvider: DataProviderLogic = DataProvider()) {
        self.dataProvider = dataProvider
    }
    
    public func login(completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        guard let email = email,
              let password = password else {
            return
        }
        
        let loginRequest = LoginRequest(email: email,
                                        password: password)
        dataProvider.login(request: loginRequest) { result in
            switch result {
            case .success(let response):
                response.saveToken()
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
