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
        setupLegendRenderer()
        setupBehavior()
        setupXAxis()
    }

    func decorate(_ dataSet: LineChartDataSet, _ index: Int) {
        dataSet.lineWidth = 1
        dataSet.colors = [style.dataColors[index]]
        dataSet.drawCircleHoleEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = true
        dataSet.highlightLineWidth = style.highlightLineWidth
        dataSet.highlightColor = style.highlightColor
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
    }

    private func setupBehavior() {
        dragEnabled = true
        setScaleEnabled(false)
        pinchZoomEnabled = false
        doubleTapToZoomEnabled = false
        highlightPerTapEnabled = false
        dragEnabled = false
        marker = AZLineChartMarker.viewFromXib()
        legend.enabled = false
        setupGestures()
    }

    private func setupXAxis() {
        xAxisRenderer = AZLineChartXAxisRenderer(
            viewPortHandler: viewPortHandler,
            axis: xAxis,
            transformer: getTransformer(forAxis: .left)
        )
        xAxis.labelFont = style.xAxisLabelFont
        xAxis.labelTextColor = style.xAxisLabelTextColor
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = true
        xAxis.labelCount = style.xAxisLabelCount
        xAxis.labelPosition = .bottom
        xAxis.drawLabelsEnabled = true
        xAxis.drawLimitLinesBehindDataEnabled = true
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.valueFormatter = AZLineChartXFormatter()

        leftAxis.labelTextColor = style.leftAxisLabelTextColor
        leftAxis.drawGridLinesEnabled = true
        leftAxis.zeroLineColor = .red
        // leftAxis.gridColor = .clear

        rightAxis.labelTextColor = style.rightAxisLabelTextColor
        rightAxis.drawGridLinesEnabled = true
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

    private func setupLegendRenderer() {
        legend.form = .square
        legend.horizontalAlignment = .center
        legend.orientation = .horizontal
    }
}
