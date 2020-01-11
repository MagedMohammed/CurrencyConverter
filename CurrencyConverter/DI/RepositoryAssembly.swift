//
//  RepositoryAssembly.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation
import Swinject

class RepositoryAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(CurrencyRepositoryProtocol.self) { _ in
            return CurrencyRepository()
        }
        
    }
    
}
