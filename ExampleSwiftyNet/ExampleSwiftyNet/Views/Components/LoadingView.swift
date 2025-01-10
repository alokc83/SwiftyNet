//
//  LoadingView.swift
//  ExampleSwiftyNet
//
//  Created by Alok Choudhary on 1/5/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .padding()
            Text("Loading products...")
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    LoadingView()
} 