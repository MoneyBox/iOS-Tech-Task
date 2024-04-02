//
//  AccountsViewModelTests.swift
//  MoneyBoxTests
//
//  Created by Daniel Murphy on 02/04/2024.
//

import XCTest
import Networking
@testable import MoneyBox

final class AccountsViewModelTests: XCTestCase {
    var target: AccountsViewModel!

    func shouldSetAccountResponseOnSuccess() throws {
        let dataProvider = SuccessDataProvider()
        target = AccountsViewModel(dataProvider: dataProvider)
        
        target.fetchAccountDetails()
        
        XCTAssertNotNil(target.accountResponse)
    }
    
    func shouldNotSetAccountResponseOnFailure() throws {
        let dataProvider = FailureDataProvider()
        target = AccountsViewModel(dataProvider: dataProvider)
        
        target.fetchAccountDetails()
        
        XCTAssertNil(target.accountResponse)
    }

    func shouldFormatAccountResponseValueCorrectlyWhenValueExists() throws {
        let dataProvider = SuccessDataProvider()
        target = AccountsViewModel(dataProvider: dataProvider)
        target.fetchAccountDetails()
        
        let result = target.getFormattedTotalPlanValue()
        
        XCTAssertEqual(result, "£100.00")
    }
    
    func shouldFormatAccountResponseValueCorrectlyWhenValueNil() throws {
        let dataProvider = FailureDataProvider()
        target = AccountsViewModel(dataProvider: dataProvider)
        target.fetchAccountDetails()
        
        let result = target.getFormattedTotalPlanValue()
        
        XCTAssertEqual(result, "£--.--")
    }
}
