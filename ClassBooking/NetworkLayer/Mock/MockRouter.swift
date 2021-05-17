//
//  MockRouter.swift
//  ClassBooking
//
//  Created by Sean.Yue on 2021/5/17.
//

import Foundation

enum MockError: String, Error {
    case wrongUrlFormat = "Your url format may be wrong."
}

class MockRouter<EndPoint: EndPointType>: NetworkRouter {
    func request(route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        do {
            guard let url = self.buildUrl(from: route) else { return completion(nil, nil, MockError.wrongUrlFormat) }
            let data = try Data(contentsOf: url, options: .alwaysMapped)
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            completion(data, response, nil)
            
        } catch {
            completion(nil, nil, error)
        }
    }
    
    func cancel() {
        print("Mock data doesn't need to cancel")
    }
    
    fileprivate func buildUrl(from route: EndPoint) -> URL? {
        let fileName = route.baseURL.absoluteString + route.path
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return nil }
        return URL(fileURLWithPath: path)
    }
}
