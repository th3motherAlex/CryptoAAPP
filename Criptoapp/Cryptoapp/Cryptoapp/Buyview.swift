//
//  Buyview.swift
//  Cryptoapp
//
//  Created by Carlos López García on 11/06/25.
//

import SwiftUI

struct BuyView: View {
    @State private var selectedCrypto = "BTC"
    @State private var amountUSD = ""

    let cryptos = ["BTC", "ETH", "USDT", "XRP", "LINK", "CRO"]
    let exampleRates: [String: Double] = [
        "BTC": 13801.51,
        "ETH": 389.04,
        "USDT": 1.0,
        "XRP": 0.2394,
        "LINK": 11.18,
        "CRO": 0.0865
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
        VStack(spacing: 20) {
            // 🔝 Título con ícono
            VStack {
                HStack {
                    Image(systemName: "cart.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                    Text("Compra segura de criptomonedas")
                        .font(.headline)
                        .bold()
                }
                .padding(.top)
                .foregroundColor(.white)

                Divider()
                    .background(Color.white.opacity(0.2))
            }

            // 🔽 Selección de criptomoneda
            VStack(alignment: .leading, spacing: 10) {
                Text("Selecciona una criptomoneda:")
                    .foregroundColor(.gray)
                Picker("Cripto", selection: $selectedCrypto) {
                    ForEach(cryptos, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding(.horizontal)

        
            // 📊 Resultado estimado
            VStack(alignment: .leading) {
                Text("Recibirás aproximadamente:")
                    .foregroundColor(.gray)
                Text("\(estimatedCrypto) \(selectedCrypto)")
                    .font(.title2)
                    .foregroundColor(.green)
            }
            .padding(.horizontal)

            // 🛒 Botón de compra
            Button(action: {
                // Aquí podrías conectar con una API o lógica real
            }) {
                Text("Comprar ahora")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .background(Color(red: 14/255, green: 23/255, blue: 42/255))
        .foregroundColor(.white)
        .edgesIgnoringSafeArea(.bottom)
    }
}
