//
//  ScheduleEndPoint.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import Foundation

enum NetworkEnviroment {
    case qa
    case production
    case staging
}

public enum ScheduleApi {
    case getSchedule(start: Date, end: Date)
    case book(date: Date)
}

extension ScheduleApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: enviromentBaseURL) else { fatalError("Base URL couldn't be configured") }
        return url
    }
    
    var path: String {
        switch self {
        //TODO:(Sean) 修改path
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
    
    var enviromentBaseURL: String {
        switch NetworkManager.enviroment {
        case .production: return "https://pro.amazingTalker/"
        case .qa: return "https://qa.amazingTalker/"
        case .staging: return "https://staging.amazingTalker/"
        }
    }
}
