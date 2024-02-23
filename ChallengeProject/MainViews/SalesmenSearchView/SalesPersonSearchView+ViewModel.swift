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
        private let networkService: NetworkServiceProtocol
        var data = [SalesPerson]()
        
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
                    if area.starts(with: searchText) {
                        return true
                    }
                }
                return false
            }
        }
        
        init<S: Scheduler>(scheduler: S, networkService: NetworkServiceProtocol) where S.SchedulerTimeType == DispatchQueue.SchedulerTimeType {
            self.networkService = networkService
            
            $searchText
                .debounce(for: .seconds(bufferSecondsToWait), scheduler: scheduler)
                .assign(to: &$debouncedSearchText)
        }
        
        // Network
        func loadData() {
            let url = URL(string: CURLStrings.sampleDataUrl)!
            networkService.fetchData(from: url) { [weak self] result in
                switch result {
                case .success(let data):
                    guard let self = self else { return }
                    self.data = self.decodeJSON(data: data).map{ SalesPerson(name: $0.name, areas: $0.areas)}

                case .failure(let error):
                    print("Error fetching data: \(error)")
                }
            }
        }
        
        func decodeJSON(data: Data) -> [SalesPerson] {
            do {
                return try JSONDecoder().decode([SalesPerson].self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
                return []
            }
        }
    }
}
