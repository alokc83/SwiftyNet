//
//  ContentView.swift
//  ExampleSwiftyNet
//
//  Created by Alok Choudhary on 1/4/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var cartViewModel = CartViewModel()
    
    var body: some View {
        TabView {
            ProductsView(cartViewModel: cartViewModel)
                .tabItem {
                    Label("Products", systemImage: "list.bullet")
                }
            
            CartView(cartViewModel: cartViewModel)
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
        }
    }
}

#Preview {
    ContentView()
}
