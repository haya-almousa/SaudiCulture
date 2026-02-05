//
//  فك الشفره .swift
//  SaudiCulture
//
//  Created by Wed Ahmed Alasiri on 15/08/1447 AH.
//

import SwiftUI

  

struct PuzzleView2: View {
    @State private var answer: String = ""
    @State private var showText = false

    
    
    
    var body: some View {
        ZStack {
            // لون الخلفية
            Color(hex: "FFF9F2")
                .ignoresSafeArea()

            // صورة النخلة بالخلفية
            GeometryReader { proxy in
                Image("palm_bg")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.15)
                    .frame(maxWidth: .infinity)
                    .position(x: proxy.size.width / 2,
                              y: proxy.size.height * 0.75)
            }
            .ignoresSafeArea()

            VStack {
                // Header
                HStack {
                    Image("home")
                        .resizable()
                        .frame(width: 24, height: 24)

                    Spacer()
                }
                .padding()

               
                HStack {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "house")
                            .font(.system(size: 30, weight: .medium)) // ⭐ حجم الأيقونة
                                       .foregroundColor(Color(hex: "874F35"))
                                       .padding(2)
                    }
                    .offset(x: -155, y: -50)
                }
                
                
                
                
                // الكرت
                VStack(spacing: 10) {
                    
                    
                    
                    Text("اكتشف العاده ")
                        .font(.title)
                        .foregroundColor(Color(hex: "874F35"))
                        .padding(.bottom, 20)
                        .offset(x: 0 , y: -100)


                    HStack(spacing: 20) {
                        Text("🟢 ☕ 🏜️")
//                        Text("☕")
//                        Text("🏜️")
                    }
                    .font(.title)

                    .offset(x: 0 , y: -100)


                    Text("😁")
                    .font(.title)
                    .offset(x: 0 , y: -60)

                    VStack(alignment: .trailing, spacing: 8) {

                        TextField("اكتب الإجابه هنا", text: $answer)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.brown)
                            .padding(.vertical, 4)
                            .frame(width: 220) // ⭐ تتحكمين بطول الخط هنا

                        Rectangle()
                            .frame(width: 290, height: 2) // ⭐ نفس العرض
                            .foregroundColor(Color(hex: "874F35")/*.opacity(0.5)*/)
                    }
                    .offset(x: 0 , y: -0)



//                    HStack {
//                        Button(action: {
//                            withAnimation(.easeInOut) {
//                                showText.toggle()
//                            }
//                        }) {
//                            if showText {
//                                Text("شراب ")
//                                    .font(.headline)
//                                    .foregroundColor(Color(hex: "FCF0DD"))
//                                    .padding(.horizontal, 28)
//                                    .padding(.vertical, 14)
//                            } else {
//                                Image(systemName: "questionmark")
//                                    .font(.system(size: 22))
//                                    .foregroundColor(.white)
//                                    .padding(16)
//                            }
//                        }
//                        .background(Color(hex: "874F35"))
//                        .clipShape(
//                            showText ? AnyShape(Capsule()) : AnyShape(Circle())
//                        )
//                        .offset(x: -140, y: 120)
//                    }

                    
                    HStack {
                        ZStack(alignment: .leading) { // نثبت النص على اليسار
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    showText.toggle()
                                }
                            }) {
                                HStack {
                                    if showText {
                                        Text(" شراب ")
                                            .font(.headline)
                                            .foregroundColor(Color(hex: "FCF0DD"))
                                            .padding(.horizontal, 28)
                                            .padding(.vertical, 14)
                                    } else {
                                        Image(systemName: "questionmark")
                                            .font(.system(size: 22))
                                            .foregroundColor(.white)
                                            .padding(16)
                                    }
                                }
                                .background(Color(hex: "874F35"))
                                .clipShape(RoundedRectangle(cornerRadius: showText ? 25 : 30)) // morph
                                .frame(minWidth: showText ? 140 : 60, alignment: .leading) // الثبات على اليسار
                            }
                        }
                        Spacer() // يخلي الزر على اليسار
//                        .offset(x: -140, y: 120)

                    }
                    .padding(.leading, 20)
                    .offset(x: 0, y: 110)

                    
                    
                }
                .frame(width: 355, height: 520) // ← هنا التحكم بالحجم
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color(hex: "874F35"), lineWidth: 4)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(hex: "FCF0DD"))
                        )
                )
                .padding()

//                Spacer()

                Button(action: {}) {
                    Text("إنهاء")
                        .foregroundColor(Color(hex: "FCF0DD"))
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(Color(hex: "874F35"))
                        .cornerRadius(25)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    PuzzleView2()
}
