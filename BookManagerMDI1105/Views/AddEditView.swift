//
//  AddEditView.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 11/25/25.
//
import SwiftUI

struct AddEditView: View {
    
    //use Binding so changes here can eventually affect the main list
    @Binding var bookToEdit: Book
    
    //use this state to hold temporary changes before saving
    @State private var workingBook: Book
    
    //use this to close the modal
    @Environment(\.dismiss) var dismiss
    
    var titleText: String
    
    init(bookToEdit: Binding<Book>) {
        self._bookToEdit = bookToEdit
        //creating a copy of the book to edit locally
        self._workingBook = State(initialValue: bookToEdit.wrappedValue)
        
        //determining the title based on whether the book has a title yet
        self.titleText = bookToEdit.wrappedValue.title.isEmpty ? "Add Book" : "Edit Book"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Book Info")) {
                    //binding these fields to temporary workingBook
                    TextField("Title", text: $workingBook.title)
                    TextField("Author", text: $workingBook.author)
                }
                
                Section(header: Text("Details")) {
                    TextEditor(text: $workingBook.details)
                        .frame(minHeight: 100)
                }
                
                //assignment 2 requirement
                Section(header: Text("Review & Rating")) {
                    Picker("Rating", selection: $workingBook.rating) {
                        ForEach(1...5, id: \.self) { rating in
                            Text("\(rating) Stars").tag(rating)
                        }
                    }
                    
                    TextField("My Review", text: $workingBook.review, axis: .vertical)
                }
            }
            .navigationTitle(titleText)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        //copying the changes back to the original binding only on Save
                        bookToEdit = workingBook
                        dismiss()
                    }
                    //disables the save button if the title is empty
                    .disabled(workingBook.title.isEmpty)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        //discards changes to 'workingBook'
                        dismiss()
                    }
                }
            }
        }
    }
}


