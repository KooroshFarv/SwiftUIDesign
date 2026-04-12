//
//  Screens.swift
//  SwiftUIDesign
//
//  Created by Koorosh Farvardin on 2026-02-08.
//

import SwiftUI

struct ScanQRView: View {
    @EnvironmentObject var store: LockerStore
    @State private var scannedLocker: Locker? = nil

    var body: some View {
        VStack(spacing: 20) {
            Text("QR Scan Screen")
                .font(AppFonts.heading)
                .foregroundColor(.white)

            Text("For demo purposes, simulate scanning a locker QR code.")
                .foregroundColor(AppColors.secondary)
                .multilineTextAlignment(.center)

            Button("Simulate Scan for Locker A-01") {
                scannedLocker = store.lockerByID("A-01")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppColors.primaryButton)
            .foregroundColor(.black)
            .cornerRadius(10)
            .padding(.horizontal)

            if let locker = scannedLocker {
                NavigationLink(destination: LockerDetailView(locker: locker)) {
                    Text("Go to Locker \(locker.id)")
                        .foregroundColor(.cyan)
                        .bold()
                }
            }

            Spacer()
        }
        .padding()
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("Scan QR")
    }
}
