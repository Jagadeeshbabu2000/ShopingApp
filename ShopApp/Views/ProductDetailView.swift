import SwiftUI

struct ProductDetailView: View {
    let product: Product
    let toggleCart: () -> Void
    let isInCart: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: product.image)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                
                Text(product.title)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                
                Text(product.description)
                    .font(.body)
                    .padding()
                
                Text("$\(String(format: "%.2f", product.price))")
                    .font(.title2)
                    .bold()
                
                Button(action: toggleCart) {
                    Text(isInCart ? "Remove from Cart" : "Add to Cart")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isInCart ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ProductDetailView(
            product: Product(
                id: 1,
                title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                price: 109.95,
                description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop in the padded sleeve, your everyday",
                category: Category.menSClothing,
                image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
                rating: Rating(rate: 3.9, count: 120)
            ),
            toggleCart: {},
            isInCart: false
        )
}
