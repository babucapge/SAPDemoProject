//
//  LoremViewModelTest.swift
//  SAPDemoProjectTests
//
//  Created by Apple on 23/07/22.
//

import XCTest
@testable import SAPDemoProject

class LoremViewModelTests: XCTestCase {
    
    func test_viewModel_with_default_network_manager() {
        let expectation = self.expectation(description: "Fetch and parse json data")
        let vm = LoremViewModel()
        vm.getData {
            XCTAssertEqual(vm.numberOfCells, 9)
            XCTAssertEqual(vm.loremTexts.first, "Lorem")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(vm.loremModel)
    }

    func test_getData_with_response() {
        let netman = NetworkManager()
        netman.parseJsonFile(name: "Lorem") { (result: Result<[LoremModel], ParseError>) in
            switch result {
            case .success(let successValue):
                XCTAssertNotNil(successValue)
                XCTAssertFalse(successValue.isEmpty)
                XCTAssertEqual(successValue.count, 3)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }

    func test_getData_with_no_data_response() {
        let netman = NetworkManager()
        netman.parseJsonFile(name: "Loremm") { (result: Result<[LoremModel], ParseError>) in
            switch result {
            case .success(let successValue):
                XCTAssertNil(successValue)
                XCTAssertTrue(successValue.isEmpty)
                XCTAssertEqual(successValue.count, 0)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testLoremTexts_with_response() {
        let expectation = self.expectation(description: "Fetch and parse json data")
        let vm = LoremViewModel()
        vm.getData {
            XCTAssertNotNil(vm.loremTexts)
            XCTAssertEqual(vm.loremTexts.count, 9)
            
            var index = 0
            for text in vm.loremTexts {
                index += 1
                if index == 1 || index%3 == 1 {
                    XCTAssertNotNil(text)
                    XCTAssertFalse(text.isEmpty)
                    XCTAssertEqual(text, "Lorem")
                } else if index == 2 || index%3 == 2 {
                    XCTAssertNotNil(text)
                    XCTAssertFalse(text.isEmpty)
                    XCTAssertEqual(text, "Lorem is the placeholder of uitextview, Lorem is the placeholder of uitextview, Lorem is the placeholder of uitextview, Lorem is the placeholder of uitextview.")
                } else {
                    XCTAssertNotNil(text)
                    XCTAssertFalse(text.isEmpty)
                    XCTAssertEqual(text, "Lorem is the placeholder of uitextview")
                }
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testLoremTexts_with_no_response() {
        let vm = LoremViewModel()
        XCTAssertEqual(vm.loremTexts.count, 0)
    }
    
    func testNumberOfCell_with_response() {
        let expectation = self.expectation(description: "Fetch and parse json data")
        let vm = LoremViewModel()
        vm.getData {
            XCTAssertNotNil(vm.numberOfCells)
            XCTAssertTrue(vm.numberOfCells != 0)
            XCTAssertEqual(vm.numberOfCells, 9)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testNumberOfCell_with_no_response() {
        let vm = LoremViewModel()
        XCTAssertEqual(vm.numberOfCells, 0)
    }
    
    func test_calculate_cell_width_and_height() {
        let expectation = self.expectation(description: "Fetch and parse json data")
        let vm = LoremViewModel()
        vm.getData {
            XCTAssertNotNil(vm.loremTexts)
            XCTAssertEqual(vm.getCellHeight(index: 1, screenWidth: 300).width,  CGFloat(60))
            XCTAssertEqual(vm.getCellHeight(index: 2, screenWidth: 240).height,  CGFloat(237))
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(vm.loremModel)
    }
}
