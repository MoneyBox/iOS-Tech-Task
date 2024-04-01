//
//  AccountsViewModel.swift
//  MoneyBox
//
//  Created by Daniel Murphy on 01/04/2024.
//

import Foundation
import Networking

enum FetchState {
    case notAttempted
    case fetching
    case fetched
    case error(Error)
}

class AccountsViewModel {
    let dataProvider: DataProvider

    var user: LoginResponse.User?
    var updateUiHook: ((FetchState) -> Void)?

    var accountResponse: AccountResponse?
    var fetchState: FetchState = .notAttempted {
        didSet {
            updateUiHook?(fetchState)
        }
    }

    init(dataProvider: DataProvider = DataProvider(), user: LoginResponse.User? = nil) {
        self.dataProvider = dataProvider
        self.user = user
    }

    func fetchAccountDetails() {
        fetchState = .fetching

        dataProvider.fetchProducts { response in
            switch response {
            case let .success(response): self.handleSuccessfulFetch(with: response)
            case let .failure(error): self.handleFailedFetch(with: error)
            }
        }
    }

    private func handleSuccessfulFetch(with response: AccountResponse) {
        accountResponse = response

        fetchState = .fetched
    }

    private func handleFailedFetch(with error: Error) {
        fetchState = .error(error)
    }
}
