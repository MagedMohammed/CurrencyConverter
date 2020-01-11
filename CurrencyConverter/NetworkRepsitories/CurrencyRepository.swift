//
//  CurrencyRepository.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation
import RxSwift

protocol CurrencyRepositoryProtocol {
    func getLatestPrices(for type: CurrencyType) -> Single<CurrencyRate>
}

class CurrencyRepository: CurrencyRepositoryProtocol {
    
    @Inject var networkHandler: NetworkHandlerProtocol
    
    func getLatestPrices(for type: CurrencyType) -> Single<CurrencyRate> {
        return Single<CurrencyRate>.create { single in
            do {
                try self.networkHandler.request(CurrencyRouter.latest(forType: type), debug: false).decoded(toType: CurrencyRate.self).observe { result in
                    switch result {
                    case .success(let response):
                        single(.success(response))
                    case .failure(let error):
                        single(.error(error))
                    }
                }
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
}
