//
//  ProductsViewModel.swift
//  MoneyBox
//
//  Created by Marc Jardine Esperas on 8/16/22.
//

import Foundation
import Networking

protocol ProductsViewModelProtocol {
    func fetchProducts(completion: @escaping (Result<Void, Error>) -> Void)
}

class ProductsViewModel: ProductsViewModelProtocol {
    private let dataProvider: DataProviderLogic
    private let user: LoginResponse.User
    
    private var account: AccountResponse?
    private var products: [ProductResponse] = []
    
    init(dataProvider: DataProviderLogic = DataProvider(), user: LoginResponse.User) {
        self.dataProvider = dataProvider
        self.user = user
    }
    
    public func accountHoldersName() -> String {
        return user.firstName ?? ""
    }
    
    public func totalPlanValueAmount() -> Double? {
        return account?.totalPlanValue
    }
    
    public func numberOfItems(in section: Int) -> Int {
        return products.count
    }
    
    public func product(at index: Int) -> ProductResponse {
        return products[index]
    }
    
    func fetchProducts(completion: @escaping (Result<Void, Error>) -> Void) {
        dataProvider.fetchProducts { [weak self] result in
            switch result {
            case .success(let products):
                self?.account = products
                self?.products = products.productResponses ?? []
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
