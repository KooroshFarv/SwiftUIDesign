//
//  ContentView.swift
//  SwiftUIDesign
//
//  Created by Koorosh Farvardin on 2026-02-08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Auth") {
                    NavigationLink("Login") { LoginView() }
                    NavigationLink("Register") { RegisterView() }
                }

                Section("Main") {
                    NavigationLink("Home") { HomeView() }
                    NavigationLink("Scan QR") { ScanQRView() }
                    NavigationLink("Locker Details") { LockerDetailsView() }
                    NavigationLink("Payment") { PaymentView() }
                    NavigationLink("Active Rental") { ActiveRentalView() }
                }

                Section("Other") {
                    NavigationLink("History") { HistoryView() }
                    NavigationLink("Settings") { SettingsView() }
                }

                Section("Gurnoor — Customer Screens") {
                    NavigationLink("Locker List") { LockerListView() }
                    NavigationLink("Rental History") { RentalHistoryView() }
                }
            }
            .navigationTitle("Screens")
        }
    }
}
