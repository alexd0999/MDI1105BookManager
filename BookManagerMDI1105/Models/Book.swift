//
//  Book.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 11/25/25.
//

import Foundation

struct Book: Identifiable {
    //unique ID for each book so the List knows how to identify
    let id: UUID = UUID()
    
    var title: String
    var author: String
    
    var coverImage: String = "default_book"
    
    var details: String
    
    var rating: Int = 3 //default rating
    var review: String = ""
}
