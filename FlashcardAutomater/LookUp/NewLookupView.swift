//
//  NewLookupView.swift
//  FlashcardAutomater
//
//  Created by Leon on 2023/8/8.
//

import SwiftUI

struct NewLookupView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var lookupOO: NewLookupOO
    @State private var input = ""
    @FocusState private var inputFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack(alignment: .center) {
                    TextField("Here is text", text: $input)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .focused($inputFocused)
                    
                    Button {
                        inputFocused = false
                        lookupOO.lookUp(with: input)
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .frame(width: 44)
                    .disabled(lookupOO.loading || input.count <= 0)
                }
                .padding([.top, .leading, .trailing], 15)
                
                if !lookupOO.loading && lookupOO.entries.count > 0 {
                    WebView(html: lookupOO.entriesHtml)
                        .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                            Color.clear
                                .frame(height: 4)
                        }
                } else {
                    Color.clear
                        .overlay {
                            if lookupOO.loading {
                                ProgressView()
                            } else if let error = lookupOO.errorForView {
                                Text(error.message)
                                    .offset(y: -30)
                            } else if lookupOO.entries.isEmpty {
                                Text("Looks like no entries here...")
                                    .offset(y: -30)
                            } else {
                                Text("Unknown error...")
                                    .offset(y: -30)
                            }
                        }
                }
            }
            .ignoresSafeArea(.container, edges: .bottom)
            .navigationTitle("New Lookup")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem {
                    Button("Save") {
                        lookupOO.saveLookup()
                        dismiss()
                    }
                    .disabled(lookupOO.loading || lookupOO.entriesHtml.isEmpty)
                }
            }
            .onAppear {
                inputFocused = true
            }
        }
        
    }
}

struct NewLookupView_Previews: PreviewProvider {
    static var previews: some View {
        NewLookupView(lookupOO: NewLookupOO(context: StorageProvider.preview.persistentContainer.viewContext))
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}
