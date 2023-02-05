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

    var style: AZLineChartStyle = AZLineChartGenericStyle()

    var datasource: AZLineChartDataSource? {
        didSet {
            setupStyle()
            datasource?.dataSetDecorator = decorateDataSet
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

    private func setupStyle() {
        setupRenderer()
        setupBehavior()
        setupXAxis()
    }

    private func setupBehavior() {
        dragEnabled = true
        setScaleEnabled(false)
        pinchZoomEnabled = false
        doubleTapToZoomEnabled = false
        highlightPerTapEnabled = false
        dragEnabled = false
        marker = AZLineChartMarker()
        setupGestures()
    }

    private func setupXAxis() {
        xAxis.labelFont = style.xAxisLabelFont
        xAxis.labelTextColor = style.xAxisLabelTextColor
        xAxis.drawAxisLineEnabled = false
        xAxis.labelCount = style.xAxisLabelCount
        xAxis.labelPosition = .bottom
        xAxis.drawLabelsEnabled = true
        xAxis.drawLimitLinesBehindDataEnabled = true
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.valueFormatter = AZLineChartXFormatter()
        leftAxis.labelTextColor = style.leftAxisLabelTextColor
        leftAxis.drawGridLinesEnabled = true
        leftAxis.granularityEnabled = true
        rightAxis.labelTextColor = style.rightAxisLabelTextColor
        rightAxis.granularityEnabled = false
    }

    private func setupObservers() {
        cancellable = datasource?.$chartData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
            self?.data = data
        }
    }

    private func setupRenderer() {
        if let defaultRenderer = renderer {
            let animator = defaultRenderer.animator
            let viewPort = defaultRenderer.viewPortHandler
            renderer = AZLineChartRenderer(
                dataProvider: self,
                animator: animator,
                viewPortHandler: viewPort
            )
        }
    }

    private func decorateDataSet(_ dataSet: LineChartDataSet, _ index: Int) -> LineChartDataSet {
        dataSet.lineWidth = 1
        dataSet.colors = [style.dataColors[index]]
        dataSet.drawCircleHoleEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = true
        dataSet.highlightLineWidth = 2
        dataSet.highlightColor = .red
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        return dataSet
    }
}
