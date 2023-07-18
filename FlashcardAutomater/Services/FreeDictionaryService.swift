//
//  FreeDictionaryService.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/7/17.
//

import Foundation
import Combine

struct FreeDictionaryService {
    private func url(for input: String) -> URL {
        urlComponents(for: input).url!
    }
    
    private func urlComponents(for input: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.dictionaryapi.dev"
        components.path = "/api/v2/entries/en/\(input)"
        
        return components
    }
}

extension FreeDictionaryService: FreeDictionaryServiceProtocol {
    func entriesPublisher(for input: String) -> AnyPublisher<Data, HTTPResponseError> {
        URLSession.shared
            .dataTaskPublisher(for: url(for: input))
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HTTPResponseError.unknown
                }
                
                if (400...499).contains(httpResponse.statusCode) {
                    throw HTTPResponseError.clientError
                }
                
                if (500...599).contains(httpResponse.statusCode) {
                    throw HTTPResponseError.serverError
                }
                
                return data
            }
            .mapError { error -> HTTPResponseError in
                if let httpResponseError = error as? HTTPResponseError {
                    return httpResponseError
                } else {
                    return HTTPResponseError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    func lookUpEntries(with input: String) async throws -> Data {
        let asyncSequence = entriesPublisher(for: input).values
        
        for try await value in asyncSequence {
            return value
        }
        
        assertionFailure("We should never arrive here!")
        return Data()
    }
}
