//
//  name.swift
//  SaudiCulture
//
//  Created by Haya almousa on 03/02/2026.
//

import SwiftUI

struct Name: View {
    @State private var name: String = ""
    @State private var navigateToWelcome = false
    
    private var isNameValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("اكتب اسمك هنا", text: $name)
                    .font(.custom("Saudi-Regular", size: 28))
                    .foregroundStyle(Color("brown"))
                    .multilineTextAlignment(.center)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(Color("brown").opacity(0.5))
                    .padding(.horizontal, 48)
                
                Button("التالي") {
                    navigateToWelcome = true
                }
                .font(.custom("Saudi-Regular", size: 20))
                .padding(.horizontal, 40)
                .padding(.vertical, 12)
                .background(Color("brown"))
                .foregroundStyle(.white)
                .clipShape(Capsule())
                .disabled(!isNameValid)
                .opacity(isNameValid ? 1 : 0.4)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundMain"))
            .ignoresSafeArea()
            .navigationDestination(isPresented: $navigateToWelcome) {
                مرحباالجنوبيه(playerName: name)
            }
        }
    }
}

#Preview {
    Name()
}
