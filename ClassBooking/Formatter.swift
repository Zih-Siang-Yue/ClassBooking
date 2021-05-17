//
//  Formatter.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import Foundation

enum Formatter: String {
    case utc             = "yyyy-MM-dd'T'HH:mm:ssZ"
    case hourToMinute    = "HH:mm"
    case yearToDateSlash = "yyyy/MM/dd"
    case yearToDateDash  = "yyyy-MM-dd"
    case date            = "dd"
    case weekday         = "E"
    case zone            = "zzz"
}
