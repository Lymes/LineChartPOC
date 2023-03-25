//
//  TableChartModel.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 16/03/23.
//

import Foundation
import UIKit

struct TableChartRowModel: Hashable {
    let title: String
    let data1: Double
    let data2: Double
    let data3: Double
    let data4: Double
    let data5: Double
    let data6: Double
    let color: UIColor
}


extension Array where Element == TableChartRowModel {

    var minPerformance: Double {
        self.min { point1, point2 in point1.data1 < point2.data1 }?.data1 ?? 0
    }

    var maxPerformance: Double {
        self.max { point1, point2 in point1.data1 < point2.data1 }?.data1 ?? 0
    }

    var maxScale: Double {
        Swift.min(Swift.max(Swift.abs(minPerformance), Swift.abs(maxPerformance)), 100.0)
    }
}
