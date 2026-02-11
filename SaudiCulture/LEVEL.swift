////
////  LEVEL.swift
////  SaudiCulture
////
////  Created by Wed Ahmed Alasiri on 22/08/1447 AH.
////
//
//
//import SwiftUI
//
//struct StackedCirclesView: View {
//    
//    let selectedCharacter: String  // ✅ استقبال الشخصية المختارة
//        let region: RegionType   // ✅ جديد
//    let totalLevels = 5
//    @State private var unlockedLevel = 0
//    @Environment(\.dismiss) var dismiss
//    @StateObject private var gameProgress = GameProgress.shared
//    @State private var navigateToFashion = false
//    @State private var selectedLevel: Int? = nil // المرحلة المختارة للغز
//
//    
//    
//    var backgroundImageName: String {
//        switch region {
//        case .central:
//            return "الوسطى"
//        case .northern:
//            return "الشماليه"
//        case .southern:
//            return "الجنوبيه"
//        case .eastern:
//            return "الشرقيه"
//        case .western:
//            return "الغربيه"
//        }
//    }
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                
//                Image(backgroundImageName)
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//                
//                ZStack {
//                    
//                    // المراحل
//                    ForEach(0..<totalLevels, id: \.self) { index in
//                        
//                        Image(index <= unlockedLevel ? "yellowCircle" : "grayCircle")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: index == 0 ? 110 : 90)
//                            .offset(y: yPosition(for: index))
//                        
//                        // نخلي الضغط فقط على المرحلة المفتوحة الحالية
//                            .onTapGesture {
//                                if index == unlockedLevel {
//                                    selectedLevel = index // تخزين المرحلة المختارة
//                                }
//                            }
//
//                    }
//                    
//                    
//                    
//                    // ✅ الشخصية المختارة (بدلنا "netImage" بالشخصية اللي اختارها)
//                    Image(selectedCharacter)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 100, height: 140)  // ✅ حجم أكبر
//                        .offset(y: yPosition(for: unlockedLevel))
//                        .animation(
//                            .spring(response: 0.6, dampingFraction: 0.7),
//                            value: unlockedLevel
//                        )
//                        .offset(y: -70)  // ✅ تعديل المكان
//                    
//                    
//                    
//                }
//                .offset(y: 60)
//                
//            }
//            
//            .navigationDestination(isPresented: $navigateToFashion) {
//                الوسطى()
//            }
//        }
//    }
//    
//    // تحريك المراحل عموديًا
//    func yPosition(for index: Int) -> CGFloat {
//        let spacing: CGFloat = 110
//        let startFromBottom: CGFloat = 200
//        return startFromBottom - CGFloat(index) * spacing
//    }
//    
//    func nextLevel() {
//        if unlockedLevel < totalLevels - 1 {
//            unlockedLevel += 1
//        } else {
//            gameProgress.completeRegion(.central)
//            dismiss()
//        }
//    }
//}
//
////#Preview {
////    NavigationStack {
////        StackedCirclesView(selectedCharacter: "نجديه")  // ✅ مؤقت للتجربة
////    }
////}
//
//#Preview {
//    NavigationStack {
//        StackedCirclesView(
//            selectedCharacter: "نجديه",
//            region: .central
//        )
//    }
//}


