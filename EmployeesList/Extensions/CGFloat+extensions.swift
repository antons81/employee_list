//
//  CGFloat+extensions.swift
//  Employees
//
//  Created by Anton Stremovskiy on 22.09.2021.
//

import Foundation
import CoreGraphics
import UIKit


public extension CGFloat {

    var toPoints: CGFloat {
        return self / UIScreen.main.scale
    }
    
    var toPixels: CGFloat {
        return self * UIScreen.main.scale
    }
}

extension CGFloat {
    
    var toDouble: Double {
        return Double(self)
    }
}
