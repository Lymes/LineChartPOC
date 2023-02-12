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
    var markers: [AZLineChartMarkerView] = []

    // MARK: Additional controls
    lazy var legendView = createLegendView()
    lazy var controlsView = createControlsView()
    lazy var leftVeilLayer = createLeftVeilLayer()
    lazy var rightVeilLayer = createRightVeilLayer()

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
        if markers.count > 1 {
            return (
                Date(timeIntervalSince1970: Double(markers.left?.value.x ?? 0)),
                Date(timeIntervalSince1970: Double(markers.right?.value.x ?? 0))
            )
        }
        return nil
    }

    func toggleEvents() {
        // let events = highlighted.count > 0 ? [] : datasource?.rawData.highlights ?? []
        // highlightValues(events)
    }

    // MARK: Private methods

    private func setupObservers() {
        cancellable = datasource?.$chartData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.data = data
                self?.updateMarkers()
            }
    }

    private func updateMarkers() {
        markers.forEach { $0.value = $0.value }
        updateLegend()
    }

    func updateLegend() {
        legendView.isHidden = markers.isEmpty
        controlsView.isHidden = markers.count != 2
        if let left = markers.left, let right = markers.right {
            let midWidth = legendView.frame.width / 2.0
            var targetXPos = left.center.x + (right.center.x - left.center.x) / 2.0
            targetXPos = min(max(targetXPos, 5 + midWidth), frame.width - midWidth - 5)
            UIView.animate(withDuration: 0.2) {
                self.legendView.center = CGPoint(x: targetXPos, y: 0)
            }
            UIView.animate(withDuration: 0.2) {
                self.controlsView.center = CGPoint(x: targetXPos, y: self.viewPortHandler.contentBottom)
            }
            updateVeil(for: left, and: right)
        }
    }

    private func updateVeil(for left: AZLineChartMarkerView, and right: AZLineChartMarkerView) {
        CALayer.perform(withDuration: 0) {
            leftVeilLayer.frame = CGRect(
                x: viewPortHandler.contentLeft,
                y: viewPortHandler.contentTop,
                width: left.point.x - viewPortHandler.contentLeft,
                height: viewPortHandler.contentHeight
            )
            rightVeilLayer.frame = CGRect(
                x: right.point.x,
                y: viewPortHandler.contentTop,
                width: viewPortHandler.contentWidth + viewPortHandler.contentLeft - right.point.x,
                height: viewPortHandler.contentHeight
            )
        }
        rightVeilLayer.isHidden = markers.count != 2
        leftVeilLayer.isHidden = markers.count != 2
    }
}
