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
    var backImageName: String = "Palms"

    var body: some View {
        ZStack {
            // CARD BASE
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(borderColor, lineWidth: 4)
                )
            
            // Inner border - only visible when face down
            if !isFaceUp {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color(hex: "D4AF37"), // Shiny gold
                                Color(hex: "F4E5B0"), // Light gold
                                Color(hex: "D4AF37")  // Shiny gold
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 3
                    )
                    .padding(8) // Creates space between outer and inner border
            }

            // BACK SIDE
            if !isFaceUp {
                Image(backImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 90, maxHeight: 90)
                    .opacity(0.9)
            }

            // FRONT SIDE
            if isFaceUp {
                VStack {
                    Spacer() // Push content down

                    VStack(spacing: 12) {
                        if let imageName = imageName {
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                                // <-- Make Date image smaller
                                .frame(maxHeight: imageName == "Date" ? 65 : 120)
                        }

                        if let text = text {
                            Text(text)
                                .foregroundStyle(Color(hex: "7A4A2E"))
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 8)
                        }
                    }
                    Spacer() // Push content up
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

        CardView(text: nil, imageName: "Date", isFaceUp: true) // smaller image
            .frame(width: 120)
    }
    .padding()
}
