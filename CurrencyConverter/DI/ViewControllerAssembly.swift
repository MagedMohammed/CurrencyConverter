//
//  ViewControllerAssembly.swift
//  Dubai Police
//
//  Created by Vortex on 10/21/19.
//  Copyright © 2019 Vortex. All rights reserved.
//

import Foundation
import Swinject

class ViewControllerAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(CurrencyRatesViewController.self) { _ in
            return CurrencyRatesViewController()
        }
        
        container.register(CurrencySelectorViewController.self) { _, currencyList in
            return CurrencySelectorViewController(currencyList: currencyList)
        }
        
        container.register(CurrencyConverterViewController.self) { _, baseCurrency, selectedCurrency in
            return CurrencyConverterViewController(baseCurrency: baseCurrency, selectedCurrency: selectedCurrency)
        }
    }
    
}
