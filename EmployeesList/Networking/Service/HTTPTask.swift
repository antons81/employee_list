//
//  HTTPTask.swift
//  Employees
//
//  Created by Anton Stremovskiy on 06.05.2020.
//  Copyright © 2020 Anton Stremovskiy. All rights reserved.
//

import Foundation
import UIKit

public typealias HTTPHeaders = [String: String]

enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?,
        urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        urlParameters: Parameters?,
        additionHeaders: Parameters?)
    case requestMultipartFormDataParametersAndHeaders(bodyParameters: Parameters?,
        urlParameters: Parameters?,
        additionHeaders: Parameters?,
        images: [UIImage]?)
    case requestBodyParametersAndHeaders(bodyParameters: Parameters?,
        additionHeaders: Parameters?)
}
