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

    func chartDataset(calculatePerformance: Bool) -> LineChartDataSet {
        LineChartDataSet(entries: map {
            ChartDataEntry(
                x: Double($0.date.timeIntervalSince1970),
                y: calculatePerformance ?
                    Double($0.value - (first?.value ?? 0)) / Double(first?.value ?? 0) :
                    Double($0.value),
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

    func filter(by maxVisible: Int, interpolator: DataPointIntepolator) -> [[DataPoint]] {
        let stride = maxPoints / maxVisible
        return stride > 2 ? decimate(by: stride, interpolator: interpolator) : self
    }

    func createChartDatasets(decorator: DataSetDecorator?, calculatePerformance: Bool) -> [LineChartDataSet] {
        enumerated().map { index, element in
            let dataSet = element.chartDataset(calculatePerformance: calculatePerformance)
            guard let decorator = decorator else { return dataSet }
            return decorator(dataSet, index)
        }
    }
}

extension Array where Element == AZLineChartMarkerView {

    var left: AZLineChartMarkerView? {
        self.min { marker1, marker2 in marker1.value.x < marker2.value.x }
    }

    var right: AZLineChartMarkerView? {
        self.max { marker1, marker2 in marker1.value.x < marker2.value.x }
    }

    func closest(to value: CGPoint) -> AZLineChartMarkerView? {
        self.min { marker1, marker2 in
            abs(marker1.value.x - value.x) < abs(marker2.value.x - value.x)
        }
    }
}
