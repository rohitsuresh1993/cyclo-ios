//
//  PeriodEvent.swift
//  
//
//  Created by Rohit Suresh on 8/25/25.
//

import Foundation
import SwiftData

@Model
class PeriodLog {
    var user: User
    var startDate: Date
    var endDate: Date
    
    init(user: User, startDate: Date, endDate: Date) {
        self.user = user
        self.startDate = startDate
        self.endDate = endDate
    }
}

struct PeriodLogDTO: Codable, Identifiable {
    var id: UUID = UUID()   // stable identity for SwiftUI Lists if needed
    var startDate: Date
    var endDate: Date
    var userId: UUID        // send a reference to the user instead of embedding User
}

extension PeriodLog {
    func toDTO() -> PeriodLogDTO {
        PeriodLogDTO(
            startDate: self.startDate,
            endDate: self.endDate,
            userId: self.user.uuid  // assuming User also has a UUID
        )
    }
}

extension PeriodLogDTO {
    func toModel(user: User) -> PeriodLog {
        PeriodLog(user: user, startDate: self.startDate, endDate: self.endDate)
    }
}
