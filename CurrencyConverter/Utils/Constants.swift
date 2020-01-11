//
//  Constants.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation

enum Constants {
    static let baseURL = "http://data.fixer.io/api"
    static let apiKey = "5fe224ed96ad0d3729eabf83614fb35d"
    
    enum CurrencyEndpoints {
        static let latest = "/latest"
    }
}
