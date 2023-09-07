//
//  StorageProvider.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/7.
//

import CoreData

final class StorageProvider {
    let persistentContainer: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "Model")
        
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data store failed to load with error: \(error)")
            }
        }
    }
}

extension StorageProvider {
    static var preview: StorageProvider = {
        let provider = StorageProvider(inMemory: true)
        
        // TODO: Fill some preview data here!
        
        return provider
    }()
}
