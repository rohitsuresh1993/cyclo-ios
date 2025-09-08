//
//  Date.swift
//  
//
//  Created by Rohit Suresh on 8/22/25.
//
import Foundation
import SwiftData

@Model
class Date: Codable, Identifiable, Equatable {
    var date: Date
    let day: Int
    let month: Int
    let year: Int
    
    init(date: Date) {
        self.date = date
        let components = calendar.dateComponents([.day, .month, .year], from: self.date)
        self.day = components.day
        self.month = components.month
        self.year = components.year
    }
}
