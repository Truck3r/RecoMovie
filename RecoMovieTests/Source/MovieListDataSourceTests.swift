//
// Created by Sune Riedel on 24/09/2020.
// Copyright (c) 2020 Sune Riedel. All rights reserved.
//

import XCTest
@testable import RecoMovie

class MovieListDataSourceTests: XCTestCase {
    func testFirstPage() {
        let expectation = XCTestExpectation(description: "Data Source Expectation")

        let network = TestNetwork()
        let dataSource = MovieListNetworkDataSource(networkInterface: network)
        dataSource.dataUpdatedCallback = { from, to in
            print("Loaded from: \(from) - to: \(to)")
        }

        XCTAssertNil(dataSource[100], "Expected nil element at position 100")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if let m = dataSource[0] {
                XCTAssertEqual(m.title, "Money Plane", "Unexpected movie title")
            } else {
                XCTFail("Movie was nil")
            }
            XCTAssertEqual(dataSource.count, 2, "Expected datasource to have 2 elements")
            let _ = dataSource[1]
            if let m = dataSource[1] {
                XCTAssertEqual(m.title, "Mulan", "Unexpected movie title")
            } else {
                XCTFail("Movie was nil")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 30.0)
    }

    func testPaging() {
        let expectation = XCTestExpectation(description: "Data Source Expectation")

        let network = TestNetwork()
        let dataSource = MovieListNetworkDataSource(networkInterface: network)
        var expectedCount = 0
        let pagesize = 2
        dataSource.dataUpdatedCallback = { from, to in
            print("Loaded from: \(from) - to: \(to)")
            expectedCount += pagesize
            XCTAssertEqual(expectedCount, to + 1, "Expected count to be: \(expectedCount)")
            _ = dataSource[to - 1]
            if expectedCount == dataSource.totalCount {
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 30.0)
    }
}
