//
//  NetworkService.swift
//  ChallengeProject
//
//  Created by Wladyslaw Jasinski on 23/02/2024.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    private let session: URLSessionProtocol
        
        init(session: URLSessionProtocol = URLSession.shared) {
            self.session = session
        }
        
        func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                    return
                }
                completion(.success(data))
            }
            task.resume()
        }
}

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
