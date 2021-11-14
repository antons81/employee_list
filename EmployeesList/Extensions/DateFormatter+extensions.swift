//
//  DateFormatter+Extension.swift
//  WiseHouse
//
//  Created by Anton Stremovskiy on 06.07.2020.
//  Copyright © 2020 Shooting App. All rights reserved.
//

import Foundation


extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM YYYY 'в' HH:mm:ss"
        formatter.locale = Locale(identifier: "uk_UA")
        formatter.calendar = Calendar.current
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        return formatter
    }()
    
    static let dateFormatterTesting: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = Locale(identifier: "uk_UA")
        formatter.calendar = Calendar.current
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        return formatter
    }()
}
