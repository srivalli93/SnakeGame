//
//  EmployeesTest.swift
//  SquareTestTests
//
//  Created by Srivalli Kanchibotla on 6/11/23.
//

import XCTest
@testable import SquareTest

class EmployeesTest: XCTestCase {
    
    func testEmployees() {
        let uuid = "0000"
        let full_name = "Jane Doe"
        let phone_number = "0000000000"
        let email_address = "test@square.com"
        let biography = "test data test data"
        let photo_url_small = "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg"
        let photo_url_large = "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg"
        let team = "test team"
        let employee_type = EmployeeType.fulltime
        
        let testEmployee = Employee(uuid: uuid,
                                    full_name: full_name, phone_number: phone_number, email_address: email_address, biography: biography, photo_url_small: photo_url_small, photo_url_large: photo_url_large, team: team, employee_type: employee_type)
        
        XCTAssertEqual(testEmployee.uuid, uuid, "Incorrect uuid")
        XCTAssertEqual(testEmployee.full_name, full_name, "Incorrect uuid")
        XCTAssertEqual(testEmployee.email_address, email_address, "Incorrect uuid")
        XCTAssertEqual(testEmployee.phone_number, phone_number, "Incorrect uuid")
        XCTAssertEqual(testEmployee.biography, biography, "Incorrect uuid")
        XCTAssertEqual(testEmployee.employee_type, employee_type, "Incorrect uuid")
        
    }

}
