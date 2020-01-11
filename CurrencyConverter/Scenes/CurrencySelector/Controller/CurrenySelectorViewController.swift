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
    var didSelectCurrency: PublishSubject<CurrencyRateViewModel> = .init()
    
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
            .subscribe(onNext: { [weak self] model in
                guard let self = self else { return }
                self.didSelectCurrency.onNext(model)
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
}

extension CurrencySelectorViewController {
    
    static func create(currencyList: BehaviorRelay<[CurrencyRateViewModel]>) -> CurrencySelectorViewController {
        return DependencyLoader.instance.container.resolve(CurrencySelectorViewController.self, argument: currencyList)!
    }
    
}
