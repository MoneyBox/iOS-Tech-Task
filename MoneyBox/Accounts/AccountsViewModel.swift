//
//  AccountsViewModel.swift
//  MoneyBox
//
//  Created by David Gray on 03/09/2023.
//

import Networking

final class AccountsViewModel {
    
    // MARK: - Properties
    private let dataProvider: DataProviderLogic
    
    
    // MARK: - Init
    init(dataProvider: DataProviderLogic) {
        self.dataProvider = dataProvider
    }
    
}
