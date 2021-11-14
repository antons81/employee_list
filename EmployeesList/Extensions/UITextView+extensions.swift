//
//  UITextView+extensions.swift
//  Employees
//
//  Created by Anton Stremovskiy on 25.10.2021.
//

import Foundation
import UIKit


extension UITextView {
    
    func resignFirstResponder(_ completion: SimpleCompletion) {
        self.resignFirstResponder()
        completion?()
    }
}
