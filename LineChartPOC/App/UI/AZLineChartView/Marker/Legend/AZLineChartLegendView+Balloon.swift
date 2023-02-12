//
//  AZLineChartLegendView+Balloon.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 12/02/23.
//

import UIKit

extension AZLineChartLegendView {

    // swiftlint:disable function_body_length
    func balloonPath (frame: CGRect) -> UIBezierPath {
        // This non-generic function dramatically improves compilation times of complex expressions.
        func fastFloor(_ xval: CGFloat) -> CGFloat { return floor(xval) }

        // Subframes
        let frame2 = CGRect(x: frame.minX + fastFloor((frame.width - 53) * 0.50000 + 0.5),
                            y: frame.minY + frame.height - 45, width: 53, height: 38)

        // Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.maxX - 14.2, y: frame.minY + 9.15))
        bezierPath.addLine(to: CGPoint(x: frame.maxX - 13.81, y: frame.minY + 9.25))
        bezierPath.addCurve(to: CGPoint(x: frame.maxX - 8.25, y: frame.minY + 14.81),
                            controlPoint1: CGPoint(x: frame.maxX - 11.23, y: frame.minY + 10.19),
                            controlPoint2: CGPoint(x: frame.maxX - 9.19, y: frame.minY + 12.23))
        bezierPath.addCurve(to: CGPoint(x: frame.maxX - 7.5, y: frame.minY + 23.79),
                            controlPoint1: CGPoint(x: frame.maxX - 7.5, y: frame.minY + 17.18),
                            controlPoint2: CGPoint(x: frame.maxX - 7.5, y: frame.minY + 19.38))
        bezierPath.addLine(to: CGPoint(x: frame.maxX - 7.5, y: frame.maxY - 41.79))
        bezierPath.addCurve(to: CGPoint(x: frame.maxX - 8.15, y: frame.maxY - 33.2),
                            controlPoint1: CGPoint(x: frame.maxX - 7.5, y: frame.maxY - 37.38),
                            controlPoint2: CGPoint(x: frame.maxX - 7.5, y: frame.maxY - 35.18))
        bezierPath.addLine(to: CGPoint(x: frame.maxX - 8.25, y: frame.maxY - 32.81))
        bezierPath.addCurve(to: CGPoint(x: frame.maxX - 13.81, y: frame.maxY - 27.25),
                            controlPoint1: CGPoint(x: frame.maxX - 9.19, y: frame.maxY - 30.23),
                            controlPoint2: CGPoint(x: frame.maxX - 11.23, y: frame.maxY - 28.19))
        bezierPath.addCurve(to: CGPoint(x: frame.maxX - 22.79, y: frame.maxY - 26.5),
                            controlPoint1: CGPoint(x: frame.maxX - 16.18, y: frame.maxY - 26.5),
                            controlPoint2: CGPoint(x: frame.maxX - 18.38, y: frame.maxY - 26.5))
        bezierPath.addLine(to: CGPoint(x: frame2.minX + 40.37, y: frame2.maxY - 19.5))
        bezierPath.addCurve(to: CGPoint(x: frame2.minX + 26.37, y: frame2.maxY - 5.5),
                            controlPoint1: CGPoint(x: frame2.minX + 33.47, y: frame2.maxY - 12.6),
                            controlPoint2: CGPoint(x: frame2.minX + 26.37, y: frame2.maxY - 5.5))
        bezierPath.addCurve(to: CGPoint(x: frame2.minX + 12.37, y: frame2.maxY - 19.5),
                            controlPoint1: CGPoint(x: frame2.minX + 26.37, y: frame2.maxY - 5.5),
                            controlPoint2: CGPoint(x: frame2.minX + 19.27, y: frame2.maxY - 12.6))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 22.79, y: frame.maxY - 26.5))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 14.2, y: frame.maxY - 27.15),
                            controlPoint1: CGPoint(x: frame.minX + 18.38, y: frame.maxY - 26.5),
                            controlPoint2: CGPoint(x: frame.minX + 16.18, y: frame.maxY - 26.5))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 13.81, y: frame.maxY - 27.25))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 8.25, y: frame.maxY - 32.81),
                            controlPoint1: CGPoint(x: frame.minX + 11.23, y: frame.maxY - 28.19),
                            controlPoint2: CGPoint(x: frame.minX + 9.19, y: frame.maxY - 30.23))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 7.5, y: frame.maxY - 41.79),
                            controlPoint1: CGPoint(x: frame.minX + 7.5, y: frame.maxY - 35.18),
                            controlPoint2: CGPoint(x: frame.minX + 7.5, y: frame.maxY - 37.38))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 7.5, y: frame.minY + 23.79))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 8.15, y: frame.minY + 15.2),
                            controlPoint1: CGPoint(x: frame.minX + 7.5, y: frame.minY + 19.38),
                            controlPoint2: CGPoint(x: frame.minX + 7.5, y: frame.minY + 17.18))
        bezierPath.addLine(to: CGPoint(x: frame.minX + 8.25, y: frame.minY + 14.81))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 13.81, y: frame.minY + 9.25),
                            controlPoint1: CGPoint(x: frame.minX + 9.19, y: frame.minY + 12.23),
                            controlPoint2: CGPoint(x: frame.minX + 11.23, y: frame.minY + 10.19))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 22.79, y: frame.minY + 8.5),
                            controlPoint1: CGPoint(x: frame.minX + 16.18, y: frame.minY + 8.5),
                            controlPoint2: CGPoint(x: frame.minX + 18.38, y: frame.minY + 8.5))
        bezierPath.addLine(to: CGPoint(x: frame.maxX - 22.79, y: frame.minY + 8.5))
        bezierPath.addCurve(to: CGPoint(x: frame.maxX - 14.2, y: frame.minY + 9.15),
                            controlPoint1: CGPoint(x: frame.maxX - 18.38, y: frame.minY + 8.5),
                            controlPoint2: CGPoint(x: frame.maxX - 16.18, y: frame.minY + 8.5))
        bezierPath.close()
        return bezierPath
    }
}
