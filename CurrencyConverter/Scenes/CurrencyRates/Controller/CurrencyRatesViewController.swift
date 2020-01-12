//
//  CurrencyPricesViewController.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import UIKit
import RxSwift

class CurrencyRatesViewController: UIViewController {
    
    private let mainView = CurrencyRatesView(frame: UIScreen.main.bounds)
    
    @Inject private var viewModel: CurrencyRatesViewModel
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.loadCurrencyList()
    }
    
    private func setupBindings() {
        
        viewModel
            .isLoading
            .bind(to: view.rx.isLoading)
            .disposed(by: disposeBag)
        
        viewModel
            .error
            .map(self.showAlert(with:))
            .subscribe()
            .disposed(by: disposeBag)
        
        viewModel
            .currencyList
            .asDriver()
            .drive(mainView.currenciesTableView.rx.items(cellIdentifier: CurrencyCell.className, cellType: CurrencyCell.self)) { _, model, cell in
                cell.configure(model: model)
            }
            .disposed(by: disposeBag)
        
        viewModel
            .currentCurrency
            .asDriver()
            .map(self.mainView.configure(model:))
            .drive()
            .disposed(by: disposeBag)
        
        mainView
            .currenciesTableView
            .rx
            .modelSelected(CurrencyRateViewModel.self)
            .map(navigateToCurrencyConverterViewController(selectedCurrency:))
            .subscribe()
            .disposed(by: disposeBag)
        
        mainView
            .currencyViewTapGesture
            .rx
            .event
            .map(navigateToCurrencySelectorViewController(_:))
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func navigateToCurrencyConverterViewController(selectedCurrency: CurrencyRateViewModel) {
        guard let baseCurrency = viewModel.baseCurrency else { return }
        DispatchQueue.main.async {
            self.present(CurrencyConverterViewController.create(baseCurrency: baseCurrency, selectedCurrency: selectedCurrency), requiresFullScreen: false)
        }
    }
    
    private func navigateToCurrencySelectorViewController(_ tapGesture: UITapGestureRecognizer) {
        let currencySelectorViewController = CurrencySelectorViewController(currencyList: viewModel.currencyList)
        
        currencySelectorViewController
            .didSelectCurrency
            .bind(to: viewModel.didSelectCurrency)
            .disposed(by: disposeBag)
        
        self.present(currencySelectorViewController, requiresFullScreen: false)
    }
    
}

extension CurrencyRatesViewController {
    
    static func create() -> CurrencyRatesViewController {
        return DependencyLoader.instance.container.resolve(CurrencyRatesViewController.self)!
    }
    
}
