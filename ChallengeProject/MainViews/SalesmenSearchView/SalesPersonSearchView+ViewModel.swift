//
//  SalesPersonSearchView+ViewModel.swift
//  ChallengeProject
//
//  Created by Wladyslaw Jasinski on 22/02/2024.
//

import Foundation
import SwiftUI

extension SalesPersonSearchView {
    @Observable
    class ViewModel {
        var data: [SalesPerson] = [
            SalesPerson(name:"Artem Titarenko", areas: ["76133"]),
            SalesPerson(name:"Bernd Schmitt", areas: ["7619*"]),
            SalesPerson(name:"Chris Krapp", areas: ["762*"]),
            SalesPerson(name:"Alex Uber", areas: ["86*"])
        ]
        
        var searchText = ""
        
        func filteredData(searchText: String, data: [SalesPerson]) -> [SalesPerson] {
            guard !searchText.isEmpty else { return data }
            return data.filter { person in
                person.areas.contains(where: { $0.starts(with: searchText) })
            }
        }
    }
}
