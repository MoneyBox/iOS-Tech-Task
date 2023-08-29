//
//  PreviewDataProvider.swift
//  MoneyBox
//
//  Created by George Woodham on 25/08/23.
//

import Foundation
import Networking

#if DEBUG
class PreviewDataProvider: DataProviderLogic {
    
    func login(request: Networking.LoginRequest, completion: @escaping ((Result<Networking.LoginResponse, Error>) -> Void)) {
        StubData.read(file: "LoginSucceed", callback: completion)
    }
    
    func fetchProducts(completion: @escaping ((Result<Networking.AccountResponse, Error>) -> Void)) {
        StubData.read(file: "Accounts", callback: completion)
    }
    
    func addMoney(request: Networking.OneOffPaymentRequest, completion: @escaping ((Result<Networking.OneOffPaymentResponse, Error>) -> Void)) {
        fatalError("Not implemented.")
    }
}

private struct StubData {
    static func read<V: Decodable>(file: String, callback: @escaping (Result<V, Error>) -> Void) {
        if let path = Bundle.main.path(forResource: file, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try JSONDecoder().decode(V.self, from: data)
                callback(.success(result))
            } catch {
                callback(.failure(NSError.error(with: "stub decoding error")))
            }
        } else {
            callback(.failure(NSError.error(with: "no json file")))
        }
    }
}
#endif
