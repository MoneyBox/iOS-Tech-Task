//
//  AccountDetailsViewModel.swift
//  MoneyBox
//
//  Created by Daniel Murphy on 02/04/2024.
//

import Foundation
import Networking

class AccountDetailsViewModel {
    let dataProvider: DataProvider
    let account: ProductResponse?

    init(dataProvider: DataProvider = DataProvider(), account: ProductResponse? = nil) {
        self.dataProvider = dataProvider
        self.account = account
    }

    func addMoneyToAccount(updateUiHook: @escaping (Result<OneOffPaymentResponse, Error>) -> Void) {
        guard let id = account?.id else {
            return
        }

        let request = OneOffPaymentRequest(amount: 10, investorProductID: id)

        dataProvider.addMoney(request: request) { response in
            updateUiHook(response)
        }
    }
}
