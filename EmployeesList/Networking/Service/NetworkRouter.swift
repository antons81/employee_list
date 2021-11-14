//
//  NetworkRouter.swift
//  Employees
//
//  Created by Anton Stremovskiy on 06.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: String?) -> Void

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
