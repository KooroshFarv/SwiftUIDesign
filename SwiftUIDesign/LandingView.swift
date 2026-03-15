//
//  LandingView.swift
//  SwiftUIDesign
//
//  Created by Home on 2026-03-15.
//
import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Text("Welcome to GMJK Lockers!")
                    .font(AppFonts.title)
                    .multilineTextAlignment(.center)
                    .padding(.top, 60)
                
                NavigationLink(destination: LoginView()) {
                    AppButtons.primary("Login")
                        .padding(.horizontal)
                }
                
                HStack {
                    Text("Don't have an account?")
                        .font(AppFonts.body)
                    NavigationLink(destination: RegisterView()) {
                        AppButtons.secondary("Sign Up")
                    }
                }
                
                Spacer()
            }
            .background(AppColors.background.ignoresSafeArea())
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}
