import XCTest
@testable import Networking

final class NetworkingTests: XCTestCase {
    
    var sut: DataProvider!
    var loginRequest: LoginRequest!
    
    override func setUpWithError() throws {
        try super.tearDownWithError()
        
        sut = DataProvider()
        loginRequest = LoginRequest(email: "test+ios2@moneyboxapp.com", password: "P455word12")
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
        loginRequest = nil
    }
    
    func testLogin_ReturnsSuccess() {
        let loginExpectation = self.expectation(description: "Login Web Service")
        
        sut.login(request: loginRequest) { result in
            if case .failure(let error) = result {
                XCTFail("Login Failed: \(error.localizedDescription)")
            }
            
            loginExpectation.fulfill()
        }
        
        self.wait(for: [loginExpectation], timeout: 30)
    }

    func testFetchProducts_ReturnsSuccess() {
        let fetchProductsExpectation = self.expectation(description: "Fetch Products Expectation")
        
        sut.login(request: loginRequest) { [weak self] result in
            if case .success(let response) = result {
                response.saveToken()
                self?.sut.fetchProducts { result in
                    if case .failure(let error) = result {
                        XCTFail("Login Failed: \(error.localizedDescription)")
                    }
                    fetchProductsExpectation.fulfill()
                }
            }
        }
        
        self.wait(for: [fetchProductsExpectation], timeout: 30)
    }
    
    func testAddMoney_ReturnsSuccess() {
        let oneOffPaymentRequest: OneOffPaymentRequest = OneOffPaymentRequest(amount: 10, investorProductID: 63429)
        
        let addMoneyExpectation = self.expectation(description: "Add Money Expectation")
        
        sut.login(request: loginRequest) { [weak self] result in
            if case .success(let response) = result {
                response.saveToken()
                self?.sut.addMoney(request: oneOffPaymentRequest) { result in
                    if case .failure(let error) = result {
                        XCTFail("Login Failed: \(error.localizedDescription)")
                    }
                    addMoneyExpectation.fulfill()
                }
            }
        }
        
        self.wait(for: [addMoneyExpectation], timeout: 30)
    }
    
    
}
