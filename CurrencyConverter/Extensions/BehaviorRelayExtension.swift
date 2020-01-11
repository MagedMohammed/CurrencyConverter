//
//  BehaviorRelayExtension.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation
import RxCocoa

extension BehaviorRelay where Element: RangeReplaceableCollection {
    
    func appending(_ element: Element.Element) {
        var array = self.value
        array.append(element)
        accept(array)
    }
    
    func appending(contentsOf sequence: [Element.Element]) {
        var array = self.value
        array.append(contentsOf: sequence)
        accept(array)
    }

}
