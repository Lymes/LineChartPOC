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
        if let newHighlight = getHighlightByTouchPoint(recognizer.location(in: self)) {
            var selections = highlighted
            if selections.count > 1,
               let closest = selections.closest(to: newHighlight),
               let index = selections.firstIndex(of: closest) {
                selections.remove(at: index)
            }
            selections.append(newHighlight)
            highlightValues(selections)
        }
    }

    @objc func dragHandler(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == NSUIGestureRecognizerState.changed,
           let newHighlight = getHighlightByTouchPoint(recognizer.location(in: self)) {
            var selections = highlighted
            if let closest = selections.closest(to: newHighlight),
               let index = selections.firstIndex(of: closest) {
                selections.remove(at: index)
                selections.insert(newHighlight, at: index)
            } else {
                if selections.count > 1 {
                    selections.remove(at: 0)
                }
                selections.append(newHighlight)
            }
            highlightValues(selections)
        }
    }

    @objc func zoomHandler(_ recognizer: UIPinchGestureRecognizer) {
        guard highlighted.count == 2,
        let left = highlighted.leftHighlight,
        let right = highlighted.rightHighlight else { return }
        if recognizer.state == NSUIGestureRecognizerState.changed {
            let scale = recognizer.scale
            if let newLeft = getHighlightByTouchPoint(CGPoint(x: left.drawX / scale, y: left.drawY)),
               let newRight = getHighlightByTouchPoint(CGPoint(x: right.drawX * scale, y: right.drawY)) {
                print(newLeft.drawX, newRight.drawX)
                //highlightValues([newLeft, newRight])
            }
        }
        recognizer.scale = 1.0
    }
}
