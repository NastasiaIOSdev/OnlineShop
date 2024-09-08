//
//  CategoryDTO.swift
//  OnlineShop
//
//  Created by Анастасия Ларина on 10.05.2024.
//

import Foundation

struct Category: Codable, Hashable {
    let id: Int
    let name: String?
    let image: String?
}
