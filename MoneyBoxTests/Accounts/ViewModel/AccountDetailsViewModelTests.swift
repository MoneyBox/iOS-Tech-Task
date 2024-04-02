//
//  AccountDetailsViewModelTests.swift
//  MoneyBoxTests
//
//  Created by Daniel Murphy on 02/04/2024.
//

import XCTest
@testable import MoneyBox

final class AccountDetailsViewModelTests: XCTestCase {
    var target: AccountDetailsViewModel!

    func testShouldReturnSuccessOnApiSuccess() throws {
        let dataProvider = SuccessDataProvider()
        target = AccountDetailsViewModel(dataProvider: dataProvider, account: dataProvider.mockAccountResponse.productResponses?.first)
        
        target.addMoneyToAccount() { response in
            switch response {
            case .success: XCTAssert(true)
            case .failure: XCTFail("failure returned despite successful api call")
            }
        }
    }
    
    func testShouldReturnFailureOnApiFailure() throws {
        let dataProvider = FailureDataProvider()
        target = AccountDetailsViewModel(dataProvider: dataProvider, account: dataProvider.mockAccountResponse.productResponses?.first)
        
        target.addMoneyToAccount() { response in
            switch response {
            case .success: XCTFail("success returned despite failing api call")
            case .failure: XCTAssert(true)
            }
        }
    }
}
