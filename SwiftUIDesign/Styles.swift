//
//  Styles.swift
//  SwiftUIDesign
//
//  Created by Home on 2026-03-15.
//

import SwiftUI

struct AppColors {
    static let primary = Color.blue
    static let secondary = Color.gray.opacity(0.7)
    static let background = Color("Background")
}

struct AppFonts {
    static let title = Font.largeTitle.bold()
    static let heading = Font.title2.bold()
    static let body = Font.body
}

struct AppButtons {
    static func primary(_ text: String) -> some View {
        Text(text)
            .font(AppFonts.heading)
            .frame(maxWidth: .infinity)
            .padding()
            .background(AppColors.primary)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 3)
    }
    
    static func secondary(_ text: String) -> some View {
        Text(text)
            .bold()
            .foregroundColor(AppColors.primary)
    }
}
