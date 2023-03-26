//
//  TableChartViewModel.swift
//  LineChartPOC
//
//  Created by leonid.mesentsev on 24/03/23.
//

import UIKit
import Combine

final class TableChartViewModel: NSObject {

    // MARK: - Publshed
    let showChart: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    let dataSet: CurrentValueSubject<[TableChartRowModel], Never> = CurrentValueSubject([])

    // MARK: - Properties

    /// Larghezza delle barre
    var barChartWidth: CGFloat = 20

    /// Durata delle animazioni, 0 per disabilitare le animazioni del tutto
    var animationDuration: Double = 0.5

    /// Animare le barre durante lo scroll
    var animateOnScroll: Bool = true

    /// Labels del header
    let labels: [String] = [
        "Linee",
        "Performance a 1 anno",
        "Performance a 6 mesi",
        "Performance a 3 mesi",
        "Performance a 1 mese",
        "Performance da inizio anno",
        "Performance a 2 anni"
    ]

    // MARK: - Public Methods

    // swiftlint:disable function_body_length
    func loadData() {
        dataSet.send([
            TableChartRowModel(
                title: "X-TEAM Team BlackRock1",
                data1: 9.6, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock2",
                data1: -1.6, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 20.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock3",
                data1: 9.6, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 40.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock4",
                data1: -8.6, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 60.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock5",
                data1: -9.6, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 80.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock6",
                data1: 3.6, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 100.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock7",
                data1: 9.6, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 120.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock8",
                data1: 4.6, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 140.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock9",
                data1: 2.6, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 160.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock10",
                data1: 5.6, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 180.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock11",
                data1: 7.1, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 200.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock12",
                data1: 5.2, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 220.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock13",
                data1: 4.2, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 240.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock14",
                data1: 9.2, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 260.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock15",
                data1: 9.1, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 280.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock16",
                data1: 5.6, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 300.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock17",
                data1: 9.0, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 320.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock18",
                data1: 8, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 340.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            ),
            TableChartRowModel(
                title: "X-TEAM Team BlackRock19",
                data1: 2.3, data2: 5.7, data3: 1.4, data4: 0.4, data5: 16.3, data6: 8.8,
                color: UIColor(hue: 360.0 / 360.0, luminance: 0.7, chroma: 0.9, alpha: 0.99)
            )
        ])
    }
}
