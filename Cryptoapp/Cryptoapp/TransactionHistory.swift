import SwiftUI

struct Transaction: Identifiable {
    let id = UUID()
    let type: String
    let crypto: String
    let amount: String
    let date: String
    let icon: String
    let color: Color
}

class TransactionHistory: ObservableObject {
    @Published var transactions: [Transaction] = []
}
