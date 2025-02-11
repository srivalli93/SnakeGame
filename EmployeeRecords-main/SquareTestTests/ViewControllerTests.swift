//
//  ViewControllerTests.swift
//  SquareTestTests
//
//  Created by Srivalli Kanchibotla on 6/11/23.
//

import XCTest
@testable import SquareTest

class ViewControllerTests: XCTestCase {

    var viewController: ViewController!
    var testTableView: UITableView!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewController = ViewController()
        testTableView = UITableView()
        testTableView.dataSource = viewController
        testTableView.delegate = viewController
    }

    override func tearDownWithError() throws {
        viewController = nil
        testTableView = nil
        try super.tearDownWithError()
    }
    
    func testRestoreTableview() {
        let employeeData = [Employee(uuid: "0000", full_name: "John", phone_number: "0123456789", email_address: "john@test.com", biography: "John's bio", photo_url_small: "smallURL.com", photo_url_large: "largeURL.com", team: "test team ", employee_type: EmployeeType.fulltime)]
        viewController.employeeData = employeeData
        
        let numOfRows = viewController.tableView(testTableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numOfRows, employeeData.count)
        XCTAssertFalse(testTableView.isHidden)
    }
    
    func testNumberofRowsInSecFailure() {
        let employeeData: [Employee] = []
        viewController.employeeData = employeeData
        let numOfRows = viewController.tableView(testTableView, numberOfRowsInSection: 0)
        
        XCTAssertEqual(numOfRows, employeeData.count)
        XCTAssertTrue(testTableView.visibleCells.isEmpty)
        
    }
    
    func testSortButtonTapped() {
        let employeeData = [Employee(uuid: "0000", full_name: "John", phone_number: "0123456789", email_address: "john@test.com", biography: "John's bio", photo_url_small: "smallURL.com", photo_url_large: "largeURL.com", team: "test team ", employee_type: EmployeeType.fulltime),
                            Employee(uuid: "0000", full_name: "Apple Doe", phone_number: "1231231234", email_address: "appleDoe@test.com", biography: "bio", photo_url_small: "small.jpeg", photo_url_large: "large.jpeg", team: "teamTeam", employee_type: EmployeeType.contractor)]
        
        viewController.employeeData = employeeData
        viewController.sortButtonTapped()
        let sortedData = viewController.employeeData
        let expectedData = [
                           Employee(uuid: "0000", full_name: "Apple Doe", phone_number: "1231231234", email_address: "appleDoe@test.com", biography: "bio", photo_url_small: "small.jpeg", photo_url_large: "large.jpeg", team: "teamTeam", employee_type: EmployeeType.contractor),
                           Employee(uuid: "0000", full_name: "John", phone_number: "0123456789", email_address: "john@test.com", biography: "John's bio", photo_url_small: "smallURL.com", photo_url_large: "largeURL.com", team: "test team ", employee_type: EmployeeType.fulltime)]
        XCTAssertEqual(sortedData, expectedData)
    }

}
