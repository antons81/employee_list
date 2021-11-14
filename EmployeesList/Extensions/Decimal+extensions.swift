//
//  Decimal+extensions.swift
//  WiseHouse
//
//  Created by Anton Stremovskiy on 02.09.2020.
//  Copyright © 2020 Shooting App. All rights reserved.
//

import Foundation


extension Decimal {
    
    var toDouble: Double {
        return (self as NSDecimalNumber).doubleValue
    }
}
