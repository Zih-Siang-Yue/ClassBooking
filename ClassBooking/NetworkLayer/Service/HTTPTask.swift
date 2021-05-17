//
//  HTTPTask.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import Foundation

public typealias HTTPHeaders = [String: String]
public typealias Parameters = [String: Any]

public enum HTTPTask {
    case request
    case requestWithParams(bodyParams: Parameters?, urlParams: Parameters?)
    case requestWithParamsAndHeader(bodyParams: Parameters?, urlParams: Parameters?, headers: HTTPHeaders?)
}
