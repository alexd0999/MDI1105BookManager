//
//  Settings.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 12/11/25.
//

import SwiftUI

struct Settings: View {
    @AppStorage("SETTINGS_THEME") private var selectedTheme: Theme = .system
    
    //keys match BookListView
    @AppStorage("settingShowBookCovers") private var showBookCovers = true
    @AppStorage("settingSortAlphabetical") private var sortAlphabetical = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Appearance")) {
                    Picker("Theme", selection: $selectedTheme) {
                        ForEach(Theme.allCases, id: \.self) { theme in
                            Text(theme.rawValue.capitalized).tag(theme)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                //list settings
                Section(header: Text("List Settings")) {
                    Toggle("Show Book Covers", isOn: $showBookCovers)
                    Toggle("Sort Alphabetically", isOn: $sortAlphabetical)
                }
                .headerProminence(.increased)
            }
            .navigationTitle("Settings")
        }
    }
}
