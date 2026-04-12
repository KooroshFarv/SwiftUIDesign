//
//  RegisterView.swift
//  SwiftUIDesign
//
//  Created by Home on 2026-03-15.
//

import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var navigateHome = false
    @State private var showAlert = false

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: LockerStore

    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.cyan)
                    Text("Back")
                        .foregroundColor(.cyan)
                }
                Spacer()
            }
            .padding(.horizontal)

            Text("Sign Up")
                .font(AppFonts.heading)
                .foregroundColor(.white)

            TextField("Name", text: $name)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .foregroundColor(.white)

            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .foregroundColor(.white)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .foregroundColor(.white)

            Button(action: {
                if name.trimmingCharacters(in: .whitespaces).isEmpty ||
                    email.trimmingCharacters(in: .whitespaces).isEmpty ||
                    password.trimmingCharacters(in: .whitespaces).isEmpty {
                    showAlert = true
                } else {
                    store.register(name: name)
                    navigateHome = true
                }
            }) {
                AppButtons.primary("Create Account")
            }
            .padding(.horizontal)

            NavigationLink("", destination: LockerListView(), isActive: $navigateHome)
                .hidden()

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background.ignoresSafeArea())
        .navigationBarHidden(true)
        .alert("Please complete all fields", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}
