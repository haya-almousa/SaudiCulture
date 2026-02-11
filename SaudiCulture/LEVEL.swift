//
//  LEVEL.swift
//  SaudiCulture
//
//  Created by Wed Ahmed Alasiri on 22/08/1447 AH.
//


import SwiftUI

struct StackedCirclesView: View {
    
    let selectedCharacter: String  // ✅ استقبال الشخصية المختارة
        let region: RegionType   // ✅ جديد
    let totalLevels = 5
    @State private var unlockedLevel = 0
    @Environment(\.dismiss) var dismiss
    @StateObject private var gameProgress = GameProgress.shared
    @State private var navigateToFashion = false
    
    
    
    var backgroundImageName: String {
        switch region {
        case .central:
            return "الوسطى"
        case .northern:
            return "الشماليه"
        case .southern:
            return "الجنوبيه"
        case .eastern:
            return "الشرقيه"
        case .western:
            return "الغربيه"
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                
                Image(backgroundImageName)
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
                                    navigateToFashion = true
                                }
                            }
                    }
                    
                    // ✅ الشخصية المختارة (بدلنا "netImage" بالشخصية اللي اختارها)
                    Image(selectedCharacter)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 140)  // ✅ حجم أكبر
                        .offset(y: yPosition(for: unlockedLevel))
                        .animation(
                            .spring(response: 0.6, dampingFraction: 0.7),
                            value: unlockedLevel
                        )
                        .offset(y: -50)  // ✅ تعديل المكان
                    
                }
                .offset(y: 60)
                
            }
            
            .navigationDestination(isPresented: $navigateToFashion) {
                الوسطى()
            }
        }
    }
    
    // تحريك المراحل عموديًا
    func yPosition(for index: Int) -> CGFloat {
        let spacing: CGFloat = 110
        let startFromBottom: CGFloat = 200
        return startFromBottom - CGFloat(index) * spacing
    }
    
    func nextLevel() {
        if unlockedLevel < totalLevels - 1 {
            unlockedLevel += 1
        } else {
            gameProgress.completeRegion(.central)
            dismiss()
        }
    }
}

//#Preview {
//    NavigationStack {
//        StackedCirclesView(selectedCharacter: "نجديه")  // ✅ مؤقت للتجربة
//    }
//}

#Preview {
    NavigationStack {
        StackedCirclesView(
            selectedCharacter: "نجديه",
            region: .central
        )
    }
}
