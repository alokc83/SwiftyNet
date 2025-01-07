import SwiftUI

struct ProductGridView: View {
    let products: [Product]
    @ObservedObject var cartViewModel: CartViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(products) { product in
                    ProductRow(product: product, cartViewModel: cartViewModel)
                }
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    ProductGridView(
        products: [
            Product(id: 1, title: "Test Product", price: 99.99, description: "Test description", category: "Electronics", image: "", brand: "Test Brand", model: "X1", color: "Black", discount: 10)
        ],
        cartViewModel: CartViewModel()
    )
} 