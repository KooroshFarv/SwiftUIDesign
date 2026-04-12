//
//  SwiftUIDesignApp.swift
//  SwiftUIDesign
//
//  Created by Koorosh Farvardin on 2026-02-08.
//

import SwiftUI

@main
struct SwiftUIDesignApp: App {
    @StateObject private var store = LockerStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
