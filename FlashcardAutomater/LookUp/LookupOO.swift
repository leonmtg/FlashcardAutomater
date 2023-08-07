//
//  LookUpOO.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/7/17.
//

import Foundation

struct ErrorForView: Error {
    let id = UUID()
    var message = ""
}

class LookupOO: ObservableObject {
    private let service: FreeDictionaryServiceProtocol
    
    private var currentInput: String?
    @Published var entries: [Entry] = []
    @Published var errorForView: ErrorForView?
    @Published var fetching = false
    @MainActor @Published var loading = false
    
    init(service: FreeDictionaryServiceProtocol = FreeDictionaryService()) {
        self.service = service

        $fetching
            .receive(on: DispatchQueue.main)
            .assign(to: &$loading)
    }
    
    func lookUp(with input: String) {
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
                
        return  try await self.service.lookUpEntries(with: input)
    }
}
