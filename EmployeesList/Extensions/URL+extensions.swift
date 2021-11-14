//
//  URL+extensions.swift
//  WiseHouse
//
//  Created by Anton Stremovskiy on 29.08.2020.
//  Copyright © 2020 Shooting App. All rights reserved.
//

import Foundation


extension URL {
    func params() -> [String:Any] {
        var dict = [String:Any]()
        
        if let components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
            if let queryItems = components.queryItems {
                for item in queryItems {
                    dict[item.name] = item.value!
                }
            }
            return dict
        } else {
            return [:]
        }
    }
}
