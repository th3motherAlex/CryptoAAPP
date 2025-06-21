//
//  ContentView.swift
//  Cryptoapp
//
//  Created by Carlos López García on 11/06/25.
//

import SwiftUI

struct Crypto: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let price: String
    let amount: String
    let change: String
    let color: Color
    let icon: String
}

let sampleCryptos = [
    Crypto(name: "BTC", symbol: "BTC", price: "$13,801.51", amount: "0", change: "-0.19%", color: .orange, icon: "bitcoinsign.circle.fill"),
    Crypto(name: "ETH", symbol: "ETH", price: "$389.04", amount: "0", change: "+0.13%", color: .blue, icon: "bitcoinsign.circle.fill"),
    Crypto(name: "XRP", symbol: "XRP", price: "$0.2394", amount: "0", change: "-0.58%", color: .gray, icon: "x.circle.fill"),
    Crypto(name: "LINK", symbol: "LINK", price: "$11.18", amount: "0", change: "-1.15%", color: .cyan, icon: "cube.fill"),
    Crypto(name: "TRX-USDT", symbol: "TRX-USDT", price: "$1", amount: "0", change: "0.00%", color: .teal, icon: "arrow.left.arrow.right.circle.fill"),
    Crypto(name: "USDT", symbol: "USDT", price: "$1", amount: "0", change: "0.00%", color: .green, icon: "dollarsign.circle.fill"),
    Crypto(name: "CRO", symbol: "CRO", price: "$0.0865", amount: "0", change: "+1.24%", color: .purple, icon: "bitcoinsign.circle.fill")
]

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var searchText = ""

    var filteredCryptos: [Crypto] {
        if searchText.isEmpty {
            return sampleCryptos
        } else {
            return sampleCryptos.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.symbol.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            walletView
                .tag(0)
                .tabItem {
                    Label("Wallet", systemImage: "wallet.pass.fill")
                }

            tabWithHeader(icon: "clock.arrow.circlepath", title: "Historial de transacciones")
                .tag(1)
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }

            ExchangeView()
                .tag(2)
                .tabItem {
                    Label("Exchange", systemImage: "arrow.2.squarepath")
                }

            BuyView()
                .tag(3)
                .tabItem {
                    Label("Buy", systemImage: "cart.fill")
                }

            StakingView()
                .tag(4)
                .tabItem {
                    Label("Staking", systemImage: "dollarsign.circle")
                }
        }
        .accentColor(.white)
        .background(
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 14/255, green: 23/255, blue: 42/255),
                Color(red: 10/255, green: 17/255, blue: 33/255)
            ]), startPoint: .top, endPoint: .bottom)
        )
    }

    var walletView: some View {
        VStack(spacing: 0) {
            // Top Bar
            HStack {
                Image(systemName: "slider.horizontal.3")
                Spacer()
                Text("0.00 USD")
                    .font(.headline)
                Spacer()
                Image(systemName: "info.circle")
            }
            .padding()
            .foregroundColor(.white)

     
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Buscar...", text: $searchText)
                    .foregroundColor(.white)
            }
            .padding(10)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)

         
            List(filteredCryptos) { crypto in
                HStack(spacing: 12) {
                    Circle()
                        .fill(crypto.color)
                        .frame(width: 36, height: 36)
                        .shadow(color: crypto.color.opacity(0.4), radius: 4)
                        .overlay(
                            Image(systemName: crypto.icon)
                                .foregroundColor(.white)
                        )

                    VStack(alignment: .leading, spacing: 2) {
                        Text(crypto.name)
                            .foregroundColor(.white)
                            .bold()
                        Text(crypto.price)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 2) {
                        Text(crypto.amount)
                            .foregroundColor(.white)
                            .bold()
                            .animation(.easeInOut(duration: 0.3), value: crypto.amount)
                        Text(crypto.change)
                            .font(.caption)
                            .foregroundColor(crypto.change.contains("-") ? .red : .green)
                            .animation(.easeInOut(duration: 0.3), value: crypto.change)
                    }
                }
                .padding(.vertical, 5)
                .listRowBackground(Color.clear)
            }
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
            .background(Color.clear)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 14/255, green: 23/255, blue: 42/255),
                Color(red: 10/255, green: 17/255, blue: 33/255)
            ]), startPoint: .top, endPoint: .bottom)
        )
    }

    func tabWithHeader(icon: String, title: String) -> some View {
        VStack {
            Spacer()
            Image(systemName: icon)
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.white.opacity(0.5))
            Text("Contenido de '\(title)' próximamente.")
                .foregroundColor(.gray)
                .font(.caption)
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 14/255, green: 23/255, blue: 42/255),
                Color(red: 10/255, green: 17/255, blue: 33/255)
            ]), startPoint: .top, endPoint: .bottom)
        )
    }
}


struct Exchange2View: View {
    var body: some View {
        ZStack {
            Color(red: 14/255, green: 23/255, blue: 42/255)
                .ignoresSafeArea()
            Text("Exchange")
                .foregroundColor(.white)
                .font(.title)
        }
    }
}

struct Buy2View: View {
    var body: some View {
        ZStack {
            Color(red: 14/255, green: 23/255, blue: 42/255)
                .ignoresSafeArea()
            Text("Buy")
                .foregroundColor(.white)
                .font(.title)
        }
    }
}

struct Staking2View: View {
    var body: some View {
        ZStack {
            Color(red: 14/255, green: 23/255, blue: 42/255)
                .ignoresSafeArea()
            Text("Staking")
                .foregroundColor(.white)
                .font(.title)
        }
    }
}
