import SwiftUI

struct CartView: View {
    @ObservedObject var cartViewModel: CartViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if cartViewModel.cartItems.isEmpty {
                    VStack {
                        Text("Your cart is empty")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                } else {
                    List {
                        ForEach(cartViewModel.cartItems) { item in
                            CartItemRow(item: item) { quantity in
                                cartViewModel.updateQuantity(productId: item.product.id, quantity: quantity)
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let item = cartViewModel.cartItems[index]
                                cartViewModel.removeFromCart(productId: item.product.id)
                            }
                        }
                        
                        Section {
                            HStack {
                                Text("Total")
                                    .font(.headline)
                                Spacer()
                                Text("$\(String(format: "%.2f", cartViewModel.totalPrice))")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Cart")
        }
    }
}

struct CartItemRow: View {
    let item: CartItem
    let onQuantityChange: (Int) -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: item.product.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } placeholder: {
                Color.gray.opacity(0.2)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.product.title)
                    .font(.headline)
                    .lineLimit(1)
                
                Text("$\(String(format: "%.2f", item.product.price))")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                Text("Qty: \(item.quantity)")
                    .font(.subheadline)
                    .frame(minWidth: 50, alignment: .trailing)
                
                Stepper("", value: Binding(
                    get: { item.quantity },
                    set: { onQuantityChange($0) }
                ), in: 1...99)
                .labelsHidden()
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    CartView(cartViewModel: CartViewModel())
} 