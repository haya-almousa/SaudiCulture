//
//  مرحبا الوسطى.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

import SwiftUI

struct مرحباالوسطى: View {
    let playerName: String
    let selectedCharacter: String
    
    private let fontName = "Saudi-Regular"
    private let figmaW: CGFloat = 390
    private let figmaH: CGFloat = 844
    private let btnX: CGFloat = 63
    private let btnY: CGFloat = 570
    private let btnW: CGFloat = 254
    private let btnH: CGFloat = 94
    private let titleCenterX: CGFloat = 195
    private let titleCenterY: CGFloat = 300
    
    @State private var navigateToMap = false  // ✅ غيرت الاسم
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let sx = geo.size.width / figmaW
                let sy = geo.size.height / figmaH
                let s  = min(sx, sy)
                
                ZStack {
                    Image("الوسطى")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    Text("مرحباً \(playerName)")
                        .font(.custom(fontName, size: 50 * s))
                        .foregroundColor(Color("brown"))
                        .position(x: titleCenterX * sx, y: titleCenterY * sy)
                    
                    Button(action: {
                        navigateToMap = true  // ✅ روح للخريطة
                    }) {
                        ZStack {
                            Capsule()
                                .fill(Color("brown"))
                                .frame(width: 260, height: 75)
                            
                            Text("ابدأ اللعبة")
                                .font(.custom(fontName, size: 50 * s))
                                .foregroundColor(.white)
                                .baselineOffset(-4 * sy)
                        }
                        .frame(width: btnW * sx, height: btnH * sy)
                    }
                    .buttonStyle(.plain)
                    .position(
                        x: (btnX + btnW/2) * sx,
                        y: (btnY + btnH/2) * sy
                    )
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $navigateToMap) {
                SaudiMapView()  // ✅ روح للخريطة زي باقي المناطق
            }
        }
    }
}

#Preview {
    NavigationStack {
        مرحباالوسطى(playerName: "هيا", selectedCharacter: "نجديه")
    }
}
