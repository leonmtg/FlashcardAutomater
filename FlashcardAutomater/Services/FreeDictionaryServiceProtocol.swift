//
//  FreeDictionaryServiceProtocol.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/7/17.
//

import Foundation
import Combine

protocol FreeDictionaryServiceProtocol {
    func entriesPublisher(for input: String) -> AnyPublisher<[Entry], HTTPResponseError>
    func lookUpEntries(with input: String) async throws -> [Entry]
}
