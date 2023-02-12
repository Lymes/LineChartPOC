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
        let lineColor = style.dataColors[index]
        dataSet.colors = [lineColor]
        dataSet.drawCircleHoleEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = true
        dataSet.highlightEnabled = false
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.drawVerticalHighlightIndicatorEnabled = false

        if index == 0 {
            let gradientColors = [lineColor.cgColor, lineColor.withAlphaComponent(0).cgColor] as CFArray
            let colorLocations: [CGFloat] = [1.0, 0.0]
            let gradient = CGGradient.init(
                colorsSpace: CGColorSpaceCreateDeviceRGB(),
                colors: gradientColors,
                locations: colorLocations
            )
            dataSet.fill = LinearGradientFill(gradient: gradient!, angle: 90.0)
            dataSet.drawFilledEnabled = true
        }
    }

    private func setupBehavior() {
        dragEnabled = true
        setScaleEnabled(false)
        pinchZoomEnabled = false
        doubleTapToZoomEnabled = false
        highlightPerTapEnabled = false
        dragEnabled = false
        legend.enabled = false
        setupGestures()
    }

    private func setupXAxis() {
        xAxisRenderer = AZLineChartXAxisRenderer(
            viewPortHandler: viewPortHandler,
            axis: xAxis,
            transformer: getTransformer(forAxis: .left)
        )
        // xAxis.labelRotationAngle = 45.0
        xAxis.labelFont = style.xAxisLabelFont
        xAxis.labelTextColor = style.xAxisLabelTextColor
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = true
        xAxis.labelCount = style.xAxisLabelCount
        xAxis.labelPosition = .bottom
        xAxis.drawLabelsEnabled = true
        xAxis.drawLimitLinesBehindDataEnabled = false
        xAxis.avoidFirstLastClippingEnabled = false
        xAxis.valueFormatter = AZLineChartXFormatter()

        leftAxis.labelTextColor = style.leftAxisLabelTextColor
        leftAxis.drawGridLinesEnabled = true
        leftAxis.gridColor = .blue.withAlphaComponent(0.5)
        leftAxis.gridLineWidth = 0.5
        leftAxis.gridLineDashPhase = 0.5
        leftAxis.gridLineDashLengths = [ 4.0, 4.0 ]

        rightAxis.labelTextColor = style.rightAxisLabelTextColor
        rightAxis.drawGridLinesEnabled = false
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
