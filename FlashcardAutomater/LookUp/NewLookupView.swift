//
//  NewLookupView.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/8.
//

import SwiftUI

struct NewLookupView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var lookupOO = LookupOO()
    @State private var input = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Here is text", text: $input)
                    .textFieldStyle(.roundedBorder)
                Button("Look Up!") {
                    
                }
                .disabled(lookupOO.loading)
                
                if lookupOO.entries.count > 0 {
                    LazyVStack {
                        ForEach(lookupOO.entries) { entry in
                            EntryView(entry: entry)
                        }
                    }
                } else {
                    Text("Looks like no entries here...")
                }
               
                Spacer()
            }
            .padding(20)
            .navigationTitle("New Lookup")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        
    }
}

struct NewLookupView_Previews: PreviewProvider {
    static var previews: some View {
        NewLookupView()
    }
}
