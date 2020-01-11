//
//  CurrencyRateResponse.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation

struct CurrencyRate: Decodable {
    
    let rates: [String: Double]
    
}
