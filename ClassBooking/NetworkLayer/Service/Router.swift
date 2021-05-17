//
//  Router.swift
//  ClassBooking
//
//  Created by Zih-Siang Yue on 2021/5/16.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        
        do {
            let request = try self.buildRequest(from: route)
            self.task = session.dataTask(with: request, completionHandler: completion)
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildUrl(from route: EndPoint) -> URL? {
        let fileName = route.baseURL.absoluteString + route.path
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return nil }
        return URL(fileURLWithPath: path)
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
            case .requestWithParams(bodyParams: let bodyParams, urlParams: let urlParams):
                try self.configureParameters(bodyParameters: bodyParams, urlParameters: urlParams, request: &request)
                
            case .requestWithParamsAndHeader(bodyParams: let bodyParams, urlParams: let urlParams, headers: let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParams, urlParameters: urlParams, request: &request)
            }
            
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParams = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParams)
            }
            
            if let urlParams = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParams)
            }
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ adiitionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = adiitionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
