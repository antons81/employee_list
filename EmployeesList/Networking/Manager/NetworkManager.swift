//
//  NetworkManager.swift
//  Employees
//
//  Created by Anton Stremovskiy on 07.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation
import UIKit

enum NetworkResponse: String {
    case success
    case authError = "Login or password are incorrect"
    case badRequest = "Bad Request"
    case failed = "Request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response"
    case serverError = "Internal server error"
    case nothingFound = "The server can not find the requested resource"
    case forbidden = "The client does not have access rights to the content"
    case methodNotAllowed = "Metthod not allowed"
    case conflict = "The request could not be processed because of conflict in the request"
}

enum Result<String> {
    case success
    case failure(String)
}

class NetworkManager {
    
    public func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 400:       return .failure(NetworkResponse.badRequest.rawValue)
        case 401:       return .failure(NetworkResponse.authError.rawValue)
        case 403:       return .failure(NetworkResponse.forbidden.rawValue)
        case 404:       return .failure(NetworkResponse.nothingFound.rawValue)
        case 405:       return .failure(NetworkResponse.methodNotAllowed.rawValue)
        case 409:       return .failure(NetworkResponse.conflict.rawValue)
        case 406...499: return .failure(NetworkResponse.authError.rawValue)
        case 411:       return .failure(NetworkResponse.authError.rawValue)
        case 500:       return .failure(NetworkResponse.serverError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        default:        return .failure(NetworkResponse.badRequest.rawValue)
        }
    }
}





