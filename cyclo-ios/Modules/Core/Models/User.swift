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
    var name: String
    var email: String
    
    init(name: String, email: String, dateOfBirth: Date) {
        self.name = name
        self.email = email
        self.dateOfBirth = dateOfBirth
    }
}
