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
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Text("Logout")
                            .bold()
                            .foregroundColor(.red)
                    }
                    .padding(.trailing)
                }
                
                Text("Hello, User!")
                    .font(AppFonts.heading)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(lockers) { locker in
                            NavigationLink(destination: LockerDetailsView(locker: locker)) {
                                HStack {
                                    Circle()
                                        .fill(locker.available ? .green : .red)
                                        .frame(width: 12, height: 12)
                                    VStack(alignment: .leading) {
                                        Text(locker.id)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(locker.location)
                                            .font(.subheadline)
                                            .foregroundColor(AppColors.secondary)
                                    }
                                    Spacer()
                                    Text(locker.available ? "Available" : "In Use")
                                        .foregroundColor(locker.available ? .green : .red)
                                }
                                .padding()
                                .background(AppColors.secondaryButton)
                                .cornerRadius(10)
                            }
                        }
                        
                        VStack(spacing: 15) {
                            NavigationLink(destination: ScanQRView()) {
                                AppButtons.primary("Scan QR")
                            }
                            NavigationLink(destination: HistoryView()) {
                                AppButtons.secondary("Rental History")
                            }
                            NavigationLink(destination: ActiveRentalView(locker: lockers[0])) {
                                AppButtons.secondary("Active Rental")
                            }
                            NavigationLink(destination: LockerDetailsView(locker: lockers[0])) {
                                AppButtons.secondary("Locker Details")
                            }
                            NavigationLink(destination: PaymentView(locker: lockers[0])) {
                                AppButtons.secondary("Payment")
                            }
                        }
                        .padding(.top)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColors.background.ignoresSafeArea())
            .navigationTitle("Home")
        }
    }
}

struct LockerDetailsView: View {
    let locker: Locker
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Locker Details")
                .font(AppFonts.heading)
                .foregroundColor(.white)
            
            Text("Locker: \(locker.id)")
                .foregroundColor(.white)
            Text("Location: \(locker.location)")
                .foregroundColor(AppColors.secondary)
            Text("Status: \(locker.available ? "Available" : "In Use")")
                .foregroundColor(locker.available ? .green : .red)
            
            if locker.available {
                NavigationLink(destination: PaymentView(locker: locker)) {
                    AppButtons.primary("Rent Locker")
                }
            } else {
                Text("Not available")
                    .foregroundColor(.red)
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("Locker Details")
    }
}

struct PaymentView: View {
    let locker: Locker
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Payment for Locker \(locker.id)")
                .font(AppFonts.heading)
                .foregroundColor(.white)
            
            Text("Price: $3.00 / hour")
                .foregroundColor(.white)
            
            NavigationLink(destination: ActiveRentalView(locker: locker)) {
                AppButtons.primary("Pay")
            }
            
            Spacer()
        }
        .padding()
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("Payment")
    }
}

struct ActiveRentalView: View {
    let locker: Locker
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Active Rental")
                .font(AppFonts.heading)
                .foregroundColor(.white)
            
            Text("Locker: \(locker.id)")
                .foregroundColor(.white)
            Text("Access Code: 123456")
                .font(.system(size: 28, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
            
            Text("Expires in: 2 hours")
                .foregroundColor(AppColors.secondary)
            
            NavigationLink(destination: HomeView()) {
                AppButtons.destructive("End Rental")
            }
            
            Spacer()
        }
        .padding()
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("Active Rental")
    }
}

struct ScanQRView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("QR Scan Screen")
                .font(AppFonts.heading)
                .foregroundColor(.white)
            
            Text("Camera")
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
        VStack {
            Text("Rental History")
                .font(AppFonts.heading)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)

            ScrollView {
                VStack(spacing: 15) {
                    Text("B-11 • 2 hours • Jan 12")
                        .foregroundColor(.white)
                        .padding()
                        .background(AppColors.secondaryButton)
                        .cornerRadius(10)
                    Text("A-01 • 1 hour • Jan 05")
                        .foregroundColor(.white)
                        .padding()
                        .background(AppColors.secondaryButton)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("History")
    }
}

struct SettingsView: View {
    var body: some View {
        Form {
            Section("Settings") {
                Text("Profile")
                    .foregroundColor(.white)
                Text("Notifications")
                    .foregroundColor(.white)
                Button("Logout") { }
                    .foregroundColor(.red)
            }
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle("Settings")
    }
}
