//
//  UIViewExtension.swift
//  CurrencyConverter
//
//  Created by Tarek Sabry on 1/11/20.
//  Copyright © 2020 Tarek Sabry. All rights reserved.
//

import UIKit
import MBProgressHUD

enum Edge {
    case safeAreaTop(CGFloat)
    case top(CGFloat)
    case leading(CGFloat)
    case trailing(CGFloat)
    case bottom(CGFloat)
    case safeAreaBottom(CGFloat)
}


extension UIView {
    
    func showActivityIndicator(isUserInteractionEnabled: Bool) {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.isUserInteractionEnabled = !isUserInteractionEnabled
        hud.restorationIdentifier = "activityIndicator"
    }
    
    func hideActivityIndicator() {
        for subview in self.subviews where subview.restorationIdentifier == "activityIndicator" {
            guard let hud = subview as? MBProgressHUD else { return }
            hud.hide(animated: true)
        }
    }
    
    func constraint(block: (UIView) -> ()) {
        translatesAutoresizingMaskIntoConstraints = false
        block(self)
    }
    
    private func constraint(firstAnchor: NSLayoutYAxisAnchor, with secondAnchor: NSLayoutYAxisAnchor, padding: CGFloat, relation: NSLayoutConstraint.Relation? = nil) -> NSLayoutConstraint {
        return firstAnchor.constraint(equalTo: secondAnchor, constant: padding)

//        let relation = relation ?? .equal
//        switch relation {
//        case .equal:
//            return firstAnchor.constraint(equalTo: secondAnchor, constant: padding)
//        case .greaterThanOrEqual:
//            return firstAnchor.constraint(greaterThanOrEqualTo: secondAnchor, constant: padding)
//        case .lessThanOrEqual:
//            return firstAnchor.constraint(lessThanOrEqualTo: secondAnchor, constant: padding)
//        @unknown default:
//            fatalError()
//        }
    }
    
    private func constraint(firstAnchor: NSLayoutXAxisAnchor, with secondAnchor: NSLayoutXAxisAnchor, padding: CGFloat, relation: NSLayoutConstraint.Relation? = nil) -> NSLayoutConstraint {
        let relation = relation ?? .equal
        switch relation {
        case .equal:
            return firstAnchor.constraint(equalTo: secondAnchor, constant: padding)
        case .greaterThanOrEqual:
            return firstAnchor.constraint(greaterThanOrEqualTo: secondAnchor, constant: padding)
        case .lessThanOrEqual:
            return firstAnchor.constraint(lessThanOrEqualTo: secondAnchor, constant: padding)
        @unknown default:
            fatalError()
        }
    }
    
    @discardableResult func safeAreaTop(_ padding: CGFloat, toView view: UIView? = nil, relation: NSLayoutConstraint.Relation? = nil) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        constraint = self.constraint(firstAnchor: topAnchor, with: constraintToView.safeAreaLayoutGuide.topAnchor, padding: padding, relation: relation)
        
