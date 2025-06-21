import SwiftUI

struct ExchangeView: View {
    @State private var fromCurrency = "BTC"
    @State private var toCurrency = "ETH"
    @State private var amount = ""
    
    let currencies = ["BTC", "ETH", "USDT", "XRP", "LINK", "CRO"]

    let rates: [String: Double] = [
        "BTC": 67000,
        "ETH": 3500,
        "USDT": 1,
        "XRP": 0.5,
        "LINK": 12,
        "CRO": 0.1
    ]

    var convertedAmount: String {
        guard let inputAmount = Double(amount),
              let fromRate = rates[fromCurrency],
              let toRate = rates[toCurrency] else {
            return "0"
        }

        let usdValue = inputAmount * fromRate
        let result = usdValue / toRate
        return String(format: "%.6f", result)
    }

    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Image(systemName: "arrow.2.squarepath")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.green)
                Text("Intercambiar criptomonedas")
                    .font(.title2)
                    .bold()
            }
            .padding(.top)

            VStack(alignment: .leading, spacing: 10) {
                Text("Cantidad a convertir:")
                    .foregroundColor(.gray)
                
                TextField("Ej. 1.5", text: $amount)
                    .padding()
                    .background(SwiftUI.Color.white.opacity(0.1))
                    .cornerRadius(8)
                    .foregroundColor(SwiftUI.Color.white)
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 10) {
                Text("Desde:")
                    .foregroundColor(.gray)

                Picker("Desde", selection: $fromCurrency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text(currency)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Text("Hacia:")
                    .foregroundColor(.gray)

                Picker("Hacia", selection: $toCurrency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text(currency)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.horizontal)

            VStack(spacing: 10) {
                Text("Resultado:")
                    .foregroundColor(.gray)

                Text("\(convertedAmount) \(toCurrency)")
                    .font(.title)
                    .bold()
                    .foregroundColor(.green)
            }
            .padding(.top)

            Spacer()
        }
        .padding()
        .background(Color(red: 14/255, green: 23/255, blue: 42/255))
        .foregroundColor(.white)
    }
}
