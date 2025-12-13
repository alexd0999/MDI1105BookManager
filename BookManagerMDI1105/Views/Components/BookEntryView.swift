//
//  BookEntryView.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 12/13/25.
//

import SwiftUI
import SwiftData
import PhotosUI

struct BookEntryView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    var bookToEdit: Book?
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre: Genre = .fantasy
    @State private var status: ReadingStatus = .toRead
    @State private var rating = 3
    @State private var isFavorite = false
    
    //select image
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    
    var isEditing: Bool {
        bookToEdit != nil
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Book Details")) {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                }
                
                Section("Classification") {
                    Picker("Genre", selection: $genre) {
                        ForEach(Genre.allCases, id: \.self) { genre in
                            Text(genre.rawValue).tag(genre)
                        }
                    }
                    
                    Picker("Status", selection: $status) {
                        ForEach(ReadingStatus.allCases) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    
                    Toggle("Favorite", isOn: $isFavorite)
                }
                
                Section("Rating") {
                    Picker("Rating", selection: $rating) {
                        ForEach(1...5, id: \.self) { i in
                            Text("\(i) Stars").tag(i)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Cover Image") {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Label(selectedImageData == nil ? "Select Cover" : "Change Cover", systemImage: "photo")
                    }
                    
                    if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle(isEditing ? "Edit Book" : "Add Book")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveBook()
                        dismiss()
                    }
                    .disabled(title.isEmpty) //noo empty books
                }
            }
            //load data on edit
            .onAppear {
                if let book = bookToEdit {
                    title = book.title
                    author = book.author
                    genre = book.genre
                    status = book.status
                    rating = book.rating
                    isFavorite = book.isFavorite
                    selectedImageData = book.imageData
                }
            }
            //photo selection
            .onChange(of: selectedItem) {
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
        }
    }
    
    func saveBook() {
        if let book = bookToEdit {
            //update existing book
            book.title = title
            book.author = author
            book.genre = genre
            book.status = status
            book.rating = rating
            book.isFavorite = isFavorite
            book.imageData = selectedImageData
        } else {
            //create new
            let newBook = Book(
                title: title,
                author: author,
                imageData: selectedImageData,
                isFavorite: isFavorite,
                genre: genre,
                rating: rating,
                status: status
            )
            modelContext.insert(newBook)
        }
    }
}
