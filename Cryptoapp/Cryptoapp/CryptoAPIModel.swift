import Foundation

struct CryptoAPIModel: Identifiable, Codable {
    let id: UUID
    let symbol: String
    let name: String
    let price: Double
}
