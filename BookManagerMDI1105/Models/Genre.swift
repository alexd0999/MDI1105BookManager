//
//  Genre.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 12/6/25.
//

enum Genre: String, CaseIterable, Hashable, Codable {
    case classic = "Classic"
    case fantasy = "Fantasy"
    case horror = "Horror"
    case mystery = "Mystery"
    case romance = "Romance"
    case scienceFiction = "Science Fiction"
    case dystopian = "Dystopian"
    case unknown = "unknown"
}

