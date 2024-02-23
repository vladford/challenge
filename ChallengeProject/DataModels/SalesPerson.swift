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
    private (set) var allAreas = [String]()
    
    init(name: String, areas: [String]) {
        self.name = name
        self.areas = areas
        self.areasString = getAreasString(areas: areas)
        self.allAreas = getAllCodes(areas: areas)
    }
    
    
    func getAllCodes(areas:[String]) -> [String] {
        var expandedAreas = [String]()
        for area in areas {
            if area.contains("*") {
                let base = area.dropLast()
                let asteriskPosition = area.distance(from: area.startIndex, to: area.firstIndex(of: "*")!)
                let rangeOfPossibilities = Int(pow(10.0, Double(5 - asteriskPosition - 1)))
                
                for i in 0..<rangeOfPossibilities {
                    let postfix = String(format: "%0\(5 - base.count)d", i)
                    expandedAreas.append("\(base)\(postfix)")
                }
            } else {
                expandedAreas.append(area)
            }
        }
        return expandedAreas
    }
    
    
    func getAreasString(areas: [String]) -> String {
        return areas.joined(separator: ", ")
    }
}
