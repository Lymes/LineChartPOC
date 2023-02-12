//
//  AZLineChartMarker.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 05/02/23.
//

import UIKit
import Charts
import CoreGraphics
import Foundation

final class AZLineChartMarkerView: UIView {
    static let width: CGFloat = 50

    var chartView: AZLineChartView? {
        didSet {
            chartView?.addSubview(self)
        }
    }

    var value: CGPoint = .zero {
        didSet {
            updatePosition()
        }
    }

    var date: Date {
        Date(timeIntervalSince1970: value.x)
    }

    var intersections: [ChartDataEntry] {
        chartView?.lineData?.dataSets.compactMap { $0.entryForXValue(value.x, closestToY: value.y) } ?? []
    }

    var point: CGPoint {
        var point = chartView?.getTransformer(forAxis: .left).pixelForValues(x: value.x, y: value.y) ?? .zero
        point.x = min(max(point.x, chartView?.viewPortHandler.contentLeft ?? 0),
                      chartView?.viewPortHandler.contentRight ?? 0)
        return point
    }

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }

        let lineWidth = chartView?.style.highlightLineWidth ?? 0
        let xPos = (Self.width - lineWidth) / 2
        let lineRect = CGRect(x: xPos,
                              y: chartView?.viewPortHandler.contentTop ?? 0,
                              width: lineWidth,
                              height: chartView?.viewPortHandler.contentHeight ?? 0
                              )
        let path = UIBezierPath(rect: lineRect)
        context.addPath(path.cgPath)
        path.close()
        let fillColor = chartView?.style.highlightColor ?? UIColor.blue
        context.setFillColor(fillColor.cgColor)
        context.setShadow(offset: .zero, blur: 3.0, color: fillColor.withAlphaComponent(0.6).cgColor)
        context.drawPath(using: .fill)
        intersections.compactMap {
            chartView?.getTransformer(forAxis: .left).pixelForValues(x: $0.x, y: $0.y).y
        }.forEach { yPos in
            let center = CGPoint(
                x: xPos + (chartView?.style.highlightLineWidth ?? 0) / 2,
                y: yPos)
            context.drawImage(UIImage(named: "point") ?? UIImage(),
                              atCenter: center, size: CGSize(width: 20, height: 20))
        }
    }

    // MARK: Private functions

    private func updatePosition() {
        frame = CGRect(x: max(0, point.x - Self.width / 2),
                       y: 0, width: Self.width, height: chartView?.frame.height ?? 0)
        setNeedsDisplay()
    }
}
