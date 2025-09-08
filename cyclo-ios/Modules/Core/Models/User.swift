//
//  Models.swift
//  
//
//  Created by Rohit Suresh on 8/22/25.
//

import Foundation
import SwiftData

@Model
class User: Identifiable {
    @Attribute(.unique) var uuid: UUID
    var name: String
    var email: String
    var dateOfBirth: Date
    
    init(name: String, email: String, dateOfBirth: Date) {
        self.uuid = UUID()
        self.name = name
        self.email = email
        self.dateOfBirth = dateOfBirth
    }
}
