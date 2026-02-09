//
//  Screens.swift
//  SwiftUIDesign
//
//  Created by Koorosh Farvardin on 2026-02-08.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        Form {
            Section("Login") {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button("Sign In") { }
            }
        }
        .navigationTitle("Login")
    }
}

struct RegisterView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        Form {
            Section("Create Account") {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button("Create Account") { }
            }
        }
        .navigationTitle("Register")
    }
}

// MARK: - Main

struct HomeView: View {
    var body: some View {
        List {
            Text("Available lockers (placeholder)")
            Text("Locker A-01 - Available")
            Text("Locker A-02 - In Use")
            Text("Locker B-11 - Available")
        }
        .navigationTitle("Home")
    }
}

struct ScanQRView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("QR Scan Screen")
                .font(.title2).bold()
            Text("Placeholder - no camera yet")
                .foregroundStyle(.secondary)

            Button("Simulate Scan") { }
                .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
        .navigationTitle("Scan QR")
    }
}

struct LockerDetailsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Locker Details")
                .font(.title).bold()

            Text("Locker: B-11")
            Text("Location: Gym Floor")
            Text("Status: Available")

            Button("Rent Locker") { }
                .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
        .navigationTitle("Locker Details")
    }
}

struct PaymentView: View {
    var body: some View {
        Form {
            Section("Payment") {
                Text("Locker: B-11")
                Text("Price: $3.00 / hour (placeholder)")
                Button("Pay (Simulated)") { }
            }
        }
        .navigationTitle("Payment")
    }
}

struct ActiveRentalView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Active Rental")
                .font(.title).bold()

            Text("Locker: B-11")
            Text("Access Code: 123456")
                .font(.system(size: 28, weight: .bold, design: .monospaced))

            Text("Expires in: 2 hours (placeholder)")
                .foregroundStyle(.secondary)

            Button("End Rental") { }
                .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
        .navigationTitle("Active Rental")
    }
}

// MARK: - Other

struct HistoryView: View {
    var body: some View {
        List {
            Text("Rental History (placeholder)")
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
                Text("Profile (placeholder)")
                Text("Notifications (placeholder)")
                Button("Logout") { }
            }
        }
        .navigationTitle("Settings")
    }
}
