//
//  ProductDetailsViewModel.swift
//  MoneyBox
//
//  Created by Marc Jardine Esperas on 8/16/22.
//

import Foundation
import Networking

protocol ProductDetailsViewModelProtocol {
    func addMoney(completion: @escaping (Result<Void, Error>) -> Void)
}

class ProductDetailsViewModel {
    private let dataProvider: DataProviderLogic
    private var product: ProductResponse
    private var moneyboxResponse: Double?
    
    init(dataProvider: DataProviderLogic = DataProvider(),
         product: ProductResponse) {
        self.dataProvider = dataProvider
        self.product = product
    }
    
    func productName() -> String {
        return product.product?.name ?? ""
    }
    
    func planValueAmount() -> String {
        guard let planValue = product.planValue else {
            return ""
        }
        
        return "£\(String(format: "%.2f", planValue))"
    }
    
    func moneyboxAmount() -> String {
        guard let moneybox = product.moneybox else {
            return ""
        }
        
        if let moneyboxResponse = moneyboxResponse {
            return "£\(String(format: "%.2f", moneyboxResponse))"
        }
        
        return "£\(String(format: "%.2f", moneybox))"
    }
    
    func addMoney(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let productId = product.id else {
            return
        }
        
        let request: OneOffPaymentRequest = OneOffPaymentRequest(amount: 10, investorProductID: productId)
        dataProvider.addMoney(request: request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.moneyboxResponse = response.moneybox
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
