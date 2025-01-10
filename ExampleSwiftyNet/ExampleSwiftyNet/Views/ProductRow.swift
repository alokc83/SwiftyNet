//
//  ProductRow.swift
//  ExampleSwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    let cartViewModel: CartViewModel
    @State private var isAnimating = false
    
    var body: some View {
        NavigationLink(destination: ProductDetailView(product: product, cartViewModel: cartViewModel)) {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .leading, spacing: 8) {
                    // Image Section with centered image
                    ZStack {
                        AsyncImage(url: URL(string: product.image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } placeholder: {
                            ZStack {
                                Color(UIColor.systemGray6)
                                ProgressView()
                            }
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    // Content Section
                    VStack(alignment: .leading, spacing: 8) {
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
                        
                        Text(product.title)
                            .font(.headline)
                            .lineLimit(2)
                        
                        Text("$\(String(format: "%.2f", product.price))")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        
                        if let brand = product.brand {
                            HStack {
                                Label(brand, systemImage: "tag")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                if let color = product.color {
                                    Text("•")
                                        .foregroundColor(.secondary)
                                    Text(color)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .background(Color(UIColor.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                
                // Animated Add to Cart Button
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        isAnimating = true
                    }
                    
                    // Reset animation state after a short delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isAnimating = false
                    }
                    
                    // Add the product to cart
                    cartViewModel.addToCart(product: product)
                }) {
                    Image(systemName: "cart.badge.plus")
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.green)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
                        .scaleEffect(isAnimating ? 0.8 : 1.0)
                }
                .offset(x: -16, y: 16)
            }
            .padding(.horizontal)
            .padding(.vertical, 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Preview with sample data
//#Preview {
//    ScrollView {
//        VStack {
//            ProductRow(product: Product(
//                id: 1,
//                title: "iPhone 13 Pro Max",
//                price: 999.99,
//                description: "The most advanced dual-camera system ever on iPhone. Lightning-fast A15 Bionic chip. A big leap in battery life.",
//                category: "Electronics",
//                image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
//                brand: "Apple",
//                model: "A2484",
//                color: "Sierra Blue",
//                discount: 15
//            )) {
//                // Implementation of onAddToCart
//            }
//            
//            ProductRow(product: Product(
//                id: 2,
//                title: "MacBook Pro",
//                price: 1299.99,
//                description: "Apple M1 Pro or M1 Max chip for a massive leap in CPU, GPU, and machine learning performance",
//                category: "Electronics",
//                image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
//                brand: "Apple",
//                model: "MacBook Pro 14",
//                color: "Space Gray",
//                discount: nil
//            )) {
//                // Implementation of onAddToCart
//            }
//        }
//        .padding(.vertical)
//    }
//    .background(Color(UIColor.systemGroupedBackground))
//} 
