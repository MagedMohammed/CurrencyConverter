//
//  FutureVoid.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation

extension Future where Value == Data {
    func toVoid() -> Future<Void> {
        return transformed { _ in
            return ()
        }
    }
}
