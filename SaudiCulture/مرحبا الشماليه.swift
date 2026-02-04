//
//  مرحبا الشماليه.swift
//  SaudiCulture
//
//  Created by danah alsadan on 16/08/1447 AH.
//

import SwiftUI

struct مرحباالشماليه: View {
    // ✅ الخط (لازم يكون PostScript Name عشان يطلع نفس فيقما)
    private let fontName = "Saudi-Regular"
    
    // ✅ مقاس تصميم فيقما (غالبًا 390x844)
    private let figmaW: CGFloat = 390
    private let figmaH: CGFloat = 844
    
    // ✅ قياسات زر "ابدأ اللعبة" من فيقما
    private let btnX: CGFloat = 63
    private let btnY: CGFloat = 570
    private let btnW: CGFloat = 254
    private let btnH: CGFloat = 94
    
    // ✅ مكان العنوان (عدليه لو عندك X/Y من فيقما)
    private let titleCenterX: CGFloat = 195
    private let titleCenterY: CGFloat = 300
    
    var body: some View {
        GeometryReader { geo in
            let sx = geo.size.width / figmaW
            let sy = geo.size.height / figmaH
            let s  = min(sx, sy)
            
            ZStack {
                // ✅ الخلفية (صورة مدموجة)
                Image("الشماليه")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // ✅ عنوان "مرحباً هيا"
                Text("مرحباً هيا")
                    .font(.custom(fontName, size: 50 * s))
                    .foregroundColor(Color("brown"))
                    .position(x: titleCenterX * sx, y: titleCenterY * sy)
                
                // ✅ زر "ابدأ اللعبة" (W/H/X/Y مثل فيقما)
                Button(action: {
                    startGame()
                }) {
                    ZStack {
                        Capsule()
                            .fill(Color("brown"))
                            .frame(width: btnW * sx, height: btnH * sy)
                        
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
    }
    
    func startGame() {
        print("اللعبة بدأت!")
        // هنا يمكنك إضافة الكود الخاص ببداية اللعبة
    }
}

#Preview {
    مرحباالشماليه()
}
