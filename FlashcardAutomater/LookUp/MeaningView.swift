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
        VStack(alignment:.leading, spacing: 8) {
            Text("\(meaning.partOfSpeech)")
                .fontWeight(.semibold)
                .italic()
            VStack(alignment:.leading, spacing: 5) {
                ForEach(meaning.definitions.indices, id: \.self) { index in
                    DefinitionView(index: index, definition: meaning.definitions[index])
                }
                if meaning.synonyms.count > 0 {
                    HStack {
                        Text("SYNONYM")
                        Text(meaning.synonyms.joined(separator: ", "))
                            .bold()
                    }
                }
                if meaning.antonyms.count > 0 {
                    HStack {
                        Text("ANTONYM")
                        Text(meaning.antonyms.joined(separator: ", "))
                            .bold()
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
