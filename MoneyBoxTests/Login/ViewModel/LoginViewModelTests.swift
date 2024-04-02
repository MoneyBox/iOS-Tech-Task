//
//  LoginViewModelTests.swift
//  MoneyBoxTests
//
//  Created by Daniel Murphy on 02/04/2024.
//

import XCTest
@testable import MoneyBox

final class LoginViewModelTests: XCTestCase {
    var target: LoginViewModel!
    
    func testShouldReturnInvalidEmailErrorForInvalidEmail() throws {
        let dataProvider = SuccessDataProvider()
        target = LoginViewModel(dataProvider: dataProvider)
        
        target.login(email: "invalid", password: "password") { result in
            switch result {
            case .success: XCTFail("email validation failed")
            case .failure(let error): 
                XCTAssertEqual(error.alertTitle, LoginAttemptResponseError.invalidEmail.alertTitle)
                XCTAssertEqual(error.alertDescription, LoginAttemptResponseError.invalidEmail.alertDescription)
            }
        }
    }
    
    func testShouldReturnInvalidPasswordErrorForInvalidPassword() throws {
        let dataProvider = SuccessDataProvider()
        target = LoginViewModel(dataProvider: dataProvider)
        
        target.login(email: "valid@email.com", password: "p") { result in
            switch result {
            case .success: XCTFail("email validation failed")
            case .failure(let error): 
                XCTAssertEqual(error.alertTitle, LoginAttemptResponseError.invalidPassword.alertTitle)
                XCTAssertEqual(error.alertDescription, LoginAttemptResponseError.invalidPassword.alertDescription)
            }
        }
    }
    
    func testShouldReturnApiErrorForApiError() throws {
        let dataProvider = FailureDataProvider()
        target = LoginViewModel(dataProvider: dataProvider)
        
        target.login(email: "valid@email.com", password: "password") { result in
            switch result {
            case .success: XCTFail("email validation failed")
            case .failure(let error):
                XCTAssertEqual(error.alertTitle, LoginAttemptResponseError.apiError(FailureDataProviderError.loginError).alertTitle)
                XCTAssertEqual(error.alertDescription, LoginAttemptResponseError.apiError(FailureDataProviderError.loginError).alertDescription)
            }
        }
    }
    
    func testShouldReturnSuccessOnAllValidationPassed() throws {
        let dataProvider = SuccessDataProvider()
        target = LoginViewModel(dataProvider: dataProvider)
        
        target.login(email: "valid@email.com", password: "password") { result in
            switch result {
            case .success: XCTAssert(true)
            case .failure: XCTFail("login validation failed")
            }
        }
    }
    
    func testShouldReturnUserInCallbackOnAllValidationPassed() throws {
        let dataProvider = SuccessDataProvider()
        target = LoginViewModel(dataProvider: dataProvider)
        
        target.login(email: "valid@email.com", password: "password") { result in
            switch result {
            case .success(let user): XCTAssertNotNil(user)
            case .failure: XCTFail("login validation failed")
            }
        }
    }
}
