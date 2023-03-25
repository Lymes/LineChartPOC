//
//  TableChartDataSource.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 16/03/23.
//

import UIKit

enum Section: String {
    case main
}

typealias Snapshot = NSDiffableDataSourceSnapshot<Section, TableChartRowModel>

final class TableChartDataSource: UITableViewDiffableDataSource<Section, TableChartRowModel> {

    init(_ tableView: TableChartView) {
        tableView.register(
            UINib(nibName: "TableChartViewCell", bundle: nil),
            forCellReuseIdentifier: Section.main.rawValue
        )
        let tableViewModel = tableView.tableViewModel
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Section.main.rawValue,
                for: indexPath) as? TableChartViewCell
            cell?.viewModel = itemIdentifier
            cell?.tableViewModel = tableViewModel
            cell?.backgroundColor = indexPath.row % 2 == 0 ? .init(white: 0.9, alpha: 0.5) : .white
            return cell ?? UITableViewCell()
        }
    }

    func setData(rows: [TableChartRowModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(rows, toSection: .main)
        apply(snapshot, animatingDifferences: true)
    }
}
