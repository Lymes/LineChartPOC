//
//  TableChartView.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 24/03/23.
//

import UIKit

class TableChartView: UITableView {

    // MARK: - Properties
    weak var tableViewModel: TableChartViewModel? {
        didSet {
            headerView.tableViewModel = tableViewModel
        }
    }

    lazy var headerView: TableChartHeaderView = {
        TableChartHeaderView.instantiate(autolayout: false)
    }()

    // MARK: - Public Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    // MARK: - Private Methods
    private func setupView() {
        separatorStyle = .none
        delegate = self
    }
}

// MARK: - Extensions
extension TableChartView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        64
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
}
