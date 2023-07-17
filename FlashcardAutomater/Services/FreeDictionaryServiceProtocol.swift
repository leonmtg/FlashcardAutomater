//
//  FreeDictionaryServiceProtocol.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/7/17.
//

import Foundation
import Combine

protocol FreeDictionaryServiceProtocol {
    func entryPublisher(for entry: String) -> AnyPublisher<Data, URLError>
}
