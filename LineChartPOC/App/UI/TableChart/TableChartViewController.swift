//
//  TableChartViewController.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 16/03/23.
//

import UIKit
import Combine

final class TableChartViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: TableChartView!

    // MARK: - Properties
    private let viewModel = TableChartViewModel()
    private var dataSource: TableChartDataSource?
    private var cancellable: AnyCancellable?

    // MARK: - Public Methods
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupDatasource()
        setupObservers()
        viewModel.loadData()
    }

    deinit {
        print("\(self) deallocated")
    }

    // MARK: - Private Methods
    private func setupTable() {
        tableView.tableViewModel = viewModel
    }

    private func setupDatasource() {
        dataSource = TableChartDataSource(tableView)
    }

    private func setupObservers() {
        cancellable = viewModel.dataSet.dropFirst().sink { [weak self] data in
            self?.dataSource?.setData(rows: data)
        }
    }
}
