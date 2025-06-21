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
    WalletToken(name: "Cardano", symbol: "ADA", price: "$0.475", change: "+0.85%", percent: "7.5%", icon: "a.circle.fill", color: Color(hex: "#E11D48")),
    WalletToken(name: "Solana", symbol: "SOL", price: "$145.12", change: "+2.10%", percent: "9.3%", icon: "s.circle.fill", color: Color(hex: "#F59E0B")),
    WalletToken(name: "Polkadot", symbol: "DOT", price: "$6.43", change: "-0.92%", percent: "4.1%", icon: "circle.grid.cross.fill", color: Color(hex: "#EC4899")),
    WalletToken(name: "Avalanche", symbol: "AVAX", price: "$31.88", change: "-1.12%", percent: "3.7%", icon: "flame.fill", color: Color(hex: "#EF4444")),
    WalletToken(name: "Polygon", symbol: "MATIC", price: "$0.82", change: "+0.39%", percent: "5.9%", icon: "m.circle.fill", color: Color(hex: "#8B5CF6")),
    WalletToken(name: "Litecoin", symbol: "LTC", price: "$83.27", change: "-0.73%", percent: "6.0%", icon: "l.circle.fill", color: Color(hex: "#64748B")),
    WalletToken(name: "Dogecoin", symbol: "DOGE", price: "$0.072", change: "+1.02%", percent: "2.8%", icon: "d.circle.fill", color: Color(hex: "#FCD34D"))

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
