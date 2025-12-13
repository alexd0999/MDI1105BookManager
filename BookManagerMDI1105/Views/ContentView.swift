//
//  ContentView.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 11/25/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    //settings tracker, no data load
    @AppStorage("hasLoadedSampleData") private var hasLoadedSampleData = false
    @AppStorage("SETTINGS_THEME") private var selectedTheme: Theme = .system
    
    var body: some View {
        TabView {
            BookListView()
                .tabItem {
                    Label("Books", systemImage: "book.fill")
                }
            
            //connected FavoritesView
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
            
            Settings()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        //ensure the color scheme applies to the entire app
        .preferredColorScheme(selectedTheme == .system ? nil : (selectedTheme == .dark ? .dark : .light))
        .onAppear {
            checkForAndLoadSampleData()
        }
    }
    
    private func checkForAndLoadSampleData() {
        //check if database is empty
        let descriptor = FetchDescriptor<Book>()
        let existingBooksCount = (try? modelContext.fetchCount(descriptor)) ?? 0
        
        if existingBooksCount == 0 {
            print("Database is empty. Loading sample data...")
            loadSampleData()
            hasLoadedSampleData = true
        } else {
            print("Database already has data. Skipping sample load.")
        }
    }
    
    private func loadSampleData() {
        for book in Book.sampleData {
            modelContext.insert(book)
        }
        //save changes immediately
        try? modelContext.save()
    }
}
