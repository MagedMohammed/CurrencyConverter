//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CurrencyConverterViewModel {
    
    var currentValue: BehaviorRelay<String> = .init(value: "")
    var convertedValue: BehaviorRelay<String> = .init(value: "")
    
    var baseCurrency: CurrencyRateViewModel!
    var selectedCurrency: CurrencyRateViewModel!
    
    private let disposeBag = DisposeBag()
    
    init() {
        observeChanges()
    }
    
    private func observeChanges() {
        currentValue
            .map { currentValue in
                guard let doubleValue = Double(currentValue) else { return "0.00" }
                let convertedValue = (doubleValue * self.selectedCurrency.value) / self.baseCurrency.value
                return String(convertedValue.roundTo(places: 5))
            }
            .bind(to: convertedValue)
            .disposed(by: disposeBag)
    }
}
