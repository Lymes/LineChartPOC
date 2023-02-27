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
            // "2009-04-02T00:00:00.000+00:00"
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
            decoder.dateDecodingStrategy = .formatted(formatter)
            guard let url = Bundle.main.url(forResource: "GraphLineresponse", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else { return }
            do {
                let decoded = try decoder.decode(DataSet.self, from: data)
                dataSet = [decoded.points]
            } catch DecodingError.dataCorrupted(let context) {
                print(context)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
    }
}