        constraint.isActive = true
        return constraint
        
    }
    
    @discardableResult func top(_ padding: CGFloat, toView view: UIView? = nil, relation: NSLayoutConstraint.Relation? = nil) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        constraint = self.constraint(firstAnchor: topAnchor, with: constraintToView.topAnchor, padding: padding, relation: relation)
        
        constraint.isActive = true
        return constraint
        
    }
    
    @discardableResult func topToBottom(ofView view: UIView, withPadding padding: CGFloat, relation: NSLayoutConstraint.Relation? = nil) -> NSLayoutConstraint {
        let constraint = self.constraint(firstAnchor: topAnchor, with: view.bottomAnchor, padding: padding, relation: relation)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func topToCenterY(ofView view: UIView, withPadding padding: CGFloat, relation: NSLayoutConstraint.Relation? = nil) -> NSLayoutConstraint {
        let constraint = self.constraint(firstAnchor: topAnchor, with: view.centerYAnchor, padding: padding, relation: relation)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func leading(_ padding: CGFloat, toView view: UIView? = nil, relation: NSLayoutConstraint.Relation? = nil) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        constraint = self.constraint(firstAnchor: leadingAnchor, with: constraintToView.leadingAnchor, padding: padding, relation: relation)
        
        constraint.isActive = true
        return constraint
        
    }
    
    @discardableResult func leadingToTrailing(ofView view: UIView, withPadding padding: CGFloat, relation: NSLayoutConstraint.Relation? = nil) -> NSLayoutConstraint {
        let constraint = self.constraint(firstAnchor: leadingAnchor, with: view.trailingAnchor, padding: padding, relation: relation)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func leadingToCenterX(ofView view: UIView, withPadding padding: CGFloat, relation: NSLayoutConstraint.Relation? = nil) -> NSLayoutConstraint {
        let constraint = self.constraint(firstAnchor: leadingAnchor, with: view.centerXAnchor, padding: padding, relation: relation)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func trailing(_ padding: CGFloat, toView view: UIView? = nil, relation: NSLayoutConstraint.Relation? = nil) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        constraint = self.constraint(firstAnchor: trailingAnchor, with: constraintToView.trailingAnchor, padding: -padding, relation: relation)
        
        constraint.isActive = true
        return constraint
        
    }
    
    @discardableResult func trailingToLeading(ofView view: UIView, withPadding padding: CGFloat, relation: NSLayoutConstraint.Relation? = nil) -> NSLayoutConstraint {
         let constraint = self.constraint(firstAnchor: trailingAnchor, with: view.leadingAnchor, padding: -padding, relation: relation)
         constraint.isActive = true
         return constraint
     }
    
    @discardableResult func bottom(_ padding: CGFloat, toView view: UIView? = nil, relation: NSLayoutConstraint.Relation? = nil) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        constraint = self.constraint(firstAnchor: bottomAnchor, with: constraintToView.bottomAnchor, padding: -padding, relation: relation)
        
        constraint.isActive = true
        return constraint
        
    }
    
    @discardableResult func safeAreaBottom(_ padding: CGFloat, toView view: UIView? = nil, relation: NSLayoutConstraint.Relation? = nil) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        constraint = self.constraint(firstAnchor: bottomAnchor, with: constraintToView.safeAreaLayoutGuide.bottomAnchor, padding: -padding, relation: relation)
        
        constraint.isActive = true
        return constraint
        
    }
    
    @discardableResult func centerX(_ padding: CGFloat, toView view: UIView? = nil, relation: NSLayoutConstraint.Relation? = nil) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        constraint = self.constraint(firstAnchor: centerXAnchor, with: constraintToView.centerXAnchor, padding: padding, relation: relation)

        constraint.isActive = true
        return constraint
        
    }
    
    
    @discardableResult func centerY(_ padding: CGFloat, toView view: UIView? = nil, relation: NSLayoutConstraint.Relation? = nil) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        constraint = self.constraint(firstAnchor: centerYAnchor, with: constraintToView.centerYAnchor, padding: padding, relation: relation)
        
        constraint.isActive = true
        return constraint
        
    }
    
    @discardableResult func height(_ constant: CGFloat) -> NSLayoutConstraint {
        let constraint = heightAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func width(_ constant: CGFloat) -> NSLayoutConstraint {
        let constraint = widthAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult func height(multiplier: CGFloat, constant: CGFloat = 0, toView view: UIView? = nil) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        constraint = heightAnchor.constraint(equalTo: constraintToView.heightAnchor, multiplier: multiplier, constant: constant)
        constraint.isActive = true
        return constraint
        
    }
    
    @discardableResult func width(multiplier: CGFloat, constant: CGFloat = 0, toView view: UIView? = nil) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        constraint = widthAnchor.constraint(equalTo: constraintToView.widthAnchor, multiplier: multiplier, constant: constant)
        constraint.isActive = true
        return constraint
        
    }
    
    func pin(edges: Edge..., toView view: UIView? = nil) {
        
        let constraintToView: UIView
        
        if let view = view {
            constraintToView = view
        } else {
            guard let superview = superview else { fatalError("Both view and superview are nil") }
            constraintToView = superview
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        for edge in edges {
            switch edge {
            case .safeAreaTop(let padding):
                safeAreaTop(padding, toView: constraintToView)
            case .top(let padding):
                top(padding, toView: constraintToView)
            case .leading(let padding):
                leading(padding, toView: constraintToView)
            case .trailing(let padding):
                trailing(padding, toView: constraintToView)
            case .bottom(let padding):
                bottom(padding, toView: constraintToView)
            case .safeAreaBottom(let padding):
                safeAreaBottom(padding, toView: constraintToView)
            }
        }
    }
}
