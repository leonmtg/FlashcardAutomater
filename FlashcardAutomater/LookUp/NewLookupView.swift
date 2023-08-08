//
//  NewLookupView.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/8.
//

import SwiftUI

struct NewLookupView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Hello, New World!")
            Spacer()
            Button("Cancel") {
                dismiss()
            }
        }
    }
}

struct NewLookupView_Previews: PreviewProvider {
    static var previews: some View {
        NewLookupView()
    }
}
