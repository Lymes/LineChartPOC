//
//  AZLineChartDataSource.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 03/02/23.
//

import UIKit
import Charts
import Combine

typealias DataSetDecorator = (LineChartDataSet, Int) -> LineChartDataSet

final class AZLineChartDataSource {
    private static let maxVisiblePoints = 100

    @Published
    var chartData: LineChartData = LineChartData()

    // MARK: Public API

    var dataSetDecorator: DataSetDecorator?

    var rawData: [[DataPoint]] = [] {
        didSet {
            setRange(startDate: rawData.minDate, endDate: rawData.maxDate)
        }
    }

    func setRange(startDate: Date, endDate: Date) {
        let prepared = rawData
            .getRange(startDate: startDate, endDate: endDate)
            .filterBy(maxVisible: Self.maxVisiblePoints, interpolator: LinearInterpolator())
        setData(prepared)
    }

    func setData(_ data: [[DataPoint]]) {
        let dataSets = data.createChartDatasets(decorator: dataSetDecorator)
        chartData = LineChartData(dataSets: dataSets)
    }
}
