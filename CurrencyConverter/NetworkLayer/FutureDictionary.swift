//
//  FutureDictionary.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation

extension Future where Value == Data {
    func asDictionary() -> Future<[String: AnyObject]> {
        return transformed {
            return try (JSONSerialization.jsonObject(with: $0, options: .allowFragments) as? [String: AnyObject] ?? [:])
        }
    }
}

extension Future where Value == [String: AnyObject] {
    func get<NextValue>(key: String, ofType type: NextValue.Type, defaultValue: NextValue) -> Future<NextValue> {
        return transformed { dictionay in
            return dictionay.valueForKeyPath(keyPath: key) as? NextValue ?? defaultValue
        }
    }
}
