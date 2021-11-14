//
//  URLParameterEncoder.swift
//  Employees
//
//  Created by Anton Stremovskiy on 06.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation


public struct URLParameterEncoder: ParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: [Parameters]) throws {}
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else  { throw NetworkError.missingUrl }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let value = "\(value)".addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                let queryItem = URLQueryItem(name: key, value: value)
                urlComponents.queryItems?.append(queryItem)
            }
            
            urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
