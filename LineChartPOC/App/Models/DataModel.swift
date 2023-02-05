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
    let value: Int
    let isEvent: Bool

    init(date: Date, value: Int, isEvent: Bool) {
        self.date = date
        self.value = value
        self.isEvent = isEvent
    }
}
