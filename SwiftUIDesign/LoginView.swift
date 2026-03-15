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
    @Environment(\.dismiss) var dismiss

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
            
            NavigationLink(destination: HomeView(), isActive: $navigateHome) {
                Button(action: { navigateHome = true }) {
                    AppButtons.primary("Sign In")
                }
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background.ignoresSafeArea())
        .navigationBarHidden(true)
    }
}
