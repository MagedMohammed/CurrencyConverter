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
    
    private(set) var currentValue: BehaviorRelay<String> = .init(value: "")
    private(set) var convertedValue: BehaviorRelay<String> = .init(value: "")
    
    var baseCurrency: CurrencyRateViewModel!
    var selectedCurrency: CurrencyRateViewModel!
    
    private let disposeBag = DisposeBag()
    
    init() {
        observeChanges()
    }
    
    private func observeChanges() {
        currentValue
            .map(Double.init)
            .map(getConvertedValue(of:))
            .bind(to: convertedValue)
            .disposed(by: disposeBag)
    }
    
    private func getConvertedValue(of value: Double?) -> String {
        guard let value = value else { return "0.00" }
        let convertedValue = (value * self.selectedCurrency.value) / self.baseCurrency.value
        return String(convertedValue.roundTo(places: 5))
    }
}
