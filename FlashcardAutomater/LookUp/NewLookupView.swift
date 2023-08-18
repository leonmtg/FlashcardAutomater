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
                    .textInputAutocapitalization(.never)
                    .padding([.top, .leading, .trailing], 20)
                Button("Look Up!") {
                    lookupOO.lookUp(with: input)
                }
                .disabled(lookupOO.loading || input.count <= 0)
                
                if lookupOO.loading {
                    Spacer()
                        .overlay {
                            ProgressView()
                        }
                } else {
                    if let error = lookupOO.errorForView {
                        Color.clear
                            .overlay {
                                Text(error.message)
                                    .offset(y: -44)
                            }
                    } else if (lookupOO.entries.isEmpty) {
                        Color.clear
                            .overlay(alignment: .center) {
                                Text("Looks like no entries here...")
                                    .offset(y: -44)
                            }
                    } else {
                        /*
                        ScrollView {
                            LazyVStack {
                                ForEach(lookupOO.entries) { entry in
                                    EntryView(entry: entry)
                                }
                            }
                            .padding([.leading, .trailing], 20)
                        }
                        .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                            Color.clear
                                .frame(height: 20)
                        }
                         */
                        WebView(html: lookupOO.entriesHtml)
                            .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                                Color.clear
                                    .frame(height: 4)
                            }
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
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
