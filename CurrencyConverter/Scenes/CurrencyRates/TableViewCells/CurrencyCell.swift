//
//  CurrencyCell.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "eur")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = "EUR"
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "0.0"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(flagImageView)
        addSubview(titleLabel)
        addSubview(valueLabel)
    }
    
    private func setupFlagImageViewConstraints() {
        flagImageView.constraint {
            $0.leading(16)
            $0.centerY(0)
            $0.width(35)
            $0.height(32)
        }
    }
    
    private func setupCurrencyTitleLabelConstraints() {
        titleLabel.constraint {
            $0.leadingToTrailing(ofView: flagImageView, withPadding: 16)
            $0.centerY(0, toView: flagImageView)
            $0.trailing(16)
        }
    }
    
    private func setupCurrencyValueLabelConstraints() {
        valueLabel.constraint {
            $0.trailing(16)
            $0.centerY(0, toView: flagImageView)
            $0.trailing(16)
        }
    }
    
    private func layoutUI() {
        addSubviews()
        setupFlagImageViewConstraints()
        setupCurrencyTitleLabelConstraints()
        setupCurrencyValueLabelConstraints()
    }
    
    func configure(model: CurrencyRateViewModel) {
        flagImageView.image = UIImage(named: model.flagCode) ?? UIImage(named: "blankflag")
        titleLabel.text = model.title
        valueLabel.text = "\(model.value)"
    }
}

#if DEBUG && canImport(SwiftUI)
import SwiftUI

struct CurrencyCellContainerView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<CurrencyCellContainerView>) -> UITableViewCell {
        CurrencyCell()
    }
    
    func updateUIView(_ uiView: UITableViewCell, context: UIViewRepresentableContext<CurrencyCellContainerView>) {}
    
    
}

struct CurrencyCellPreviewer: PreviewProvider {
    
    static var previews: some View {
        CurrencyCellContainerView().frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
    }
    
}

#endif
