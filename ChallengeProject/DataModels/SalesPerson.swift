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
    private (set) var areasString = ""
    private (set) var allAreas = Set<String>()
    
    init(name: String, areas: [String]) {
        self.name = name
        self.areas = areas
        self.areasString = getAreasString(areas: areas)
        self.allAreas = getAllCodes(areas: areas)
    }
    
    
    func getAllCodes(areas: [String]) -> Set<String> {
        var expandedAreas = Set<String>()
        for area in areas {
            if area.contains("*") {
                // Determine the base of the code without the asterisk
                let base = area.dropLast()
                let numberOfZeros = 5 - base.count // Calculate how many zeros to append
                
                // Calculate the start and end range based on the base
                let startRange = Int(base + String(repeating: "0", count: numberOfZeros))!
                let endRange = Int(base + String(repeating: "9", count: numberOfZeros))!
                
                // Generate all codes within the range
                for code in startRange...endRange {
                    expandedAreas.insert(String(code))
                }
            } else {
                // If there's no asterisk, add the area code as it is
                expandedAreas.insert(area)
            }
        }
        return expandedAreas
    }
    
    
    func getAreasString(areas: [String]) -> String {
        return areas.joined(separator: ", ")
    }
}
