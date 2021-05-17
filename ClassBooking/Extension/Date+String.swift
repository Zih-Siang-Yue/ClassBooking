//
//  Date+String.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import Foundation

extension Date {    
    var ymdSlashStr: String {
        return self.converToStr(format: Formatter.yearToDateSlash.rawValue)
    }
    
    var ymdDashStr: String {
        return self.converToStr(format: Formatter.yearToDateDash.rawValue)
    }
    
    var weekDayStr: String {
        return self.converToStr(format: Formatter.weekday.rawValue)
    }
    
    var dateStr: String {
        return self.converToStr(format: Formatter.date.rawValue)
    }
    
    func converToStr(format: String = Formatter.utc.rawValue) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
