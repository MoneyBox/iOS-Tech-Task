//
//  ProductListViewModelTests.swift
//  MoneyBoxTests
//
//  Created by George Woodham on 25/08/23.
//

import Foundation
@testable import MoneyBox
import XCTest

class ProductListViewModelTests: XCTestCase {
        
    func testTitle_IsProducts() {
        // Setup
        let viewModel = ProductListViewModel()
        
        // Verify
        XCTAssertEqual(viewModel.title, "Products")
        
    }
    
    func testInitialState_IsLoading () {
        // Setup
        let viewModel = ProductListViewModel(dataProvider: StubDataProvider())

        // Verify
        XCTAssertEqual(viewModel.state, .loading)
    }
    
    func testStateChanges_ToLoaded_GivenSuccessfullResponse() {
        // Setup
        let viewModel = ProductListViewModel(dataProvider: StubDataProvider())
        
        // Run
        viewModel.fetchProducts()
        
        // Verify
        guard case .loaded = viewModel.state else {
            XCTFail("Expected case .loaded, got: \(viewModel.state)")
            return
        }
    }
    
    func testStateChanges_ToError_GivenErrorResponse() {
        // Setup
        let stubDataProvider = StubDataProvider()
        stubDataProvider.forceError = true
        let viewModel = ProductListViewModel(dataProvider: stubDataProvider)

        // Run
        viewModel.fetchProducts()

        // Verify
        XCTAssertEqual(viewModel.state, .error(message: "Forced stub error"))
    }
}
