//
//  CALayer+extensions.swift
//  WiseHouse
//
//  Created by Anton Stremovskiy on 02.08.2020.
//  Copyright © 2020 Shooting App. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    func roundCorners(radius:CGFloat) {
       let roundPath = UIBezierPath(
           roundedRect: self.bounds,
           cornerRadius: radius)
       let maskLayer = CAShapeLayer()
       maskLayer.path = roundPath.cgPath
       self.mask = maskLayer
   }
}