//import SwiftUI
//
//struct StackedCirclesView: View {
//
//    let selectedCharacter: String
//    let region: RegionType
//
//    let totalLevels = 5
//    @State private var unlockedLevel = 0
//
//    @Environment(\.dismiss) var dismiss
//    @StateObject private var gameProgress = GameProgress.shared
//
//    @State private var selectedLevel: Int? = nil   // ✅ هذا اللي بيشغل التنقل
//
//    var backgroundImageName: String {
//        switch region {
//        case .central:  return "الوسطى"
//        case .northern: return "الشماليه"
//        case .southern: return "الجنوبيه"
//        case .eastern:  return "الشرقيه"
//        case .western:  return "الغربيه"
//        }
//    }
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//
//                Image(backgroundImageName)
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//
//                ZStack {
//
//                    // المراحل
//                    ForEach(0..<totalLevels, id: \.self) { index in
//                        let isYellow = (index <= unlockedLevel)
//                        let size: CGFloat = (index == 0 ? 110 : 90)
//
//                        ZStack {
//                            Image(isYellow ? "yellowCircle" : "grayCircle")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: size, height: size)
//
//                            // ✅ طبقة ضغط مضمونة
//                            Button {
//                                guard isYellow else { return }   // فقط الصفراء
//                                selectedLevel = index            // ✅ يفعّل التنقل مباشرة
//                            } label: {
//                                Color.clear
//                                    .frame(width: size, height: size)
//                                    .contentShape(Circle())      // ✅ منطقة لمس دائرية
//                            }
//                            .buttonStyle(.plain)
//                        }
//                        .offset(y: yPosition(for: index))       // ✅ الـ offset على الكونتينر كله
//                        .zIndex(10)                              // ✅ فوق أي طبقات ثانية
//                    }
//
//                    // الشخصية
//                    Image(selectedCharacter)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 100, height: 140)
//                        .offset(y: yPosition(for: unlockedLevel))
//                        .animation(.spring(response: 0.6, dampingFraction: 0.7),
//                                   value: unlockedLevel)
//                        .offset(y: -70)
//                        .allowsHitTesting(false)                 // ✅ لا تمنع لمس الدوائر
//                }
//                .offset(y: 60)
//            }
//
//            // ✅ التنقل عند اختيار مرحلة
//            .navigationDestination(item: $selectedLevel) { _ in
//                الوسطى()
//            }
//        }
//    }
//
//    func yPosition(for index: Int) -> CGFloat {
//        let spacing: CGFloat = 110
//        let startFromBottom: CGFloat = 200
//        return startFromBottom - CGFloat(index) * spacing
//    }
//
//    func nextLevel() {
//        if unlockedLevel < totalLevels - 1 {
//            unlockedLevel += 1
//        } else {
//            gameProgress.completeRegion(.central)
//            dismiss()
//        }
//    }
//}
import SwiftUI

struct StackedCirclesView: View {
    let selectedCharacter: String
    let region: RegionType
    let totalLevels = 5
    @StateObject var flow = LevelFlow.shared
    @Environment(\.dismiss) var dismiss
    @StateObject private var gameProgress = GameProgress.shared
    @State private var navigateToFashion = false

    var current: Int {
        flow.currentLevel(for: region)
    }

    var backgroundImageName: String {
        switch region {
        case .central:  return "الوسطى"
        case .northern: return "الشماليه"
        case .southern: return "الجنوبيه"
        case .eastern:  return "الشرقيه"
        case .western:  return "الغربيه"
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
                    ForEach(0..<totalLevels, id: \.self) { index in
                        Image(index <= current ? "yellowCircle" : "grayCircle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: index == 0 ? 110 : 90)
                            .offset(y: yPosition(for: index))
                            .onTapGesture {
                                if index == current {
                                    navigateToFashion = true
                                }
                            }
                    }

                    Image(selectedCharacter)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 140)
                        .offset(y: yPosition(for: current) - 70) // استخدم current هنا
                        .animation(.spring(), value: current)
                        .allowsHitTesting(false)
                }
                .offset(y: 60)
            }
            .navigationDestination(isPresented: $navigateToFashion) {
                PuzzleView(region: region)
            }
        }
    }

    func yPosition(for index: Int) -> CGFloat {
        let spacing: CGFloat = 110
        let startFromBottom: CGFloat = 200
        return startFromBottom - CGFloat(index) * spacing
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

//#Preview {
//    NavigationStack {
//        StackedCirclesView(
//            selectedCharacter: "نجديه",
//            region: .central
//        )
//    }
//}
