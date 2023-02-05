//
//  AZLineChartRenderer.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 04/02/23.
//

import Foundation
import CoreGraphics
import Charts

final class AZLineChartRenderer: LineChartRenderer {

    override func drawData(context: CGContext) {
        printTimeElapsedWhenRunningCode(title: "drawData") {
            super.drawData(context: context)
        }
    }

    private func printTimeElapsedWhenRunningCode(title: String, operation: () -> Void) {
        let startTime = CFAbsoluteTimeGetCurrent()
        operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Time elapsed for \(title): \(timeElapsed) s")
    }
}
