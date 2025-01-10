//
//  CategoryChip.swift
//  ExampleSwiftyNet
//
//  Created by Alok Choudhary on 1/10/25.
//

import SwiftUI

/// A reusable button component that displays a category with an icon and title
struct CategoryChip: View {
    // MARK: - Properties
    
    /// The title text to display below the icon
    let title: String
    
    /// The SF Symbol name for the icon
    let systemImage: String
    
    /// Whether this category is currently selected
    let isSelected: Bool
    
    /// Callback when the chip is tapped
    let action: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(AppConstants.UI.Colors.secondary)
                        .frame(width: AppConstants.UI.categoryChipSize, height: AppConstants.UI.categoryChipSize)
                    
                    Image(systemName: systemImage)
                        .font(.system(size: 18))
                        .foregroundColor(.primary)
                }
                .overlay(
                    Circle()
                        .stroke(isSelected ? AppConstants.UI.Colors.primary : Color.clear, lineWidth: 2)
                )
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    HStack {
        CategoryChip(
            title: AppConstants.Categories.all,
            systemImage: "square.grid.2x2",
            isSelected: true,
            action: {}
        )
        CategoryChip(
            title: AppConstants.Categories.displayNames[AppConstants.Categories.electronics] ?? "",
            systemImage: AppConstants.Categories.icons[AppConstants.Categories.electronics] ?? "",
            isSelected: false,
            action: {}
        )
    }
    .padding()
} 