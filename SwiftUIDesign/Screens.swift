//
//  Screens.swift
//  SwiftUIDesign
//
//  Created by Koorosh Farvardin on 2026-02-08.
//

import SwiftUI

struct ScanQRView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("QR Scan Screen")
                .font(AppFonts.heading)
                .foregroundColor(.white)

            Text("Camera integration coming soon")
                .foregroundColor(AppColors.secondary)

            Button("Scan") { }
                .padding()
                .frame(maxWidth: .infinity)
                .background(AppColors.primaryButton)
                .foregroundColor(.black)
                .cornerRadius(10)
                .padding(.horizontal)

            Spacer()
        }
        .padding()
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("Scan QR")
    }
}

struct HistoryView: View {
    var body: some View {
        RentalHistoryView()
    }
}

struct SettingsView: View {
    var body: some View {
        Form {
            Section("Settings") {
                Text("Profile")
                Text("Notifications")
                Button("Logout") { }
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Settings")
    }
}
