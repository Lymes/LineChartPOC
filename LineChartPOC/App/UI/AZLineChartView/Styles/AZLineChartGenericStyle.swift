//
//  AZLineChartGenericStyle.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 05/02/23.
//

import UIKit

struct AZLineChartGenericStyle: AZLineChartStyle {

    let lineWidth: CGFloat = 2.0

    let xAxisLabelFont: UIFont = .systemFont(ofSize: 11)
    let xAxisLabelTextColor: UIColor = .black
    let xAxisLabelCount: Int = 5

    let leftAxisLabelTextColor: UIColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
    let rightAxisLabelTextColor: UIColor = .red

    var dataColors: [UIColor] = []

    init() {
        for _ in 0...30 {
            dataColors.append(.random())
        }
    }
}
