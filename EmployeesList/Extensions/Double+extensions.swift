//
//  Double+extensions.swift
//  WiseHouse
//
//  Created by Anton Stremovskiy on 23.11.2020.
//  Copyright © 2020 Shooting App. All rights reserved.
//

import Foundation


extension Double {
    
    var toString: String {
        return String(self)
    }
}

extension Double {
    
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    
    var format2Decimals: String {
        return String(format: "%.2f", self)
    }
    
    var format2DecimalsInch: String {
        return String(format: "%.2f˝", self)
    }
    
    var format2DecimalsCm: String {
        return String(format: "%.2f cm", self)
    }
    
    var formatToInt: Int {
        return Int(self)
    }
}

extension Double {
    
    func convert(from originalUnit: UnitLength, to convertedUnit: UnitLength) -> Double {
        return Measurement(value: self, unit: originalUnit).converted(to: convertedUnit).value
    }
    
    var inchesToMillimeters: Double {
        return self.convert(from: .inches, to: .millimeters)
    }
    
    var inchesToCentimeters: Double {
        return self.convert(from: .inches, to: .centimeters)
    }
    
    var millimetersToInches: Double {
        return self.convert(from: .millimeters, to: .inches)
    }
    
    var centimeterToInch: Double {
        return self.convert(from: .centimeters, to: .inches)
    }
    
    var yardsToMeters: Double {
        return self.convert(from: .yards, to: .meters)
    }
    
    var metersToYards: Double {
        return self.convert(from: .meters, to: .yards)
    }
    
    var toCentimeters: Double {
        return self.convert(from: .meters, to: .centimeters)
    }
}


extension Double {
    
    // Rounds the double to decimal places value
    
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(1000.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
