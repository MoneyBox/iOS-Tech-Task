//
//  LoginViewModelTests.swift
//  MoneyBoxTests
//
//  Created by David Gray on 03/09/2023.
//

import Combine
import Networking
import XCTest
@testable import MoneyBox


final class LoginViewModelTests: XCTestCase {
    
    // MARK: - Test Properties
    var cancellables: Set<AnyCancellable> = []
    
    
    func test_loginButtonEnabled() {
        // Mock Setup
        let loginButtonEnabledExpectation = expectation(description: "Excected loginButtonEnabled to be true!")
        
        // Given I have values in the email AND password text fields
        let sut = LoginViewModel(dataProvider: MockDataProvider())
        
        sut.loginButtonEnabled.dropFirst(2).sink { enabled in
            guard enabled else {
                XCTFail("Expected login button to be enabled!")
                return
            }
            loginButtonEnabledExpectation.fulfill()
            
        }.store(in: &cancellables)
        
        // When
        sut.emailFieldText.value = "example@moneyboxapp.com"
        sut.passwordFieldText.value = "12345"
        
        // Then
        waitForExpectations(timeout: 0.5)
    }
    
    func test_loginButtonDisabled_emptyEmailAndPassword() {
        // Mock Setup
        let loginButtonDisabledExpectation = expectation(description: "Excected loginButtonEnabled to be false!")
        
        // Given
        let sut = LoginViewModel(dataProvider: MockDataProvider())
        
        sut.loginButtonEnabled.dropFirst(2).sink { enabled in
            guard enabled == false else {
                XCTFail("Expected login button to be disabled!")
                return
            }
            loginButtonDisabledExpectation.fulfill()
            
        }.store(in: &cancellables)
        
        // WhenI have no value in the email AND password fields
        sut.emailFieldText.value = ""
        sut.passwordFieldText.value = ""
        
        // Then
        waitForExpectations(timeout: 0.5)
    }
    
    func test_loginButtonDisabled_noEmail() {
        // Mock Setup
        let loginButtonDisabledExpectation = expectation(description: "Excected loginButtonEnabled to be false!")
        
        // Given
        let sut = LoginViewModel(dataProvider: MockDataProvider())
        
        sut.loginButtonEnabled.dropFirst(2).sink { enabled in
            guard enabled == false else {
                XCTFail("Expected login button to be disabled!")
                return
            }
            loginButtonDisabledExpectation.fulfill()
            
        }.store(in: &cancellables)
        
        // When I have no value in the email field
        sut.emailFieldText.value = ""
        sut.passwordFieldText.value = "12345"
        
        // Then
        waitForExpectations(timeout: 0.5)
    }
    
    func test_loginButtonDisabled_emptyPassword() {
        // Mock Setup
        let loginButtonDisabledExpectation = expectation(description: "Excected loginButtonEnabled to be false!")
        
        // Given I have no value in the password field
        let sut = LoginViewModel(dataProvider: MockDataProvider())
        
        sut.loginButtonEnabled.dropFirst(2).sink { enabled in
            guard enabled == false else {
                XCTFail("Expected login button to be disabled!")
                return
            }
            loginButtonDisabledExpectation.fulfill()
            
        }.store(in: &cancellables)
        
        // When
        sut.emailFieldText.value = "example@example.com"
        sut.passwordFieldText.value = ""
        
        // Then
        waitForExpectations(timeout: 0.5)
    }
    
    func test_loginButtonTapped_networkRequestIsMade() {
        
        // Mock Setup
        let loginServiceCalledExpectation = expectation(description: "Expected login function on DataProvider to be called!")
        let mockDataProvider = MockDataProvider()
        mockDataProvider.loginCalledClosure = {
            loginServiceCalledExpectation.fulfill()
        }
        
        // Given I have valid credentials
        let sut = LoginViewModel(dataProvider: mockDataProvider)
        sut.emailFieldText.value = "example@example.com"
        sut.passwordFieldText.value = "secureP455w0rd"
        
        // When the login button is tapped
        sut.loginTapped()
        
        // Then I expect a login network request to be made
        waitForExpectations(timeout: 0.5)
    }
    
}
