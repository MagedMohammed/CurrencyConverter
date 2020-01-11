//
//  CurrencySelectorView.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import UIKit

class CurrencySelectorView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Your Preferred Currency"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let currenciesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(type: CurrencyCell.self)
        tableView.rowHeight = 50
        return tableView
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
        addSubview(titleLabel)
        addSubview(currenciesTableView)
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.constraint {
            $0.safeAreaTop(16)
            $0.centerX(0)
        }
    }
    
    private func setupCurrenciesTableViewConstraints() {
        currenciesTableView.constraint {
            $0.topToBottom(ofView: titleLabel, withPadding: 16)
            $0.leading(0)
            $0.trailing(0)
            $0.bottom(0)
        }
    }
    
    private func layoutUI() {
        addSubviews()
        setupTitleLabelConstraints()
        setupCurrenciesTableViewConstraints()
    }
}

#if DEBUG && canImport(SwiftUI)
import SwiftUI

struct CurrencySelectorViewControllerContainerView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CurrencySelectorViewControllerContainerView>) -> CurrencySelectorViewController {
        return CurrencySelectorViewController.create(currencyList: .init(value: []))
    }
    
    func updateUIViewController(_ uiViewController: CurrencySelectorViewController, context: UIViewControllerRepresentableContext<CurrencySelectorViewControllerContainerView>) {}
    
    
}

struct CurrencySelectorViewControllerPreviewer: PreviewProvider {
    
    static var previews: some View {
        CurrencySelectorViewControllerContainerView().edgesIgnoringSafeArea(.all)
    }
    
}
#endif
