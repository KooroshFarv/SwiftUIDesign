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
            VStack(spacing: 60) {
                Text("Welcome to GMJK Lockers!")
                    .font(AppFonts.title)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 80)

                NavigationLink(destination: LoginView()) {
                    AppButtons.primary("Login")
                        .padding(.horizontal)
                }

                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.white)
                    NavigationLink(destination: RegisterView()) {
                        Text("Sign Up")
                            .bold()
                            .foregroundColor(.cyan)
                    }
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColors.background.ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
}
