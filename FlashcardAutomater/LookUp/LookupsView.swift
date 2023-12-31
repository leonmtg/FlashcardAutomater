//
//  LookupsView.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/1.
//

import SwiftUI

struct LookupsView: View {
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(fetchRequest: Lookup.lookupsByUpdateDate)
    var lookups: FetchedResults<Lookup>
    
    @State private var creatingNewLookup = false
    
    var body: some View {
        NavigationStack {
            List(lookups) { lookup in
                Text(lookup.input ?? "--")
            }
            .overlay {
                if lookups.isEmpty {
                    Text("Oops, looks like there's no data...")
                }
            }
            .navigationTitle("Lookups")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        creatingNewLookup = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $creatingNewLookup) {
                        NewLookupView(lookupOO: NewLookupOO(context: context))
                    }
                }
            }
        }
    }
}

struct LookupsView_Previews: PreviewProvider {
    static var previews: some View {
        LookupsView()
    }
}
