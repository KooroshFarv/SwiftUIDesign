//
//  LoginView.swift
//  SwiftUIDesign
//
//  Created by Home on 2026-03-15.
//

import SwiftUI

struct LoginView: View {
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

            Text("Login")
                .font(AppFonts.heading)
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
                if email.trimmingCharacters(in: .whitespaces).isEmpty ||
                    password.trimmingCharacters(in: .whitespaces).isEmpty {
                    showAlert = true
                } else {
                    let name = email.components(separatedBy: "@").first ?? "User"
                    store.login(name: name)
                    navigateHome = true
                }
            }) {
                AppButtons.primary("Sign In")
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
        .alert("Please enter email and password", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}
