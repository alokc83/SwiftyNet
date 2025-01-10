//
//  ProductsView.swift
//  ExampleSwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import SwiftUI

struct ProductsView: View {
    @StateObject private var viewModel = ProductListViewModel()
    @ObservedObject var cartViewModel: CartViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                // Categories Section
                CategoryView(
                    selectedCategory: nil,
                    onCategorySelected: { category in
                        // We'll implement this later
                    }
                )
                
                // Products List
                ScrollView {
                    Group {
                        switch viewModel.state {
                        case .loading:
                            LoadingView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        case .error(let error):
                            ErrorView(error: error) {
                                viewModel.fetchProducts()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        case .loaded(let products):
                            ProductGridView(products: products, cartViewModel: cartViewModel)
                        
                        case .initial:
                            Color.clear
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .padding(.top)
                }
                .background(Color(.systemGroupedBackground))
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Products")
        }
        .onAppear {
            if case .initial = viewModel.state {
                viewModel.fetchProducts()
            }
        }
    }
}

#Preview {
    ProductsView(cartViewModel: CartViewModel())
} 