//
//  CryptoappApp.swift
//  Cryptoapp
//
//  Created by Carlos López García on 11/06/25.
//

import SwiftUI

@main
struct CryptoTabbedApp: App {
    @StateObject var history = TransactionHistory()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(history)
        }
    }
}

