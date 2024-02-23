//
//  CCellModelTests.swift
//  ChallengeProjectTests
//
//  Created by Wladyslaw Jasinski on 23/02/2024.
//

import XCTest
@testable import ChallengeProject

class CCellViewViewModelTests: XCTestCase {

    var viewModel: CCellView.ViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CCellView.ViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testChevronRotationWhenCollapsed() {
        // Given
        viewModel.isExpanded = false
        
        // When
        viewModel.updateChevronRotation()
        
        // Then
        XCTAssertEqual(viewModel.rotationAngle, 0, "Rotation angle should be 0 when collapsed")
    }

    func testChevronRotationWhenExpanded() {
        // Given
        viewModel.isExpanded = true
        
        // When
        viewModel.updateChevronRotation()
        
        // Then
        XCTAssertEqual(viewModel.rotationAngle, 90, "Rotation angle should be 90 when expanded")
    }
}
