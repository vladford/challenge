//
//  SalesPersonSearchModelTests.swift
//  ChallengeProjectTests
//
//  Created by Wladyslaw Jasinski on 23/02/2024.
//

import XCTest
import Combine
@testable import ChallengeProject

class MockNetworkService: NetworkServiceProtocol {
    var fetchCompletionResult: Result<Data, Error>?
    
    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        if let result = fetchCompletionResult {
            completion(result)
        }
    }
}

class SalesPersonSearchViewModelTests: XCTestCase {
    var viewModel: SalesPersonSearchView.ViewModel!
    var mockNetworkService: MockNetworkService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = .init(scheduler: DispatchQueue.main, networkService: mockNetworkService)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testLoadDataSuccess() {
        let sampleJSONData = """
        [
            {"name":"Artem Titarenko", "areas": ["76133"]},
            {"name":"Bernd Schmitt", "areas": ["7619*"]},
            {"name":"Chris Krapp", "areas": ["762*"]},
            {"name":"Alex Uber", "areas": ["86*"]}
        ]
        """.data(using: .utf8)!
        
        mockNetworkService.fetchCompletionResult = .success(sampleJSONData)
        let expectation = self.expectation(description: "Data loaded")
        
        viewModel.loadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.data.count, 4)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    func testSearchFiltering() {
        viewModel.data = [
            SalesPerson(name: "Artem Titarenko", areas: ["76133"]),
            SalesPerson(name: "Bernd Schmitt", areas: ["7619*"]), // Expands to 76190 to 76199
            SalesPerson(name: "Chris Krapp", areas: ["762*"]), // Expands to 76200 to 76299
            SalesPerson(name: "Alex Uber", areas: ["86*"]) // Expands to 86000 to 86999
        ]
        
        viewModel.debouncedSearchText = "762" // This should match "Chris Krapp" because of the expansion logic
        
        // Assertions
        XCTAssertEqual(viewModel.filteredData.count, 1, "Filtered data should only contain one SalesPerson matching '762'")
        XCTAssertEqual(viewModel.filteredData.first?.name, "Chris Krapp", "Filtered SalesPerson should be 'Chris Krapp'")
    }
    
    func testSearchFiltering_2() {
        viewModel.data = [
            SalesPerson(name: "Artem Titarenko", areas: ["76133", "9900*"]), //Expands to 99009
            SalesPerson(name: "Bernd Schmitt", areas: ["7619*"]), // Expands to 76190 to 76199
            SalesPerson(name: "Chris Krapp", areas: ["762*"]), // Expands to 76200 to 76299
            SalesPerson(name: "Alex Uber", areas: ["86*"]) // Expands to 86000 to 86999
        ]
        
        viewModel.debouncedSearchText = "99002" // This should match "Artem Titarenko" because of the expansion logic
        
        // Assertions
        XCTAssertEqual(viewModel.filteredData.count, 1, "Filtered data should only contain one SalesPerson matching '99002'")
        XCTAssertEqual(viewModel.filteredData.first?.name, "Artem Titarenko", "Filtered SalesPerson should be 'Artem Titarenko'")
    }
    
    func testSearchFilteringWithEmptySearchText() {
        viewModel.data = [
            SalesPerson(name: "Artem Titarenko", areas: ["76133"]),
            SalesPerson(name: "Bernd Schmitt", areas: ["7619*"]),
            SalesPerson(name: "Chris Krapp", areas: ["762*"]),
            SalesPerson(name: "Alex Uber", areas: ["86*"])
        ]
        
        viewModel.debouncedSearchText = "" // Empty search text
        
        XCTAssertEqual(viewModel.filteredData.count, 4, "Filtered data should contain all SalesPersons when search text is empty")
    }
    
    func testSearchFilteringWithNoMatch() {
        viewModel.data = [
            SalesPerson(name: "Artem Titarenko", areas: ["76133"]),
            SalesPerson(name: "Bernd Schmitt", areas: ["7619*"]),
            SalesPerson(name: "Chris Krapp", areas: ["762*"]),
            SalesPerson(name: "Alex Uber", areas: ["86*"])
        ]
        
        viewModel.debouncedSearchText = "12345" // No match
        
        XCTAssertEqual(viewModel.filteredData.count, 0, "Filtered data should contain no SalesPersons when search text matches no areas")
    }
    
    func testSearchFilteringWithAsteriskSearchText() {
        viewModel.data = [
            SalesPerson(name: "Artem Titarenko", areas: ["76133"]),
            SalesPerson(name: "Bernd Schmitt", areas: ["7619*"]),
            SalesPerson(name: "Chris Krapp", areas: ["762*"]),
            SalesPerson(name: "Alex Uber", areas: ["86*"])
        ]
        
        viewModel.debouncedSearchText = "76*" // Matches with "76133", "7619*", and "762*"
        
        XCTAssertEqual(viewModel.filteredData.count, 3, "Filtered data should match areas beginning with '76'")
    }
    
    func testSearchFilteringWithExactMatch() {
        viewModel.data = [
            SalesPerson(name: "Artem Titarenko", areas: ["76133"]),
            SalesPerson(name: "Bernd Schmitt", areas: ["76195"]),
            SalesPerson(name: "Chris Krapp", areas: ["76200"]),
            SalesPerson(name: "Alex Uber", areas: ["86000"])
        ]
        
        viewModel.debouncedSearchText = "76133" // Exact match
        
        XCTAssertEqual(viewModel.filteredData.count, 1, "Filtered data should only contain one SalesPerson matching '76133'")
        XCTAssertEqual(viewModel.filteredData.first?.name, "Artem Titarenko", "Filtered SalesPerson should be 'Artem Titarenko'")
    }
    
    func testSearchFilteringWithMultipleMatches() {
        viewModel.data = [
            SalesPerson(name: "Artem Titarenko", areas: ["76000", "761*"]), // Expands to 76100 to 76199
            SalesPerson(name: "Bernd Schmitt", areas: ["76150", "762*"]), // Direct match and expands to 76200 to 76299
            SalesPerson(name: "Chris Krapp", areas: ["76205"]),
            SalesPerson(name: "Alex Uber", areas: ["86000"])
        ]
        
        viewModel.debouncedSearchText = "761" // Matches "Artem Titarenko" and "Bernd Schmitt"
        
        XCTAssertEqual(viewModel.filteredData.count, 2, "Filtered data should contain two SalesPersons matching '761'")
    }
}
