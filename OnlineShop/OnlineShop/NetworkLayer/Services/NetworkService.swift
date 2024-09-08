//
//  NetworkService.swift
//  OnlineShop
//
//  Created by Анастасия Ларина on 10.05.2024.
//
import Foundation
import Combine

protocol NetworkService: AnyObject {
    func getProducts() -> AnyPublisher<[ProductDTO], Error>
}

final class NetworkServiceImpl: NetworkService {
     private let session = URLSession.shared
     func getProducts() -> AnyPublisher<[ProductDTO], Error> {
         request(.posts)
     }
 }

private extension NetworkServiceImpl {
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
        session.dataTaskPublisher(for: endpoint.url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
