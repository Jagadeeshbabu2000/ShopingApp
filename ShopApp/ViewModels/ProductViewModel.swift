import Foundation

@MainActor
class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var cartItems: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadProducts() async {
        isLoading = true
        errorMessage = nil
        do {
            products = try await APIService.shared.fetchProducts()
        } catch let apiError as APIError {
            errorMessage = apiError.localizedDescription
        } catch {
            errorMessage = "Unexpected error: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func toggleCart(_ product: Product) {
            if cartItems.contains(where: { $0.id == product.id }) {
                cartItems.removeAll { $0.id == product.id }
            } else {
                cartItems.append(product)
            }
        }
    
    func isInCart(_ product: Product) -> Bool {
            cartItems.contains(where: { $0.id == product.id })
        }
}
