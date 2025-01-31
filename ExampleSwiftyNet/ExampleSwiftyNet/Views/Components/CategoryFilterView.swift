//
//  CategoryFilterView.swift
//  ExampleSwiftyNet
//
//  Created by Alok Choudhary on 1/5/25.
//

import SwiftUI

/// A view that displays a horizontal scrollable list of category filters
struct CategoryFilterView: View {
    // MARK: - Properties
    
    /// Array of category identifiers to display
    let categories: [String]
    
    /// Currently selected category identifier (nil means "All" is selected)
    let selectedCategory: String?
    
    /// Callback when a category is selected
    let onCategorySelected: (String?) -> Void
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: AppConstants.UI.categorySpacing) {
                CategoryChip(
                    title: AppConstants.Categories.all,
                    systemImage: "square.grid.2x2",
                    isSelected: selectedCategory == nil,
                    action: { onCategorySelected(nil) }
                )
                
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
    
    // MARK: - Helper Methods
    
    /// Converts a category identifier to its display name
    private func titleFor(_ category: String) -> String {
        AppConstants.Categories.displayNames[category] ?? category.capitalized
    }
    
    /// Gets the SF Symbol name for a category
    private func iconFor(_ category: String) -> String {
        AppConstants.Categories.icons[category] ?? "questionmark.circle"
    }
} 