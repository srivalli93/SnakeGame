//
//  Employees.swift
//  SquareTest
//
//  Created by Srivalli Kanchibotla on 6/5/23.
//

import Foundation

struct Employees: Codable {
    var employees: [Employee]
}

struct Employee: Codable, Equatable {
    
    internal init(uuid: String, full_name: String, phone_number: String? = nil, email_address: String, biography: String? = nil, photo_url_small: String? = nil, photo_url_large: String? = nil, team: String, employee_type: EmployeeType) {
        self.uuid = uuid
        self.full_name = full_name
        self.phone_number = phone_number
        self.email_address = email_address
        self.biography = biography
        self.photo_url_small = photo_url_small
        self.photo_url_large = photo_url_large
        self.team = team
        self.employee_type = employee_type
    }
    
    var uuid: String
    var full_name: String
    var phone_number: String?
    var email_address: String
    var biography: String?
    var photo_url_small: String?
    var photo_url_large: String?
    var team: String
    var employee_type: EmployeeType
    

}

enum EmployeeType: String, Codable {
    case fulltime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"
}
