//
//  CategoryFilterView.swift
//  ExampleSwiftyNet
//
//  Created by Alok Choudhary on 1/5/25.
//

import SwiftUI

struct CategoryFilterView: View {
    let categories: [String]
    let selectedCategory: String?
    let onCategorySelected: (String?) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(categories, id: \.self) { category in
                    CategoryChip(
                        title: titleFor(category),
                        systemImage: iconFor(category),
                        isSelected: category == selectedCategory,
                        action: { onCategorySelected(category) }
                    )
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func titleFor(_ category: String) -> String {
        switch category {
        case "electronics": return "Electronics"
        case "jewelery": return "Beauty"
        case "men's clothing": return "Mens"
        case "women's clothing": return "Womens"
        default: return category.capitalized
        }
    }
    
    private func iconFor(_ category: String) -> String {
        switch category {
        case "electronics": return "laptopcomputer"
        case "jewelery": return "crown.fill"
        case "men's clothing": return "tshirt.fill"
        case "women's clothing": return "bag.fill"
        default: return "questionmark.circle"
        }
    }
}

struct CategoryChip: View {
    let title: String
    let systemImage: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(Color(.systemGray6))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: systemImage)
                        .font(.system(size: 18))
                        .foregroundColor(.primary)
                }
                .overlay(
                    Circle()
                        .stroke(isSelected ? Color.green : Color.clear, lineWidth: 2)
                )
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
        }
    }
} 