//
//  MoviesAppUITests.swift
//  MoviesAppUITests
//
//  Created by Ricardo Hernandez on 13/07/24.
//

import XCTest

final class MoviesAppUITests: XCTestCase {

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
