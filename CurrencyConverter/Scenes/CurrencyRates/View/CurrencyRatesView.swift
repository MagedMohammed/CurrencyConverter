//
//  CurrencyRatesView.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import UIKit

class CurrencyRatesView: UIView, UITextFieldDelegate {
    
    let currencyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "blankflag")
        return imageView
    }()
    
    let currencyTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = "---"
        return label
    }()
    
    let currenciesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(type: CurrencyCell.self)
        tableView.rowHeight = 50
        return tableView
    }()
    
    let currencyViewTapGesture = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .appBlue
        layoutUI()
        setupGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(currencyView)
        currencyView.addSubview(flagImageView)
        currencyView.addSubview(currencyTitleLabel)
        addSubview(currenciesTableView)
    }
    
    private func setupCurrencyViewConstraints() {
        currencyView.constraint {
            $0.safeAreaTop(16)
            $0.centerX(0)
            $0.height(40)
        }
    }
    
    private func setupFlagImageViewConstraints() {
        flagImageView.constraint {
            $0.leading(12)
            $0.centerY(0)
            $0.width(35)
            $0.height(32)
            
        }
    }
    
    private func setupCurrencyTitleLabelConstraints() {
        currencyTitleLabel.constraint {
            $0.leadingToTrailing(ofView: flagImageView, withPadding: 16)
            $0.centerY(0, toView: flagImageView)
            $0.trailing(16)
        }
    }
    
    private func setupCurrenciesTableViewConstraints() {
        currenciesTableView.constraint {
            $0.topToBottom(ofView: currencyView, withPadding: 16)
            $0.leading(0)
            $0.trailing(0)
            $0.bottom(0)
        }
    }
    
    private func layoutUI() {
        addSubviews()
        setupCurrencyViewConstraints()
        setupFlagImageViewConstraints()
        setupCurrencyTitleLabelConstraints()
        setupCurrenciesTableViewConstraints()
    }
    
    private func setupGestureRecognizers() {
        currencyView.addGestureRecognizer(currencyViewTapGesture)
    }
    
    func configure(model: CurrencyRateViewModel) {
        flagImageView.image = UIImage(named: model.flagCode) ?? UIImage(named: "blankflag")
        currencyTitleLabel.text = model.title
    }
    
}

//Improving the workflow with new SwiftUI features.
#if DEBUG && canImport(SwiftUI)
import SwiftUI

struct CurrencyRatesViewControllerContainerView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CurrencyRatesViewControllerContainerView>) -> CurrencyRatesViewController {
        return CurrencyRatesViewController.create()
    }
    
    func updateUIViewController(_ uiViewController: CurrencyRatesViewController, context: UIViewControllerRepresentableContext<CurrencyRatesViewControllerContainerView>) {}
    
    
}

struct CurrencyRatesViewControllerPreviewer: PreviewProvider {
    
    static var previews: some View {
        CurrencyRatesViewControllerContainerView().edgesIgnoringSafeArea(.all)
    }
    
}
#endif
