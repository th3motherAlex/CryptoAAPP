//
//  HistoryView.swift
//  Cryptoapp
//
//  Created by Carlos López García on 11/06/25.
//

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

let sampleTransactions = [
    Transaction(type: "Compra", crypto: "BTC", amount: "+0.005 BTC", date: "11 Jun 2025, 09:12", icon: "arrow.down.circle.fill", color: .green),
    Transaction(type: "Venta", crypto: "ETH", amount: "-0.2 ETH", date: "10 Jun 2025, 18:45", icon: "arrow.up.circle.fill", color: .red)
]

struct HistoryView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "clock.arrow.circlepath")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("Historial de transacciones")
                    .font(.headline)
                    .bold()
            }
            .padding()
            .foregroundColor(.white)

            Divider().background(Color.white.opacity(0.2))

            List(sampleTransactions) { tx in
                HStack {
                    Circle()
                        .fill(tx.color)
                        .frame(width: 36, height: 36)
                        .overlay(Image(systemName: tx.icon).foregroundColor(.white))

                    VStack(alignment: .leading) {
                        Text("\(tx.type) \(tx.crypto)").foregroundColor(.white).bold()
                        Text(tx.date).font(.caption).foregroundColor(.gray)
                    }

                    Spacer()

                    Text(tx.amount)
                        .foregroundColor(tx.amount.contains("-") ? .red : .green)
                        .bold()
                }
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            Spacer()
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.bottom)
    }
}
