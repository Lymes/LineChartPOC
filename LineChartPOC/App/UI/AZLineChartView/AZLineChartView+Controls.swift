//
//  AZLineChartView+Controls.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 12/02/23.
//

import UIKit

extension AZLineChartView: AZLineChartControlsDelegate {

    func saveSelectedRange() {
    }

    func expandSelectedRange() {
        if let range = markersRange {
            datasource?.setRange(
                startDate: range.0,
                endDate: range.1)
        }
    }

    // MARK: Additional controls creation

    func createLegendView() -> AZLineChartLegendView {
        if let view = (Bundle.main.loadNibNamed(
            String(describing: AZLineChartLegendView.self),
            owner: self, options: nil)![0]) as? AZLineChartLegendView {
            view.frame = CGRect(x: 0, y: 0, width: bounds.width / 5, height: bounds.height / 6)
            addSubview(view)
            return view
        }
        return AZLineChartLegendView()
    }

    func createControlsView() -> AZLineChartControlsView {
        if let view = (Bundle.main.loadNibNamed(
            String(describing: AZLineChartControlsView.self),
            owner: self, options: nil)![0]) as? AZLineChartControlsView {
            view.delegate = self
            addSubview(view)
            return view
        }
        return AZLineChartControlsView()
    }

    func createLeftVeilLayer() -> CALayer {
       let veil = CALayer()
        veil.backgroundColor = style.veilColor.cgColor
        veil.zPosition = -1
        layer.addSublayer(veil)
        return veil
    }

    func createRightVeilLayer() -> CALayer {
       let veil = CALayer()
        veil.backgroundColor = style.veilColor.cgColor
        veil.zPosition = -1
        layer.addSublayer(veil)
        return veil
    }
}
