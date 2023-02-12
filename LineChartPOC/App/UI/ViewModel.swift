//
//  ViewModel.swift
//  LineChartPOC
//
//  Created by Leonid Mesentsev on 03/02/23.
//

import Foundation
import Combine

final class ViewModel: NSObject {

    @Published
    var dataSet: [[DataPoint]] = [[]]

    func loadData() {
        Task(priority: .userInitiated) {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .millisecondsSince1970

            guard let url = Bundle.main.url(forResource: "line_data_1", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else { return }
            if let decoded = try? decoder.decode([[DataPoint]].self, from: data) {
                dataSet = decoded
            } else {
                print("Cannot decode")
            }
        }
    }

}
