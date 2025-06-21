import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var history: TransactionHistory

    var body: some View {
        ZStack {
            Color(red: 14/255, green: 23/255, blue: 42/255).ignoresSafeArea()

            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "clock.arrow.circlepath")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundColor(.yellow)
                    Text("Historial de transacciones")
                        .font(.title2).bold()
                        .foregroundColor(.white)
                }
                .padding(.horizontal)

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(history.transactions.reversed()) { tx in
                            HStack(spacing: 16) {
                                Circle()
                                    .fill(tx.color)
                                    .frame(width: 48, height: 48)
                                    .overlay(Image(systemName: tx.icon)
                                        .foregroundColor(.white)
                                        .font(.system(size: 20)))

                                VStack(alignment: .leading) {
                                    Text("\(tx.type) \(tx.crypto)")
                                        .foregroundColor(.white)
                                        .font(.headline)

                                    Text(tx.date)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }

                                Spacer()

                                Text(tx.amount)
                                    .foregroundColor(tx.amount.contains("-") ? .red : .green)
                                    .bold()
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
