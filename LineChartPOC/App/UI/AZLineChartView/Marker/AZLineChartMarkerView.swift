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
            setValue(xPos: value.x, yPos: value.y)
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
        let path = UIBezierPath(roundedRect: lineRect, cornerRadius: 4)

        let fillColor = chartView?.style.highlightColor.cgColor ?? UIColor.blue.cgColor
        context.setStrokeColor(UIColor.black.cgColor)
        context.setFillColor(fillColor)
        context.setShadow(offset: .zero, blur: 3.0, color: UIColor(white: 0.01, alpha: 0.6).cgColor)
        addIntersections(xPos: xPos, to: path)
        context.addPath(path.cgPath)
        path.close()
        context.drawPath(using: .fill)
    }

    // MARK: Private functions

    private func setValue(xPos: Double, yPos: Double) {
        let xPos = max(0, point.x - Self.width / 2)
        let rect = CGRect(x: xPos, y: 0, width: Self.width, height: chartView?.frame.height ?? 0)
        frame = rect
        setNeedsDisplay()
    }

    private func addIntersections(xPos: CGFloat, to path: UIBezierPath) {
        intersections.compactMap {
            chartView?.getTransformer(forAxis: .left).pixelForValues(x: $0.x, y: $0.y).y
        }.forEach { yPos in
            path.append(
                UIBezierPath(
                    arcCenter: CGPoint(
                        x: xPos + (chartView?.style.highlightLineWidth ?? 0) / 2,
                        y: yPos),
                    radius: 10,
                    startAngle: 0,
                    endAngle: 2 * .pi,
                    clockwise: true
                )
            )
        }
    }
}
