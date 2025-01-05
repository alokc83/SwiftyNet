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
    private let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func fetchProducts() {
        guard case .initial = state else {
            state = .loading
            return
        }
        
        Task {
            do {
                state = .loading
                let products = try await apiService.fetchProducts()
                state = .loaded(products)
            } catch {
                state = .error(error)
            }
        }
    }
} 