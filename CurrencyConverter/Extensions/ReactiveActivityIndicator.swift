//
//  ReactiveActivityIndicator.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    
    public var isLoading: Binder<Bool> {
        return Binder(base) { view, isActive in
            if isActive {
                view.showActivityIndicator(isUserInteractionEnabled: true)
            } else {
                view.hideActivityIndicator()
            }
        }
    }
    
}
