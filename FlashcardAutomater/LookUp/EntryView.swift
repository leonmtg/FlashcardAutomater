//
//  EntryView.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/8.
//

import SwiftUI

struct EntryView: View {
    var entry: Entry
    
    var body: some View {
        VStack {
            Text("\(entry.word)")
                .fontWeight(.bold)
            
            VStack(alignment:.leading) {
                ForEach(entry.meanings) { meaning in
                    MeaningView(meaning: meaning)
                }
            }
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static let entry = Entry.mock
    static var previews: some View {
        EntryView(entry: entry)
    }
}
