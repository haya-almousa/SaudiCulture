//
//  CardView.swift
//  SaudiCulture
//
//  Created by Rawan Algarny on 21/08/1447 AH.
//

import SwiftUI

struct CardView: View {
    var text: String?
    var imageName: String?
    var isFaceUp: Bool
    var borderColor: Color = Color(hex: "731112")
    var backImageName: String = "نخله"

    var body: some View {
        let isIPad = UIDevice.current.userInterfaceIdiom == .pad

        ZStack {
            RoundedRectangle(cornerRadius: isIPad ? 16 : 20)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: isIPad ? 16 : 20)
                        .stroke(borderColor, lineWidth: isIPad ? 3 : 4)
                )
            
            if !isFaceUp {
                RoundedRectangle(cornerRadius: isIPad ? 12 : 16)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color(hex: "D4AF37"),
                                Color(hex: "F4E5B0"),
                                Color(hex: "D4AF37")
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: isIPad ? 2 : 3
                    )
                    .padding(isIPad ? 6 : 8)
            }

            if !isFaceUp {
                Image(backImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        maxWidth: isIPad ? 145 : 90,
                        maxHeight: isIPad ? 145 : 90
                    )
                    .opacity(0.9)
            }

            if isFaceUp {
                VStack {
                    Spacer()

                    VStack(spacing: isIPad ? 6 : 12) {
                        if let imageName = imageName {
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: imageName == "Date" ? (isIPad ? 100 : 65) : (isIPad ? 175 : 120))
                        }

                        if let text = text {
                            Text(text)
                                .foregroundStyle(Color(hex: "7A4A2E"))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, isIPad ? 8 : 8)
                                .font(.custom("Saudi-Bold", size: isIPad ? 24 : 20))
                        }
                    }

                    Spacer()
                }
                .aspectRatio(0.6, contentMode: .fit)
            }
        }
        .aspectRatio(0.6, contentMode: .fit)
    }
}

#Preview {
    HStack(spacing: 12) {
        CardView(text: "ثوب\nشيلة", imageName: nil, isFaceUp: true)
            .frame(width: 120)

        CardView(text: nil, imageName: "NajdW", isFaceUp: true)
            .frame(width: 120)

        CardView(text: nil, imageName: "Date", isFaceUp: true)
            .frame(width: 120)
    }
    .padding()
}
