import Foundation

@MainActor
class CartViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []
    
    func addToCart(product: Product) {
        if let existingIndex = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[existingIndex].quantity += 1
        } else {
            cartItems.append(CartItem(product: product, quantity: 1))
        }
    }
    
    func removeFromCart(productId: Int) {
        cartItems.removeAll { $0.product.id == productId }
    }
    
    func updateQuantity(productId: Int, quantity: Int) {
        if let index = cartItems.firstIndex(where: { $0.product.id == productId }) {
            if quantity > 0 {
                cartItems[index].quantity = quantity
            } else {
                cartItems.remove(at: index)
            }
        }
    }
    
    var totalPrice: Double {
        cartItems.reduce(0) { total, item in
            let price = item.product.price
            let discount = Double(item.product.discount ?? 0) / 100.0
            let discountedPrice = price * (1 - discount)
            return total + (discountedPrice * Double(item.quantity))
        }
    }
}

struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
} 