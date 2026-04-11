//
//  LockerMapView.swift
//  SwiftUIDesign
//
//  Created by Gurnoor Khurana
//
//  Map view showing all lockers on campus, color-coded by availability.
//

import SwiftUI
import MapKit

// MARK: - Locker Map View

struct LockerMapView: View {
    let lockers: [Locker] = SampleData.lockers

    @State private var selectedLocker: Locker? = nil
    @State private var selectedFilter: Locker.LockerStatus? = nil

    private var visibleLockers: [Locker] {
        guard let filter = selectedFilter else { return lockers }
        return lockers.filter { $0.status == filter }
    }

    // Center on the cluster of lockers
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 43.65037, longitude: -79.37070),
            span: MKCoordinateSpan(latitudeDelta: 0.0025, longitudeDelta: 0.0025)
        )
    )

    var body: some View {
        VStack(spacing: 0) {
            // Status filter bar
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    MapFilterPill(label: "All",
                                  color: .blue,
                                  isSelected: selectedFilter == nil) {
                        selectedFilter = nil
                    }
                    MapFilterPill(label: "Available",
                                  color: .green,
                                  isSelected: selectedFilter == .available) {
                        selectedFilter = selectedFilter == .available ? nil : .available
                    }
                    MapFilterPill(label: "In Use",
                                  color: .red,
                                  isSelected: selectedFilter == .inUse) {
                        selectedFilter = selectedFilter == .inUse ? nil : .inUse
                    }
                    MapFilterPill(label: "Reserved",
                                  color: .orange,
                                  isSelected: selectedFilter == .reserved) {
                        selectedFilter = selectedFilter == .reserved ? nil : .reserved
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            .background(Color(.systemGroupedBackground))

            // Map
            Map(position: $cameraPosition) {
                ForEach(visibleLockers) { locker in
                    Annotation(
                        "Locker \(locker.id)",
                        coordinate: CLLocationCoordinate2D(
                            latitude: locker.latitude,
                            longitude: locker.longitude
                        )
                    ) {
                        LockerMapPin(locker: locker, isSelected: selectedLocker?.id == locker.id)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.3)) {
                                    selectedLocker = selectedLocker?.id == locker.id ? nil : locker
                                }
                            }
                    }
                }
            }
            .mapStyle(.standard(elevation: .realistic))
        }
        .navigationTitle("Locker Map")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("\(visibleLockers.filter { $0.status == .available }.count) available")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        // Detail sheet when a locker is tapped
        .sheet(item: $selectedLocker) { locker in
            LockerMapDetailSheet(locker: locker)
        }
    }
}

// MARK: - Map Pin

private struct LockerMapPin: View {
    let locker: Locker
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .fill(locker.status.color)
                    .frame(width: isSelected ? 44 : 32, height: isSelected ? 44 : 32)
                    .shadow(color: locker.status.color.opacity(0.4), radius: isSelected ? 8 : 4)

                Image(systemName: pinIcon)
                    .font(.system(size: isSelected ? 18 : 14, weight: .semibold))
                    .foregroundStyle(.white)
            }

            // Callout label when selected
            if isSelected {
                Text(locker.id)
                    .font(.caption2.bold())
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(.white)
                    .cornerRadius(6)
                    .shadow(radius: 2)
            }
        }
        .animation(.spring(response: 0.3), value: isSelected)
    }

    private var pinIcon: String {
        switch locker.status {
        case .available: return "lock.open.fill"
        case .inUse:     return "lock.fill"
        case .reserved:  return "clock.fill"
        }
    }
}

// MARK: - Map Detail Sheet

private struct LockerMapDetailSheet: View {
    let locker: Locker
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Status header
                HStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(locker.status.color.opacity(0.15))
                            .frame(width: 64, height: 64)
                        Image(systemName: locker.status == .available ? "lock.open.fill" : "lock.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(locker.status.color)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Locker \(locker.id)")
                            .font(.title2).bold()
                        StatusBadge(status: locker.status)
                    }
                    Spacer()
                }
                .padding(.horizontal)

                // Info grid
                VStack(spacing: 0) {
                    MapDetailRow(icon: "building.2",      label: "Floor",    value: locker.floor)
                    Divider().padding(.leading, 52)
                    MapDetailRow(icon: "square.resize",   label: "Size",     value: locker.size.rawValue)
                    Divider().padding(.leading, 52)
                    MapDetailRow(icon: "dollarsign.circle", label: "Rate",   value: "$\(locker.hourlyRate, specifier: "%.2f")/hr")
                    Divider().padding(.leading, 52)
                    MapDetailRow(icon: "location.fill",   label: "Coordinates",
                                 value: String(format: "%.5f, %.5f", locker.latitude, locker.longitude))
                }
                .background(Color(.secondarySystemBackground))
                .cornerRadius(14)
                .padding(.horizontal)

                if locker.status == .available {
                    NavigationLink(destination: LockerDetailView(locker: locker)) {
                        Label("View & Rent This Locker", systemImage: "lock.open.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundStyle(.white)
                            .cornerRadius(14)
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.top, 20)
            .navigationTitle("Locker Info")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

// MARK: - Map Detail Row

private struct MapDetailRow: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .foregroundStyle(.secondary)
                .frame(width: 28)
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundStyle(.primary)
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
    }
}

// MARK: - Map Filter Pill

private struct MapFilterPill: View {
    let label: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
                Text(label)
                    .font(.subheadline)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 6)
            .background(isSelected ? color.opacity(0.15) : Color(.secondarySystemBackground))
            .foregroundStyle(isSelected ? color : .primary)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? color : .clear, lineWidth: 1.5)
            )
            .cornerRadius(20)
        }
    }
}
