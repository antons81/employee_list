//
//  ProfileEndpoint.swift
//  Employees
//
//  Created by Anton Stremovskiy on 28.07.2021.
//

import Foundation
import UIKit

public enum TallinnEmployeeApi {
    case tallinn_employee_list
}

extension TallinnEmployeeApi: EndPointType {
    
    var path: String {
        switch self {
        case .tallinn_employee_list:
            return "employee_list"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .tallinn_employee_list:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .tallinn_employee_list:
            return .requestParameters(bodyParameters: nil, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var baseURL: URL {
        guard let url = URL(string: Endpoints.tallinnURL) else { fatalError("baseURL could not be configured." )}
        return url
    }
}
