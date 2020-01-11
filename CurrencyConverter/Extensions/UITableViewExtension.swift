//
//  UITableViewExtension.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(type: T.Type) {
        self.register(type, forCellReuseIdentifier: type.className)
    }
    
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.className, for: indexPath) as! T
    }
}
