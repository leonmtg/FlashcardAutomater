//
//  LookupsView.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/1.
//

import SwiftUI

struct LookupsView: View {
    @ObservedObject var lookupsOO: LookupsOO
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct LookupsView_Previews: PreviewProvider {
    static let lookupsOO = LookupsOO(storageProvider: StorageProvider())
    
    static var previews: some View {
        LookupsView(lookupsOO: lookupsOO)
    }
}
