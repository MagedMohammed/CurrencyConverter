//
//  CurrencyPricesViewModel.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CurrencyRatesViewModel {
    
    @Inject private var currencyRepository: CurrencyRepositoryProtocol
    
    private let disposeBag = DisposeBag()
    
    private var currencyViewModels = [CurrencyRateViewModel]()
    private(set) var baseCurrency: CurrencyRateViewModel?
    
    var currencyList: BehaviorRelay<[CurrencyRateViewModel]> = .init(value: [])
    var currentCurrency: BehaviorRelay<CurrencyRateViewModel?> = .init(value: nil)
    var isLoading: PublishSubject<Bool> = .init()
    var error: PublishSubject<String> = .init()
    var didSelectCurrency: PublishSubject<CurrencyRateViewModel> = .init()
    
    init() {
        observeChanges()
    }
    
    func loadCurrencyList() {
        isLoading.onNext(true)
        currencyRepository
            .getLatestPrices(for: .eur)
            .map { rates -> [CurrencyRateViewModel] in
                return rates.rates
                    .map { key, value in return CurrencyRateViewModel(flagCode: key.lowercased(), title: key.uppercased(), value: value.roundTo(places: 5)) }
                    .sorted(by: { $0.title < $1.title })
            }.subscribe(onSuccess: { [weak self] viewModels in
                guard let self = self else { return }
                self.isLoading.onNext(false)
                self.currencyList.accept(viewModels)
                self.currencyViewModels = viewModels
                self.baseCurrency = viewModels.first(where: { $0.title == CurrencyType.eur.rawValue })
                self.currentCurrency.accept(self.baseCurrency)
            }, onError: { error in
                    self.isLoading.onNext(false)
                    self.error.onNext(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    private func observeChanges() {
        didSelectCurrency.subscribe(onNext: { [weak self] currencyRate in
            guard let self = self else { return }
            self.calculateCurrencyPrices(against: currencyRate)
        }).disposed(by: disposeBag)
    }
    
    private func calculateCurrencyPrices(against selectedCurrency: CurrencyRateViewModel) {
        guard let baseCurrency = baseCurrency else { return }
        
        let priceAgainstCurrentCurrency = baseCurrency.value / selectedCurrency.value
        let viewModels = currencyViewModels.map { CurrencyRateViewModel(flagCode: $0.flagCode, title: $0.title, value: ($0.value * priceAgainstCurrentCurrency).roundTo(places: 5)) }
        
        self.currencyViewModels = viewModels
        self.currencyList.accept(viewModels)
        
        var selectedCurrency = selectedCurrency
        selectedCurrency.value = 1.0
        
        self.baseCurrency = selectedCurrency
        self.currentCurrency.accept(selectedCurrency)
        
    }
    
    
}
