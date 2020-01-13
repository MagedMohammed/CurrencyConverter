//
//  CurrenySelectorViewController.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CurrencySelectorViewController: UIViewController {
    
    private let mainView = CurrencySelectorView(frame: UIScreen.main.bounds)
    
    private let currencyList: BehaviorRelay<[CurrencyRateViewModel]>
    private(set) var didSelectCurrency: PublishSubject<CurrencyRateViewModel> = .init()
    
    private let disposeBag = DisposeBag()
    
    init(currencyList: BehaviorRelay<[CurrencyRateViewModel]>) {
        self.currencyList = currencyList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    private func setupBindings() {
        
        currencyList
            .asDriver()
            .drive(mainView.currenciesTableView.rx.items(cellIdentifier: CurrencyCell.className, cellType: CurrencyCell.self)) { _, model, cell in
                cell.configure(model: model)
            }
            .disposed(by: disposeBag)
        
        mainView
            .currenciesTableView
            .rx
            .modelSelected(CurrencyRateViewModel.self)
            .asDriver()
            .map(didSelectCurrency(selectedCurrency:))
            .drive()
            .disposed(by: disposeBag)
    }
    
    private func didSelectCurrency(selectedCurrency: CurrencyRateViewModel) {
        didSelectCurrency.onNext(selectedCurrency)
        dismiss(animated: true, completion: nil)
    }
}

extension CurrencySelectorViewController {
    
    static func create(currencyList: BehaviorRelay<[CurrencyRateViewModel]>) -> CurrencySelectorViewController {
        return DependencyLoader.instance.container.resolve(CurrencySelectorViewController.self, argument: currencyList)!
    }
    
}
