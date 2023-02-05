//
//  Array+Extensions.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 04/02/23.
//

import Foundation
import Charts

extension Array where Element == DataPoint {

    var minDate: Date {
        self.min { point1, point2 in point1.date < point2.date }?.date ?? Date()
    }

    var maxDate: Date {
        self.max { point1, point2 in point1.date < point2.date }?.date ?? Date()
    }

    var chartDataset: LineChartDataSet {
        LineChartDataSet(entries: map {
            ChartDataEntry(
                x: Double($0.date.timeIntervalSince1970),
                y: Double($0.value),
                data: $0
            )
        })
    }

    func highlights(for index: Int) -> [Highlight] {
        filter { $0.isEvent }.map {
            Highlight(
                x: $0.date.timeIntervalSince1970,
                dataSetIndex: index,
                stackIndex: 0
            )
        }
    }

    func getRange(startDate: Date, endDate: Date) -> [DataPoint] {
        filter { $0.date >= startDate && $0.date <= endDate }
    }

    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }

    func decimate(by stride: Int, interpolator: DataPointIntepolator) -> [DataPoint] {
        chunked(into: stride).compactMap { interpolator.interpolate($0) }
    }
}

extension Array where Element == [DataPoint] {

    var minDate: Date {
        self.min { point1, point2 in point1.minDate < point2.minDate }?.minDate ?? Date()
    }

    var maxDate: Date {
        self.max { point1, point2 in point1.maxDate < point2.maxDate }?.maxDate ?? Date()
    }

    var maxPoints: Int {
        self.max { point1, point2 in point1.count < point2.count }?.count ?? 0
    }

    var highlights: [Highlight] {
        enumerated().flatMap { index, element in
            element.highlights(for: index)
        }
    }

    func getRange(startDate: Date, endDate: Date) -> [[DataPoint]] {
        map { $0.getRange(startDate: startDate, endDate: endDate) }
    }

    func decimate(by stride: Int, interpolator: DataPointIntepolator) -> [[DataPoint]] {
        map { $0.decimate(by: stride, interpolator: interpolator) }
    }

    func filterBy(maxVisible: Int, interpolator: DataPointIntepolator) -> [[DataPoint]] {
        let stride = maxPoints / maxVisible
        return stride > 2 ? decimate(by: stride, interpolator: interpolator) : self
    }

    func createChartDatasets(decorator: DataSetDecorator ) -> [LineChartDataSet] {
        enumerated().map { index, element in
            decorator(element.chartDataset, index)
        }
    }
}

extension Array where Element == Highlight {

    var leftHighlight: Highlight? {
        self.min { highlight1, highlight2 in highlight1.x < highlight2.x }
    }

    var rightHighlight: Highlight? {
        self.max { highlight1, highlight2 in highlight1.x < highlight2.x }
    }

    func closest(to highlight: Highlight) -> Highlight? {
        self.min { highlight1, highlight2 in
            abs(highlight1.x - highlight.x) < abs(highlight2.x - highlight.x)
        }
    }
}
