//
//  URLParameterEncoder.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameter: Parameters) throws {
        guard let url = urlRequest.url else {
            throw NetworkError.missingURL
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              parameter.isEmpty else {
            throw NetworkError.parametersNil
        }
        
        components.queryItems = []
        
        parameter.forEach { (key, value) in
            let item = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            components.queryItems?.append(item)
        }
        
        urlRequest.url = components.url
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
