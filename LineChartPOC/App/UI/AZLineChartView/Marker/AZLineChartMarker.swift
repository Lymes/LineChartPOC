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

class AZLineChartMarker: MarkerView {
    @IBOutlet weak var label: UILabel!

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        return formatter
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        super.refreshContent(entry: entry, highlight: highlight)
        let date = Date(timeIntervalSince1970: entry.x)
        let text = String(dateFormatter.string(from: date))
        label.text = text
    }

    override func draw(context: CGContext, point: CGPoint) {
        let offset = self.offsetForDrawing(atPoint: point)

        context.saveGState()
        context.translateBy(x: point.x + offset.x - bounds.width / 2.0,
                              y: 0)
        UIGraphicsPushContext(context)
        self.layer.render(in: context)
        UIGraphicsPopContext()
        context.restoreGState()
    }
}
