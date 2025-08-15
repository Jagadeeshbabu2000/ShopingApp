import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: ProductViewModel
    @State private var showThankYou = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.cartItems.isEmpty {
                    Text("Your cart is empty")
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(viewModel.cartItems, id: \.id) { item in
                            HStack {
                                AsyncImage(url: URL(string: item.image)) { image in
                                    image.resizable().scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading) {
                                    Text(item.title).font(.headline)
                                    Text("$\(String(format: "%.2f", item.price))")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    Button("Checkout") {
                        showThankYou = true
                        viewModel.cartItems.removeAll()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                }
            }
            .navigationTitle("Cart")
            .navigationBarTitleDisplayMode(.inline)
            .font(.system(size: 20, weight: .bold))
            .alert("Thank You!", isPresented: $showThankYou) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}

#Preview {
    CartView(viewModel: ProductViewModel())
}
