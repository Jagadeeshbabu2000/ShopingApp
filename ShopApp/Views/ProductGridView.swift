import SwiftUI

struct ProductGridView: View {
    
    @StateObject var viewModel = ProductViewModel()
    @State private var showCart = false
    let itemCount = Array(repeating: GridItem(.flexible()), count: 2)

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: itemCount, spacing: 16) {
                            ForEach(viewModel.products) { product in
                                NavigationLink(destination:
                                    ProductDetailView(
                                        product: product,
                                        toggleCart: { viewModel.toggleCart(product) },
                                        isInCart: viewModel.isInCart(product)
                                    )
                                ) {
                                    ProductItemView(
                                        product: product,
                                        isInCart: viewModel.isInCart(product),
                                        toggleCart: { viewModel.toggleCart(product) }
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Shop")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CartView(viewModel: viewModel)) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "cart")
                            if !viewModel.cartItems.isEmpty {
                                Text("\(viewModel.cartItems.count)")
                                    .font(.caption2)
                                    .padding(4)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .offset(x: 8, y: -8)
                            }
                        }
                    }
                }
            }
            .task {
                await viewModel.loadProducts()
            }
        }
    }
}

#Preview {
    ProductGridView()
}
