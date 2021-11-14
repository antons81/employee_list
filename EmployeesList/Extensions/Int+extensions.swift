//
//  Int+extension.swift
//  WiseHouse
//
//  Created by Anton Stremovskiy on 25.06.2020.
//  Copyright © 2020 Shooting App. All rights reserved.
//

import Foundation


extension Int {
    
    var toString: String {
        return String(self)
    }
}

extension Int {
    func dayNumberToWeekdayName() -> String? {
        
        if self == 0 {
            return nil
        }
        
        let formatter = DateFormatter()
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 1
        formatter.locale = Locale(identifier: "uk_UA")
        formatter.calendar = calendar
        formatter.timeZone = TimeZone.current
        formatter.setLocalizedDateFormatFromTemplate("EEE")
        let weekdayString = formatter.shortWeekdaySymbols[self]
        return weekdayString.capitalized
    }
}

extension Int {
    static func random(in range: ClosedRange<Int>, excluding x: Int) -> Int {
        if range.contains(x) {
            let r = Int.random(in: Range(uncheckedBounds: (range.lowerBound, range.upperBound)))
            return r == x ? range.upperBound : r
        } else {
            return Int.random(in: range)
        }
    }
}

extension Int {
    var boolValue: Bool { return self != 0 }
}

extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}
