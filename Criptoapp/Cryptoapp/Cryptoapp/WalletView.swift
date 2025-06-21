//
//  WalletView.swift
//  Cryptoapp
//
//  Created by Carlos López García on 11/06/25.
//

import SwiftUI

struct WalletToken: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let price: String
    let change: String
    let percent: String
    let icon: String
    let color: Color
}

let walletTokens = [
    WalletToken(name: "Bitcoin", symbol: "BTC", price: "$13,801.51", change: "-0.19%", percent: "32.5%", icon: "bitcoinsign.circle.fill", color: .orange),
    WalletToken(name: "Ethereum", symbol: "ETH", price: "$389.04", change: "+0.13%", percent: "21.3%", icon: "e.circle.fill", color: Color(hex: "#6366F1")),
    WalletToken(name: "XRP", symbol: "XRP", price: "$0.2394", change: "-0.58%", percent: "14.2%", icon: "x.circle.fill", color: Color(hex: "#14B8A6")),
    WalletToken(name: "Chainlink", symbol: "LINK", price: "$11.18", change: "-1.15%", percent: "12.0%", icon: "link.circle.fill", color: Color(hex: "#3B82F6")),
    WalletToken(name: "USDT", symbol: "USDT", price: "$1.00", change: "0.00%", percent: "20.0%", icon: "dollarsign.circle.fill", color: Color(hex: "#10B981"))
]

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

struct WalletView: View {
    var body: some View {
        VStack(spacing: 28) {
            
            // 🪙 Balance Principal
            VStack(spacing: 6) {
                Text("Total Balance")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("$1,135,192.04")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text("+$18,975.68 (1.70%)")
                    .font(.footnote)
                    .foregroundColor(.green)
            }
            
            Divider().background(Color.white.opacity(0.1))

            // 📋 Encabezados
            HStack {
                Text("Token")
                Spacer()
                Text("Portfolio")
                Spacer()
                Text("Price")
            }
            .foregroundColor(.white.opacity(0.7))
            .font(.caption)
            .padding(.horizontal)

            // 🔄 Lista
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(walletTokens) { token in
                        HStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(token.color)
                                    .frame(width: 44, height: 44)
                                    .shadow(color: token.color.opacity(0.4), radius: 5, x: 0, y: 2)
                                Image(systemName: token.icon)
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .medium))
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(token.symbol)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(token.name)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }

                            Spacer()
                            
                            Text(token.percent)
                                .foregroundColor(.white)
                                .font(.subheadline)
                                .frame(width: 60, alignment: .trailing)

                            VStack(alignment: .trailing, spacing: 2) {
                                Text(token.price)
                                    .foregroundColor(.white)
                                Text(token.change)
                                    .font(.caption2)
                                    .foregroundColor(token.change.contains("-") ? .red : .green)
                            }
                            .frame(width: 80, alignment: .trailing)
                        }
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.03), Color.white.opacity(0.08)]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                        )
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.05), lineWidth: 1)
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 32)
        .padding(.horizontal)
        .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "#1E1B2E"), Color(hex: "#111827")]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}
