//
//  String+Date.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import Foundation

extension String {
    func converToDate(format: String = Formatter.utc.rawValue) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
        
    var date: Date? {
        return self.converToDate(format: Formatter.yearToDateDash.rawValue)
    }
}
