//
//  DataPointInterpolator.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 04/02/23.
//

import Foundation

protocol DataPointIntepolator {
    func interpolate(_ chunk: [DataPoint]) -> DataPoint
}

final class LinearInterpolator: DataPointIntepolator {

    func interpolate(_ chunk: [DataPoint]) -> DataPoint {
        let midTime = chunk.reduce(Double(0)) { $0 + $1.date.timeIntervalSince1970 } / Double(chunk.count)
        let midValue = chunk.reduce(Double(0)) { $0 + $1.value } / Double(chunk.count)
        let isEvent = !chunk.filter { $0.isEvent }.isEmpty
        return DataPoint(date: Date(timeIntervalSince1970: midTime), value: midValue, isEvent: isEvent)
    }
}
