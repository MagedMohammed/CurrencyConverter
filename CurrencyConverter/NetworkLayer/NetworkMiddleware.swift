//
//  NetworkMiddleware.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkMiddlewareProtocol {
    var sessionManager: SessionManager { get }
}

class NetworkMiddleware: NetworkMiddlewareProtocol, RequestAdapter, RequestRetrier {
    
    lazy var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        let sessionManager = SessionManager(configuration: configuration)
        sessionManager.adapter = self
        sessionManager.retrier = self
        return sessionManager
    }()
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        guard let currentURL = urlRequest.url else { return urlRequest }
        var urlRequest = urlRequest
        urlRequest.url = currentURL.appending("access_key", value: Constants.apiKey)
        return urlRequest
    }
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        completion(false, 0)
    }

    
}
