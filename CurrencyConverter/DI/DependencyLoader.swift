//
//  DependencyLoader.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation
import Swinject

class DependencyLoader {
    
    static let instance: DependencyLoader = DependencyLoader()
    
    let container = Container()
    private let assembler: Assembler
    
    private init() {
        assembler = Assembler([
            NetworkAssembly(),
            RepositoryAssembly(),
            ViewControllerAssembly(),
            ViewModelAssembly(),
        ], container: container)
        InjectSettings.resolver = container
    }
    
}
