//
//  DetailView.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 11/25/25.
//
import SwiftUI

struct DetailView: View {
    
    //binding here so updates from the Edit screen reflect immediately
    @Binding var book: Book
    
    @State private var showEditBookSheet: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack(alignment: .top) {
                    //handling the missing image asset gracefully
                    if UIImage(named: book.coverImage) != nil {
                        Image(book.coverImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                    } else {
                        Image(systemName: "book.closed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(book.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("by \(book.author)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        //added quick star display
                        HStack {
                            ForEach(1...5, id: \.self) { star in
                                Image(systemName: star <= book.rating ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .font(.caption)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                //Description Section
                DescriptionView(name: book.title, text: book.details)
                    .padding(.horizontal)
                
                Divider()
                
                //Review Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("My Review")
                        .font(.headline)
                    
                    if book.review.isEmpty {
                        Text("No review yet.")
                            .italic()
                            .foregroundColor(.gray)
                    } else {
                        Text(book.review)
                            .font(.body)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Edit") {
                //trigger edit sheet
                showEditBookSheet.toggle()
            }
        }
        .sheet(isPresented: $showEditBookSheet) {
            AddEditView(bookToEdit: $book)
        }
    }
}

//created separate view per assignment instructions
struct DescriptionView: View {
    var name: String
    var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Description for \(name)")
                .font(.headline)
                .padding(.bottom, 2)
            
            Text(text)
                .font(.body)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
        }
    }
}
