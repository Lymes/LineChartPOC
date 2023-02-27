//
//  DataModel.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 03/02/23.
//

import Foundation

// NB. Ho usato class perche passo la reference a ChartDataEntry
// per eventuale uso e per ottimizzare uso di memoria
//
final class DataPoint: Decodable {
    let date: Date
    let valueY: Double

    var isEvent: Bool { false }
    var value: Double { valueY }

    init(date: Date, value: Double, isEvent: Bool = false) {
        self.date = date
        self.valueY = value
    }
}

struct DataSet: Decodable {
    let points: [DataPoint]
}
