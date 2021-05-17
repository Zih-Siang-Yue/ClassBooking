//
//  Date+Calendar.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import Foundation

extension Date {
    var calendar: Calendar {
        return Calendar.current
    }
    
    //MARK: - Year
    var year: Int { return calendar.component(.year, from: self) }
    
    //MARK: - Month
    var month: Int { return calendar.component(.month, from: self) }
    
    //MARK: - Week
    var weekDay: Int { return calendar.component(.weekday, from: self) }
    
    var thisWeekStr: String {
        return Date.today().weekStr
    }

    var weekStr: String {
        let weekStr = "\(self.week.first!.ymdSlashStr) - \(self.week.last!.dateStr)"
        return weekStr
    }

    var week: [Date] {
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: self)!
        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - self.weekDay, to: self) }
        return days

    }
    
    var nextWeek: Date {
        return calendar.date(byAdding: .day, value: 7, to: self)!
    }
    
    var lastWeek: Date {
        return calendar.date(byAdding: .day, value: -7, to: self)!
    }
    
    //MARK: - Date
    static func today() -> Date {
        return Date()
    }
    
    var day: Int { return calendar.component(.day, from: self) }
    
    var firstDayOfMonth: Date {
        return calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
    }
}

//extension Date {
//    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
//        return get(.next, weekday, considerToday: considerToday)
//    }
//
//    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
//        return get(.previous, weekday, considerToday: considerToday)
//    }
//
//    func get(_ direction: SearchDirection, _ weekDay: Weekday, considerToday consider: Bool = false) -> Date {
//        let dayName = weekDay.rawValue
//        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
//
//        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
//
//        let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1
//        let calendar = Calendar(identifier: .gregorian)
//
//        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
//            return self
//        }
//
//        var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
//        nextDateComponent.weekday = searchWeekdayIndex
//
//        let date = calendar.nextDate(after: self,
//                                     matching: nextDateComponent,
//                                     matchingPolicy: .nextTime,
//                                     direction: direction.calendarSearchDirection)
//
//        return date!
//    }
//}

// MARK: Helper methods
//extension Date {
//    func getWeekDaysInEnglish() -> [String] {
//        var calendar = Calendar(identifier: .gregorian)
//        calendar.locale = Locale(identifier: "en_US_POSIX")
//        return calendar.weekdaySymbols
//    }
//    
//    enum Weekday: String {
//        case sunday, monday, tuesday, wednesday, thursday, friday, saturday
//    }
//    
//    enum SearchDirection {
//        case next
//        case previous
//        
//        var calendarSearchDirection: Calendar.SearchDirection {
//            switch self {
//            case .next:
//                return .forward
//            case .previous:
//                return .backward
//            }
//        }
//    }
//}
