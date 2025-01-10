//
//  AppConstants.swift
//  ExampleSwiftyNet
//
//  Created by Alok Choudhary on 1/10/25.
//

import Foundation
import SwiftUI

/// Constants used throughout the application
enum AppConstants {
    /// Category-related constants
    enum Categories {
        static let all = "All"
        static let electronics = "electronics"
        static let jewelry = "jewelery"
        static let mensClothing = "men's clothing"
        static let womensClothing = "women's clothing"
        
        static let allCategories = [
            electronics,
            jewelry,
            mensClothing,
            womensClothing
        ]
        
        /// Maps category identifiers to display names
        static let displayNames: [String: String] = [
            electronics: "Electronics",
            jewelry: "Beauty",
            mensClothing: "Mens",
            womensClothing: "Womens"
        ]
        
        /// Maps category identifiers to SF Symbol names
        static let icons: [String: String] = [
            electronics: "laptopcomputer",
            jewelry: "crown.fill",
            mensClothing: "tshirt.fill",
            womensClothing: "bag.fill"
        ]
    }
    
    /// UI-related constants
    enum UI {
        static let cornerRadius: CGFloat = 10
        static let defaultPadding: CGFloat = 16
        static let categoryChipSize: CGFloat = 50
        static let categorySpacing: CGFloat = 16
        
        /// Animation durations
        enum AnimationDuration {
            static let short = 0.3
            static let medium = 0.5
            static let long = 2.0
        }
        
        /// Colors
        enum Colors {
            static let primary = Color.green
            static let secondary = Color(.systemGray6)
        }
    }
    
    /// Cart-related constants
    enum Cart {
        static let maxQuantity = 99
        static let minQuantity = 1
    }
} 