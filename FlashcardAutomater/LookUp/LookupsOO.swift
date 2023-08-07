//
//  LookupsOO.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/1.
//

import SwiftUI
import CoreData

class LookupsOO: NSObject, ObservableObject {
    @Published var lookups = [Lookup]()
    
    private let fetchedResultsController: NSFetchedResultsController<Lookup>
    
    init(storageProvider: StorageProvider) {
        let fetchRequest: NSFetchRequest<Lookup> = Lookup.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Lookup.updateDate, ascending: false)]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                   managedObjectContext: storageProvider.persistentContainer.viewContext,
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName: nil)
        super.init()
        
        fetchedResultsController.delegate = self
    }
    
    func fetchLookups() {
        try! fetchedResultsController.performFetch()
        lookups = fetchedResultsController.fetchedObjects ?? []
    }
}

extension LookupsOO: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        lookups = controller.fetchedObjects as? [Lookup] ?? []
    }
}
