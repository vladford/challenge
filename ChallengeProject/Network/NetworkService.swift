//
//  NetworkService.swift
//  ChallengeProject
//
//  Created by Wladyslaw Jasinski on 23/02/2024.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
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
