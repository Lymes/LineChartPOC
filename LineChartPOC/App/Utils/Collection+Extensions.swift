//
//  Collection+Extensions.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 24/03/23.
//

import Foundation

extension Collection {

    /// Returns the element at the specified index if it exists, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
