import SwiftUI

struct StakingOption: Identifiable {
    let id = UUID()
    let name: String
    let apy: String
    let duration: String
    let icon: String
    let color: Color
}

let stakingOptions = [
    StakingOption(name: "ETH", apy: "4.5%", duration: "90 días", icon: "bitcoinsign.circle.fill", color: .blue),
    StakingOption(name: "USDT", apy: "8.0%", duration: "30 días", icon: "dollarsign.circle.fill", color: .green),
    StakingOption(name: "CRO", apy: "12.5%", duration: "180 días", icon: "bitcoinsign.circle.fill", color: .purple),
    StakingOption(name: "LINK", apy: "6.3%", duration: "60 días", icon: "cube.fill", color: .cyan)
]

struct StakingView: View {
    var body: some View {
        ZStack {
            Color(red: 14/255, green: 23/255, blue: 42/255).ignoresSafeArea()

            VStack(spacing: 20) {
                // Encabezado
                VStack(spacing: 8) {
                    Image(systemName: "dollarsign.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.yellow)

                    Text("Gana recompensas con Staking")
                        .font(.title2).bold()
                        .foregroundColor(.white)
                }
                .padding(.top)

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(stakingOptions) { option in
                            HStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(option.color)
                                        .frame(width: 50, height: 50)
                                    Image(systemName: option.icon)
                                        .foregroundColor(.white)
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(option.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text("Duración: \(option.duration)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }

                                Spacer()

                                VStack(alignment: .trailing, spacing: 4) {
                                    Text(option.apy)
                                        .foregroundColor(.green)
                                        .bold()

                                    Button(action: {
                                    }) {
                                        Text("Stake")
                                            .font(.caption2)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color.white.opacity(0.1))
                                            .cornerRadius(6)
                                    }
                                    .foregroundColor(.white)
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(14)
                            .padding(.horizontal)
                        }
                    }
                }

                Spacer()
            }
            .padding(.top)
        }
    }
}
