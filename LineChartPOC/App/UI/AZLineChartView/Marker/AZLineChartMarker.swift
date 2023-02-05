//
//  AZLineChartMarker.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 05/02/23.
//

import UIKit
import Charts

class AZLineChartMarker: MarkerView {
    private var text = ""
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        return formatter
    }()

    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        super.refreshContent(entry: entry, highlight: highlight)
        let date = Date(timeIntervalSince1970: entry.x)
        text = String(dateFormatter.string(from: date))
    }

    override func draw(context: CGContext, point: CGPoint) {
        super.draw(context: context, point: point)

        var drawAttributes = [NSAttributedString.Key: Any]()
        drawAttributes[.font] = UIFont.systemFont(ofSize: 15)
        drawAttributes[.foregroundColor] = UIColor.white
        drawAttributes[.backgroundColor] = UIColor.darkGray

        self.bounds.size = (" \(text) " as NSString).size(withAttributes: drawAttributes)
        self.offset = CGPoint(x: 0, y: -self.bounds.size.height - 2)

        let offset = self.offsetForDrawing(atPoint: point)

        drawText(text: " \(text) " as NSString,
                 rect: CGRect(origin: CGPoint(x: point.x + offset.x, y: point.y + offset.y), size: self.bounds.size),
                 withAttributes: drawAttributes)
    }

    func drawText(text: NSString, rect: CGRect, withAttributes attributes: [NSAttributedString.Key: Any]? = nil) {
        let size = text.size(withAttributes: attributes)
        let centeredRect = CGRect(
            x: rect.origin.x - rect.size.width / 2.0,
            y: 0,
            width: size.width,
            height: size.height
        )
        text.draw(in: centeredRect, withAttributes: attributes)
    }
}
