//
//  EndPoint.swift
//  OnlineShop
//
//  Created by Анастасия Ларина on 07.05.2024.
//

import Foundation

struct Endpoint {
    let path: String    
    var url: URL {
        var components = URLComponents(string: "https://api.escuelajs.co")
        components?.path = path
        guard let url = components?.url else {
            preconditionFailure("Unable to create url from: \(String(describing: components))")
        }
        return url
    }
    static let posts = Self(path: "/api/v1/products")
}
