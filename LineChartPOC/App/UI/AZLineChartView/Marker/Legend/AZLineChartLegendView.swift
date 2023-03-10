//
//  AZLineChartLegendView.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 11/02/23.
//

import UIKit

final class AZLineChartLegendView: UIView {

    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    private let baloonMaskLayer = CAShapeLayer()
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MMM/yy"
        return formatter
    }()

    var markers: [AZLineChartMarkerView] = [] {
        didSet {
            guard !markers.isEmpty else { return }
            labelView.text = markers.count > 1 ?
                """
                \(dateFormatter.string(from: markers.left?.date ?? Date(timeIntervalSince1970: 0))) - \
                \(dateFormatter.string(from: markers.right?.date ?? Date(timeIntervalSince1970: 0)))
                """ :
            markers.count == 1 ? "\(dateFormatter.string(from: markers[0].date))" : nil
        }
    }

    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
        setupCollectionView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = CGRect(x: 10, y: 10, width: bounds.width - 20, height: bounds.height - 40)
        labelView.frame = contentView.bounds.insetBy(dx: 10, dy: 10)
        let balloonPath = balloonPath(frame: bounds).cgPath
        baloonMaskLayer.frame = bounds
        baloonMaskLayer.path = balloonPath
        layer.shadowPath = balloonPath
    }

    // MARK: Private functions

    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
    }

    private func setupStyle() {
        backgroundColor = .clear
        backgroundView.backgroundColor = .white
        backgroundView.layer.mask = baloonMaskLayer
        backgroundView.layer.masksToBounds = true
        layer.masksToBounds = false
        layer.shadowColor   = UIColor(white: 0, alpha: 0.4).cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset  = .zero
        layer.shadowRadius  = 10.0
    }
}
