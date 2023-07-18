//
//  FreeDictionaryServiceProtocol.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/7/17.
//

import Foundation
import Combine

protocol FreeDictionaryServiceProtocol {
    func entriesPublisher(for input: String) -> AnyPublisher<Data, URLError>
    func lookUpEntries(with input: String) async throws -> Data
}
