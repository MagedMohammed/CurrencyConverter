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
            .subscribe(onNext: { error in
                self.showAlert(with: error)
            })
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
            .drive(onNext: { [weak self] model in
                guard let self = self, let model = model else { return }
                self.mainView.configure(model: model)
            })
            .disposed(by: disposeBag)
        
        mainView
            .currenciesTableView
            .rx
            .modelSelected(CurrencyRateViewModel.self)
            .subscribe(onNext: { [weak self] model in
                guard let self = self, let baseCurrency = self.viewModel.baseCurrency else { return }
                DispatchQueue.main.async {
                    self.present(CurrencyConverterViewController.create(baseCurrency: baseCurrency, selectedCurrency: model), requiresFullScreen: false)
                }
            }).disposed(by: disposeBag)
        
        mainView.currencyViewTapGesture.rx.event.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            let currencySelectorViewController = CurrencySelectorViewController.create(currencyList: self.viewModel.currencyList)
            currencySelectorViewController
                .didSelectCurrency
                .bind(to: self.viewModel.didSelectCurrency)
                .disposed(by: self.disposeBag)
            self.present(currencySelectorViewController, requiresFullScreen: false)
        }).disposed(by: disposeBag)
    }
    
}

extension CurrencyRatesViewController {
    
    static func create() -> CurrencyRatesViewController {
        return DependencyLoader.instance.container.resolve(CurrencyRatesViewController.self)!
    }
    
}
