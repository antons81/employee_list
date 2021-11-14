//
//  Encodable+extensions.swift
//  Employees
//
//  Created by Anton Stremovskiy on 06.08.2021.
//

import Foundation

extension Encodable {
    
    func toJSONString() -> String {
        do {
            let jsonData = try JSONEncoder().encode(self)
            return String(data: jsonData, encoding: .utf8)!
        } catch let error {
            print(error.localizedDescription)
        }
        return ""
    }
}
