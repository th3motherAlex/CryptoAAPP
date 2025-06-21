import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var searchText = ""
    @StateObject private var viewModel = CryptoViewModel()

    var filteredCryptos: [Crypto] {
        if searchText.isEmpty {
            return viewModel.cryptos
        } else {
            return viewModel.cryptos.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            walletView
                .tag(0)
                .tabItem {
                    Label("Pricing", systemImage: "wallet.pass.fill")
                }

            HistoryView()
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
        .onAppear {
            viewModel.fetchCryptos()
        }
    }

    var walletView: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "slider.horizontal.3")
                Spacer()
                Text("0.00 USD")
                    .font(.title3.bold())
                Spacer()
                Image(systemName: "info.circle")
            }
            .padding(.horizontal)
            .foregroundColor(.white)

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Buscar...", text: $searchText)
                    .foregroundColor(.white)
            }
            .padding(10)
            .background(Color.white.opacity(0.05))
            .cornerRadius(10)
            .padding(.horizontal)
            
            Text("Total monedas: \(viewModel.cryptos.count)")
                .foregroundColor(.white)

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(filteredCryptos) { crypto in
                        HStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(crypto.color)
                                    .frame(width: 40, height: 40)
                                    .shadow(color: crypto.color.opacity(0.5), radius: 5)
                                Image(systemName: crypto.icon)
                                    .foregroundColor(.white)
                            }

                            VStack(alignment: .leading) {
                                Text(crypto.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Text(crypto.price)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            VStack(alignment: .trailing) {
                                Text(crypto.amount)
                                    .foregroundColor(.white)
                                    .font(.subheadline.bold())
                                Text(crypto.change)
                                    .font(.caption2)
                                    .foregroundColor(crypto.change.contains("-") ? .red : .green)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.04))
                        .cornerRadius(14)
                        .padding(.horizontal)
                    }
                }
            }
        }
        .padding(.top, 20)
        .background(
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 14/255, green: 23/255, blue: 42/255),
                Color(red: 10/255, green: 17/255, blue: 33/255)
            ]), startPoint: .top, endPoint: .bottom)
        )
    }
}
