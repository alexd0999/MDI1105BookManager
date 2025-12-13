//
//  Book.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 11/25/25.
//

//
//  Book.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 11/25/25.
//

//
//  Book.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 11/25/25.
//

import SwiftUI
import SwiftData

@Model
final class Book {
    var title: String
    var author: String
    var coverImage: String
    @Attribute(.externalStorage) var imageData: Data?
    var isFavorite: Bool
    var genre: Genre
    var rating: Int
    var status: ReadingStatus
    
    init(title: String, author: String, coverImage: String = "", imageData: Data? = nil, isFavorite: Bool = false, genre: Genre = .unknown, rating: Int = 3, status: ReadingStatus = .toRead) {
        self.title = title
        self.author = author
        self.coverImage = coverImage
        self.imageData = imageData
        self.isFavorite = isFavorite
        self.genre = genre
        self.rating = rating
        self.status = status
    }
}

extension Book {
    static let sampleData: [Book] = [
        Book(title: "The Fellowship of the Ring", author: "J.R.R. Tolkien", coverImage: "lotr1", isFavorite: true, genre: .fantasy, rating: 5, status: .completed),
        Book(title: "The Two Towers", author: "J.R.R. Tolkien", coverImage: "lotr2", isFavorite: false, genre: .fantasy, rating: 4, status: .toRead),
        Book(title: "The Return of the King", author: "J.R.R. Tolkien", coverImage: "lotr3", isFavorite: true, genre: .fantasy, rating: 5, status: .reading),
        Book(title: "If You Give A Mouse A Cookie", author: "Laura Joffe Numeroff", coverImage: "mousecookie1", isFavorite: true, genre: .classic, rating: 5, status: .reading),
    ]
}
