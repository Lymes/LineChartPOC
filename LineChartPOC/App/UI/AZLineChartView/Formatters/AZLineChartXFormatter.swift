//
//  AZLineChartXFormatter.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 05/02/23.
//

import Foundation
import Charts

class AZLineChartXFormatter: NSObject {
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yy"
        return formatter
    }()
}

extension AZLineChartXFormatter: AxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: value)
        return dateFormatter.string(from: date)
    }
}
