//
//  ContentView.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 11/25/25.
//

import SwiftUI

struct ContentView: View {
    
    //initializing the list with data from my API
    @State var books = getBooks()
    @State var showAddBookSheet: Bool = false
    
    //created a placeholder book for the Add feature
    @State var newBook = Book(title: "", author: "", details: "")
    
    var body: some View {
        NavigationStack {
            List($books) { $bookInList in
                NavigationLink(destination: DetailView(book: $bookInList)) {
                    BookLinkItem(book: bookInList)
                }
            }
            .navigationTitle("Book Manager")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add") {
                        //reset the newBook variable before opening the sheet
                        newBook = Book(title: "", author: "", details: "")
                        showAddBookSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: $showAddBookSheet) {
                //when sheet is dismissed, checks if I should add the book
                if !newBook.title.isEmpty {
                    books.append(newBook)
                }
            } content: {
                AddEditView(bookToEdit: $newBook)
            }
        }
    }
}
