//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import UIKit
import RxSwift

class CurrencyConverterViewController: UIViewController, UITextFieldDelegate {
    
    private let mainView = CurrencyConverterView(frame: UIScreen.main.bounds)
    
    @Inject private var viewModel: CurrencyConverterViewModel
    
    private let baseCurrency: CurrencyRateViewModel
    private let selectedCurrency: CurrencyRateViewModel
    private let disposeBag = DisposeBag()
    
    init(baseCurrency: CurrencyRateViewModel, selectedCurrency: CurrencyRateViewModel) {
        self.baseCurrency = baseCurrency
        self.selectedCurrency = selectedCurrency
        mainView.configure(baseCurrency: baseCurrency, selectedCurrency: selectedCurrency)
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
        setupTextFieldDelegate()
        setupBindings()
    }
    
    private func setupTextFieldDelegate() {
        mainView.baseCurrencyTextField.delegate = self
    }
    
    private func setupBindings() {
        
        mainView
            .baseCurrencyTextField
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.currentValue)
            .disposed(by: disposeBag)
        
        viewModel
            .convertedValue
            .asDriver()
            .drive(mainView.selectedCurrencyTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString
        let newText = text.replacingCharacters(in: range, with: string)
        if let regex = try? NSRegularExpression(pattern: "^[0-9]*((\\.|,)[0-9]{0,2})?$", options: .caseInsensitive) {
            return regex.numberOfMatches(in: newText, options: .reportProgress, range: NSRange(location: 0, length: (newText as NSString).length)) > 0
        }
        return false
    }
}

extension CurrencyConverterViewController {
    
    static func create(baseCurrency: CurrencyRateViewModel, selectedCurrency: CurrencyRateViewModel) -> CurrencyConverterViewController {
        let viewController = DependencyLoader.instance.container.resolve(CurrencyConverterViewController.self, arguments: baseCurrency, selectedCurrency)!
        viewController.viewModel.baseCurrency = baseCurrency
        viewController.viewModel.selectedCurrency = selectedCurrency
        return viewController
    }
    
}
