//
//  api.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 11/25/25.
//

import Foundation

func getBooks() -> [Book] {
    return [
        Book(
            title: "The Fellowship of the Ring",
            author: "J.R.R. Tolkien",
            coverImage: "lotr1",
            details: "A group of thirteen people set out on a perilous quest to destroy the One Ring, a powerful artifact that threatens Middle-earth.",
            rating: 5,
            review: "A classic."
        ),
        Book(
            title: "The Two Towers",
            author: "J.R.R. Tolkien",
            coverImage: "lotr2",
            details: "As the Fellowship faces the treacherous path of Mount Doom, they are joined by new allies and confront the dark forces that seek to use the One Ring for their own nefarious purposes.",
            rating: 4,
            review: "A bit slow halfway through. Battle scenes were awesome."
        ),
        Book(
            title: "The Return of the King",
            author: "J.R.R. Tolkien",
            coverImage: "lotr3",
            details: "The final confrontation between the light and dark forces ensues as the Fellowship, now weakened but not defeated, faces the One Ring in a climactic battle at Mount Doom.",
            rating: 5,
            review: "The perfect ending to a long journey."
        )
    ]
}
