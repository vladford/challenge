//
//  NetworkServiceProtocol.swift
//  ChallengeProject
//
//  Created by Wladyslaw Jasinski on 23/02/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
