//
//  AZLineChartXAxisRenderer.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 06/02/23.
//

import UIKit
import Charts
import CoreGraphics

final class AZLineChartXAxisRenderer: XAxisRenderer {

    @objc override var gridClippingRect: CGRect {
        var contentRect = viewPortHandler.contentRect
        let deltax = self.axis.gridLineWidth
        contentRect.origin.x -= deltax / 2.0
        contentRect.size.width += deltax
        contentRect.origin.y = contentRect.size.height + 5
        return contentRect
    }

    override func renderGridLines(context: CGContext) {
        guard
            let transformer = self.transformer,
            axis.isEnabled,
            axis.isDrawGridLinesEnabled
            else { return }

        context.saveGState()
        defer { context.restoreGState() }

        context.clip(to: self.gridClippingRect)

        context.setShouldAntialias(axis.gridAntialiasEnabled)
        context.setStrokeColor(axis.gridColor.cgColor)
        context.setLineWidth(axis.gridLineWidth)
        context.setLineCap(axis.gridLineCap)

        if axis.gridLineDashLengths != nil {
            context.setLineDash(phase: axis.gridLineDashPhase, lengths: axis.gridLineDashLengths)
        } else {
            context.setLineDash(phase: 0.0, lengths: [])
        }

        let valueToPixelMatrix = transformer.valueToPixelMatrix

        var position = CGPoint.zero

        let entries = axis.entries

        for entry in entries {
            position.x = CGFloat(entry)
            position.y = CGFloat(entry)
            position = position.applying(valueToPixelMatrix)

            drawGridLine(context: context, x: position.x, y: position.y)
        }
    }

    // swiftlint:disable identifier_name
    @objc override func drawGridLine(context: CGContext, x: CGFloat, y: CGFloat) {
        guard x >= viewPortHandler.offsetLeft && x <= viewPortHandler.chartWidth else { return }

        context.beginPath()
        context.move(to: CGPoint(x: x, y: viewPortHandler.contentTop))
        context.addLine(to: CGPoint(x: x, y: viewPortHandler.contentBottom + 5))
        context.strokePath()
    }

    @objc override func drawLabel(
        context: CGContext,
        formattedLabel: String,
        x: CGFloat,
        y: CGFloat,
        attributes: [NSAttributedString.Key: Any],
        constrainedTo size: CGSize,
        anchor: CGPoint,
        angleRadians: CGFloat) {
        context.drawMultilineText(formattedLabel,
                                  at: CGPoint(x: x, y: y),
                                  constrainedTo: size,
                                  anchor: anchor,
                                  angleRadians: angleRadians,
                                  attributes: attributes)
    }

}

extension FloatingPoint {
    var DEG2RAD: Self {
        return self * .pi / 180
    }

    var RAD2DEG: Self {
        return self * 180 / .pi
    }

    /// - Note: Value must be in degrees
    /// - Returns: An angle between 0.0 < 360.0 (not less than zero, less than 360)
    var normalizedAngle: Self {
        let angle = truncatingRemainder(dividingBy: 360)
        return (sign == .minus) ? angle + 360 : angle
    }
}

extension CGSize {
    func rotatedBy(degrees: CGFloat) -> CGSize {
        let radians = degrees.DEG2RAD
        return rotatedBy(radians: radians)
    }

    func rotatedBy(radians: CGFloat) -> CGSize {
        return CGSize(
            width: abs(width * cos(radians)) + abs(height * sin(radians)),
            height: abs(width * sin(radians)) + abs(height * cos(radians))
        )
    }
}

// swiftlint:disable function_parameter_count
extension CGContext {

    func drawMultilineText(_ text: String,
                           at point: CGPoint,
                           constrainedTo size: CGSize,
                           anchor: CGPoint,
                           angleRadians: CGFloat,
                           attributes: [NSAttributedString.Key: Any]?) {
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        drawMultilineText(text,
                          at: point,
                          constrainedTo: size,
                          anchor: anchor,
                          knownTextSize: rect.size,
                          angleRadians: angleRadians,
                          attributes: attributes
        )
    }

    func drawMultilineText(_ text: String,
                           at point: CGPoint,
                           constrainedTo size: CGSize,
                           anchor: CGPoint,
                           knownTextSize: CGSize,
                           angleRadians: CGFloat,
                           attributes: [NSAttributedString.Key: Any]?) {
        var rect = CGRect(origin: .zero, size: knownTextSize)

        UIGraphicsPushContext(self)

        if angleRadians != 0.0 {
            // Move the text drawing rect in a way that it always rotates around its center
            rect.origin.x = -knownTextSize.width * 0.5
            rect.origin.y = -knownTextSize.height * 0.5

            var translate = point

            // Move the "outer" rect relative to the anchor, assuming its centered
            if anchor.x != 0.5 || anchor.y != 0.5 {
                let rotatedSize = knownTextSize.rotatedBy(radians: angleRadians)

                translate.x -= rotatedSize.width * (anchor.x - 0.5)
                translate.y -= rotatedSize.height * (anchor.y - 0.5)
            }

            saveGState()
            translateBy(x: translate.x, y: translate.y)
            rotate(by: angleRadians)

            (text as NSString).draw(with: rect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

            restoreGState()
        } else {
            if anchor.x != 0.0 || anchor.y != 0.0 {
                rect.origin.x = -knownTextSize.width * anchor.x
                rect.origin.y = -knownTextSize.height * anchor.y
            }

            rect.origin.x += point.x
            rect.origin.y += point.y

            (text as NSString).draw(with: rect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        }

        UIGraphicsPopContext()
    }
}
