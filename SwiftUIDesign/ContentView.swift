//
//  ContentView.swift
//  SwiftUIDesign
//
//  Created by Koorosh Farvardin on 2026-02-08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandingView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
                Section("Other") {
                    NavigationLink("History") { HistoryView() }
                    NavigationLink("Settings") { SettingsView() }
                }

                Section("Gurnoor — Customer Screens") {
                    NavigationLink("Locker List") { LockerListView() }
                    NavigationLink("Rental History") { RentalHistoryView() }
                }
            }
            .navigationTitle("Screens")
        }
    }
}
