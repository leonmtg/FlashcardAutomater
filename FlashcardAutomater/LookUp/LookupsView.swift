//
//  LookupsView.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/1.
//

import SwiftUI

struct LookupsView: View {
    @StateObject private var lookupsOO = LookupsOO()
    
    @FetchRequest(fetchRequest: Lookup.lookupsByUpdateDate)
    var lookups: FetchedResults<Lookup>
    
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
                        
                    } label: {
                        Image(systemName: "plus")
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
