//
// Created by Sune Riedel on 24/09/2020.
// Copyright (c) 2020 Sune Riedel. All rights reserved.
//

import XCTest
@testable import RecoMovie

class RemoteTests: XCTestCase {
    func testFetch() {
        let expectation = XCTestExpectation(description: "Network Expectation")
        let remoteInterface: NetworkInterface = RemoteNetwork()
        remoteInterface.fetchJSON("https://www.dropbox.com/s/jkybb4i4de3jalx/test.json?dl=1", codable: CodableTest.self, completion: {
            data, response, error in
            guard let d = data else {
                XCTFail("No data")
                return
            }
            if let r = response {
                XCTAssertEqual(r.code, 200)
            }
            XCTAssertEqual("value1", d.field1)
            XCTAssertEqual(123, d.field2)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 30.0)
    }

    func testFetchNotFound() {
        let expectation = XCTestExpectation(description: "Network Expectation")
        let remoteInterface: NetworkInterface = RemoteNetwork()
        remoteInterface.fetchJSON("https://www.dropbox.com/test", codable: CodableTest.self, completion: {
            data, response, error in
            if data == nil {
                XCTAssertEqual(error, .contentError)
            }
            else {
                XCTFail("No data expected")
            }
            if let r = response {
                XCTAssertEqual(r.code, 404)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 30.0)
    }

    func testNetworkError() {
        let expectation = XCTestExpectation(description: "Network Expectation")
        let remoteInterface: NetworkInterface = RemoteNetwork()
        remoteInterface.fetchJSON("test://test", codable: CodableTest.self, completion: {
            data, response, error in
            if data == nil {
                XCTAssertEqual(error, .networkError)
            }
            else {
                XCTFail("No data expected")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 30.0)
    }

    func testURLError() {
        let expectation = XCTestExpectation(description: "Network Expectation")
        let remoteInterface: NetworkInterface = RemoteNetwork()
        remoteInterface.fetchJSON("#€%&", codable: CodableTest.self, completion: {
            data, response, error in
            if data == nil {
                XCTAssertEqual(error, .urlError)
            }
            else {
                XCTFail("No data expected")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 30.0)
    }

    struct CodableTest: Codable {
        var field1: String
        var field2: Int
    }
}
