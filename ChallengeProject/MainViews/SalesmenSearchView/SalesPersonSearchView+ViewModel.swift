//
//  SalesPersonSearchView+ViewModel.swift
//  ChallengeProject
//
//  Created by Wladyslaw Jasinski on 22/02/2024.
//

import Combine
import SwiftUI


extension SalesPersonSearchView {
    
    class ViewModel: ObservableObject {
        var data: [SalesPerson] = [
            SalesPerson(name:"Artem Titarenko", areas: ["76133", "9900*", "86543"]),
            SalesPerson(name:"Bernd Schmitt", areas: ["7619*"]),
            SalesPerson(name:"Chris Krapp", areas: ["762*"]),
            SalesPerson(name:"Alex Uber", areas: ["86*"])
        ]
        
        @Published var searchText = ""
        @Published private var debouncedSearchText = ""
        private let bufferSecondsToWait: Double = 1
        
        var filteredData: [SalesPerson] {
            var searchText = debouncedSearchText
            if debouncedSearchText.hasSuffix("*") {
                searchText = String(searchText.dropLast(1))
            }
            
            guard !searchText.isEmpty else { return data }
            return data.filter { person in
                
                for area in person.allAreas {
                    
                    print("area: \(area)")
                    
                    if area.starts(with: searchText) {
                        print("x area: \(area) starts \(searchText))")
                        return true
                    }
                }
                return false
            }
        }
        
        init<S: Scheduler>(scheduler: S) where S.SchedulerTimeType == DispatchQueue.SchedulerTimeType {
            $searchText
                .debounce(for: .seconds(bufferSecondsToWait), scheduler: scheduler)
                .assign(to: &$debouncedSearchText)
        }
    }
}
