//
//  LookUpOO.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/7/17.
//

import Foundation
import Combine

struct ErrorForView: Error {
    let id = UUID()
    var message = ""
}

class LookupOO: ObservableObject {
    private let service: FreeDictionaryServiceProtocol
    
    private var currentInput: String?
    @Published var entries: [Entry] = []
    @Published var entriesHtml: String = ""
    @Published var errorForView: ErrorForView?
    private var fetching = false
    
    // TODO: Maybe I can use a better solution here: https://www.swiftbysundell.com/articles/handling-loading-states-in-swiftui/
    @Published var loading = false
    
    private var cancellable: AnyCancellable?
    
    init(service: FreeDictionaryServiceProtocol = FreeDictionaryService()) {
        self.service = service
        
        cancellable = $entries
            .map { entries in
                MarkdownToHTMLConverter.convertMarkdownSupportedArray(entries, separator: "<br />")
            }
            .sink { [unowned self] html in
                self.entriesHtml = html
                self.loading = false
            }
    }
    
    func lookUp(with input: String) {
        loading = true
        
        Task {
            do {
                let fetchedEntries = try await lookUp(with: input)
                
                await MainActor.run {
                    self.entries = fetchedEntries
                }
            } catch let error as HTTPResponseError {
                await MainActor.run {
                    self.errorForView = ErrorForView(message: error.localizedDescription)
                }
            } catch {
                await MainActor.run {
                    self.errorForView = ErrorForView(message: "Unknown Error.")
                }
            }
        }
    }
    
    func lookUp(with input: String) async throws -> [Entry] {
        guard fetching == false else {
            return []
        }
        
        currentInput = input
        fetching = true
        defer {
            fetching = false
        }
                
        return try await self.service.lookUpEntries(with: input)
    }
}
