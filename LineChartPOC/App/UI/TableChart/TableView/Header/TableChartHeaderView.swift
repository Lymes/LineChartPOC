//
//  TableChartHeaderView.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 24/03/23.
//

import UIKit

final class TableChartHeaderView: UIView {
    // MARK: - IBOutlets
    @IBOutlet weak var chartTitle: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var perf1Label: UILabel!
    @IBOutlet weak var perf2Label: UILabel!
    @IBOutlet weak var perf3Label: UILabel!
    @IBOutlet weak var perf4Label: UILabel!
    @IBOutlet weak var perf5Label: UILabel!
    @IBOutlet weak var perf6Label: UILabel!
    @IBOutlet weak var minPerfLabel: UILabel!
    @IBOutlet weak var medPerfLabel: UILabel!
    @IBOutlet weak var maxPerfLabel: UILabel!

    // MARK: - Properties
    weak var tableViewModel: TableChartViewModel? {
        didSet {
            setupLabels()
            updateTitle(0)
        }
    }
    private var dataTitle: UIView? { perf2Label.superview }

    // MARK: - Public Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    // MARK: - Private Methods
    @objc private func performanceTapped() {
        tableViewModel?.showChart.send(!(tableViewModel?.showChart.value ?? false))
        updateTitle(tableViewModel?.animationDuration ?? 0)
    }

    private func updateTitle(_ duration: Double) {
        UIView.animate(withDuration: duration) {
            self.chartTitle.alpha = (self.tableViewModel?.showChart.value ?? false) ? 1 : 0
            self.dataTitle?.alpha = (self.tableViewModel?.showChart.value ?? false) ? 0 : 1
        }
        updateChartLabels()
    }

    private func setupLabels() {
        titleLabel.text = tableViewModel?.labels[safe: 0]
        perf1Label.text = tableViewModel?.labels[safe: 1]
        perf2Label.text = tableViewModel?.labels[safe: 2]
        perf3Label.text = tableViewModel?.labels[safe: 3]
        perf4Label.text = tableViewModel?.labels[safe: 4]
        perf5Label.text = tableViewModel?.labels[safe: 5]
        perf6Label.text = tableViewModel?.labels[safe: 6]
    }

    private func updateChartLabels() {
        let maxScale = tableViewModel?.dataSet.value.maxScale ?? 0
        let minValue = (tableViewModel?.dataSet.value.minPerformance ?? 0) < 0 ? -maxScale : 0
        minPerfLabel.text = "\(minValue)%"
        medPerfLabel.text = "\((abs(maxScale) - abs(minValue)) / 2)%"
        maxPerfLabel.text = "\(maxScale)%"
    }

    private func setupView() {
        perf1Label.textColor = .blue
        perf1Label.isUserInteractionEnabled = true
        perf1Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(performanceTapped)))
    }
}
