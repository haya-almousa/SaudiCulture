////
////  GamePopupView.swift
////  SaudiCulture
////
////  Created by Rawan Algarny on 22/08/1447 AH.
////
//
//import SwiftUI
//
//enum GamePopupType {
//    case win
//    case timeUp
//}
//
//struct GamePopupView: View {
//    
//    let type: GamePopupType
//    let onClose: () -> Void
//    let onPrimaryAction: (() -> Void)?
//    
//    var body: some View {
//        ZStack {
//            // 1️⃣ Blur the background cards when popup appears
////    VisualEffectBlur(blurStyle: .systemThinMaterial) // NEW
////                            .edgesIgnoringSafeArea(.all)///
////            ///
////            Color.black.opacity(0.4)
////                .ignoresSafeArea()
////                      
//            
//            VStack(spacing: 20) {
//                
//                // Close button (only for time-up)
//                if type == .timeUp {
//                    HStack {
//                        Button(action: onClose) {
//                            Image(systemName: "xmark")
//                                .foregroundColor(.white)
//                                .padding()
//                                .font(.system(size: 22, weight: .bold))
//                        }
//                        Spacer()
//                    }
//                }
//                
//                Text(title)
//                    .font(.custom("Saudi-Bold", size: 28))
//                    .foregroundColor(.white)
//                
//                Text(message)
//                    .font(.custom("Saudi-Bold", size: 28))
//                    .multilineTextAlignment(.center)
//                    .foregroundColor(.white)
//                    .padding(.horizontal, 16)
//                
////                if let onPrimaryAction {
////                    Button(action: onPrimaryAction) {
////                        Text(buttonText)
////                            .font(.custom("Saudi-Bold", size: 28))
////                            .foregroundColor(Color(hex: "731112"))
////                            .padding()
////                            .frame(maxWidth: .infinity)
////                            .background(Color(hex: "FFEFD8"))
////                            .cornerRadius(16)
////                            .padding(.horizontal, 40)
////                    }
////                }
//                if let onPrimaryAction {
//                    Button(action: onPrimaryAction) {
//                        ZStack {
//                            Capsule()
//                                .fill(Color("brown"))                   // background color
//                                .frame(width: 300, height: 80)          // bigger fixed size
//                            
//                            Text(buttonText)
//                                .font(.custom("Saudi-Bold", size: 24)) // font size
//                                .foregroundColor(.white)
//                        }
//                    }
//                    .buttonStyle(.plain)
//                }///button
//
//
//            }
//            .padding()
//           // .background(Color(hex: "731112").opacity(0.85))
//            .background(Color(hex: "FFE5C4").opacity(0.95)) // 2️⃣ Updated color
//            .shadow(color: .black.opacity(0.6), radius: 15, x: 0, y: 5) // 3️⃣ Shadow added
//
//
//           .cornerRadius(24)
//            //.shadow(radius: 10)
////            .frame(
////                width: UIScreen.main.bounds.width * 0.85,
////                height: UIScreen.main.bounds.height * 0.85
////            )
//            .frame(
//                  width: UIScreen.main.bounds.width * 0.9,  // 4️⃣ Bigger width
//                  height: UIScreen.main.bounds.height * 0.6 // 4️⃣ Bigger height, closer to card size
//                        )
//            .transition(.scale.combined(with: .opacity))
//        }
//    }
//    
//    // MARK: - Content
//    private var title: String {
//        switch type {
//        case .win:
//            return "مبروك !"
//        case .timeUp:
//            return "انتهت اللعبه"
//        }
//    }
//    
//    
//    
//    
//    private var message: String {
//        switch type {
//        case .win:
//            return "لقد نجحت في مطابقة جميع الكروت!"
//            //return ""
//        case .timeUp:
//            return "العوض بالجايات"
//        }
//  }
////    private var message: String {
////        type == .timeUp ? "العوض بالجايات" : ""
////    }
////    
//    
//    
//    private var buttonText: String {
//        "يلا على اللعبه الي بعدها !"
//    }
//}
//
//
//// 1️⃣ Blur helper view for SwiftUI
//// Only needed if you don't already have a VisualEffectBlur view in your project
//struct VisualEffectBlur: UIViewRepresentable {
//    var blurStyle: UIBlurEffect.Style
//
//    func makeUIView(context: Context) -> UIVisualEffectView {
//        UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
//    }
//
//    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
//}
//////
/////
//#Preview {
//    GamePopupView(
//        type: .win,                       // or .timeUp to test the other popup
//        onClose: { print("Popup closed") },
//        onPrimaryAction: { print("Primary action tapped") }
//    )
//}
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
            // Main Card Container
            VStack(spacing: 20) {
                
                // 1. Top Header (Close Button)
                HStack {
                    if type == .timeUp {
                        Button(action: onClose) {
                            Image(systemName: "xmark")
                                .foregroundColor(Color("brown"))
                                .font(.system(size: 22, weight: .bold))
                                .padding()
                        }
                    }
                    Spacer()
                }
                
                Spacer() // Pushes content to middle
                
                // 2. Text Content
                Text(title)
                    .font(.custom("Saudi-Bold", size: 34))
                    .foregroundColor(Color("brown"))
                
                Text(message)
                    .font(.custom("Saudi-Bold", size: 26))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("brown"))
                    .padding(.horizontal, 20)
                
                Spacer() // Pushes content to middle
                
                // 3. Action Button
                if let onPrimaryAction {
                    Button(action: onPrimaryAction) {
                        ZStack {
                            Capsule()
                                .fill(Color("brown"))
                                .frame(width: 280, height: 70)
                            
                            Text(buttonText)
                                .font(.custom("Saudi-Bold", size: 22))
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 40)
                }
            }
            .padding()
            .background(Color(hex: "FCF0DD")) // Light cream background
            .cornerRadius(30)
            .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
            .frame(
                width: UIScreen.main.bounds.width * 0.85,
                height: UIScreen.main.bounds.height * 0.55
            )
        }
    }
    
    // MARK: - Logic Properties
    private var title: String {
        switch type {
        case .win:
           // return "مبروك !"
            return "كفو عليك! "
        case .timeUp:
            return "خلصت اللعبة"
        }
    }
    
    private var message: String {
        switch type {
        case .win:
            //return "لقد نجحت في مطابقة جميع الكروت!"
            return  "خلّصت اللعبة وطابقتهم كلهم"
        case .timeUp:
            return "العوض بالجايات"
        }
    }
    
    private var buttonText: String {
        "يلا على اللعبة اللي بعدها !"
    }
}



#Preview {
    GamePopupView(
        type: .win,        // or .timeUp to test the other popup
        onClose: { print("Popup closed") },
        onPrimaryAction: { print("Primary action tapped") }
    )
}

