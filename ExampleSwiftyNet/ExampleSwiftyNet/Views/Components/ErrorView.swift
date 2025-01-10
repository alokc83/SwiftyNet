//
//  ErrorView.swift
//  ExampleSwiftyNet
//
//  Created by Alok Choudhary on 1/5/25.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Error loading products")
                .font(.headline)
            
            Text(error.localizedDescription)
                .font(.caption)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Retry") {
                retryAction()
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    ErrorView(error: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Network connection lost"]), retryAction: {})
} 