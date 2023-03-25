//
//  UIView+Extensions.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 24/03/23.
//

import UIKit

extension UIView {

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    static func instantiate(autolayout: Bool = true) -> Self {
        // generic helper function
        func instantiateUsingNib<T: UIView>(autolayout: Bool) -> T {
            if let view = self.nib.instantiate() as? T {
                view.translatesAutoresizingMaskIntoConstraints = !autolayout
                return view
            }
            return T()
        }
        return instantiateUsingNib(autolayout: autolayout)
    }
}

extension UINib {
    func instantiate() -> Any? {
        return self.instantiate(withOwner: nil, options: nil).first
    }
}
