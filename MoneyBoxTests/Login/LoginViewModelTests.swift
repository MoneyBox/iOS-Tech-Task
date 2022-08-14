//
//  LoginViewModelTests.swift
//  MoneyBoxTests
//
//  Created by Marc Jardine Esperas on 8/17/22.
//

import XCTest
@testable import MoneyBox
@testable import Networking

class LoginViewModelTests: XCTestCase {
    
    private var dataProviderMock: DataProviderMock!
    private var sut: LoginViewModel!
    
    override func setUpWithError() throws {
        dataProviderMock = DataProviderMock()
        
        sut = LoginViewModel(dataProvider: dataProviderMock)
        
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        dataProviderMock = nil
        sut = nil
        
        try super.setUpWithError()
    }

    func testLoginViewModel_Login_ShouldShowSuccessfulResponse() {
        let loginExpectation = self.expectation(description: "Login Web Service Successful Response Expectation")

        sut.login { result in
            if case .success(let response) = result {
                XCTAssertEqual(response.user.firstName, "Michael")
                XCTAssertEqual(response.user.lastName, "Jordan")
                XCTAssertEqual(response.session.bearerToken, "GuQfJPpjUyJH10Og+hS9c0ttz4q2ZoOnEQBSBP2eAEs=")
                loginExpectation.fulfill()
            }
            
        }
        
        self.wait(for: [loginExpectation], timeout: 2)
    }
}
