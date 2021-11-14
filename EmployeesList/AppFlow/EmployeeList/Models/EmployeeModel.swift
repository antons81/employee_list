//
//  EmployeeModel.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 13.11.2021.
//

import Foundation

typealias Employees = [EmployeeModel]

// MARK: - Employee
struct EmployeeModel: Codable, Hashable {
    let firstName: String
    let lastName: String
    let position: String
    let contactDetails: ContactDetailsModel
    let projects: [String]?

    enum CodingKeys: String, CodingKey {
        case firstName = "fname"
        case lastName = "lname"
        case position = "position"
        case contactDetails = "contact_details"
        case projects = "projects"
    }
    
    static func == (lhs: EmployeeModel, rhs: EmployeeModel) -> Bool {
        return lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName &&
        lhs.position == rhs.position &&
        lhs.contactDetails == rhs.contactDetails &&
        lhs.projects == rhs.projects
    }
}

// MARK: - ContactDetails
struct ContactDetailsModel: Codable, Hashable {
    let email: String
    let phone: String?

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case phone = "phone"
    }
    
    static func == (lhs: ContactDetailsModel, rhs: ContactDetailsModel) -> Bool {
        return lhs.email == rhs.email &&
        lhs.phone == rhs.phone
    }
}
