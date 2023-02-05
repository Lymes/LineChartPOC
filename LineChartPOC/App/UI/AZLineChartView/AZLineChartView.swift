//
//  AZLineChartView.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 03/02/23.
//

import UIKit
import Charts
import Combine

final class AZLineChartView: LineChartView, ChartViewDelegate {

    private var cancellable: AnyCancellable?
    override var highlighted: [Highlight] {
        super.highlighted
    }

    // MARK: Public API

    var style: AZLineChartStyle = AZLineChartGenericStyle() {
        didSet {
            setupStyle()
        }
    }

    var datasource: AZLineChartDataSource? {
        didSet {
            datasource?.dataSetDecorator = { [weak self] dataSet, index in
                self?.decorate(dataSet, index)
                return dataSet
            }
            setupObservers()
        }
    }

    var markersRange: (Date, Date)? {
        if highlighted.count > 1 {
            return (
                Date(timeIntervalSince1970: highlighted.leftHighlight?.x ?? 0),
                Date(timeIntervalSince1970: highlighted.rightHighlight?.x ?? 0)
            )
        }
        return nil
    }

    func toggleEvents() {
        var events = highlighted
        if events.count > 0 {
            events = []
        } else {
            events = datasource?.rawData.highlights ?? []
        }
        highlightValues(events)
    }

    // MARK: Private methods

    private func setupObservers() {
        cancellable = datasource?.$chartData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.data = data
            }
    }
}
