//
//  FutureDecoded.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation

extension Future where Value == Data {
    func decoded<NextValue: Decodable>(toType type: NextValue.Type, keyPath: String = "") throws -> Future<NextValue> {
        return transformed {
            do {
                if keyPath == "" {
                    return try JSONDecoder().decode(NextValue.self, from: $0)
                } else {
                    return try JSONDecoder().decode(NextValue.self, from: $0, keyPath: keyPath)
                }
                
            } catch {
                throw error
            }
        }
    }
}
