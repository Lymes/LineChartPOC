//
//  AZLineChartView+Gestures.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 05/02/23.
//

import UIKit
import Charts

extension AZLineChartView {

    public func setupGestures() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHandler)))
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragHandler)))
        addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(zoomHandler)))
    }

    @objc func tapHandler(_ recognizer: UITapGestureRecognizer) {
        guard (datasource?.rangedData.maxPoints ?? 0) > 0 else { return }
        let value = valueForTouchPoint(point: recognizer.location(in: self), axis: .left)
        if markers.count > 1, let closest = markers.closest(to: value) {
            closest.value = value
        } else {
            appendMarker(with: value)
        }
        updateLegend()
    }

    @objc func dragHandler(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == NSUIGestureRecognizerState.changed {
            let value = valueForTouchPoint(point: recognizer.location(in: self), axis: .left)
            if let closest = markers.closest(to: value) {
                closest.value = value
            }
            updateLegend()
        }
    }

    @objc func zoomHandler(_ recognizer: UIPinchGestureRecognizer) {
//        guard markers.count == 2, let left = markers.left, let right = markers.right else { return }
//        if recognizer.state == NSUIGestureRecognizerState.changed {
//            let scale = recognizer.scale
//        }
//        recognizer.scale = 1.0
//        updateLegend()
    }

    private func appendMarker(with value: CGPoint) {
        let marker = AZLineChartMarker(frame: .zero)
        marker.chartView = self
        marker.value = value
        markers.append(marker)
        bringSubviewToFront(legendView)
    }
}
