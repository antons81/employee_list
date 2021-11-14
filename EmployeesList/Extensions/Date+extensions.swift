//
//  Date+Extension.swift
//  WiseHouse
//
//  Created by Anton Stremovskiy on 06.07.2020.
//  Copyright © 2020 Shooting App. All rights reserved.
//

import Foundation

extension Date {
    
    static func today() -> Date {
        return Date()
    }
    
    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.Next,
                   weekday,
                   considerToday: considerToday)
    }
    
    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.Previous,
                   weekday,
                   considerToday: considerToday)
    }
    
    func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             considerToday consider: Bool = false) -> Date {
        
        let dayName = weekDay.rawValue
        
        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1
        
        let calendar = Calendar(identifier: .gregorian)
        
        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
            return self
        }
        
        var nextDateComponent = DateComponents()
        nextDateComponent.weekday = searchWeekdayIndex
        
        
        let date = calendar.nextDate(after: self,
                                     matching: nextDateComponent,
                                     matchingPolicy: .nextTime,
                                     direction: direction.calendarSearchDirection)
        
        return date!
    }
    
}

// MARK: Helper methods

extension Date {
    
    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    
    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum SearchDirection {
        case Next
        case Previous
        
        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .Next:
                return .forward
            case .Previous:
                return .backward
            }
        }
    }
}

extension Date {
    
    func dateToString(with format: String?, _ timezone: String? = "UTC") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format ?? "dd MMMM YYYY 'в' HH:mm"
        dateFormatter.locale = Locale(identifier: "uk_UA")
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    
    func dateToTimeInterval() -> Double {
        return self.timeIntervalSince1970
    }

    func dateAt(hours: Int, minutes: Int) -> Date {
        
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        //get the month/day/year componentsfor today's date.
        
        var date_components = calendar.components(
            [NSCalendar.Unit.year,
             NSCalendar.Unit.month,
             NSCalendar.Unit.day],
            from: self)
        
        //Create an NSDate for the specified time today.
        date_components.hour = hours
        date_components.minute = minutes
        date_components.second = 0
        
        let newDate = calendar.date(from: date_components)!
        return newDate
    }
    
    func dayNumberOfWeek() -> Int? {
        guard let weekday = Calendar.current.dateComponents([.weekday], from: self).weekday else { return 0 }
        if weekday == 1 {
            return weekday + 6
        }
        return weekday - 1
    }
}

public extension Date {
    func dayDifferenceFromDate() -> String {
        let calendar = NSCalendar.current
        if calendar.isDateInToday(self as Date) { return "Today" }
        else if calendar.isDateInTomorrow(self as Date) { return "Tomorrow" }
        else { return "" }
    }
}

extension Date {
    var previousMonth: String? {
        return Calendar.current.date(byAdding: .month, value: -1, to: Date())?.dateToString(with: "LLLL").capitalized
    }
}

extension Date {

    func daysBetween(date: Date) -> Int {
        return Date.daysBetween(start: self, end: date)
    }

    static func daysBetween(start: Date, end: Date) -> Int {
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: start)
        let date2 = calendar.startOfDay(for: end)

        let a = calendar.dateComponents([.day], from: date1, to: date2)
        return a.value(for: .day)!
    }
    
    func isExpired(_ endDate: Date) -> Bool {
        return self > endDate
    }
}


extension Date {
    
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
