//
//  AZLineChartLegendView.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 11/02/23.
//

import UIKit

final class AZLineChartLegendView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.layer.cornerRadius = 8
        collectionView.layer.masksToBounds = true
    }

    private func setupStyle() {
        layer.masksToBounds = false
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
    }
}
