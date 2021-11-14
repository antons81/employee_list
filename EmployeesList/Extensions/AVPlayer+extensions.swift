//
//  AVPlayer+Extension.swift
//  WiseHouse
//
//  Created by Anton Stremovskiy on 24.07.2020.
//  Copyright © 2020 Shooting App. All rights reserved.
//

import Foundation
import AVKit
import UIKit

extension CGAffineTransform {
    static let degreeRotation90 = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
    static let degreeRotation180 = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2) * 3)
    static let degreeRotation360 = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2) * 2)
}

extension AVPlayerLayer {

    var fullScreenAnimationDuration: TimeInterval {
        return 0.15
    }
    
    func minimizeToFrame360(_ frame: CGRect) {
           UIView.animate(withDuration: fullScreenAnimationDuration) {
               self.setAffineTransform(.degreeRotation360)
               self.frame = frame
           }
       }

    func minimizeToFrame(_ frame: CGRect) {
        UIView.animate(withDuration: fullScreenAnimationDuration) {
            self.setAffineTransform(.identity)
            self.frame = frame
        }
    }
    
    func goFullscreenLeft() {
        UIView.animate(withDuration: fullScreenAnimationDuration) {
            self.setAffineTransform(.degreeRotation90)
            self.frame = UIScreen.main.bounds
        }
    }
    
    func goFullscreenRight() {
        UIView.animate(withDuration: fullScreenAnimationDuration) {
            self.setAffineTransform(.degreeRotation180)
            self.frame = UIScreen.main.bounds
        }
    }
}
