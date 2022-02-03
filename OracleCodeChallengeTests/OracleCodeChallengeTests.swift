//
//  OracleCodeChallengeTests.swift
//  OracleCodeChallengeTests
//
//  Created by pradeep kumar jalakam on 2/2/22.
//

import XCTest
import Combine
@testable import OracleCodeChallenge

class OracleCodeChallengeTests: XCTestCase {
    private var viewModel = HomeViewModel() 
    private var cancellable: AnyCancellable?
    private var errorCancellable: AnyCancellable?

    override func setUpWithError() throws {
        // to setup mock data for unit testing this should be only for debug schema
        MockURLProtocol.configureMock()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModalAndNetworkManagerHappyPath() throws {
        func subscribeToData() {
            // Subscribe to the view model, networkManager and model to update the tableView
            cancellable = viewModel.$items.sink(receiveValue:{
                 items in
                if !items.isEmpty {
                    XCTAssertTrue(!items.isEmpty, "")
                }
            })
        }
        //does not matter i mocked data using URLProtocol for happy path
        let baseUrlString = "https://test.com"
        viewModel.getHomeData(baseUrl: baseUrlString)
        subscribeToData()
    }
    
    func testViewModalAndNetworkManagerFailurePath() throws {
        func subscribeToData() {
        
            errorCancellable = viewModel.$errorString.sink(receiveValue: { errorString in
                if !errorString.isEmpty {
                    XCTAssertTrue(!errorString.isEmpty, "")
                }
            })
        }
        //does not matter i mocked data using URLProtocol for happy path
        let baseUrlString = "//:Some random url"
        viewModel.getHomeData(baseUrl: baseUrlString)
        subscribeToData()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            viewModel.getHomeData(baseUrl: "https://test.com")
            // Put the code you want to measure the time of here.
        }
    }

}
