//
//  PeriodEvent.swift
//  
//
//  Created by Rohit Suresh on 8/25/25.
//

import Foundation
import SwiftData

@Model
class PeriodLog: Codable, Identifiable {
    var user: User
    var startDate: Date
    var endDate: Date
    
    init(startDate, endDate) {
        self.startDate = startDate
        self.endDate = endDate
    }
}
