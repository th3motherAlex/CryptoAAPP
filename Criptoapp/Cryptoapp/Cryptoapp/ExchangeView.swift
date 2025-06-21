//
//  ExchangeView.swift
//  Cryptoapp
//
//  Created by Carlos López García on 11/06/25.
//

import SwiftUI

struct ExchangeView: View {
    @State private var fromCurrency = "BTC"
    @State private var toCurrency = "ETH"
    @State private var amount = ""

    let currencies = ["BTC", "ETH", "USDT", "XRP", "LINK", "CRO"]

    var body: some View {
        VStack(spacing: 20) {
            // Título e ícono
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

            // Selección de criptos
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

          
            // Botón de intercambio
            Button(action: {
                // Acción futura: lógica de intercambio
            }) {
                Text("Intercambiar")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .background(Color(red: 14/255, green: 23/255, blue: 42/255))
        .foregroundColor(.white)
    }
}
