//
//  FavoritesView.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 12/6/25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query(filter: #Predicate<Book> { $0.isFavorite }) var favoriteBooks: [Book]
    
    let gridLayout = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if favoriteBooks.isEmpty {
                    ContentUnavailableView(
                        "No Favorites Yet",
                        systemImage: "heart.slash",
                        description: Text("Mark books as favorites to see them here.")
                    )
                    .padding(.top, 50)
                } else {
                    LazyVGrid(columns: gridLayout, spacing: 16) {
                        ForEach(favoriteBooks) { book in
                            NavigationLink(destination: BookDetailView(book: book)) {
                                SquareCardView(book: book)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Favorite Books")
            .background(Color(.systemGroupedBackground))
        }
    }
}
