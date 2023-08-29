//
//  LoginViewModelTests.swift
//  MoneyBoxTests
//
//  Created by George Woodham on 25/08/23.
//

import Combine
import Foundation
@testable import MoneyBox
import XCTest

class LoginViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func testTitle_IsLogin() {
        // Setup
        let viewModel = LoginViewModel()
        
        // Verify
        XCTAssertEqual(viewModel.title, "Login")
        
    }
    
    func testInitialState_IsIdle () {
        // Setup
        let viewModel = LoginViewModel(dataProvider: StubDataProvider())

        // Verify
        XCTAssertEqual(viewModel.state, .idle)
    }
    
    func testStateChanges_ToLoading_WhenLoggingIn() {
        // Setup
        var result: LoginViewModel.State?
        let viewModel = LoginViewModel(dataProvider: StubDataProvider())
        viewModel.$state
            .dropFirst()
            .prefix(1)
            .sink { state in
                result = state
            }
            .store(in: &cancellables)
        
        // Run
        viewModel.login()
        
        // Verify
        XCTAssertEqual(result, .loading)
    }
    
    func testStateChanges_ToLoggedIn_WhenLoggingIn_GivenSuccessfullResponse() {
        // Setup
        let viewModel = LoginViewModel(dataProvider: StubDataProvider())

        // Run
        viewModel.login()
        
        // Verify
        XCTAssertEqual(viewModel.state, .loggedIn)
    }
    
    func testStateChanges_ToError_WhenLoggingIn_GivenErrorResponse() {
        // Setup
        let stubDataProvider = StubDataProvider()
        stubDataProvider.forceError = true
        let viewModel = LoginViewModel(dataProvider: stubDataProvider)

        // Run
        viewModel.login()
        
        // Verify
        XCTAssertEqual(viewModel.state, .error(message: "Forced stub error"))
    }
}
