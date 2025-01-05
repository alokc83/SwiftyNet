//
//  Product.swift
//  ExampleSwiftyNet
//
//  Created by Alok Choudhary on 1/5/25.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let brand: String?
    let model: String?
    let color: String?
    let discount: Int?
}
