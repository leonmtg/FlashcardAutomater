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
        VStack(spacing: 20) {
            Text("\(entry.word)")
                .fontWeight(.bold)
            VStack(alignment: .leading, spacing: 20) {
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
