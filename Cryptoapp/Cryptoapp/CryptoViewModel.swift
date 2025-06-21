import Foundation
import SwiftUI

struct Crypto: Identifiable {
    let id: UUID
    let name: String
    let price: String
    let amount: String
    let change: String
    let color: Color
    let icon: String
}

class CryptoViewModel: ObservableObject {
    @Published var cryptos: [Crypto] = []

    func fetchCryptos() {
        guard let url = URL(string: "http://192.168.1.10:8080/api/cryptos") else {
            print("❌ URL inválida")
            return
        }

        print("🔍 NSAppTransportSecurity cargado correctamente")

        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error de red: \(error)")
                return
            }

            guard let data = data else {
                print("❌ No se recibió data")
                return
            }

            do {
                let decoded = try JSONDecoder().decode([CryptoAPIModel].self, from: data)
                print("✅ Cryptos decodificados: \(decoded.map { $0.name })")
                
                DispatchQueue.main.async {
                    self.cryptos = decoded.map { apiModel in
                        Crypto(
                            id: apiModel.id,
                            name: apiModel.name,
                            price: "$\(String(format: "%.2f", apiModel.price))",
                            amount: "0",
                            change: "0.00%",
                            color: .blue,
                            icon: "bitcoinsign.circle.fill"
                        )
                    }
                }
            } catch {
                print("❌ Error al decodificar: \(error)")
                if let raw = String(data: data, encoding: .utf8) {
                    print("🔎 JSON recibido:\n\(raw)")
                }
            }
        }.resume()
    }


    private func colorForCrypto(_ name: String) -> Color {
        switch name.lowercased() {
            case "bitcoin": return .orange
            case "ethereum": return .blue
            case "xrp": return .gray
            case "link": return .cyan
            case "tron", "trx": return .teal
            case "usdt", "tether": return .green
            case "cardano", "ada": return .pink
            case "solana", "sol": return .yellow
            case "polkadot", "dot": return .red
            case "binance", "bnb": return .indigo
            case "avalanche", "avax": return .brown
            case "polygon", "matic": return .mint
            case "litecoin", "ltc": return .gray
            case "dogecoin", "doge": return .orange
            default: return .white.opacity(0.6)
        }
    }

    private func iconForCrypto(_ name: String) -> String {
        switch name.lowercased() {
            case "bitcoin": return "bitcoinsign.circle.fill"
            case "ethereum": return "e.circle.fill"
            case "xrp": return "x.circle.fill"
            case "link": return "cube.fill"
            case "tron", "trx": return "arrow.left.arrow.right.circle.fill"
            case "usdt", "tether": return "dollarsign.circle.fill"
            case "cardano", "ada": return "a.circle.fill"
            case "solana", "sol": return "s.circle.fill"
            case "polkadot", "dot": return "circle.grid.cross.fill"
            case "binance", "bnb": return "b.circle.fill"
            case "avalanche", "avax": return "flame.fill"
            case "polygon", "matic": return "m.circle.fill"
            case "litecoin", "ltc": return "l.circle.fill"
            case "dogecoin", "doge": return "d.circle.fill"
            default: return "questionmark.circle.fill"
        }
    }
}
