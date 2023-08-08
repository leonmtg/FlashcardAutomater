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
        if lookups.count > 0 {
            List(lookups) { lookup in
                Text(lookup.input ?? "--")
            }
        } else {
            Text("Nothing here...")
        }
        
    }
}

struct LookupsView_Previews: PreviewProvider {
    static var previews: some View {
        LookupsView()
    }
}
