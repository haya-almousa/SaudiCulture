//
//  LEVEL.swift
//  SaudiCulture
//
//  Created by Wed Ahmed Alasiri on 22/08/1447 AH.
//


import SwiftUI

struct StackedCirclesView: View {
    
    let totalLevels = 5
    @State private var unlockedLevel = 0
    @Environment(\.dismiss) var dismiss
    @StateObject private var gameProgress = GameProgress.shared
    @State private var navigateToFashion = false
    var body: some View {
        NavigationStack {
        ZStack {
            
            Image("الوسطى")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            ZStack {
                
                // المراحل
                ForEach(0..<totalLevels, id: \.self) { index in
                    
                    Image(index <= unlockedLevel ? "yellowCircle" : "grayCircle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: index == 0 ? 110 : 90)
                        .offset(y: yPosition(for: index))
                    
                    // نخلي الضغط فقط على المرحلة المفتوحة الحالية
                        .onTapGesture {
                            if index == unlockedLevel {
//                                nextLevel()
                                navigateToFashion = true
                            }
                        }
                }
                
                // الشخصية
                Image("netImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70)
                    .offset(y: yPosition(for: unlockedLevel))
                    .animation(
                        .spring(response: 0.6, dampingFraction: 0.7),
                        value: unlockedLevel
                    )
                    .offset(y: -40)
                
            }
            .offset(y: 60)
            
        }
        
        .navigationDestination(isPresented: $navigateToFashion) {
                        الوسطى()
                    }
//        .onTapGesture {
//            nextLevel()
//        }
    }
    }
    
    // تحريك المراحل عموديًا
    func yPosition(for index: Int) -> CGFloat {
        let spacing: CGFloat = 110
        let startFromBottom: CGFloat = 200 // تحكم بمكان البداية من تحت
        return startFromBottom - CGFloat(index) * spacing
    }

    
    // فتح مرحلة جديدة
//    func nextLevel() {
//        if unlockedLevel < totalLevels - 1 {
//            unlockedLevel += 1
//        }
//    }
    func nextLevel() {
        if unlockedLevel < totalLevels - 1 {
            unlockedLevel += 1
        } else {
            // آخر مرحلة انخلّصت ✅
            gameProgress.completeRegion(.central)
            dismiss() // يرجع للخريطة
        }
    }


}
#Preview {
    StackedCirclesView()
}
