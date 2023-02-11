//
//  CALayer+Extensions.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 11/02/23.
//

import UIKit

extension CALayer {
    class func perform(withDuration duration: Double, actions: () -> Void) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        actions()
        CATransaction.commit()
    }
}
