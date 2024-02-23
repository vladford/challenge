//
//  SalesPerson.swift
//  ChallengeProject
//
//  Created by Wladyslaw Jasinski on 22/02/2024.
//

import Foundation

struct SalesPerson: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let areas: [String]
    
    func areasString() -> String {
        return areas.joined(separator: ", ")
    }
}
