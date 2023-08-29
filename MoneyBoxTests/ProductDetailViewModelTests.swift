//
//  ProductDetailViewModelTests.swift
//  MoneyBoxTests
//
//  Created by George Woodham on 25/08/23.
//

import Foundation
@testable import MoneyBox
import XCTest

class ProductDetailsViewModelTests: XCTestCase {
    
    func testAmountUpdates_WhenAddingMoneyToMoneyBox() {
        // Setup
        let viewModel = ProductDetailViewModel(
            product: .testInstance(),
            dataProvider: StubDataProvider()
        )
        
        // Run
        viewModel.addMoney()
        
        // Verify
        XCTAssertEqual(viewModel.product.moneybox, 10930.0)
    }
}

private extension ProductEntity {
    static func testInstance() -> Self {
        self.init(
            id: 1,
            name: "",
            planValue: 500,
            moneybox: 100
        )
    }
}
