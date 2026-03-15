//
//  Styles.swift
//  SwiftUIDesign
//
//  Created by Home on 2026-03-15.
//

import SwiftUI

struct AppColors {
    static let background = Color(.darkGray)
    static let secondary = Color(.lightGray)
    static let primaryButton = Color.cyan
    static let secondaryButton = Color.gray.opacity(0.7)
    static let destructiveButton = Color.red
}

struct AppFonts {
    static let title = Font.largeTitle.bold()
    static let heading = Font.title2.bold()
    static let body = Font.body
}

struct AppButtons {
    static func primary(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppColors.primaryButton)
            .cornerRadius(10)
    }
    
    static func secondary(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppColors.secondaryButton)
            .cornerRadius(10)
    }
    
    static func destructive(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppColors.destructiveButton)
            .cornerRadius(10)
    }
}
