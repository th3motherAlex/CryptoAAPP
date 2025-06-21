import SwiftUI

struct BuyView: View {
    @EnvironmentObject var history: TransactionHistory

    @State private var selectedCrypto = "BTC"
    @State private var amountUSD = ""
    @State private var purchaseConfirmed = false

    let cryptos = ["BTC", "ETH", "USDT", "XRP", "LINK", "CRO", "ADA", "SOL", "DOT", "AVAX", "MATIC", "LTC", "DOGE"]

    let exampleRates: [String: Double] = [
        "BTC": 13801.51, "ETH": 389.04, "USDT": 1.0,
        "XRP": 0.2394, "LINK": 11.18, "CRO": 0.0865,
        "ADA": 0.475, "SOL": 145.12, "DOT": 6.43,
        "AVAX": 31.88, "MATIC": 0.82, "LTC": 83.27, "DOGE": 0.072
    ]

    var estimatedCrypto: String {
        guard let usd = Double(amountUSD),
              let rate = exampleRates[selectedCrypto] else {
            return "0"
        }
        let quantity = usd / rate
        return String(format: "%.6f", quantity)
    }

    var body: some View {
        ZStack {
            Color(red: 14/255, green: 23/255, blue: 42/255).ignoresSafeArea()

            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Image(systemName: "cart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.yellow)

                    Text("Compra segura de criptomonedas")
                        .font(.title2).bold()
                        .foregroundColor(.white)
                }

                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Selecciona una criptomoneda:")
                            .foregroundColor(.gray)
                        Picker("Cripto", selection: $selectedCrypto) {
                            ForEach(cryptos, id: \.self) { Text($0) }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(.white)
                    }

                    VStack(alignment: .leading) {
                        Text("Monto en USD:")
                            .foregroundColor(.gray)

                        TextField("Ej. 100", text: $amountUSD)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    }

                    VStack(alignment: .leading) {
                        Text("Recibirás aproximadamente:")
                            .foregroundColor(.gray)
                        Text("\(estimatedCrypto) \(selectedCrypto)")
                            .font(.title3).bold()
                            .foregroundColor(.green)
                    }

                    Button(action: {
                        purchaseConfirmed = true
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd MMM yyyy, HH:mm"
                        let newTx = Transaction(
                            type: "Compra",
                            crypto: selectedCrypto,
                            amount: "+\(estimatedCrypto) \(selectedCrypto)",
                            date: formatter.string(from: Date()),
                            icon: "arrow.down.circle.fill",
                            color: .green
                        )
                        history.transactions.append(newTx)
                    }) {
                        Text("Comprar ahora")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }

                    if purchaseConfirmed {
                        Text("✅ Compra confirmada de \(estimatedCrypto) \(selectedCrypto)")
                            .foregroundColor(.green)
                            .font(.footnote)
                            .transition(.opacity)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.05))
                .cornerRadius(20)
                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
    }
}
