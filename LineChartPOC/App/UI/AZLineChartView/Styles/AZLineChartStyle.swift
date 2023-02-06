//
//  AZLineChartStyle.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 05/02/23.
//

import UIKit

protocol AZLineChartStyle {
    var lineWidth: CGFloat { get }

    var xAxisLabelFont: UIFont { get }
    var xAxisLabelTextColor: UIColor { get }
    var xAxisLabelCount: Int { get }

    var leftAxisLabelTextColor: UIColor { get }
    var rightAxisLabelTextColor: UIColor { get }

    var highlightLineWidth: CGFloat { get }
    var highlightColor: UIColor { get }

    var dataColors: [UIColor] { get }
}
