//
//  BookManagerMDI1105App.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 11/25/25.
//

import SwiftUI
import SwiftData

@main
struct BookManagerMDI1105App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
