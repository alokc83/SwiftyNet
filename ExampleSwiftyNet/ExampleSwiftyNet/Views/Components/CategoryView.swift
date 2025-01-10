//
//  CategoryView.swift
//  ExampleSwiftyNet
//
//  Created by Alok Choudhary on 1/5/25.
//

import SwiftUI

struct CategoryView: View {
    let selectedCategory: String?
    let onCategorySelected: (String?) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("All Categories")
                .font(.headline)
                .padding(.horizontal)
            
            CategoryFilterView(
                categories: ["electronics", "jewelery", "men's clothing", "women's clothing"],
                selectedCategory: selectedCategory,
                onCategorySelected: onCategorySelected
            )
        }
        .padding(.vertical, 16)
        .background(
            Color(.systemBackground)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
} 