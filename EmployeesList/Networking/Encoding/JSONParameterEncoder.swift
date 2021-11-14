//
//  JSONParameterEncoder.swift
//  Employees
//
//  Created by Anton Stremovskiy on 06.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation


public struct JSONParameterEncoder: ParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
            
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                print(JSONString)
            }
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    
    public static func encode(urlRequest: inout URLRequest, with parameters: [Parameters]) throws {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            urlRequest.httpBody = jsonData
            
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                print(JSONString)
            }
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
