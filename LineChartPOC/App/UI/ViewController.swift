//
//  ViewController.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 03/02/23.
//

import UIKit
import Combine

final class ViewController: UIViewController {

    // MARK: UI controls

    @IBOutlet var chartView: AZLineChartView!

    // MARK: Private properties

    private let datasource = AZLineChartDataSource()
    private let viewModel = ViewModel()
    private var cancellable: AnyCancellable?

    // MARK: Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.style = AZLineChartGenericStyle()
        chartView.datasource = datasource
        setupObservers()
        viewModel.loadData()
    }

    // MARK: Private methods

    private func setupObservers() {
        cancellable = viewModel.$dataSet.sink { [weak self] data in
            self?.datasource.rawData = data
        }
    }

    // MARK: Actions

    @IBAction func togglePerformance() {
        datasource.calculatePerformance.toggle()
    }

    @IBAction func zoomFull() {
        datasource.setRange(
            startDate: datasource.rawData.minDate,
            endDate: datasource.rawData.maxDate)
    }

    @IBAction func zoomToMarkers() {
        chartView.removeMarkers()
    }

    @IBAction func toggleEvents() {
        chartView.toggleEvents()
    }

}
