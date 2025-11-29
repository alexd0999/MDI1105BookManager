//
//  BookLinkItem.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 11/25/25.
//

import SwiftUI

struct BookLinkItem: View {
    //accepts a book passed in from the parent view
    var book: Book
    
    var body: some View {
        HStack {
            //checks if the image name exists, otherwise show a default icon
            //prevents issues since I haven't uploaded all png assets yet
            if UIImage(named: book.coverImage) != nil {
                Image(book.coverImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 75)
                    .cornerRadius(5)
            } else {
                Image(systemName: "book.closed.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 75)
                    .foregroundColor(.gray)
            }
            
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
