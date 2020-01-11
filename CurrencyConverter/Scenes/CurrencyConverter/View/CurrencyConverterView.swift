//
//  CurrencyConverterView.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import UIKit

class CurrencyConverterView: UIView {
    
    let currencyTextFieldsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let baseCurrencyTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 23, weight: .regular)
        textField.placeholder = "0.00"
        textField.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let baseCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let selectedCurrencyTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 23, weight: .regular)
        textField.placeholder = "0.00"
        textField.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    let selectedCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .appBlue
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(currencyTextFieldsContainerView)
        currencyTextFieldsContainerView.addSubview(baseCurrencyTextField)
        currencyTextFieldsContainerView.addSubview(baseCurrencyLabel)
        currencyTextFieldsContainerView.addSubview(separatorView)
        currencyTextFieldsContainerView.addSubview(selectedCurrencyTextField)
        currencyTextFieldsContainerView.addSubview(selectedCurrencyLabel)
    }
    
    private func setupCurrencyTextFieldsContainerViewConstraints() {
        currencyTextFieldsContainerView.constraint {
            $0.top(0)
            $0.leading(0)
            $0.trailing(0)
        }
    }
    
    private func setupBaseCurrencyTextFieldConstraints() {
        baseCurrencyTextField.constraint {
            $0.top(32)
            $0.leading(32)
            $0.height(50)
            $0.trailingToLeading(ofView: baseCurrencyLabel, withPadding: 8)
        }
    }
    
    private func setupBaseCurrencyLabelConstraints() {
        baseCurrencyLabel.constraint {
            $0.trailing(8)
            $0.centerY(0, toView: baseCurrencyTextField)
            $0.width(50)
        }
    }
    
    private func setupSeparatorViewConstraints() {
        separatorView.constraint {
            $0.topToBottom(ofView: baseCurrencyTextField, withPadding: 32)
            $0.leading(0)
            $0.trailing(0)
            $0.height(0.3)
        }
    }
    
    private func setupSelectedCurrencyTextFieldConstraints() {
        selectedCurrencyTextField.constraint {
            $0.topToBottom(ofView: separatorView, withPadding: 32)
            $0.leading(32)
            $0.height(50)
            $0.bottom(24)
            $0.trailingToLeading(ofView: selectedCurrencyLabel, withPadding: 8)
        }
    }
    
    private func setupSelectedCurrencyLabelConstraints() {
        selectedCurrencyLabel.constraint {
            $0.trailing(8)
            $0.centerY(0, toView: selectedCurrencyTextField)
            $0.width(50)
        }
    }
    
    private func layoutUI() {
        addSubviews()
        setupCurrencyTextFieldsContainerViewConstraints()
        setupBaseCurrencyTextFieldConstraints()
        setupBaseCurrencyLabelConstraints()
        setupSeparatorViewConstraints()
        setupSelectedCurrencyTextFieldConstraints()
        setupSelectedCurrencyLabelConstraints()
    }
    
    func configure(baseCurrency: CurrencyRateViewModel, selectedCurrency: CurrencyRateViewModel) {
        baseCurrencyLabel.text = baseCurrency.title
        selectedCurrencyLabel.text = selectedCurrency.title
    }
    
}

#if DEBUG && canImport(SwiftUI)
import SwiftUI

struct CurrencyConverterViewControllerContainerView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CurrencyConverterViewControllerContainerView>) -> CurrencyConverterViewController {
        return CurrencyConverterViewController.create(baseCurrency: CurrencyRateViewModel(flagCode: "123", title: "123", value: 12), selectedCurrency: CurrencyRateViewModel(flagCode: "123", title: "123", value: 12))
    }
    
    func updateUIViewController(_ uiViewController: CurrencyConverterViewController, context: UIViewControllerRepresentableContext<CurrencyConverterViewControllerContainerView>) {}
    
    
}

struct CurrencyConverterViewControllerPreviewer: PreviewProvider {
    
    static var previews: some View {
        CurrencyConverterViewControllerContainerView().edgesIgnoringSafeArea(.all)
    }
    
}
#endif
