//
//  StakingView.swift
//  Cryptoapp
//
//  Created by Carlos López García on 11/06/25.
//

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
        VStack(spacing: 0) {
            // Encabezado
            VStack {
                HStack {
                    Image(systemName: "dollarsign.circle")
                        .resizable()
                        .frame(width: 28, height: 28)
                    Text("Gana recompensas con Staking")
                        .font(.headline)
                        .bold()
                }
                .padding(.top)
                .foregroundColor(.white)

                Divider()
                    .background(.white.opacity(0.2))
            }

            // Lista de opciones de staking
            List(stakingOptions) { option in
                HStack {
                    Circle()
                        .fill(option.color)
                        .frame(width: 36, height: 36)
                        .overlay(
                            Image(systemName: option.icon)
                                .foregroundColor(.white)
                        )

                    VStack(alignment: .leading) {
                        Text(option.name)
                            .foregroundColor(.white)
                            .bold()
                        Text("Duración: \(option.duration)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    VStack(alignment: .trailing) {
                        Text(option.apy)
                            .foregroundColor(.green)
                            .bold()
                        Button(action: {
                            // Acción futura para iniciar staking
                        }) {
                            Text("Stake")
                                .font(.caption)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(5)
                        }
                        .foregroundColor(.white)
                    }
                }
                .listRowBackground(Color.clear)
                .padding(.vertical, 4)
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)

            Spacer()
        }
        .background(Color(red: 14/255, green: 23/255, blue: 42/255))
        .edgesIgnoringSafeArea(.bottom)
    }
}
