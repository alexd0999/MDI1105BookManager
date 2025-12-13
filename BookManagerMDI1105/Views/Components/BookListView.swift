//
//  BookListView.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 12/11/25.
//

import SwiftUI
import SwiftData

struct BookListView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var books: [Book]
    
    @State private var isShowingFilterSheet = false
    @State private var isShowingAddSheet = false
    
    //filter States
    @State private var filterGenre: Genre? = nil
    @State private var filterShowFavoritesOnly = false
    
    //settings Keys (match Settings.swift)
    @AppStorage("settingShowBookCovers") private var showBookCovers = true
    @AppStorage("settingSortAlphabetical") private var sortAlphabetical = false

    var filteredAndSortedBooks: [Book] {
        //filter
        var result = books.filter { book in
            if filterShowFavoritesOnly && !book.isFavorite { return false }
            if let selected = filterGenre, book.genre != selected { return false }
            return true
        }
        
        //sort
        if sortAlphabetical {
            result.sort { $0.title < $1.title }
        }
        
        return result
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredAndSortedBooks) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        BookRow(book: book, showCover: showBookCovers)
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("My Library")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button { isShowingFilterSheet = true } label: {
                            Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                        }
                        Button { isShowingAddSheet = true } label: {
                            Label("Add", systemImage: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowingFilterSheet) {
                FilterView(selectedGenre: $filterGenre, showOnlyFavorites: $filterShowFavoritesOnly)
            }
            .sheet(isPresented: $isShowingAddSheet) {
                BookEntryView()
            }
        }
    }
    
    private func deleteBooks(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(filteredAndSortedBooks[index])
            }
        }
    }
}

//subview for cleaner code
struct BookRow: View {
    let book: Book
    let showCover: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            if showCover {
                Group {
                    if let data = book.imageData, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage).resizable()
                    } else {
                        // Fallback for asset images or placeholder
                        Image(book.coverImage.isEmpty ? "book.closed" : book.coverImage)
                            .resizable()
                    }
                }
                .scaledToFill()
                .frame(width: 50, height: 75)
                .cornerRadius(8)
                .clipped()
            }
            
            VStack(alignment: .leading) {
                Text(book.title).font(.headline)
                Text(book.author).font(.subheadline).foregroundColor(.secondary)
            }
            
            Spacer()
            

            if book.isFavorite {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
        }
    }
}
