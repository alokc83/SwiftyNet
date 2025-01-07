import SwiftUI

struct ProductsView: View {
    @StateObject private var viewModel = ProductListViewModel()
    @ObservedObject var cartViewModel: CartViewModel
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    LoadingView()
                    
                case .error(let error):
                    ErrorView(error: error) {
                        viewModel.fetchProducts()
                    }
                    
                case .loaded(let products):
                    ProductGridView(products: products, cartViewModel: cartViewModel)
                    
                case .initial:
                    Color.clear
                }
            }
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