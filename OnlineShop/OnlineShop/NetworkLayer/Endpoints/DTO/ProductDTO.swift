//
//  ProductDTO.swift
//  OnlineShop
//
//  Created by Анастасия Ларина on 07.05.2024.
//

import Foundation

struct ProductDTO: Codable, Hashable {
    let id: Int
    let title: String
    let price: Int
    let category: Category?
    let images: [String]
}
