//
//  TableChartViewCell+Chart.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 24/03/23.
//

import UIKit

extension TableChartViewCell {

    var showingChart: Bool { tableViewModel?.showChart.value ?? false }
    var minPerformance: Double { tableViewModel?.dataSet.minPerformance ?? 0 }
    var maxPerformance: Double { tableViewModel?.dataSet.maxPerformance ?? 0 }
    var maxScale: Double { tableViewModel?.dataSet.maxScale ?? 0 }
    var barChartWidth: CGFloat { tableViewModel?.barChartWidth ?? 0 }

    func drawChart() {
        guard maxScale != 0 else { return }

        let maxHeight = bounds.height
        let maxWidth = minPerformance < 0 ? chartContainer.bounds.width / 2 : chartContainer.bounds.width
        let separatorOriginX = minPerformance < 0 ? chartContainer.bounds.width / 2 : 0
        chartSeparator.frame = CGRect(x: separatorOriginX, y: 0, width: 1, height: maxHeight)

        let barYOffset = (maxHeight - barChartWidth) / 2.0
        let barWidth = ((viewModel?.data1 ?? 0) / maxScale) * maxWidth

        let initBarFrame = CGRect(
            x: separatorOriginX,
            y: barYOffset,
            width: 0,
            height: barChartWidth
        )
        let finalBarFrame = CGRect(
            x: separatorOriginX,
            y: barYOffset,
            width: barWidth,
            height: barChartWidth
        )

        self.chartBar.frame = showingChart ? initBarFrame : finalBarFrame
        UIView.animate(withDuration: 0.4) {
            self.chartBar.frame = self.showingChart ? finalBarFrame : initBarFrame
        }
    }
}
