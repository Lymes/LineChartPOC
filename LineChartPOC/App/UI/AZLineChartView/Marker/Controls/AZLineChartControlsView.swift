//
//  AZLineChartControlsView.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 12/02/23.
//

import UIKit

protocol AZLineChartControlsDelegate: AnyObject {
    func saveSelectedRange()
    func expandSelectedRange()
}

final class AZLineChartControlsView: UIView {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var expandButton: UIButton!

    weak var delegate: AZLineChartControlsDelegate?

    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        saveButton.layer.cornerRadius   = saveButton.frame.height / 2
        expandButton.layer.cornerRadius = expandButton.frame.height / 2
    }

    // MARK: Actions

    @IBAction func saveTapped() {
        delegate?.saveSelectedRange()
    }

    @IBAction func expandTapped() {
        delegate?.expandSelectedRange()
    }

    // MARK: Private functions

    private func setupView() {
        backgroundColor = .clear
        let shadowColor = UIColor(white: 0, alpha: 0.4).cgColor
        saveButton.layer.masksToBounds   = false
        saveButton.layer.shadowColor     = shadowColor
        saveButton.layer.shadowOpacity   = 0.4
        saveButton.layer.shadowOffset    = .zero
        saveButton.layer.shadowRadius    = 10
        expandButton.layer.masksToBounds = false
        expandButton.layer.shadowColor   = shadowColor
        expandButton.layer.shadowOpacity = 0.4
        expandButton.layer.shadowOffset  = .zero
        expandButton.layer.shadowRadius  = 10
    }
}
