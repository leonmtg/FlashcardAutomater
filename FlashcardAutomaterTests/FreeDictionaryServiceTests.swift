//
//  FreeDictionaryServiceTests.swift
//  FlashcardAutomaterTests
//
//  Created by Leon on 2023/7/17.
//

import XCTest
import Combine
@testable import FlashcardAutomater

final class FreeDictionaryServiceTests: XCTestCase {
    var service: FreeDictionaryService!
    private var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        
        service = .init()
    }
    
    override func tearDown() {
        subscriptions = []
        
        super.tearDown()
    }
    
    func test_entriesPublisherHasData() {
        var data: Data?
        var error: URLError?
        let expectation = self.expectation(description: "Fetch Entry")
        
        service.entriesPublisher(for: "hello")
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let theError):
                    error = theError
                }
                
                expectation.fulfill()
            } receiveValue: { theData in
                data = theData
            }
            .store(in: &subscriptions)

        waitForExpectations(timeout: 5)
        
        XCTAssertNil(error)
        XCTAssertNotNil(data)
    }
}
