import SwiftUI

class APIService {
    static let shared = APIService()
    
    func fetchProducts() async throws -> [Product] {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            throw APIError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            guard 200..<209 ~= httpResponse.statusCode else {
                throw APIError.serverError(httpResponse.statusCode)
            }
            do {
                return try JSONDecoder().decode([Product].self, from: data)
            } catch {
                throw APIError.decodingError(error)
            }
        } catch let error as URLError {
            throw APIError.networkError(error)
        } catch {
            throw APIError.networkError(error)
        }
    }
}


