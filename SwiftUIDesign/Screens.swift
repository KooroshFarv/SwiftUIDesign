//
//  Screens.swift
//  SwiftUIDesign
//
//  Created by Koorosh Farvardin on 2026-02-08.
//

import SwiftUI

struct HomeView: View {
    let lockers = [
        Locker(id: "A-01", location: "1st Floor", available: true),
        Locker(id: "A-02", location: "1st Floor", available: false),
        Locker(id: "B-11", location: "Gym Floor", available: true)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    Text("Hello, User!")
                        .font(AppFonts.title)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 15) {
                        Text("Available Lockers")
                            .font(AppFonts.heading)
                            .padding(.horizontal)

                        ForEach(lockers) { locker in
                            NavigationLink(destination: LockerDetailsView(locker: locker)) {
                                HStack {
                                    Circle()
                                        .fill(locker.available ? .green : .red)
                                        .frame(width: 12, height: 12)
                                    VStack(alignment: .leading) {
                                        Text(locker.id)
                                            .font(AppFonts.body)
                                        Text(locker.location)
                                            .font(.subheadline)
                                            .foregroundColor(AppColors.secondary)
                                    }
                                    Spacer()
                                    Text(locker.available ? "Available" : "In Use")
                                        .foregroundColor(locker.available ? .green : .red)
                                        .font(.subheadline)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: .gray.opacity(0.3), radius: 2, x: 0, y: 2)
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    VStack(spacing: 15) {
                        NavigationLink(destination: ScanQRView()) {
                            AppButtons.primary("Scan QR Code")
                                .padding(.horizontal)
                        }
                        NavigationLink(destination: ActiveRentalView(locker: lockers.first(where: { $0.available }) ?? lockers[0])) {
                            AppButtons.primary("Active Rental")
                                .padding(.horizontal)
                        }
                        NavigationLink(destination: PaymentView(locker: lockers.first(where: { $0.available }) ?? lockers[0])) {
                            AppButtons.primary("Payment")
                                .padding(.horizontal)
                        }
                        NavigationLink(destination: LockerDetailsView(locker: lockers.first!)) {
                            AppButtons.primary("Locker Details")
                                .padding(.horizontal)
                        }
                    }

                    VStack(spacing: 15) {
                        NavigationLink(destination: HistoryView()) {
                            AppButtons.secondary("History")
                        }
                        NavigationLink(destination: SettingsView()) {
                            AppButtons.secondary("Settings")
                        }
                    }

                    Spacer(minLength: 20)
                }
            }
            .background(AppColors.background.ignoresSafeArea())
            .navigationTitle("Home")
        }
    }
}

struct LockerDetailsView: View {
    let locker: Locker

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Locker Details")
                .font(.title).bold()
            Text("Locker: \(locker.id)")
            Text("Location: \(locker.location)")
            Text("Status: \(locker.available ? "Available" : "In Use")")

            if locker.available {
                NavigationLink("Rent Locker") {
                    PaymentView(locker: locker)
                }
                .buttonStyle(.borderedProminent)
            } else {
                Text("Not available")
                    .foregroundColor(.red)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Locker Details")
    }
}

struct PaymentView: View {
    let locker: Locker

    var body: some View {
        Form {
            Section("Payment") {
                Text("Locker: \(locker.id)")
                Text("Price: $3.00 / hour")
                NavigationLink("Pay") {
                    ActiveRentalView(locker: locker)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle("Payment")
    }
}

struct ActiveRentalView: View {
    let locker: Locker

    var body: some View {
        VStack(spacing: 12) {
            Text("Active Rental")
                .font(.title).bold()
            Text("Locker: \(locker.id)")
            Text("Access Code: 123456")
                .font(.system(size: 28, weight: .bold, design: .monospaced))
            Text("Expires in: 2 hours")
                .foregroundStyle(.secondary)
            NavigationLink("End Rental") {
                HomeView()
            }
            .buttonStyle(.bordered)
            Spacer()
        }
        .padding()
        .navigationTitle("Active Rental")
    }
}

struct ScanQRView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("QR Scan Screen")
                .font(.title2).bold()
            Text("Camera")
                .foregroundStyle(.secondary)
            Button("Scan") { }
                .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
        .navigationTitle("Scan QR")
    }
}

struct HistoryView: View {
    var body: some View {
        List {
            Text("Rental History")
            Text("B-11 • 2 hours • Jan 12")
            Text("A-01 • 1 hour • Jan 05")
        }
        .navigationTitle("History")
    }
}

struct SettingsView: View {
    var body: some View {
        Form {
            Section("Settings") {
                Text("Profile")
                Text("Notifications")
                Button("Logout") { }
            }
        }
        .navigationTitle("Settings")
    }
}
