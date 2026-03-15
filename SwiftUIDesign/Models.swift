//
//  Models.swift
//  SwiftUIDesign
//
//  Created by Gurnoor Khurana
//

import Foundation

// MARK: - Locker Model

struct Locker: Identifiable {
    let id: String
    let size: LockerSize
    let floor: String
    let hourlyRate: Double
    var status: LockerStatus
    var currentUserName: String?
    var rentalEndsAt: Date?

    enum LockerSize: String {
        case small  = "Small"
        case medium = "Medium"
        case large  = "Large"
    }

    enum LockerStatus: String {
        case available = "Available"
        case inUse     = "In Use"
        case reserved  = "Reserved"
    }
}

// MARK: - Rental Model

struct Rental: Identifiable {
    let id: UUID
    let lockerID: String
    let startDate: Date
    let endDate: Date
    let totalPaid: Double
    let accessCode: String

    var duration: String {
        let hours = Calendar.current.dateComponents([.hour], from: startDate, to: endDate).hour ?? 0
        return hours == 1 ? "1 hour" : "\(hours) hours"
    }

    var formattedDate: String {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: startDate)
    }

    var timeRange: String {
        let f = DateFormatter()
        f.timeStyle = .short
        return "\(f.string(from: startDate)) – \(f.string(from: endDate))"
    }
}

// MARK: - Sample Data

struct SampleData {
    static let lockers: [Locker] = [
        Locker(id: "A-01", size: .small,  floor: "Ground Floor", hourlyRate: 2.00, status: .available),
        Locker(id: "A-02", size: .small,  floor: "Ground Floor", hourlyRate: 2.00, status: .inUse,
               currentUserName: "Alex T.", rentalEndsAt: Date().addingTimeInterval(3600)),
        Locker(id: "A-03", size: .medium, floor: "Ground Floor", hourlyRate: 3.50, status: .available),
        Locker(id: "B-01", size: .medium, floor: "Level 1",      hourlyRate: 3.50, status: .available),
        Locker(id: "B-02", size: .large,  floor: "Level 1",      hourlyRate: 5.00, status: .inUse,
               currentUserName: "Sam R.", rentalEndsAt: Date().addingTimeInterval(7200)),
        Locker(id: "B-03", size: .large,  floor: "Level 1",      hourlyRate: 5.00, status: .available),
        Locker(id: "B-11", size: .medium, floor: "Gym Floor",    hourlyRate: 3.00, status: .available),
        Locker(id: "C-01", size: .small,  floor: "Level 2",      hourlyRate: 2.00, status: .reserved),
        Locker(id: "C-02", size: .medium, floor: "Level 2",      hourlyRate: 3.50, status: .available),
        Locker(id: "C-03", size: .large,  floor: "Level 2",      hourlyRate: 5.00, status: .available),
    ]

    static let rentalHistory: [Rental] = [
        Rental(
            id: UUID(),
            lockerID: "B-11",
            startDate: Calendar.current.date(byAdding: .day, value: -3, to: Date())!,
            endDate:   Calendar.current.date(byAdding: .hour, value: -1,
                           to: Calendar.current.date(byAdding: .day, value: -3, to: Date())!.addingTimeInterval(7200))!,
            totalPaid: 6.00,
            accessCode: "482910"
        ),
        Rental(
            id: UUID(),
            lockerID: "A-01",
            startDate: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
            endDate:   Calendar.current.date(byAdding: .hour, value: 1,
                           to: Calendar.current.date(byAdding: .day, value: -10, to: Date())!)!,
            totalPaid: 2.00,
            accessCode: "137645"
        ),
        Rental(
            id: UUID(),
            lockerID: "C-02",
            startDate: Calendar.current.date(byAdding: .day, value: -20, to: Date())!,
            endDate:   Calendar.current.date(byAdding: .hour, value: 3,
                           to: Calendar.current.date(byAdding: .day, value: -20, to: Date())!)!,
            totalPaid: 10.50,
            accessCode: "920374"
        ),
    ]
}
