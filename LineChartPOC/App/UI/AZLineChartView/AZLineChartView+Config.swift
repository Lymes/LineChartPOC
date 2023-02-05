//
//  AZLineChartView+Config.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 05/02/23.
//

import UIKit
import Charts

typealias DataSetDecorator = (LineChartDataSet, Int) -> LineChartDataSet

extension AZLineChartView {

    func setupStyle() {
        setupRenderer()
        setupBehavior()
        setupXAxis()
    }

    func decorate(_ dataSet: LineChartDataSet, _ index: Int) {
        dataSet.lineWidth = 1
        dataSet.colors = [style.dataColors[index]]
        dataSet.drawCircleHoleEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = true
        dataSet.highlightLineWidth = 2
        dataSet.highlightColor = .red
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
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
}
