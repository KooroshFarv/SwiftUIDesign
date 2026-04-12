//
//  LockerStore.swift
//  SwiftUIDesign
//
//  Created by Koorosh Farvardin on 2026-04-11.
//


import Foundation
import SwiftUI
import Combine

final class LockerStore: ObservableObject {
    @Published var lockers: [Locker]
    @Published var rentalHistory: [Rental]
    @Published var currentUserName: String = ""

    init(
        lockers: [Locker] = SampleData.lockers,
        rentalHistory: [Rental] = SampleData.rentalHistory,
        currentUserName: String = ""
    ) {
        self.lockers = lockers
        self.rentalHistory = rentalHistory
        self.currentUserName = currentUserName
    }

    func login(name: String) {
        currentUserName = name
    }

    func register(name: String) {
        currentUserName = name
    }

    func rentLocker(locker: Locker, hours: Int) -> Rental? {
        guard let index = lockers.firstIndex(where: { $0.id == locker.id }) else {
            return nil
        }

        guard lockers[index].status == .available else {
            return nil
        }

        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .hour, value: hours, to: startDate) ?? startDate
        let totalPaid = lockers[index].hourlyRate * Double(hours)
        let accessCode = String(format: "%06d", Int.random(in: 100000...999999))

        lockers[index].status = .inUse
        lockers[index].currentUserName = currentUserName.isEmpty ? "Guest User" : currentUserName
        lockers[index].rentalEndsAt = endDate

        let newRental = Rental(
            id: UUID(),
            lockerID: locker.id,
            startDate: startDate,
            endDate: endDate,
            totalPaid: totalPaid,
            accessCode: accessCode
        )

        rentalHistory.insert(newRental, at: 0)
        return newRental
    }

    func lockerByID(_ id: String) -> Locker? {
        lockers.first(where: { $0.id == id })
    }
}
