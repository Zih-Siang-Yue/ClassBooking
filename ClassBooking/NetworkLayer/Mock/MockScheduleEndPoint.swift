//
//  ScheduleMockEndPoint.swift
//  ClassBooking
//
//  Created by Sean.Yue on 2021/5/17.
//

import Foundation

public enum MockScheduleApi {
    case getSchedule(start: Date, end: Date)
    case book(date: Date)
}

extension MockScheduleApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "Schedule") else { fatalError("Base URL couldn't be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .getSchedule(let start,let end): return "_\(start.ymdDashStr)_\(end.ymdDashStr)"
        case .book(_): return "classBooking"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getSchedule(_, _):
            return .get
        case .book(_):
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .book(let date):
            return .requestWithParams(bodyParams: ["date": date.converToStr()], urlParams: nil)
            
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
