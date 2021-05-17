//
//  ScheduleModel.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import Foundation

struct ScheduleModel: Codable {
    let available: [Time]
    let booked: [Time]
}

struct Time: Codable {
    let start: String
    let end: String
}
