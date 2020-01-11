//
//  CurrencyRouter.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation
import Alamofire

enum CurrencyRouter: URLRequestConvertible {
    
    case latest(forType: CurrencyType)
    
    var method: HTTPMethod {
        switch self {
        case .latest:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .latest(let type):
            return [
                "base": type.rawValue
            ]
        }
    }
    
    var url: URL {
        let endpoint: String
        switch self {
        case .latest:
            endpoint = Constants.CurrencyEndpoints.latest
        }
        return URL(string: Constants.baseURL)!.appendingPathComponent(endpoint)
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .latest:
            return URLEncoding.queryString
        }
    }
    
}
