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
    // MARK: - Properties
    static let contextWidth: CGFloat = 50.0

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

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }

        let lineWidth = chartView?.style.highlightLineWidth ?? 0
        let xPos = (Self.contextWidth - lineWidth) / 2.0
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
                x: xPos + (chartView?.style.highlightLineWidth ?? 0) / 2.0,
                y: yPos)
            context.drawImage(UIImage(named: "point") ?? UIImage(),
                              atCenter: center, size: CGSize(width: 20.0, height: 20.0))
        }
    }

    // MARK: - Private Methods
    private func updatePosition() {
        frame = CGRect(x: max(0, point.x - Self.contextWidth / 2.0),
                       y: 0, width: Self.contextWidth, height: chartView?.frame.height ?? 0)
        setNeedsDisplay()
    }
}
