//
//  AZLineChartDataSource.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 03/02/23.
//

import UIKit
import Charts
import Combine

final class AZLineChartDataSource {
    private static let maxVisiblePoints = 100000
    private static let minRangeSeconds: Double = 72 * 3600

    // MARK: Public API

    @Published
    var chartData: LineChartData = LineChartData()

    var calculatePerformance = true {
        didSet {
            updateChartData()
        }
    }

    var rangedData: [[DataPoint]] = [] {
        didSet {
            updateChartData()
        }
    }

    var dataSetDecorator: DataSetDecorator?

    var rawData: [[DataPoint]] = [] {
        didSet {
            setRange(startDate: rawData.minDate, endDate: rawData.maxDate)
        }
    }

    func setRange(startDate: Date, endDate: Date) {
        guard (endDate.timeIntervalSince1970 -
               startDate.timeIntervalSince1970) > Self.minRangeSeconds else { return }
        rangedData = rawData
            .getRange(startDate: startDate, endDate: endDate)
            .filter(by: Self.maxVisiblePoints, interpolator: LinearInterpolator())
    }

    private func updateChartData() {
        let dataSets = rangedData.createChartDatasets(decorator: dataSetDecorator,
                                                      calculatePerformance: calculatePerformance)
        chartData = LineChartData(dataSets: dataSets)
    }
}
