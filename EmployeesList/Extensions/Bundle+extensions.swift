//
//  Bundle+extensions.swift
//  Employees
//
//  Created by Anton Stremovskiy on 31.07.2021.
//

import Foundation


extension Bundle {
    
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
