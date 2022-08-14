//
//  DataProviderMock.swift
//  
//
//  Created by Marc Jardine Esperas on 8/17/22.
//

import XCTest
@testable import MoneyBox
@testable import Networking

class DataProviderMock: DataProviderLogic {
    public func login(request: LoginRequest, completion: @escaping ((Result<LoginResponse, Error>) -> Void)) {
        StubData.read(file: "LoginSucceed", callback: completion)
    }
    
    public func fetchProducts(completion: @escaping ((Result<AccountResponse, Error>) -> Void)) {
        StubData.read(file: "Accounts", callback: completion)
    }
    
    func addMoney(request: OneOffPaymentRequest, completion: @escaping ((Result<OneOffPaymentResponse, Error>) -> Void)) {
        StubData.read(file: "Addmoney", callback: completion)
    }
}
