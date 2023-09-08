//
//  LookUpOO.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/7/17.
//

import Foundation
import Combine
import CoreData

struct ErrorForView: Error {
    let id = UUID()
    var message = ""
}

class NewLookupOO: ObservableObject {
    private let service: FreeDictionaryServiceProtocol
    private let context: NSManagedObjectContext
    
    private var currentInput: String?
    
    @Published var entries: [Entry] = []
    @Published var entriesHtml: String = ""
    @Published var errorForView: ErrorForView?
    private var fetching = false
    
    // TODO: Maybe I can use a better solution here: https://www.swiftbysundell.com/articles/handling-loading-states-in-swiftui/
    @Published var loading = false
    
    private var cancellable: AnyCancellable?
    
    init(service: FreeDictionaryServiceProtocol = FreeDictionaryService(), context: NSManagedObjectContext? = nil) {
        guard let context = context else {
            fatalError("Attempting to create a managed object that not passing a context explicitly")
        }
        
        self.context = context
        self.service = service
        
        cancellable = $entries
            .map { entries in
                MarkdownToHTMLConverter.convertMarkdownSupportedArray(entries, separator: "\n\n")
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
    
    func saveLookup() {
        guard let input = self.currentInput else {
            fatalError("Attempting to create a managed object while not having a 'input'")
        }
        guard !self.entriesHtml.isEmpty else {
            fatalError("Attempting to create a managed object while not having a 'entriesHtml'")
        }
        
        let lookup = Lookup(context: self.context)
        
        lookup.input = input
        lookup.html = self.entriesHtml
        lookup.updateDate = Date()
        
        do {
            try self.context.save()
            print("Lookup saved succesfully")
        } catch {
            self.context.rollback()
            print("Failed to save lookup: \(error)")
        }
    }
}
