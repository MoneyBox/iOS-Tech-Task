//
//  ProductDetailViewModel.swift
//  MoneyBox
//
//  Created by George Woodham on 25/08/23.
//

import Foundation
import MoneyBoxUI
import Networking

final class ProductDetailViewModel: ObservableObject {
        
    @Published var product: ProductEntity
    
    let dataProvider: DataProviderLogic
        
    init(
        product: ProductEntity,
        dataProvider: DataProviderLogic = DataProvider()
    ) {
        self.product = product
        self.dataProvider = dataProvider
    }
    
    func addMoney() {
        let request = OneOffPaymentRequest(
            amount: 10,
            investorProductID: product.id!
        )
        dataProvider.addMoney(request: request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.product.moneybox = response.moneybox
            case .failure:
                break
            }
        }
    }
}
