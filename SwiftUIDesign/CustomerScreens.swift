//
//  CustomerScreens.swift
//  SwiftUIDesign
//
//  Created by Gurnoor Khurana
//
//  Customer-facing screens: Locker List, Locker Detail, Rental History
//

import SwiftUI

// MARK: - Locker List (Home)

struct LockerListView: View {
    @State private var searchText = ""
    @State private var selectedSize: Locker.LockerSize? = nil

    var lockers: [Locker] { SampleData.lockers }

    var filtered: [Locker] {
        lockers.filter { locker in
            let matchesSearch = searchText.isEmpty ||
                locker.id.localizedCaseInsensitiveContains(searchText) ||
                locker.floor.localizedCaseInsensitiveContains(searchText)
            let matchesSize = selectedSize == nil || locker.size == selectedSize
            return matchesSearch && matchesSize
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterPill(label: "All", isSelected: selectedSize == nil) {
                            selectedSize = nil
                        }

                        ForEach([Locker.LockerSize.small, .medium, .large], id: \.self) { size in
                            FilterPill(label: size.rawValue, isSelected: selectedSize == size) {
                                selectedSize = selectedSize == size ? nil : size
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                .background(Color(.systemGroupedBackground))

                List(filtered) { locker in
                    NavigationLink(destination: LockerDetailView(locker: locker)) {
                        LockerRow(locker: locker)
                    }
                }
                .listStyle(.insetGrouped)

                NavigationLink(destination: ScanQRView()) {
                    Label("Scan Locker QR", systemImage: "qrcode.viewfinder")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundStyle(.white)
                        .cornerRadius(12)
                        .padding()
                }
            }
            .searchable(text: $searchText, prompt: "Search by ID or floor")
            .navigationTitle("Available Lockers")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("\(filtered.filter { $0.status == .available }.count) available")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

// MARK: - Locker Row

private struct LockerRow: View {
    let locker: Locker

    var body: some View {
        HStack(spacing: 14) {
            Circle()
                .fill(locker.status.color)
                .frame(width: 12, height: 12)

            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text("Locker \(locker.id)")
                        .font(.headline)

                    Spacer()

                    Text("$" + String(format: "%.2f", locker.hourlyRate) + "/hr")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: 6) {
                    Label(locker.floor, systemImage: "building.2")
                    Text("·")
                    Label(locker.size.rawValue, systemImage: "square.resize")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            StatusBadge(status: locker.status)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Locker Detail

struct LockerDetailView: View {
    let locker: Locker
    @State private var selectedHours = 1
    @State private var showRentSheet = false

    var totalPrice: Double { locker.hourlyRate * Double(selectedHours) }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(spacing: 12) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Locker \(locker.id)")
                                .font(.largeTitle)
                                .bold()

                            Text(locker.floor)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        StatusBadge(status: locker.status)
                            .scaleEffect(1.2)
                    }

                    Divider()

                    HStack(spacing: 0) {
                        DetailStat(icon: "square.resize", label: "Size", value: locker.size.rawValue)

                        Divider().frame(height: 40)

                        DetailStat(
                            icon: "dollarsign.circle",
                            label: "Rate",
                            value: "$" + String(format: "%.2f", locker.hourlyRate) + "/hr"
                        )

                        Divider().frame(height: 40)

                        DetailStat(icon: "mappin.and.ellipse", label: "Floor", value: locker.floor)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(14)
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Features")
                        .font(.headline)
                        .padding(.horizontal)

                    VStack(spacing: 0) {
                        FeatureRow(icon: "lock.shield.fill", text: "Secure Digital Lock", color: .blue)
                        Divider().padding(.leading, 52)
                        FeatureRow(icon: "clock.fill", text: "24/7 Access", color: .green)
                        Divider().padding(.leading, 52)
                        FeatureRow(icon: "bell.fill", text: "Expiry Reminders", color: .orange)
                        Divider().padding(.leading, 52)
                        FeatureRow(icon: "qrcode", text: "QR Code Entry", color: .purple)
                    }
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(14)
                    .padding(.horizontal)
                }

                if locker.status == .available {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Rental Duration")
                            .font(.headline)
                            .padding(.horizontal)

                        VStack(spacing: 12) {
                            Stepper(
                                "**\(selectedHours)** \(selectedHours == 1 ? "hour" : "hours")",
                                value: $selectedHours,
                                in: 1...24
                            )

                            Divider()

                            HStack {
                                Text("Total")
                                    .foregroundStyle(.secondary)

                                Spacer()

                                Text("$" + String(format: "%.2f", totalPrice))
                                    .font(.title3)
                                    .bold()
                            }
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(14)
                        .padding(.horizontal)
                    }

                    Button(action: { showRentSheet = true }) {
                        Label("Rent This Locker", systemImage: "lock.open.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundStyle(.white)
                            .cornerRadius(14)
                    }
                    .padding(.horizontal)
                    .sheet(isPresented: $showRentSheet) {
                        RentConfirmationSheet(locker: locker, hours: selectedHours, total: totalPrice)
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Locker Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - confirmation

struct RentConfirmationSheet: View {
    let locker: Locker
    let hours: Int
    let total: Double

    @Environment(\.dismiss) private var dismiss
    @State private var confirmed = false

    var body: some View {
        NavigationStack {
            if confirmed {
                VStack(spacing: 24) {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(.green)

                    Text("Locker Rented!")
                        .font(.title)
                        .bold()

                    Text("Your access code")
                        .foregroundStyle(.secondary)

                    Text("483 291")
                        .font(.system(size: 48, weight: .bold, design: .monospaced))
                        .kerning(4)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)

                    Text("Valid for \(hours) \(hours == 1 ? "hour" : "hours") · Locker \(locker.id)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Button("Done") { dismiss() }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                }
                .padding()
            } else {
                Form {
                    Section("Rental Summary") {
                        LabeledContent("Locker", value: locker.id)
                        LabeledContent("Floor", value: locker.floor)
                        LabeledContent("Size", value: locker.size.rawValue)
                        LabeledContent("Duration", value: "\(hours) \(hours == 1 ? "hour" : "hours")")
                        LabeledContent("Total", value: "$" + String(format: "%.2f", total))
                    }

                    Section {
                        Button("Confirm & Pay") {
                            confirmed = true
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .navigationTitle("Confirm Rental")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                    }
                }
            }
        }
    }
}

// MARK: - Rental History

struct RentalHistoryView: View {
    @State private var showCodeFor: Rental? = nil
    let history = SampleData.rentalHistory

    var body: some View {
        List(history) { rental in
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("Locker \(rental.lockerID)")
                        .font(.headline)

                    Spacer()

                    Text("$" + String(format: "%.2f", rental.totalPaid))
                        .font(.subheadline.bold())
                        .foregroundStyle(.green)
                }

                HStack(spacing: 6) {
                    Label(rental.formattedDate, systemImage: "calendar")
                    Text("·")
                    Label(rental.duration, systemImage: "clock")
                }
                .font(.caption)
                .foregroundStyle(.secondary)

                Text(rental.timeRange)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Button {
                    showCodeFor = rental
                } label: {
                    Label("View Access Code", systemImage: "key.fill")
                        .font(.caption)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .padding(.top, 2)
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Rental History")
        .sheet(item: $showCodeFor) { rental in
            VStack(spacing: 20) {
                Text("Access Code")
                    .font(.title2)
                    .bold()

                Text("Locker \(rental.lockerID) · \(rental.formattedDate)")
                    .foregroundStyle(.secondary)

                Text(rental.accessCode)
                    .font(.system(size: 42, weight: .bold, design: .monospaced))
                    .kerning(6)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)

                Text("(Rental has ended)")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Button("Close") { showCodeFor = nil }
                    .buttonStyle(.bordered)
            }
            .padding()
            .presentationDetents([.medium])
        }
    }
}

// MARK: - Shared UI Components

private struct FilterPill: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.subheadline)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(isSelected ? Color.accentColor : Color(.secondarySystemBackground))
                .foregroundStyle(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

struct StatusBadge: View {
    let status: Locker.LockerStatus

    var body: some View {
        Text(status.rawValue)
            .font(.caption2.bold())
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(status.color.opacity(0.15))
            .foregroundStyle(status.color)
            .cornerRadius(8)
    }
}

private struct DetailStat: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.subheadline.bold())

            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct FeatureRow: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .foregroundStyle(color)
                .frame(width: 28)

            Text(text)

            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
    }
}

extension Locker.LockerStatus {
    var color: Color {
        switch self {
        case .available:
            return .green
        case .inUse:
            return .red
        case .reserved:
            return .orange
        }
    }
}
