//
//  ViewModelAssembly.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(CurrencyRatesViewModel.self) { _ in
            return CurrencyRatesViewModel()
        }
        
        container.register(CurrencyConverterViewModel.self) { _ in
            CurrencyConverterViewModel()
        }
    }
    
}
