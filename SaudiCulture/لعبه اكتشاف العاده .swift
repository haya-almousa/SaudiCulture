////
////  فك الشفره .swift
////  SaudiCulture
////
////  Created by Wed Ahmed Alasiri on 15/08/1447 AH.
////
//
////import SwiftUI
//
//  ❤️no touch plz
////
////struct PuzzleView2: View {
////    @State private var answer: String = ""
////    @State private var showText = false
////    @State private var showPopup = false
////    
////    @State private var shakeOffset: CGFloat = 0
////    
////    
////    
////    var body: some View {
////        ZStack {
////            Image("background")
////                .resizable()
////                .scaledToFit()
////                .frame(maxWidth: .infinity)
////                .ignoresSafeArea()
////
////
////
////            VStack {
////                // Header
////                HStack {
////                    Spacer()
////                    Button(action: {}) {
////                        Text("انهاء اللعبه ")
////                            .font(.custom("Saudi-Regular", size: 14))
////
////                            .foregroundColor(Color(hex: "FCF0DD"))
////                            .padding(.horizontal, 20)
////                            .padding(.vertical, 8)
////                            .background(Color(hex: "874F35"))
////                            .cornerRadius(25)
////
////                    }
////                }
////                .padding()
////
////                // الكرت
////                VStack(spacing: 10) {
////
////
////
////                    Text("اكتشف العاده ")
////                        .font(.custom("Saudi-Regular", size: 25))
////                        .foregroundColor(Color(hex: "874F35"))
////                        .padding(.bottom, 20)
////                        .offset(x: 0 , y: -10)
////
////
////                    HStack(spacing: 20) {
////                        Text("اجعل الفنجال يتحرك  ")
////                    }
////                    .font(.custom("Saudi-Regular", size: 30))
////                    .foregroundColor(Color(hex: "874F35"))
////                    .offset(x: 0 , y: 10 )
////
//////
//////                    Image("الفنجال ")
//////                                .resizable()
//////                                .scaledToFit()
//////                                .frame(width: 300, height: 300)
//////                                .offset(x: 0 , y: 80)
////
////                    Image("الفنجال ")
////                                            .resizable()
////                                            .scaledToFit()
////                                            .frame(width: 300, height: 300)
////                                            .offset(x: shakeOffset, y: 80) // ربط الـ offset بمتغير الاهتزاز
////                                            .animation(.default, value: shakeOffset)
////
////                    HStack {
////                        Button(action: {
////                            withAnimation(.easeInOut) {
////                                showPopup = true
////                            }
////                        }) {
////                            Image(systemName: "questionmark")
////                                .font(.system(size: 22))
////                                .foregroundColor(.white)
////                                .padding(16)
////                                .background(Color(hex: "874F35"))
////                                .clipShape(Circle())
////                        }
////
////                        Spacer()
////                    }
////                    .padding(.leading, 20)
////
////
////
//////                    if showPopup {
//////                            // محتوى البوب أب
//////                            ZStack() {
//////                                VStack(spacing: 20){
//////                                    Text("هز الجوال")
//////                                        .font(.custom("Saudi-Regular", size: 22))
//////                                        .foregroundColor(Color(hex: "FCF0DD"))
//////
//////                                    Text("هز الجهاز لمعرفة المعلومة")
//////                                        .font(.custom("Saudi-Regular", size: 16))
//////                                        .foregroundColor(Color(hex: "FCF0DD"))
//////
//////                                    Button("إغلاق") {
//////                                        withAnimation {
//////                                            showPopup = false
//////                                        }
//////                                    }
//////                                    .padding(.horizontal, 30)
//////                                    .padding(.vertical, 10)
//////                                    .background(Color(hex: "FCF0DD"))
//////                                    .foregroundColor(Color(hex: "874F35"))
//////                                    .clipShape(Capsule())
//////                                }
//////                                .padding(24)
//////                                .background(Color(hex: "874F35"))
//////                                .cornerRadius(24)
//////                                .shadow(radius: 10)
//////                                .transition(.scale)
//////                                .offset(x:0,y:-150)
//////                            }
//////                    }
////
////
////
////                }
////                .frame(width: 355, height: 520) // ← هنا التحكم بالحجم
////                .background(
////                    RoundedRectangle(cornerRadius: 30)
////                        .stroke(Color(hex: "874F35"), lineWidth: 4)
////                        .background(
////                            RoundedRectangle(cornerRadius: 30)
////                                .fill(Color(hex: "FCF0DD"))
////                        )
////                )
////                .padding()
////                .overlay(
////                    Group {
////                        if showPopup {
////                            ZStack {
////                              
////                                VStack(spacing: 20) {
////                                    Text("هز الجوال")
////                                        .font(.custom("Saudi-Regular", size: 22))
////                                        .foregroundColor(Color(hex: "FCF0DD"))
////
////                                    Text("هز الجهاز لمعرفة المعلومة")
////                                        .font(.custom("Saudi-Regular", size: 16))
////                                        .foregroundColor(Color(hex: "FCF0DD"))
////
////                                    Button("إغلاق") {
////                                        withAnimation {
////                                            showPopup = false
////                                        }
////                                    }
////                                    .padding(.horizontal, 30)
////                                    .padding(.vertical, 10)
////                                    .background(Color(hex: "FCF0DD"))
////                                    .foregroundColor(Color(hex: "874F35"))
////                                    .clipShape(Capsule())
////                                }
////                                .padding(24)
////                                .background(Color(hex: "874F35"))
////                                .cornerRadius(24)
////                                .shadow(radius: 10)
////                                .transition(.scale)
////                            }
////                        }
////                    }
////                )
////                .padding()
////
//////                Spacer()
////
////                Button(action: {
////                    
////                    
////                }) {
////                    Text("التالي ")
////                        .font(.custom("Saudi-Regular", size: 18))
////                        .foregroundColor(Color(hex: "FCF0DD"))
////                        .padding(.horizontal, 40)
////                        .padding(.vertical, 12)
////                        .background(Color(hex: "874F35"))
////                        .cornerRadius(25)
////                }
////
////                Spacer()
////            }
////        }
////    }
////}
////
////// إضافة هذا الامتداد لاكتشاف حركة الهز
////extension NSNotification.Name {
////    static let deviceDidShake = NSNotification.Name("deviceDidShake")
////}
////
////extension UIWindow {
////    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
////        if motion == .motionShake {
////            NotificationCenter.default.post(name: .deviceDidShake, object: nil)
////        }
////    }
////}
//
//
//import SwiftUI
//
//struct PuzzleView2: View {
//    @State private var answer: String = ""
//    @State private var showText = false
//    @State private var showPopup = false
//    @State private var shakePower: CGFloat = 15 // ← هذا يتحكم بالهزة
//
//    // --- (1) المتغيرات الجديدة هنا ---
//    @State private var shakeOffset: CGFloat = 0
//    @State private var showNextButton = false
//
//    var body: some View {
//        NavigationStack{
//        ZStack {
//            Image("background")
//                .resizable()
//                .scaledToFit()
//                .frame(maxWidth: .infinity)
//                .ignoresSafeArea()
//            
//            VStack {
//                // Header (انهاء اللعبة)
//                HStack {
//                    Spacer()
//                    Button(action: {}) {
//                        Text("انهاء اللعبه ")
//                            .font(.custom("Saudi-Regular", size: 14))
//                            .foregroundColor(Color(hex: "FCF0DD"))
//                            .padding(.horizontal, 20)
//                            .padding(.vertical, 8)
//                            .background(Color(hex: "874F35"))
//                            .cornerRadius(25)
//                    }
//                }
//                .padding()
//                
//                // الكرت الرئيسي
//                VStack(spacing: 10) {
//                    Text("اكتشف العاده ")
//                        .font(.custom("Saudi-Regular", size: 25))
//                        .foregroundColor(Color(hex: "874F35"))
//                        .padding(.bottom, 20)
//                        .offset(x: 0, y: -10)
//                    
//                    Text("اجعل الفنجال يتحرك ")
//                        .font(.custom("Saudi-Regular", size: 30))
//                        .foregroundColor(Color(hex: "874F35"))
//                        .offset(x: 0, y: 10)
//                    
//                    // --- (2) صورة الفنجال مربوطة بالاهتزاز ---
//                    Image("الفنجال ")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 300, height: 300)
//                        .offset(x: shakeOffset, y: 80) // هنا الحركة
//                        .animation(.default, value: shakeOffset)
//                    
//                }
//                .frame(width: 355, height: 520)
//                .background(
//                    RoundedRectangle(cornerRadius: 30)
//                        .stroke(Color(hex: "874F35"), lineWidth: 4)
//                        .background(RoundedRectangle(cornerRadius: 30).fill(Color(hex: "FCF0DD")))
//                )
//                .padding()
//                
//                // --- (3) زر التالي يظهر فقط بعد الهز ---
//                if showNextButton {
//                    NavigationLink(destination: PuzzleView3())
//                    {
//                        Text("التالي ")
//                            .font(.custom("Saudi-Regular", size: 18))
//                            .foregroundColor(Color(hex: "FCF0DD"))
//                            .padding(.horizontal, 40)
//                            .padding(.vertical, 12)
//                            .background(Color(hex: "874F35"))
//                            .cornerRadius(25)
//                            .shadow(radius: 5)
//                    }
//                    .transition(.scale.combined(with: .opacity)) // حركة الظهور
//                    .padding(.top, 20)
//                }
//                
//                Spacer()
//            }
//        }
//            
//    }.navigationBarBackButtonHidden(true)
//       
//
//        // --- (4) المستمع لحركة الهز يوضع هنا في نهاية الـ ZStack ---
//        .onReceive(NotificationCenter.default.publisher(for: .deviceDidShake)) { _ in
//            handleShake()
//        }
//    }
//
//    // --- (5) الوظيفة التي تنفذ عند الهز ---
////    func handleShake() {
////        // اهتزاز الفنجال
////        withAnimation(.interpolatingSpring(stiffness: 100, damping: 5)) {
////            shakeOffset = 15
////        }
////        
////        // إرجاع الفنجال وإظهار الزر
////        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
////            withAnimation(.spring()) {
////                shakeOffset = 0
////                showNextButton = true // الزر يظهر هنا
////            }
////        }
////    }
//    func handleShake() {
//        // ← قيم التحريك يمين ↔️ يسار
//        let values: [CGFloat] = [80, -80, 60, -60, 40, -40, 0]
//        var delay: Double = 0
//
//        for value in values {
//            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//                withAnimation(.interpolatingSpring(stiffness: 300, damping: 4)) {
//                    shakeOffset = value
//                }
//            }
//            delay += 0.05 // ← سرعة الهزة: كل حركة 0.05 ثانية
//        }
//
//        // ← إظهار زر التالي بعد انتهاء الهزة
//        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//            showNextButton = true
//        }
//    }
//
//
//}
//
//// --- (6) المنطقة الخارجية (تأكدي من وجودها ليعمل الهز) ---
//extension NSNotification.Name {
//    static let deviceDidShake = NSNotification.Name("deviceDidShake")
//}
//
//extension UIWindow {
//    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//        if motion == .motionShake {
//            NotificationCenter.default.post(name: .deviceDidShake, object: nil)
//        }
//    }
//}
//#Preview {
//    PuzzleView2()
//}
//
