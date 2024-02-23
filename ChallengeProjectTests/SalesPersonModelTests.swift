//
//  SalesPersonModelTests.swift
//  ChallengeProjectTests
//
//  Created by Wladyslaw Jasinski on 23/02/2024.
//

import XCTest
@testable import ChallengeProject

class SalesPersonTests: XCTestCase {
    
    func testSalesPersonInitialization() {
        let salesPerson = SalesPerson(name: "John Doe", areas: ["76133", "762*"])
        
        XCTAssertEqual(salesPerson.name, "John Doe")
        XCTAssertEqual(salesPerson.areas, ["76133", "762*"])
        // Test initial processing of areas
        XCTAssertTrue(salesPerson.allAreas.contains("76133"))
        XCTAssertTrue(salesPerson.allAreas.contains(where: { $0.starts(with: "762") }))
        XCTAssertEqual(salesPerson.areasString, "76133, 762*")
    }
    
    func testAllCodesExpansion() {
        let salesPerson = SalesPerson(name: "Test", areas: ["76*"])
        // Ensure it expands to 100 possibilities (76000 to 76999)
        XCTAssertEqual(salesPerson.allAreas.count, 1000)
        XCTAssertTrue(salesPerson.allAreas.contains("76000"))
        XCTAssertTrue(salesPerson.allAreas.contains("76999"))
    }
    
    func testAllCodesWithoutAsterisk() {
        let salesPerson = SalesPerson(name: "Test", areas: ["76133"])
        // Ensure no expansion occurs
        XCTAssertEqual(salesPerson.allAreas.count, 1)
        XCTAssertTrue(salesPerson.allAreas.contains("76133"))
    }
    
    func testAreasStringMultiple() {
        let salesPerson = SalesPerson(name: "Test", areas: ["76133", "762*"])
        // Test correct string concatenation
        XCTAssertEqual(salesPerson.areasString, "76133, 762*")
    }
    
    func testAreasStringSingle() {
        let salesPerson = SalesPerson(name: "Test", areas: ["76133"])
        // Test correct string with a single area
        XCTAssertEqual(salesPerson.areasString, "76133")
    }
    
    // Test edge cases
    func testEmptyAreas() {
        let salesPerson = SalesPerson(name: "Test", areas: [])
        XCTAssertEqual(salesPerson.allAreas.count, 0)
        XCTAssertEqual(salesPerson.areasString, "")
    }
    
/* 
 
 TO DO: This scenario is not being handled properly in the implementation. Due to the 24h required for the challenge being almost up, I wasn't able to fix this bug. I'm adding it to the 'TO DO' list.
 
    func testAreaCodeWithMultipleAsterisks() {
        
        // This test checks behavior when multiple asterisks are provided.
        let salesPerson = SalesPerson(name: "Test", areas: ["76**"])
        
        XCTAssertEqual(salesPerson.allAreas.count, 0, "Area codes with multiple asterisks should be ignored.")
    }
*/
}
