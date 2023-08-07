//
//  StorageProvider.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/7.
//

import CoreData

final class StorageProvider {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data store failed to load with error: \(error)")
            }
        }
    }
}

extension StorageProvider {
    func saveLookup(with input: String) {
        let lookup = Lookup(context: persistentContainer.viewContext)
        lookup.input = input
        lookup.updateDate = Date()
        
        do {
            try persistentContainer.viewContext.save()
            print("Lookup saved succesfully")
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save lookup: \(error)")
        }
    }
    
    func getAllLookups() -> [Lookup] {
        let fetchRequest: NSFetchRequest<Lookup> = Lookup.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch lookups: \(error)")
            return []
        }
    }
    
    func deleteLookup(_ lookup: Lookup) {
        persistentContainer.viewContext.delete(lookup)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context: \(error)")
        }
    }
}
