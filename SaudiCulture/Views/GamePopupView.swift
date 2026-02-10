//
//  GamePopupView.swift
//  SaudiCulture
//
//  Created by Rawan Algarny on 22/08/1447 AH.
//

import SwiftUI

enum GamePopupType {
    case win
    case timeUp
}

struct GamePopupView: View {
    
    let type: GamePopupType
    let onClose: () -> Void
    let onPrimaryAction: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // Close button (only for time-up)
                if type == .timeUp {
                    HStack {
                        Button(action: onClose) {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .padding()
                                .font(.system(size: 22, weight: .bold))
                        }
                        Spacer()
                    }
                }
                
                Text(title)
                    .font(.custom("Saudi-Bold", size: 28))
                    .foregroundColor(.white)
                
                Text(message)
                    .font(.custom("Saudi-Bold", size: 28))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                
                if let onPrimaryAction {
                    Button(action: onPrimaryAction) {
                        Text(buttonText)
                            .font(.custom("Saudi-Bold", size: 28))
                            .foregroundColor(Color(hex: "731112"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "FFEFD8"))
                            .cornerRadius(16)
                            .padding(.horizontal, 40)
                    }
                }
            }
            .padding()
            .background(Color(hex: "731112").opacity(0.85))
            .cornerRadius(24)
            .shadow(radius: 10)
            .frame(
                width: UIScreen.main.bounds.width * 0.85,
                height: UIScreen.main.bounds.height * 0.85
            )
            .transition(.scale.combined(with: .opacity))
        }
    }
    
    // MARK: - Content
    private var title: String {
        switch type {
        case .win:
            return "مبروك !"
        case .timeUp:
            return "انتهت اللعبه"
        }
    }
    
    private var message: String {
        switch type {
        case .win:
            return "لقد نجحت في مطابقة جميع الكروت!"
        case .timeUp:
            return "العوض بالجايات"
        }
    }
    
    private var buttonText: String {
        "يلا على اللعبه الي بعدها !"
    }
}


