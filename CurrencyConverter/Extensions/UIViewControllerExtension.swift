//
//  UIViewControllerExtension.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(with message: String) {
        AlertBuilder(title: "", message: message, preferredStyle: .alert)
            .addAction(title: "OK", style: .default)
            .build()
            .show()
    }
    
    func present(_ viewController: UIViewController, requiresFullScreen: Bool = true, completion: (() -> ())? = nil) {
        if #available(iOS 13.0, *) {
            viewController.modalPresentationStyle = requiresFullScreen ? .fullScreen : .automatic
        }
        present(viewController, animated: true, completion: completion)
    }
}
