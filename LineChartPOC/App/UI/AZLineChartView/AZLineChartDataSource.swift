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
    private var colors: [UIColor] = []

    @Published
    var chartData: LineChartData = LineChartData()

    // MARK: Public API

    var rawData: [[DataPoint]] = [] {
        didSet {
            generateRandomColors()
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
        let dataSets = data.createChartDatasets(decorator: decorateDataSet)
        chartData = LineChartData(dataSets: dataSets)
    }

    // MARK: Private methods

    private func decorateDataSet(_ dataSet: LineChartDataSet, _ index: Int) -> LineChartDataSet {
        dataSet.lineWidth = 1
        dataSet.colors = [colors[index]]
        dataSet.drawCircleHoleEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = true
        dataSet.highlightLineWidth = 2
        dataSet.highlightColor = .red
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        return dataSet
    }

    private func generateRandomColors() {
        colors = []
        for _ in 0...rawData.count {
            colors.append(.random())
        }
    }
}
