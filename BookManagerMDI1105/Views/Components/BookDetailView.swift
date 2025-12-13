//
//  BookDetailView.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 12/13/25.
//

import SwiftUI

struct BookDetailView: View {
    @Bindable var book: Book
    @State private var isShowingEditSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                //image header
                HStack {
                    Spacer()
                    if let data = book.imageData, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 250)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    } else {
                        Image(book.coverImage.isEmpty ? "book.closed.fill" : book.coverImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 250)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                    Spacer()
                }
                .padding(.top)

                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(book.title)
                            .font(.title)
                            .bold()
                        Spacer()
                        FavoriteToggle(isFavorite: $book.isFavorite)
                    }
                    
                    Text(book.author)
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Genre")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(book.genre.rawValue)
                                .font(.headline)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Status")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(book.status.rawValue)
                                .font(.headline)
                                .padding(6)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                    
                    Divider()
                    
                    Text("Rating")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        ForEach(1...5, id: \.self) { index in
                            Image(systemName: index <= book.rating ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Edit") {
                isShowingEditSheet = true
            }
        }
        .sheet(isPresented: $isShowingEditSheet) {
            BookEntryView(bookToEdit: book)
        }
    }
}
