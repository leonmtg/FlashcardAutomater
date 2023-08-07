//
//  FlashcardAutomaterApp.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/7/17.
//

import SwiftUI

@main
struct FlashcardAutomaterApp: App {
    let storageProvider = StorageProvider()
    
    var body: some Scene {
        WindowGroup {
            LookupsView(lookupsOO: LookupsOO(storageProvider: storageProvider))
        }
    }
}
