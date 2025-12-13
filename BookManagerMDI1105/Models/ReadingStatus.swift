//
//  ReadingStatus.swift
//  BookManagerMDI1105
//
//  Created by Alex Arthur on 12/6/25.
//

enum ReadingStatus: String, CaseIterable, Codable, Identifiable {
    var id: String { self.rawValue }
    case toRead = "To Read"
    case reading = "Reading"
    case completed = "Completed"
}
