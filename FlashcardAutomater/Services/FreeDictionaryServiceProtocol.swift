//
//  FreeDictionaryServiceProtocol.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/7/17.
//

import Foundation
import Combine

enum HTTPResponseError: String, Error {
    case unknown = "Response wasn't recognized."
    case clientError = "Problem getting the information."
    case serverError = "Problem with the server."
    case decodeError = "Problem reading the returned data"
}


protocol FreeDictionaryServiceProtocol {
    func entriesPublisher(for input: String) -> AnyPublisher<[Entry], HTTPResponseError>
    func lookUpEntries(with input: String) async throws -> [Entry]
}
