//
//  LineChartPOCTests.swift
//  LineChartPOCTests
//
//  Created by Leonid Mesentsev on 04/02/23.
//

import XCTest
@testable import LineChartPOC

final class LineChartPOCTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMinMax1() throws {
        let data = [
            DataPoint(date: Date(timeIntervalSince1970: 100), value: 0, isEvent: false),
            DataPoint(date: Date(timeIntervalSince1970: 200), value: 0, isEvent: false),
            DataPoint(date: Date(timeIntervalSince1970: 300), value: 0, isEvent: false)
        ]
        print(data.minDate.timeIntervalSince1970)
        print(data.maxDate.timeIntervalSince1970)
        XCTAssertTrue(data.minDate == Date(timeIntervalSince1970: 100))
        XCTAssertTrue(data.maxDate == Date(timeIntervalSince1970: 300))
    }

    func testMinMax2() throws {
        let data = [
            [
            DataPoint(date: Date(timeIntervalSince1970: 100), value: 0, isEvent: false),
            DataPoint(date: Date(timeIntervalSince1970: 200), value: 0, isEvent: false),
            DataPoint(date: Date(timeIntervalSince1970: 300), value: 0, isEvent: false)
            ],
            [
                DataPoint(date: Date(timeIntervalSince1970: 50), value: 0, isEvent: false),
                DataPoint(date: Date(timeIntervalSince1970: 200), value: 0, isEvent: false),
                DataPoint(date: Date(timeIntervalSince1970: 500), value: 0, isEvent: false)
            ],
            [
                DataPoint(date: Date(timeIntervalSince1970: 200), value: 0, isEvent: false),
                DataPoint(date: Date(timeIntervalSince1970: 250), value: 0, isEvent: false),
                DataPoint(date: Date(timeIntervalSince1970: 400), value: 0, isEvent: false)
            ]
        ]
        print(data.minDate.timeIntervalSince1970)
        print(data.maxDate.timeIntervalSince1970)
        XCTAssertTrue(data.minDate == Date(timeIntervalSince1970: 50))
        XCTAssertTrue(data.maxDate == Date(timeIntervalSince1970: 500))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
