//
//  ProductListViewModel.swift
//  ExampleSwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import Foundation

@MainActor
class ProductListViewModel: ObservableObject {
    enum ViewState {
        case initial
        case loading
        case error(Error)
        case loaded([Product])
    }
    
    @Published private(set) var state: ViewState = .initial
    @Published var selectedCategory: String? = nil
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func fetchProducts(byCategory category: String? = nil) {
        Task {
            do {
                state = .loading
                let products: [Product]
                if let category = category {
                    products = try await apiService.fetchProducts(byCategory: category)
                } else {
                    products = try await apiService.fetchProducts()
                }
                state = .loaded(products)
            } catch {
                state = .error(error)
            }
        }
    }
    
    func selectCategory(_ category: String?) {
        selectedCategory = category
        fetchProducts(byCategory: category)
    }
} 