//
//  ChallengeProjectTests.swift
//  ChallengeProjectTests
//
//  Created by Wladyslaw Jasinski on 23/02/2024.
//

import XCTest
@testable import ChallengeProject

class MockURLSession: URLSessionProtocol {
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        completionHandler(nextData, nil, nextError)
        return nextDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private(set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}

class NetworkServiceTests: XCTestCase {
    
    func testFetchDataSuccess() {
        let mockURLSession = MockURLSession()
        mockURLSession.nextData = "{\"key\":\"value\"}".data(using: .utf8)
        
        let networkService = NetworkService(session: mockURLSession)
        let url = URL(string: "https://test.com")!
        
        let expectation = self.expectation(description: "FetchDataSuccess")
        
        networkService.fetchData(from: url) { result in
            if case .success(let data) = result {
                XCTAssertNotNil(data)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(mockURLSession.nextDataTask.resumeWasCalled)
    }
    
    func testFetchDataFailure() {
        let mockURLSession = MockURLSession()
        mockURLSession.nextError = NSError(domain: "TestError", code: -1, userInfo: nil)
        
        let networkService = NetworkService(session: mockURLSession)
        let url = URL(string: "https://test.com")!
        
        let expectation = self.expectation(description: "FetchDataFailure")
        
        networkService.fetchData(from: url) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(mockURLSession.nextDataTask.resumeWasCalled)
    }
}


