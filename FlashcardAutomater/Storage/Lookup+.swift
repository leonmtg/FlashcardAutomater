//
//  Lookup+.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/8.
//

import CoreData

extension Lookup {
    static var lookupsByUpdateDate: NSFetchRequest<Lookup> {
        let request: NSFetchRequest<Lookup> = Lookup.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Lookup.updateDate, ascending: false)
        ]
        return request
    }
}
