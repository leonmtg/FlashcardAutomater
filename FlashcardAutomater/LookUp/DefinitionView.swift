//
//  DefinitionView.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/14.
//

import SwiftUI

struct DefinitionView: View {
    var index: Int
    var definition: Definition
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(index + 1)")
            VStack(alignment:.leading) {
                Text(definition.definition)
                if definition.synonyms.count > 0 {
                    HStack {
                        Text("SYNONYM")
                        Text(definition.synonyms.joined(separator: ", "))
                            .bold()
                    }
                }
                if definition.antonyms.count > 0 {
                    HStack {
                        Text("ANTONYM")
                        Text(definition.antonyms.joined(separator: ", "))
                            .bold()
                    }
                }
                if let example = definition.example {
                    HStack {
                        Text("•")
                        Text(example)
                            .italic()
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

struct DefinitionView_Previews: PreviewProvider {
    static let defination = Definition.mock
    
    static var previews: some View {
        DefinitionView(index: 1, definition: defination)
    }
}
