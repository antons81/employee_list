//
//  TartuEndpoint.swift
//  EmployeesList
//
//  Created by Anton Stremovskiy on 13.11.2021.
//

import Foundation

public enum TartuEmployeeApi {
    case tartu_employee_list
}

extension TartuEmployeeApi: EndPointType {
    
    var path: String {
        switch self {
        case .tartu_employee_list:
            return "employee_list"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .tartu_employee_list:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .tartu_employee_list:
            return .requestParameters(bodyParameters: nil, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var baseURL: URL {
        guard let url = URL(string: Endpoints.tartuURL) else { fatalError("baseURL could not be configured." )}
        return url
    }
}
