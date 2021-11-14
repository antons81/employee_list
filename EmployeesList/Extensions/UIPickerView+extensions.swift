//
//  UIPickerView+extensions.swift
//  Employees
//
//  Created by Anton Stremovskiy on 05.08.2021.
//

import UIKit

extension UIPickerView {
@IBInspectable var pickerTextColor: UIColor? {
    get {
        return self.pickerTextColor
    }
    set {
        self.setValue(newValue, forKeyPath: "textColor")
    }
}}
