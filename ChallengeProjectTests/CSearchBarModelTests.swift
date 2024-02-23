//
//  CSearchBarTests.swift
//  ChallengeProjectTests
//
//  Created by Wladyslaw Jasinski on 23/02/2024.
//

import XCTest
@testable import ChallengeProject

class CSearchBarViewModelTests: XCTestCase {

    var viewModel: CSearchBar.ViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CSearchBar.ViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testStartEditingTrue() {
        // When
        viewModel.startEditing(true)
        
        // Then
        XCTAssertTrue(viewModel.isEditing, "isEditing should be true after starting editing")
    }
    
    func testStartEditingFalse() {
        // Setup initial state
        viewModel.startEditing(true) // Assume editing started
        // When
        viewModel.startEditing(false)
        
        // Then
        XCTAssertFalse(viewModel.isEditing, "isEditing should be false after stopping editing")
    }
    
    func testLimitTextUnderLimit() {
        let result = viewModel.limitText(5, text: "Hi")
        XCTAssertEqual(result, "Hi", "Text under the limit should be unchanged")
    }
    
    func testLimitTextAtLimit() {
        let result = viewModel.limitText(5, text: "Hello")
        XCTAssertEqual(result, "Hello", "Text at the limit should be unchanged")
    }
    
    func testLimitTextOverLimit() {
        let result = viewModel.limitText(5, text: "Hello, World!")
        XCTAssertEqual(result, "Hello", "Text over the limit should be truncated to the limit")
    }
}
