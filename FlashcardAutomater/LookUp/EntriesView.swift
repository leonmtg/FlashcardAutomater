//
//  EntriesView.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/8.
//

import SwiftUI

struct EntriesView: View {
    @ObservedObject var lookupOO: LookupOO
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct EntriesView_Previews: PreviewProvider {
    static let lookupOO = LookupOO()
    
    static var previews: some View {
        EntriesView(lookupOO: lookupOO)
    }
}
