//
//  ProductsViewModelTests.swift
//  MoneyBoxTests
//
//  Created by Marc Jardine Esperas on 8/17/22.
//

import XCTest
@testable import MoneyBox
@testable import Networking

class ProductsViewModelTests: XCTestCase {
    
    private var dataProviderMock: DataProviderMock!
    private var sut: ProductsViewModel!
    private var user: LoginResponse.User!

    override func setUpWithError() throws {
        dataProviderMock = DataProviderMock()
        user = LoginResponse.User(firstName: "Michael", lastName: "Jordan")
        sut = ProductsViewModel(dataProvider: dataProviderMock, user: user)
        
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        dataProviderMock = nil
        sut = nil
        
        try super.setUpWithError()
    }

    func testProductsViewModelTests_FetchProducts_ShouldShowSuccessfulResponse() {
        let loginExpectation = self.expectation(description: "Fetch Products Web Service Successful Response Expectation")

        sut.fetchProducts { result in
            if case .success(_) = result {
                loginExpectation.fulfill()
            }
        }
        
        self.wait(for: [loginExpectation], timeout: 2)
    }
}
