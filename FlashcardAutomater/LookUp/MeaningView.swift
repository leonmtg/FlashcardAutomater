//
//  MeaningView.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/14.
//

import SwiftUI

struct MeaningView: View {
    var meaning: Meaning
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("\(meaning.partOfSpeech)")
            VStack(alignment:.leading) {
                ForEach(meaning.definitions.indices, id: \.self) { index in
                    HStack {
                        Text("\(index + 1)")
                        Text(meaning.definitions[index].definition)
                    }
                }
            }
        }
    }
}

struct MeaningView_Previews: PreviewProvider {
    static let meaning = Meaning.mock
    static var previews: some View {
        MeaningView(meaning: meaning)
    }
}
