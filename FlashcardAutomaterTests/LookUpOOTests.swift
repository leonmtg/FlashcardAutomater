//
//  LookUpOOTests.swift
//  FlashcardAutomaterTests
//
//  Created by Leon on 2023/7/18.
//

import XCTest
@testable import FlashcardAutomater

final class LookUpOOTests: XCTestCase {
    var lookUpOO: LookUpOO!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        lookUpOO = LookUpOO()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func test_lookUpFetchedEntries() async {
        let input = "hello"
        
        do {
            let entries = try await lookUpOO.lookUp(with: input)
            XCTAssertTrue(entries.count > 0, "Should Have Entries!")
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func test_lookUpCatchedErrors() async {
        let input = "xxxxxxxxxx"
        do {
            let entries = try await lookUpOO.lookUp(with: input)
            XCTAssertFalse(entries.count > 0, "Should NOT Have Entries!")
        } catch {
            print(error.localizedDescription)
            XCTAssertNotNil(error)
        }
    }
}
