//
//  FilterView.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 12/11/25.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedGenre: Genre?
    @Binding var showOnlyFavorites: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Filters")) {
                    Toggle(isOn: $showOnlyFavorites) {
                        Label("Favorites Only", systemImage: "heart.fill")
                    }
                    
                    Picker(selection: $selectedGenre, label: Label("Genre", systemImage: "book.closed")) {
                        Text("All Genres").tag(Genre?.none)
                        ForEach(Genre.allCases, id: \.self) { genre in
                            Text(genre.rawValue).tag(genre as Genre?)
                        }
                    }
                }
                
                Section {
                    //removing custom frames and button styles
                    Button(role: .destructive) {
                        selectedGenre = nil
                        showOnlyFavorites = false
                        dismiss()
                    } label: {
                        Text("Clear All Filters")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationTitle("Filter Books")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                       dismiss()
                    }
                }
            }
        }
    }
}
