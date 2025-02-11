//
//  InputServiceTests.swift
//  SquareTestTests
//
//  Created by Srivalli Kanchibotla on 6/11/23.
//

import XCTest
@testable import SquareTest

class InputServiceTests: XCTestCase {
    
    var inputService: InputService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        inputService = InputService()
    }

    override func tearDownWithError() throws {
        inputService = nil
        try super.tearDownWithError()
    }

    func testEmployeeDataSucess() throws {
        let expectation = self.expectation(description: "Returns employee data")
        inputService.getEmployeeData { result in
            switch result {
            case .success(let employees):
                XCTAssertNotNil(employees, "Employee data should not be nil")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed with \(error)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetEmployeeDataFailure() {
        let expectation = self.expectation(description: "Should not return employee data")
        inputService.inputURL = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
        
        inputService.getEmployeeData { result in
            switch result {
            case .success(_):
                XCTFail("Should fail")
            case .failure(let error):
                XCTAssertNotNil(error, "Error should not be nil")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }


}
