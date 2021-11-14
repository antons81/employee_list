//
//  ResponseModel.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 13.11.2021.
//

import Foundation


struct ResponseModel: Decodable {
    
    let email: String?
    let message: String?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case email
        case message
        case error
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.email = try? container.decode(String.self, forKey: .email)
        self.message = try? container.decode(String.self, forKey: .message)
        self.error = try? container.decode(String.self, forKey: .error)
    }
}
