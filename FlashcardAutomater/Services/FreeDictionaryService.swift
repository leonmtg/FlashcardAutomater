//
//  FreeDictionaryService.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/7/17.
//

import Foundation
import Combine

struct FreeDictionaryService {
    private func url(for entry: String) -> URL {
        urlComponents(for: entry).url!
    }
    
    private func urlComponents(for entry: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.dictionaryapi.dev"
        components.path = "/api/v2/entries/en/\(entry)"
        
        return components
    }
}

extension FreeDictionaryService: FreeDictionaryServiceProtocol {
    func entryPublisher(for entry: String) -> AnyPublisher<Data, URLError> {
        URLSession.shared
            .dataTaskPublisher(for: url(for: entry))
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
