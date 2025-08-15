import SwiftUI

struct ProductItemView: View {
    let product: Product
    let isInCart: Bool
    let toggleCart: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: product.image)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 120)
            .cornerRadius(8)
            .frame(maxWidth: .infinity, alignment: .center)

            
            Text(product.title)
                .font(.headline)
                .lineLimit(2)
            
            Text("$\(String(format: "%.2f", product.price))")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                Text("⭐️ \(String(format: "%.1f", product.rating.rate))")
                    .font(.caption)
                Spacer()
                Button(action: toggleCart) {
                    Image(systemName: isInCart ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    ProductItemView(
           product: Product(
               id: 1,
               title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
               price: 109.95,
               description: "Your perfect pack for everyday use and walks in the forest.",
               category: Category.menSClothing,
               image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
               rating: Rating(rate: 3.9, count: 120)
           ),
           isInCart: false,
           toggleCart: {}
       )
}
