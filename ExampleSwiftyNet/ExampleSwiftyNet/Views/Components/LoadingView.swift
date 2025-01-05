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