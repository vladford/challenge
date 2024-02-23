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
            SalesPerson(name:"Artem Titarenko", areas: ["76133"]),
            SalesPerson(name:"Bernd Schmitt", areas: ["7619*"]),
            SalesPerson(name:"Chris Krapp", areas: ["762*"]),
            SalesPerson(name:"Alex Uber", areas: ["86*"])
        ]
        
        @Published var searchText = ""
        @Published private var debouncedSearchText = ""
        private let bufferSecondsToWait: Double = 1
        
        var filteredData: [SalesPerson] {
            guard !debouncedSearchText.isEmpty else { return data }
            return data.filter { person in
                person.areas.contains { area in
                    area.lowercased().starts(with: debouncedSearchText.lowercased())
                }
            }
        }
        
        init<S: Scheduler>(scheduler: S) where S.SchedulerTimeType == DispatchQueue.SchedulerTimeType {
            $searchText
                .debounce(for: .seconds(bufferSecondsToWait), scheduler: scheduler)
                .assign(to: &$debouncedSearchText)
        }
    }
}
