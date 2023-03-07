//
//  AZLineChartGenericStyle.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 05/02/23.
//

import UIKit
import SwiftUI

struct AZLineChartGenericStyle: AZLineChartStyle {

    let lineWidth: CGFloat               = 2.0
    let xAxisLabelFont: UIFont           = .systemFont(ofSize: 11.0)
    let xAxisLabelTextColor: UIColor     = .black
    let xAxisLabelCount: Int             = 5
    let leftAxisLabelTextColor           = UIColor(red: 0.2, green: 0.709, blue: 0.898, alpha: 1.0)
    let rightAxisLabelTextColor: UIColor = .red
    let highlightLineWidth: CGFloat      = 4.0
    let highlightColor                   = UIColor(red: 0, green: 0.478, blue: 0.702, alpha: 1.0)
    let veilColor                        = UIColor.init(white: 0.99, alpha: 0.8)
    let zoomMagnifyingStep: CGFloat      = 5.0

    var dataColors: [UIColor] = []

    init() {
        // dataColors.append(.blue)
        for _ in 0...30 {
            // pastels
            // let color = UIColor(hue: .random(in: 0..<360), saturation: 0.8, brightness: 0.8, alpha: 0.99)
            // robust
            // let color = UIColor(hue: .random(in: 0..<360), saturation: 0.6, brightness: 0.5, alpha: 0.99)
            // HLCA
            let color = UIColor(hue: .random(in: 0..<1.0), luminance: 0.7, chroma: 0.9, alpha: 0.99)
            dataColors.append(color)
        }
    }
}
