//
//  EndpointTypeProtocol.swift
//  Employees
//
//  Created by Anton Stremovskiy on 06.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation


protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
