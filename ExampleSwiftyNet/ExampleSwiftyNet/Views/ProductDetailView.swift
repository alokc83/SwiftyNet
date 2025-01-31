//
//  ProductDetailView.swift
//  ExampleSwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @ObservedObject var cartViewModel: CartViewModel
    @State private var quantity: Int = 1
    @State private var isAnimating = false
    @State private var showAddedToCartFeedback = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Image Section
                AsyncImage(url: URL(string: product.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 300)
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                }
                .background(Color(UIColor.systemBackground))
                
                // Content Section
                VStack(alignment: .leading, spacing: 16) {
                    // Title and Rating
                    VStack(alignment: .leading, spacing: 8) {
                        Text(product.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        if let brand = product.brand {
                            Text(brand)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Price Section
                    HStack(alignment: .center) {
                        Text("$\(String(format: "%.2f", product.price))")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        
                        if let discount = product.discount {
                            Text("\(discount)% OFF")
                                .font(.caption)
                                .fontWeight(.bold)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                    }
                    
                    // Quantity Stepper
                    HStack {
                        Text("Quantity:")
                            .font(.headline)
                        Stepper(value: $quantity, in: 1...99) {
                            Text("\(quantity)")
                                .font(.headline)
                                .frame(minWidth: 40)
                        }
                    }
                    .padding(.vertical)
                    
                    // Enhanced Add to Cart Button
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            isAnimating = true
                            cartViewModel.addToCart(product: product)
                            showAddedToCartFeedback = true
                        }
                        
                        // Reset animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isAnimating = false
                            // Hide feedback after 2 seconds
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                showAddedToCartFeedback = false
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "cart.badge.plus")
                            Text("Add to Cart")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .scaleEffect(isAnimating ? 0.95 : 1.0)
                    }
                    
                    // Added to Cart Feedback
                    if showAddedToCartFeedback {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Added to Cart!")
                        }
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    
                    // Description
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.headline)
                        Text(product.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    
                    // Additional Details
                    if let color = product.color {
                        DetailRow(title: "Color", value: color)
                    }
                    if let model = product.model {
                        DetailRow(title: "Model", value: model)
                    }
                    DetailRow(title: "Category", value: product.category)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
        }
    }
} 
