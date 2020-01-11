//
//  NetworkAssembly.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation
import Swinject
import Alamofire

class NetworkAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(NetworkMiddlewareProtocol.self) { _ in
            return NetworkMiddleware()
        }
        
        container.register(SessionManager.self) { resolver in
            return resolver.resolve(NetworkMiddlewareProtocol.self)!.sessionManager
        }
        
        container.register(NetworkHandlerProtocol.self) { _ in
            return NetworkHandler()
        }
    }
    
}
