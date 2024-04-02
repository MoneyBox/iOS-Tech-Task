//
//  MockDataProvider.swift
//  MoneyBoxTests
//
//  Created by Daniel Murphy on 02/04/2024.
//

import Foundation
import Networking

class SuccessDataProvider: DataProviderLogic {
    public let mockLoginResponse = LoginResponse(
        session: LoginResponse.Session(bearerToken: "mockBearerToken"),
        user: LoginResponse.User(firstName: "John", lastName: "Doe")
    )

    public let mockAccountResponse = AccountResponse(totalPlanValue: 100.0, productResponses: [ProductResponse(id: 123)])

    public let mockOneOffPaymentResponse = OneOffPaymentResponse()

    func login(request _: LoginRequest, completion: @escaping ((Result<LoginResponse, Error>) -> Void)) {
        completion(.success(mockLoginResponse))
    }

    func fetchProducts(completion: @escaping ((Result<AccountResponse, Error>) -> Void)) {
        completion(.success(mockAccountResponse))
    }

    func addMoney(request _: OneOffPaymentRequest, completion: @escaping ((Result<OneOffPaymentResponse, Error>) -> Void)) {
        completion(.success(mockOneOffPaymentResponse))
    }
}

enum FailureDataProviderError: Error {
    case loginError, fetchError, addMoneyError
}

class FailureDataProvider: DataProviderLogic {
    public let mockLoginResponse = LoginResponse(
        session: LoginResponse.Session(bearerToken: "mockBearerToken"),
        user: LoginResponse.User(firstName: "John", lastName: "Doe")
    )

    public let mockAccountResponse = AccountResponse(totalPlanValue: 100.0, productResponses: [ProductResponse(id: 123)])

    public let mockOneOffPaymentResponse = OneOffPaymentResponse()

    func login(request _: LoginRequest, completion: @escaping ((Result<LoginResponse, Error>) -> Void)) {
        completion(.failure(FailureDataProviderError.loginError))
    }

    func fetchProducts(completion: @escaping ((Result<AccountResponse, Error>) -> Void)) {
        completion(.failure(FailureDataProviderError.fetchError))
    }

    func addMoney(request _: OneOffPaymentRequest, completion: @escaping ((Result<OneOffPaymentResponse, Error>) -> Void)) {
        completion(.failure(FailureDataProviderError.addMoneyError))
    }
}
