//
//  TableChartViewCell.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 16/03/23.
//

import UIKit
import Combine

final class TableChartViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var chartContainer: UIView!
    @IBOutlet weak var chartSeparator: UIView!
    @IBOutlet weak var chartBar: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var perf1Label: UILabel!
    @IBOutlet weak var perf2Label: UILabel!
    @IBOutlet weak var perf3Label: UILabel!
    @IBOutlet weak var perf4Label: UILabel!
    @IBOutlet weak var perf5Label: UILabel!
    @IBOutlet weak var perf6Label: UILabel!

    // MARK: - Properties
    weak var tableViewModel: TableChartViewModel? {
        didSet {
            setupCell()
            setupObservers()
        }
    }

    var viewModel: TableChartRowModel? {
        didSet {
            setupLabels()
            colorView.backgroundColor = viewModel?.color
        }
    }

    private var cancellable: AnyCancellable?
    private var dataContainer: UIView? { perf2Label.superview }

    // MARK: - Public Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        updateChart(0)
    }

    override func prepareForReuse() {
        setupCell()
        updateChart(0)
    }

    // MARK: - Private Methods
    private func setupCell() {
        selectionStyle = .none
        colorView.layer.cornerRadius = 2
        colorView.clipsToBounds = true
        chartBar.backgroundColor = viewModel?.color
    }

    private func setupObservers() {
        updateChart(0)
        cancellable = tableViewModel?.showChart.sink { [weak self] _ in
            self?.updateChart()
        }
    }

    private func updateChart(_ duration: CGFloat = 0.4) {
        UIView.animate(withDuration: duration) {
            self.dataContainer?.alpha = (self.tableViewModel?.showChart.value ?? false) ? 0 : 1
            self.chartContainer.alpha = (self.tableViewModel?.showChart.value ?? false) ? 1 : 0
        }
        layoutIfNeeded()
        drawChart()
    }

    private func setupLabels() {
        titleLabel.text = "\(viewModel?.title ?? "")"
        perf1Label.text = "\(viewModel?.data1 ?? 0)"
        perf2Label.text = "\(viewModel?.data2 ?? 0)"
        perf3Label.text = "\(viewModel?.data3 ?? 0)"
        perf4Label.text = "\(viewModel?.data4 ?? 0)"
        perf5Label.text = "\(viewModel?.data5 ?? 0)"
        perf6Label.text = "\(viewModel?.data6 ?? 0)"
    }
}
