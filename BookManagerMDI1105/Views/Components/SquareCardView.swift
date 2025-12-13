//
//  SquareCardView.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 12/11/25.
//

import SwiftUI

struct SquareCardView: View {
    //only needs read access
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            //placeholder in case no image name
            Group {
                if let data = book.imageData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                } else if !book.coverImage.isEmpty {
                    Image(book.coverImage)
                        .resizable()
                } else {
                    Image(systemName: "book.closed")
                        .resizable()
                        .padding(20)
                }
            }
            .scaledToFill()
            .frame(height: 150)
            .clipped() //ensures image doesn't spill out of the frame
            .background(Color.gray.opacity(0.3))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .lineLimit(1) //keeps the title on one line
                
                //simple star rating display
                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        Image(systemName: index < book.rating ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 12)
        }
        //card styling
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
