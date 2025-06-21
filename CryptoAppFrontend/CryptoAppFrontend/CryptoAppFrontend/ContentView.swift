//
//  ContentView.swift
//  CryptoAppFrontend
//
//  Created by Carlos López García on 17/06/25.
//

import SwiftUI

struct CryptoAPIModel: Identifiable, Codable {
    var id: String { symbol }
    let name: String
    let symbol: String
    let price: Double
    let amount: Double
    let change: Double
    let colorHex: String
    let iconName: String
}

@MainActor
class CryptoViewModel: ObservableObject {
    @Published var tokens: [CryptoAPIModel] = []

    func fetch() async {
        guard let url = URL(string: "http://localhost:8080/api/cryptos") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([CryptoAPIModel].self, from: data)
            self.tokens = decoded

        } catch {
            print("Error: \(error)")
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        self.init(.sRGB, red: Double(r)/255, green: Double(g)/255, blue: Double(b)/255)
    }
}

struct ContentView: View {
    @StateObject private var viewModel = CryptoViewModel()

    var body: some View {
        VStack {
            Text("Crypto Wallet")
                .font(.largeTitle)
                .padding()

            List(viewModel.tokens) { token in
                HStack {
                    Circle()
                        .fill(Color(hex: token.colorHex))
                        .frame(width: 32, height: 32)
                        .overlay(
                            Image(systemName: token.iconName)
                                .foregroundColor(.white)
                        )
                    VStack(alignment: .leading) {
                        Text(token.name)
                        Text("\(token.symbol) - $\(token.price, specifier: "%.2f")")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(token.amount, specifier: "%.4f")")
                        Text("\(token.change, specifier: "%.2f")%")
                            .foregroundColor(token.change < 0 ? .red : .green)
                    }
                }
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
}
