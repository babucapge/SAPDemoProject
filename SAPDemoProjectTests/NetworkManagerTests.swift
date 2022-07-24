//
//  NetworkManagerTest.swift
//  SAPDemoProjectTests
//
//  Created by Apple on 23/07/22.
//

import XCTest
@testable import SAPDemoProject

class NetworkManagerTests: XCTestCase {
    
    func test_getData_with_response() throws {
        let data = try jsonMapping_with_response(fromJSON: "Lorem")
        XCTAssertNotNil(data)
        let loremM = try JSONDecoder().decode([LoremModel].self, from: data)
        
        XCTAssertFalse(loremM.isEmpty)
        XCTAssertNotNil(loremM)
        XCTAssertEqual(loremM.count, 3)
        
        for lorem in loremM {
            XCTAssertNotNil(lorem.title)
            XCTAssertEqual(lorem.title, "Lorem")
            
            XCTAssertNotNil(lorem.description)
            XCTAssertEqual(lorem.description, "Lorem is the placeholder of uitextview, Lorem is the placeholder of uitextview, Lorem is the placeholder of uitextview, Lorem is the placeholder of uitextview.")
            
            XCTAssertNotNil(lorem.shortDescription)
            XCTAssertEqual(lorem.shortDescription, "Lorem is the placeholder of uitextview")
        }
    }
    
    func jsonMapping_with_response(fromJSON fileName: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        
        XCTAssertNotNil(fileName)
        XCTAssertFalse(fileName.isEmpty)
        XCTAssertEqual(fileName, "Lorem")
        
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing File: \(fileName).json")
            throw ParseError.noData
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            XCTAssertNil(url)
            throw ParseError.noData
        }
    }
}
